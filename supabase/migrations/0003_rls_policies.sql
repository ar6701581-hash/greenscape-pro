-- Migration 0003: Row Level Security (RLS) Policies

-- Enable RLS on all tables
ALTER TABLE leads ENABLE ROW LEVEL SECURITY;
ALTER TABLE site_walks ENABLE ROW LEVEL SECURITY;
ALTER TABLE pricing_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE proposals ENABLE ROW LEVEL SECURITY;
ALTER TABLE proposal_line_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE clarification_items ENABLE ROW LEVEL SECURITY;
ALTER TABLE ai_extractions ENABLE ROW LEVEL SECURITY;
ALTER TABLE approval_events ENABLE ROW LEVEL SECURITY;

-- Allow full access for anon and service role (internal operations tool scope)
CREATE POLICY "Allow public read access for pricing items" ON pricing_items FOR SELECT USING (true);
CREATE POLICY "Allow full access to leads" ON leads FOR ALL USING (true);
CREATE POLICY "Allow full access to site_walks" ON site_walks FOR ALL USING (true);
CREATE POLICY "Allow full access to pricing_items" ON pricing_items FOR ALL USING (true);
CREATE POLICY "Allow full access to proposals" ON proposals FOR ALL USING (true);
CREATE POLICY "Allow full access to proposal_line_items" ON proposal_line_items FOR ALL USING (true);
CREATE POLICY "Allow full access to clarification_items" ON clarification_items FOR ALL USING (true);
CREATE POLICY "Allow full access to ai_extractions" ON ai_extractions FOR ALL USING (true);
CREATE POLICY "Allow full access to approval_events" ON approval_events FOR ALL USING (true);
