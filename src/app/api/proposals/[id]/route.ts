import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase/server';
import { getPricingItemById } from '@/lib/pricing/lookup';
import { calculateLineTotal, calculateProposalTotals } from '@/lib/pricing/engine';
import { logAuditEvent } from '@/lib/proposals/audit';

export async function GET(req: Request, { params }: { params: { id: string } }) {
  try {
    const proposalId = params.id;

    // Fetch proposal with lead and site walk
    const { data: proposal, error: propErr } = await supabaseAdmin
      .from('proposals')
      .select('*, leads(*), site_walks(*)')
      .eq('id', proposalId)
      .single();

    if (propErr || !proposal) {
      return NextResponse.json({ error: 'Proposal not found' }, { status: 404 });
    }

    // Fetch line items
    const { data: lineItems } = await supabaseAdmin
      .from('proposal_line_items')
      .select('*, pricing_items(*)')
      .eq('proposal_id', proposalId)
      .eq('is_deleted', false)
      .order('line_order', { ascending: true });

    // Fetch clarification items
    const { data: clarifications } = await supabaseAdmin
      .from('clarification_items')
      .select('*, pricing_items(*)')
      .eq('proposal_id', proposalId)
      .order('created_at', { ascending: true });

    // Fetch audit timeline
    const { data: auditEvents } = await supabaseAdmin
      .from('approval_events')
      .select('*')
      .eq('proposal_id', proposalId)
      .order('created_at', { ascending: true });

    return NextResponse.json({
      proposal,
      lineItems: lineItems || [],
      clarifications: clarifications || [],
      auditEvents: auditEvents || []
    });
  } catch (err) {
    return NextResponse.json({ error: (err as Error).message }, { status: 500 });
  }
}

