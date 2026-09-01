import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase/server';
import { assertValidTransition, ProposalStatus } from '@/lib/proposals/state-machine';
import { logAuditEvent } from '@/lib/proposals/audit';
import { sendSlackApprovalNotification } from '@/lib/slack/notify';

export async function POST(req: Request, { params }: { params: { id: string } }) {
  try {
    const proposalId = params.id;
    const body = await req.json();
    const { expectedVersion } = body;

    if (typeof expectedVersion !== 'number') {
      return NextResponse.json({ error: 'expectedVersion number is required for concurrency safety.' }, { status: 400 });
    }

    // Fetch current proposal with lead details
    const { data: proposal, error: fetchErr } = await supabaseAdmin
      .from('proposals')
      .select('*, leads(*)')
      .eq('id', proposalId)
      .single();

    if (fetchErr || !proposal) {
      return NextResponse.json({ error: 'Proposal not found' }, { status: 404 });
    }

    const currentStatus = proposal.status as ProposalStatus;

    // Check for pending unresolved clarifications
    const { count: unresolvedCount } = await supabaseAdmin
      .from('clarification_items')
      .select('id', { count: 'exact', head: true })
      .eq('proposal_id', proposalId)
      .eq('resolved', false);

    if ((unresolvedCount || 0) > 0) {
      return NextResponse.json(
        { error: `Cannot approve proposal with ${unresolvedCount} unresolved clarification items.` },
        { status: 409 }
      );
    }

    // 1. Enforce Server-Side State Transition Rules
    try {
      assertValidTransition(currentStatus, 'APPROVED');
    } catch (transErr) {
      return NextResponse.json({ error: (transErr as Error).message }, { status: 409 });
    }

    // 2. Server-side Conditional Update (Optimistic Concurrency Control)
    const nextVersion = proposal.version + 1;
    const { data: updatedProposal, error: updateErr } = await supabaseAdmin
      .from('proposals')
      .update({
        status: 'APPROVED',
        version: nextVersion,
        updated_at: new Date().toISOString()
      })
      .eq('id', proposalId)
      .eq('status', 'NEEDS_REVIEW')
      .eq('version', expectedVersion)
      .select('*, leads(*)')
      .single();

    if (updateErr || !updatedProposal) {
      return NextResponse.json(
        { error: 'Approval race condition or double submission detected. Proposal was modified or already approved.' },
        { status: 409 }
      );
    }

    // Record server-side approval event
    await logAuditEvent(
      proposalId,
      'APPROVED',
      'marcus',
      currentStatus,
      'APPROVED',
      `Proposal approved by Marcus. Version advanced to ${nextVersion}. Total: $${updatedProposal.total_amount}`
    );

    // 3. Attempt Downstream Slack Notification (Isolated Failure Domain)
    const slackResult = await sendSlackApprovalNotification({
      proposalId: updatedProposal.id,
      customerName: updatedProposal.leads?.name || 'Customer',
      address: `${updatedProposal.leads?.address || ''}, ${updatedProposal.leads?.city || 'Phoenix'}`,
      totalAmount: updatedProposal.total_amount || 0,
      renderRequired: updatedProposal.render_required || false
    });

    if (slackResult.success) {
      // Slack succeeded → transition to SENT
      await supabaseAdmin
        .from('proposals')
        .update({
          status: 'SENT',
          slack_notified: true,
          slack_notified_at: new Date().toISOString(),
          slack_error: null
        })
        .eq('id', proposalId);

      await logAuditEvent(
        proposalId,
        'SLACK_SENT',
        'system',
        'APPROVED',
        'SENT',
        'Slack approval notification dispatched successfully.'
      );

      return NextResponse.json({
        success: true,
        status: 'SENT',
        message: 'Proposal approved and Slack notification dispatched.',
        proposal: { ...updatedProposal, status: 'SENT', slack_notified: true }
      });
    } else {
      // CRITICAL REQUIREMENT: Slack failure leaves proposal APPROVED (never FAILED)
      await supabaseAdmin
        .from('proposals')
        .update({
          slack_error: slackResult.error || 'Slack webhook notification failed'
        })
        .eq('id', proposalId);

      await logAuditEvent(
        proposalId,
        'SLACK_FAILED',
        'system',
        'APPROVED',
        'APPROVED',
        `Slack notification failed: ${slackResult.error}. Proposal remains APPROVED.`,
        { error: slackResult.error }
      );

      return NextResponse.json({
        success: true,
        status: 'APPROVED',
        warning: `Proposal approved successfully, but Slack notification failed: ${slackResult.error}`,
        proposal: { ...updatedProposal, slack_error: slackResult.error }
      });
    }
  } catch (err) {
    console.error('❌ Error approving proposal:', err);
    return NextResponse.json({ error: (err as Error).message }, { status: 500 });
  }
}
