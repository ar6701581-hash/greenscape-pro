-- Migration 0002: Indexes and Constraints

-- Performance Indexes
CREATE INDEX IF NOT EXISTS idx_proposals_lead_id ON proposals(lead_id);
CREATE INDEX IF NOT EXISTS idx_proposals_status ON proposals(status);
CREATE INDEX IF NOT EXISTS idx_proposal_line_items_proposal_id ON proposal_line_items(proposal_id);
CREATE INDEX IF NOT EXISTS idx_clarification_items_proposal_id ON clarification_items(proposal_id);
CREATE INDEX IF NOT EXISTS idx_approval_events_proposal_id ON approval_events(proposal_id);
CREATE INDEX IF NOT EXISTS idx_ai_extractions_proposal_id ON ai_extractions(proposal_id);
CREATE INDEX IF NOT EXISTS idx_pricing_items_active ON pricing_items(active);

-- Business Logic Uniqueness Constraints
-- Prevent duplicate active proposals for the same site walk
CREATE UNIQUE INDEX IF NOT EXISTS idx_one_active_proposal_per_site_walk
  ON proposals(site_walk_id)
  WHERE status NOT IN ('FAILED');

-- Prevent double approval race conditions
CREATE UNIQUE INDEX IF NOT EXISTS idx_one_approval_per_proposal
  ON approval_events(proposal_id)
  WHERE action = 'APPROVED';