// Line Item Management Endpoint (Edit quantity, delete line, resolve clarification, add line)
export async function PUT(req: Request, { params }: { params: { id: string } }) {
  try {
    const proposalId = params.id;
    const body = await req.json();
    const { action, lineItemId, quantity, clarificationId, catalogItemId, answer } = body;

    // Fetch proposal
    const { data: proposal, error: propErr } = await supabaseAdmin
      .from('proposals')
      .select('*')
      .eq('id', proposalId)
      .single();

    if (propErr || !proposal) {
      return NextResponse.json({ error: 'Proposal not found' }, { status: 404 });
    }

    if (proposal.status === 'APPROVED' || proposal.status === 'SENT') {
      return NextResponse.json({ error: 'Approved proposals cannot be edited.' }, { status: 400 });
    }

    if (action === 'EDIT_QUANTITY') {
      if (!lineItemId || !quantity || quantity <= 0) {
        return NextResponse.json({ error: 'Valid lineItemId and positive quantity required.' }, { status: 400 });
      }

      const { data: existingLine } = await supabaseAdmin
        .from('proposal_line_items')
        .select('*, pricing_items(*)')
        .eq('id', lineItemId)
        .single();

      if (!existingLine || !existingLine.pricing_items) {
        return NextResponse.json({ error: 'Line item or catalog item reference not found.' }, { status: 404 });
      }

      const updatedCalculatedLine = calculateLineTotal(
        existingLine.pricing_items,
        quantity,
        existingLine.ai_confidence || 1.0,
        existingLine.ai_extracted_name || existingLine.name,
        existingLine.special_conditions
      );

      await supabaseAdmin
        .from('proposal_line_items')
        .update({
          quantity: updatedCalculatedLine.quantity,
          line_total: updatedCalculatedLine.line_total,
          out_of_range: updatedCalculatedLine.out_of_range,
          out_of_range_note: updatedCalculatedLine.out_of_range_note
        })
        .eq('id', lineItemId);

      await logAuditEvent(
        proposalId,
        'LINE_ITEM_EDITED',
        'marcus',
        proposal.status,
        proposal.status,
        `Updated quantity for "${existingLine.name}" to ${quantity}`,
        { lineItemId, oldQuantity: existingLine.quantity, newQuantity: quantity }
      );
    } else if (action === 'DELETE_LINE_ITEM') {
      if (!lineItemId) {
        return NextResponse.json({ error: 'lineItemId required.' }, { status: 400 });
      }

      await supabaseAdmin
        .from('proposal_line_items')
        .update({ is_deleted: true })
        .eq('id', lineItemId);

      await logAuditEvent(
        proposalId,
        'LINE_ITEM_DELETED',
        'marcus',
        proposal.status,
        proposal.status,
        `Soft-deleted line item ${lineItemId}`
      );
    } else if (action === 'ADD_LINE_ITEM') {
      if (!catalogItemId || !quantity || quantity <= 0) {
        return NextResponse.json({ error: 'Valid catalogItemId and positive quantity required.' }, { status: 400 });
      }

      const catalogItem = await getPricingItemById(catalogItemId);
      if (!catalogItem) {
        return NextResponse.json({ error: 'Catalog item not found or inactive.' }, { status: 404 });
      }

      const calculated = calculateLineTotal(catalogItem, quantity, 1.0, catalogItem.name);

      await supabaseAdmin.from('proposal_line_items').insert({
        proposal_id: proposalId,
        pricing_item_id: catalogItem.id,
        line_order: 99,
        name: calculated.name,
        description: calculated.description,
        category: calculated.category,
        unit: calculated.unit,
        unit_price: calculated.unit_price,
        quantity: calculated.quantity,
        line_total: calculated.line_total,
        ai_confidence: 1.0,
        ai_extracted_name: catalogItem.name,
        out_of_range: calculated.out_of_range,
        out_of_range_note: calculated.out_of_range_note,
        is_manually_added: true
      });

      await logAuditEvent(
        proposalId,
        'LINE_ITEM_ADDED',
        'marcus',
        proposal.status,
        proposal.status,
        `Manually added "${catalogItem.name}" (Qty: ${quantity})`
      );
    } else if (action === 'RESOLVE_CLARIFICATION') {
      if (!clarificationId || !catalogItemId || !quantity || quantity <= 0) {
        return NextResponse.json({ error: 'clarificationId, catalogItemId, and positive quantity required.' }, { status: 400 });
      }

      const catalogItem = await getPricingItemById(catalogItemId);
      if (!catalogItem) {
        return NextResponse.json({ error: 'Selected catalog item not found.' }, { status: 404 });
      }

      // Mark clarification resolved
      await supabaseAdmin
        .from('clarification_items')
        .update({
          answer: answer || 'Resolved by Marcus',
          resolved: true,
          resolved_at: new Date().toISOString()
        })
        .eq('id', clarificationId);

      // Create new line item from resolved clarification
      const calculated = calculateLineTotal(catalogItem, quantity, 1.0, catalogItem.name);

      await supabaseAdmin.from('proposal_line_items').insert({
        proposal_id: proposalId,
        pricing_item_id: catalogItem.id,
        line_order: 90,
        name: calculated.name,
        description: calculated.description,
        category: calculated.category,
        unit: calculated.unit,
        unit_price: calculated.unit_price,
        quantity: calculated.quantity,
        line_total: calculated.line_total,
        ai_confidence: 1.0,
        ai_extracted_name: catalogItem.name,
        out_of_range: calculated.out_of_range,
        out_of_range_note: calculated.out_of_range_note,
        is_manually_added: false
      });

      await logAuditEvent(
        proposalId,
        'CLARIFICATION_RESOLVED',
        'marcus',
        proposal.status,
        proposal.status,
        `Resolved clarification into line item "${catalogItem.name}" (Qty: ${quantity})`
      );
    }

    // Recalculate totals for proposal after edit
    const { data: activeLineItems } = await supabaseAdmin
      .from('proposal_line_items')
      .select('line_total')
      .eq('proposal_id', proposalId)
      .eq('is_deleted', false);

    const totals = calculateProposalTotals(activeLineItems || [], proposal.tax_rate);

    // Check if unresolved clarifications remain
    const { count: unresolvedCount } = await supabaseAdmin
      .from('clarification_items')
      .select('id', { count: 'exact', head: true })
      .eq('proposal_id', proposalId)
      .eq('resolved', false);

    const newProposalStatus = (unresolvedCount || 0) === 0 ? 'NEEDS_REVIEW' : 'NEEDS_CLARIFICATION';

    await supabaseAdmin
      .from('proposals')
      .update({
        subtotal: totals.subtotal,
        tax_amount: totals.taxAmount,
        total_amount: totals.totalAmount,
        render_required: totals.renderRequired,
        render_flag_note: totals.renderFlagNote,
        status: newProposalStatus,
        updated_at: new Date().toISOString()
      })
      .eq('id', proposalId);

    return NextResponse.json({
      success: true,
      status: newProposalStatus,
      subtotal: totals.subtotal,
      totalAmount: totals.totalAmount,
      renderRequired: totals.renderRequired,
      unresolvedClarifications: unresolvedCount || 0
    });
  } catch (err) {
    return NextResponse.json({ error: (err as Error).message }, { status: 500 });
  }
}
