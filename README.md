# Greenscape Pro — AI Proposal & Quote Drafting Agent

An internal operational AI application for **Greenscape Pro**, a premium residential hardscape and landscape design-build company in Phoenix, Arizona.

The application turns Marcus Tate's raw site-walk notes into a structured, pricing-backed proposal draft within hours while keeping Marcus as the final human decision maker.

---

## 🌿 Core Architectural Principle

> **AI interprets. Database provides truth. Code calculates. Human approves. External systems are notified.**

If asked: *"How do you know the AI didn't invent a $12,000 price?"*  
**Answer:** It can't. The AI model never supplies unit prices or calculates totals. The AI extracts scope terms and maps them to catalog item UUIDs. The application backend retrieves authoritative unit prices from Supabase PostgreSQL and deterministically computes line totals and proposal sums.

---

## 🏗️ Architecture & Technology Stack

| Layer | Technology | Purpose / Design Decision |
|---|---|---|
| **Framework** | Next.js 14 (App Router) | Server Components & API Routes keep secrets server-side |
| **Language** | TypeScript | Zod validation safety & typed DB queries |
| **Styling** | Tailwind CSS v3 | Utility-first responsive operational UI |
| **Database** | Supabase (PostgreSQL) | Persistent storage with RLS, foreign keys, and indexes |
| **AI Provider** | Google Gemini 2.0 Flash | Native JSON schema enforcement (`responseMimeType: 'application/json'`) |
| **Validation** | Zod | Runtime schema validation of AI extractions |
| **Integration** | Slack Incoming Webhook | Fail-safe proposal approval notification |
| **Testing** | Vitest | Invariant unit tests for state machine & pricing engine |

---

## 📊 Database & Pricing Catalog

- **Supabase PostgreSQL Schema:** Migrations located in `supabase/migrations/`
  - `leads`: Customer contact details and site location
  - `site_walks`: Unstructured site walk raw notes & word counts
  - `pricing_items`: Authoritative 200+ item pricing catalog (sourced from `greenscape_pro_pricing_catalog.csv`)
  - `proposals`: Proposal status, subtotal, tax, total, render flags, and version lock
  - `proposal_line_items`: Deterministic calculated line items (unit price × quantity)
  - `clarification_items`: Persisted unresolved scope ambiguity records
  - `ai_extractions`: Raw AI payload and parsed JSON audit logs
  - `approval_events`: Comprehensive audit trail of all actions and edits

*Disclaimer:* The 200-item pricing catalog contains **DEMO/SAMPLE data** created for take-home demonstration purposes and does not represent Greenscape Pro's proprietary pricing. Replacing the catalog requires modifying database rows, not application code.

---

## 🔄 Proposal State Machine

```text
Site Walk Notes Input
        ↓
     DRAFT
        ├────────────► NEEDS_CLARIFICATION (if missing info/unmatched items exist)
        │                      │ (human resolves via UI)
        ▼                      ▼
  NEEDS_REVIEW ◄───────────────┘
        ↓ (Marcus clicks Approve — server-side optimistic lock)
     APPROVED
        ├────────────► SENT (Slack webhook succeeds)
        │
        └────────────► Stays APPROVED (Slack webhook fails — error stored in DB)
```

- **Double-Approval Protection:** Enforced via DB unique index on `(proposal_id, action='APPROVED')` and optimistic concurrency locking on `proposals.version`.
- **Carlos Render Rule:** Calculated proposal total > $30,000 authoritatively sets `render_required = true` and displays `"CARLOS RENDER REQUIRED"`. AI render prediction is advisory only.

---

## ⚡ Setup & Local Development Instructions

### 1. Clone & Install Dependencies

```bash
git clone https://github.com/your-repo/greenscape-pro.git
cd greenscape-pro
npm install
```

### 2. Environment Variables

Copy `.env.example` to `.env.local` and fill in your keys:

```bash
cp .env.example .env.local
```

Required variables in `.env.local`:
```ini
NEXT_PUBLIC_SUPABASE_URL=https://your-project.supabase.co
NEXT_PUBLIC_SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key
GEMINI_API_KEY=your-google-gemini-api-key
SLACK_WEBHOOK_URL=https://hooks.slack.com/services/your/webhook/url
NEXT_PUBLIC_APP_URL=http://localhost:3000
TAX_RATE=0.0
```

### 3. Database Migration & CSV Catalog Import

Run migrations in Supabase SQL Editor or push via CLI:
1. Execute `supabase/migrations/0001_initial_schema.sql`
2. Execute `supabase/migrations/0002_indexes.sql`
3. Execute `supabase/migrations/0003_rls_policies.sql`
4. Execute `supabase/seed/pricing_catalog_seed.sql` (generated from CSV via `node scripts/generate_seed.js`)

### 4. Run Development Server

```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000) in your browser.

### 5. Run Invariant Tests

```bash
npx vitest run
```

---

## 💰 Cost Analysis per Proposal Generation

- **Selected Model:** `gemini-2.0-flash`
- **Input Tokens per Proposal:** ~5,000–7,000 tokens (system prompt with catalog manifest + site walk notes)
- **Output Tokens per Proposal:** ~800–1,500 tokens (structured JSON extraction)
- **Cost per Proposal:** ~$0.001–$0.002 (under 0.2 cents)
- **Annual Cost (150 proposals/year):** ~$0.15–$0.30/year — effectively zero
- **Execution Discipline:** Exactly **one primary Gemini call per proposal submission**, with at most one controlled retry if schema parsing fails. Zero AI calls for arithmetic or database lookups.

---

## 🔒 Security & Known Limitations

- **Authentication:** For this take-home build, access is URL-based (no login screen). In production, Supabase Auth with magic links and per-user RLS would be enabled.
- **Server Keys:** `SUPABASE_SERVICE_ROLE_KEY`, `GEMINI_API_KEY`, and `SLACK_WEBHOOK_URL` are strictly server-side and never exposed to the client browser.
- **Tax Rate:** `TAX_RATE` defaults to `0.0` (no fabricated sales tax assumption).
