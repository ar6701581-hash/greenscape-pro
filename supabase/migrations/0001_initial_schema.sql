-- Migration 0001: Initial Core Schema for Greenscape Pro

-- Enable UUID extension
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- 1. Leads Table
CREATE TABLE IF NOT EXISTS leads (
  id         UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name       TEXT NOT NULL,
  email      TEXT,
  phone      TEXT,
  address    TEXT,
  city       TEXT DEFAULT 'Phoenix',
  state      TEXT DEFAULT 'AZ',
  notes      TEXT,
  source     TEXT,
  created_at TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 2. Site Walks Table
CREATE TABLE IF NOT EXISTS site_walks (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lead_id         UUID NOT NULL REFERENCES leads(id) ON DELETE CASCADE,
  conducted_at    TIMESTAMPTZ DEFAULT now(),
  raw_notes       TEXT NOT NULL,
  word_count      INT,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 3. Pricing Items Catalog Table
CREATE TABLE IF NOT EXISTS pricing_items (
  id                       UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id                  TEXT UNIQUE NOT NULL,   -- e.g. "GP-001"
  category                 TEXT NOT NULL,
  subcategory              TEXT,
  name                     TEXT NOT NULL,
  description              TEXT,
  unit                     TEXT NOT NULL,
  unit_price               NUMERIC(12,2) NOT NULL CHECK (unit_price > 0),
  min_quantity             NUMERIC(12,2),
  typical_quantity         NUMERIC(12,2),
  max_quantity             NUMERIC(12,2),
  synonyms                 TEXT[],
  requires_dimensions      BOOLEAN NOT NULL DEFAULT false,
  requires_material        BOOLEAN NOT NULL DEFAULT false,
  requires_site_verify     BOOLEAN NOT NULL DEFAULT false,
  clarification_question   TEXT,
  confidence_notes         TEXT,
  active                   BOOLEAN NOT NULL DEFAULT true,
  created_at               TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at               TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 4. Proposals Table
CREATE TABLE IF NOT EXISTS proposals (
  id               UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  lead_id          UUID NOT NULL REFERENCES leads(id),
  site_walk_id     UUID NOT NULL REFERENCES site_walks(id),
  status           TEXT NOT NULL DEFAULT 'DRAFT'
                   CHECK (status IN (
                     'DRAFT','NEEDS_CLARIFICATION','NEEDS_REVIEW',
                     'APPROVED','SENT','FAILED'
                   )),
  project_summary  TEXT,
  subtotal         NUMERIC(12,2),
  tax_rate         NUMERIC(6,4) NOT NULL DEFAULT 0.0,
  tax_amount       NUMERIC(12,2),
  total_amount     NUMERIC(12,2),
  render_required  BOOLEAN NOT NULL DEFAULT false,
  render_flag_note TEXT,
  slack_notified   BOOLEAN NOT NULL DEFAULT false,
  slack_notified_at TIMESTAMPTZ,
  slack_error      TEXT,
  version          INT NOT NULL DEFAULT 1,
  created_at       TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at       TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 5. Proposal Line Items Table
CREATE TABLE IF NOT EXISTS proposal_line_items (
  id                     UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  proposal_id            UUID NOT NULL REFERENCES proposals(id) ON DELETE CASCADE,
  pricing_item_id        UUID REFERENCES pricing_items(id),
  line_order             INT NOT NULL DEFAULT 0,
  name                   TEXT NOT NULL,
  description            TEXT,
  category               TEXT,
  unit                   TEXT NOT NULL,
  unit_price             NUMERIC(12,2) NOT NULL,
  quantity               NUMERIC(12,2) NOT NULL CHECK (quantity > 0),
  line_total             NUMERIC(12,2) NOT NULL,
  ai_confidence          NUMERIC(4,3),
  ai_extracted_name      TEXT,
  out_of_range           BOOLEAN NOT NULL DEFAULT false,
  out_of_range_note      TEXT,
  special_conditions     TEXT,
  is_manually_added      BOOLEAN NOT NULL DEFAULT false,
  is_deleted             BOOLEAN NOT NULL DEFAULT false,
  created_at             TIMESTAMPTZ NOT NULL DEFAULT now(),
  updated_at             TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 6. Clarification Items Table
CREATE TABLE IF NOT EXISTS clarification_items (
  id                        UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  proposal_id               UUID NOT NULL REFERENCES proposals(id) ON DELETE CASCADE,
  original_extracted_name   TEXT NOT NULL,
  question                  TEXT NOT NULL,
  proposed_catalog_item_id  UUID REFERENCES pricing_items(id),
  answer                    TEXT,
  resolved                  BOOLEAN NOT NULL DEFAULT false,
  created_at                TIMESTAMPTZ NOT NULL DEFAULT now(),
  resolved_at               TIMESTAMPTZ
);

-- 7. AI Extractions Table
CREATE TABLE IF NOT EXISTS ai_extractions (
  id                UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  proposal_id       UUID NOT NULL REFERENCES proposals(id) ON DELETE CASCADE,
  site_walk_id      UUID NOT NULL REFERENCES site_walks(id),
  model             TEXT NOT NULL,
  prompt_version    TEXT NOT NULL,
  raw_response      JSONB NOT NULL,
  parsed_scope      JSONB NOT NULL,
  extraction_status TEXT NOT NULL DEFAULT 'SUCCESS'
                    CHECK (extraction_status IN ('SUCCESS','PARTIAL','FAILED')),
  input_tokens      INT,
  output_tokens     INT,
  latency_ms        INT,
  created_at        TIMESTAMPTZ NOT NULL DEFAULT now()
);

-- 8. Approval & Audit Events Table
CREATE TABLE IF NOT EXISTS approval_events (
  id              UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  proposal_id     UUID NOT NULL REFERENCES proposals(id),
  action          TEXT NOT NULL
                  CHECK (action IN (
                    'SUBMITTED','APPROVED','REJECTED','SENT',
                    'LINE_ITEM_EDITED','LINE_ITEM_ADDED','LINE_ITEM_DELETED',
                    'CLARIFICATION_RESOLVED','SLACK_SENT','SLACK_FAILED'
                  )),
  actor           TEXT NOT NULL DEFAULT 'marcus',
  notes           TEXT,
  previous_status TEXT,
  new_status      TEXT,
  payload         JSONB,
  created_at      TIMESTAMPTZ NOT NULL DEFAULT now()
);
