import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase/server';
import { fetchActiveCatalogManifest, getPricingItemById } from '@/lib/pricing/lookup';
import { extractScopeFromNotes } from '@/lib/ai/extract';
import { GEMINI_MODEL_NAME } from '@/lib/ai/gemini';
import { validateInputNotes, applyExtractionGuardrails } from '@/lib/proposals/guardrails';
import { calculateLineTotal, calculateProposalTotals } from '@/lib/pricing/engine';
import { logAuditEvent } from '@/lib/proposals/audit';
import { ProposalStatus } from '@/lib/proposals/state-machine';

export async function POST(req: Request) {
  try {
    const body = await req.json();
    const { leadId, rawNotes, leadName, leadAddress, leadPhone, leadEmail } = body;

    // 1. Input Guardrails
    const noteValidation = validateInputNotes(rawNotes);
    if (!noteValidation.isValid) {
      return NextResponse.json({ error: noteValidation.error }, { status: 400 });
    }

    let targetLeadId = leadId;

    // Create lead if missing
    if (!targetLeadId && leadName) {
      const { data: newLead, error: leadError } = await supabaseAdmin
        .from('leads')
        .insert({
          name: leadName,
          address: leadAddress || 'Phoenix, AZ',
          phone: leadPhone || null,
          email: leadEmail || null
        })
        .select('id')
        .single();

      if (leadError) throw new Error(`Lead creation failed: ${leadError.message}`);
      targetLeadId = newLead.id;
    }

    if (!targetLeadId) {
      return NextResponse.json({ error: 'Lead selection or quick-create lead details required.' }, { status: 400 });
    }

    // Record site walk
    const { data: siteWalk, error: siteWalkError } = await supabaseAdmin
      .from('site_walks')
      .insert({
        lead_id: targetLeadId,
        raw_notes: rawNotes,
        word_count: rawNotes.trim().split(/\s+/).length
      })
      .select('id')
      .single();

    if (siteWalkError) throw new Error(`Failed to record site walk: ${siteWalkError.message}`);

    // Fetch active pricing items manifest
    const manifest = await fetchActiveCatalogManifest();

    // Initial DRAFT Proposal record
    const { data: proposal, error: propError } = await supabaseAdmin
      .from('proposals')
      .insert({
        lead_id: targetLeadId,
        site_walk_id: siteWalk.id,
        status: 'DRAFT',
        version: 1
      })
      .select('id')
      .single();

    if (propError) throw new Error(`Failed to initialize proposal record: ${propError.message}`);

    await logAuditEvent(proposal.id, 'SUBMITTED', 'marcus', null, 'DRAFT', 'Proposal initial submission from site walk notes');

    // 2. Perform Single Controlled Gemini AI Extraction
    let aiExtractionResult;
    try {
      aiExtractionResult = await extractScopeFromNotes(rawNotes, manifest);
    } catch (aiErr) {
      await supabaseAdmin.from('proposals').update({ status: 'FAILED' }).eq('id', proposal.id);
      await logAuditEvent(proposal.id, 'FAILED', 'system', 'DRAFT', 'FAILED', `AI Extraction Failed: ${(aiErr as Error).message}`);
      return NextResponse.json({ error: `AI Scope extraction failed: ${(aiErr as Error).message}` }, { status: 500 });
    }

    const { output, rawResponseText, latencyMs } = aiExtractionResult;

    // Record raw AI extraction for auditability
    await supabaseAdmin.from('ai_extractions').insert({
      proposal_id: proposal.id,
      site_walk_id: siteWalk.id,
      model: GEMINI_MODEL_NAME,
      prompt_version: 'v1.0',
      raw_response: { text: rawResponseText },
      parsed_scope: output,
      extraction_status: 'SUCCESS',
      latency_ms: latencyMs
    });

    // 3. Apply Output Guardrails & Item Filtering
    const guardrailResult = applyExtractionGuardrails(output);
    const calculatedLineItems = [];

    // Process valid matching scope items through deterministic engine
    for (const scopeItem of guardrailResult.cleanScopeItems) {
      if (scopeItem.catalog_item_id && scopeItem.quantity) {
        const catalogItem = await getPricingItemById(scopeItem.catalog_item_id);
        if (catalogItem) {
          const line = calculateLineTotal(
            catalogItem,
            scopeItem.quantity,
            scopeItem.confidence,
            scopeItem.extracted_name,
            scopeItem.special_conditions
          );
          calculatedLineItems.push(line);
        }
      }
    }

    // Insert calculated line items into proposal_line_items
    if (calculatedLineItems.length > 0) {
      const lineRows = calculatedLineItems.map((item, idx) => ({
        proposal_id: proposal.id,
        pricing_item_id: item.pricing_item_id,
        line_order: idx + 1,
        name: item.name,
        description: item.description,
        category: item.category,
        unit: item.unit,
        unit_price: item.unit_price, // DETERMINISTIC PRICE FROM DB
        quantity: item.quantity,
        line_total: item.line_total,
        ai_confidence: item.ai_confidence,
        ai_extracted_name: item.ai_extracted_name,
        out_of_range: item.out_of_range,
        out_of_range_note: item.out_of_range_note,
        special_conditions: item.special_conditions
      }));

      await supabaseAdmin.from('proposal_line_items').insert(lineRows);
    }

    // Insert ambiguity records into clarification_items table
    if (guardrailResult.clarificationItems.length > 0) {
      const clarRows = guardrailResult.clarificationItems.map(c => ({
        proposal_id: proposal.id,
        original_extracted_name: c.extracted_name,
        question: c.question,
        proposed_catalog_item_id: c.proposed_catalog_item_id,
        resolved: false
      }));

      await supabaseAdmin.from('clarification_items').insert(clarRows);
    }

    // 4. Calculate Deterministic Proposal Totals
    const taxRate = parseFloat(process.env.TAX_RATE || '0.0');
    const totals = calculateProposalTotals(calculatedLineItems, taxRate);

    // Determine target proposal status
    const hasClarifications = guardrailResult.clarificationItems.length > 0;
    const nextStatus: ProposalStatus = hasClarifications ? 'NEEDS_CLARIFICATION' : 'NEEDS_REVIEW';

    // Update proposal record
    await supabaseAdmin
      .from('proposals')
      .update({
        project_summary: output.project_summary,
        subtotal: totals.subtotal,
        tax_rate: totals.taxRate,
        tax_amount: totals.taxAmount,
        total_amount: totals.totalAmount,
        render_required: totals.renderRequired,
        render_flag_note: totals.renderFlagNote,
        status: nextStatus
      })
      .eq('id', proposal.id);

    await logAuditEvent(
      proposal.id,
      'STATUS_CHANGE',
      'system',
      'DRAFT',
      nextStatus,
      `Proposal processed. Subtotal: $${totals.subtotal}, Status: ${nextStatus}`
    );

    return NextResponse.json({
      proposalId: proposal.id,
      status: nextStatus,
      subtotal: totals.subtotal,
      totalAmount: totals.totalAmount,
      renderRequired: totals.renderRequired,
      clarificationsCount: guardrailResult.clarificationItems.length,
      warnings: guardrailResult.warnings
    });
  } catch (err) {
    console.error('❌ Error processing proposal creation API:', err);
    return NextResponse.json({ error: (err as Error).message }, { status: 500 });
  }
}
