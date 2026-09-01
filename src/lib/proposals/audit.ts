import { supabaseAdmin } from '../supabase/server';

export async function logAuditEvent(
  proposalId: string | null,
  action: string,
  actor: string = 'marcus',
  previousStatus: string | null = null,
  newStatus: string | null = null,
  notes: string | null = null,
  payload: Record<string, unknown> | null = null
): Promise<void> {
  if (!proposalId) return;

  const { error } = await supabaseAdmin.from('approval_events').insert({
    proposal_id: proposalId,
    action,
    actor,
    previous_status: previousStatus,
    new_status: newStatus,
    notes,
    payload
  });

  if (error) {
    console.error(`❌ Failed to record audit event "${action}" for proposal ${proposalId}:`, error.message);
  }
}
