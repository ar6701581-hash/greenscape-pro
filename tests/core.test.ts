import { describe, it, expect } from 'vitest';
import { validateStateTransition, assertValidTransition, InvalidTransitionError } from '../src/lib/proposals/state-machine';
import { calculateLineTotal, calculateProposalTotals } from '../src/lib/pricing/engine';
import { applyExtractionGuardrails, validateInputNotes } from '../src/lib/proposals/guardrails';

describe('Proposal State Machine Invariants', () => {
  it('allows valid state transitions', () => {
    expect(validateStateTransition('DRAFT', 'NEEDS_REVIEW')).toBe(true);
    expect(validateStateTransition('DRAFT', 'NEEDS_CLARIFICATION')).toBe(true);
    expect(validateStateTransition('NEEDS_CLARIFICATION', 'NEEDS_REVIEW')).toBe(true);
    expect(validateStateTransition('NEEDS_REVIEW', 'APPROVED')).toBe(true);
    expect(validateStateTransition('APPROVED', 'SENT')).toBe(true);
  });

  it('rejects invalid state transitions', () => {
    expect(validateStateTransition('DRAFT', 'SENT')).toBe(false);
    expect(validateStateTransition('APPROVED', 'NEEDS_REVIEW')).toBe(false);
    expect(validateStateTransition('SENT', 'DRAFT')).toBe(false);
  });

  it('CRITICAL: prevents APPROVED -> FAILED transition when Slack fails', () => {
    expect(validateStateTransition('APPROVED', 'FAILED')).toBe(false);
    expect(() => assertValidTransition('APPROVED', 'FAILED')).toThrow(InvalidTransitionError);
  });
});

describe('Deterministic Pricing Engine Invariants', () => {
  const dummyItem = {
    id: 'item-123',
    item_id: 'GP-001',
    category: 'Hardscape',
    subcategory: 'Pavers',
    name: 'Travertine Paver',
    description: null,
    unit: 'sqft',
    unit_price: 28.00, // AUTHORITATIVE DB PRICE
    min_quantity: 100,
    typical_quantity: 500,
    max_quantity: 1000,
    synonyms: [],
    requires_dimensions: true,
    requires_material: true,
    requires_site_verify: false,
    clarification_question: null,
    confidence_notes: null,
    active: true
  };

  it('computes exact line totals without IEEE floating point drift', () => {
    const line = calculateLineTotal(dummyItem, 600, 0.95, 'travertine pavers');
    expect(line.unit_price).toBe(28.00);
    expect(line.quantity).toBe(600);
    expect(line.line_total).toBe(16800.00);
    expect(line.out_of_range).toBe(false);
  });

  it('flags out-of-range quantities without clamping extracted value', () => {
    const line = calculateLineTotal(dummyItem, 1500, 0.90, 'travertine pavers');
    expect(line.quantity).toBe(1500); // KEPT EXTRACTED QUANTITY
    expect(line.out_of_range).toBe(true);
    expect(line.out_of_range_note).toContain('exceeds the typical maximum catalog quantity');
  });

  it('rejects zero or negative quantities', () => {
    expect(() => calculateLineTotal(dummyItem, 0, 0.9, 'pavers')).toThrow();
    expect(() => calculateLineTotal(dummyItem, -50, 0.9, 'pavers')).toThrow();
  });

  it('authoritatively triggers Carlos Render flag when total > $30,000', () => {
    const totalsUnder = calculateProposalTotals([{ line_total: 25000 }], 0);
    expect(totalsUnder.renderRequired).toBe(false);

    const totalsOver = calculateProposalTotals([{ line_total: 35000 }], 0);
    expect(totalsOver.renderRequired).toBe(true);
    expect(totalsOver.renderFlagNote).toBe('CARLOS RENDER REQUIRED');
  });
});

describe('Guardrails & Input Validation Invariants', () => {
  it('rejects empty site walk notes', () => {
    const res = validateInputNotes('');
    expect(res.isValid).toBe(false);
    expect(res.error).toContain('cannot be empty');
  });

  it('warns on short notes < 20 words', () => {
    const res = validateInputNotes('Short note only five words here.');
    expect(res.isValid).toBe(true);
    expect(res.warning).toBeDefined();
  });

  it('converts unmatched AI scope items into clarification_items', () => {
    const aiOutput = {
      project_summary: 'Test summary',
      scope_items: [
        {
          extracted_name: 'Custom Waterfall Feature',
          catalog_item_id: null, // UNMATCHED
          catalog_item_name: null,
          category: 'Water Features',
          quantity: 1,
          unit: 'each',
          confidence: 0.5,
          requires_clarification: true,
          clarification_question: 'Which waterfall style is preferred?',
          special_conditions: null,
          notes: null
        }
      ],
      missing_information: [],
      general_clarification_questions: [],
      render_likely_required: false,
      render_reason: null,
      extraction_notes: null
    };

    const result = applyExtractionGuardrails(aiOutput);
    expect(result.cleanScopeItems.length).toBe(0);
    expect(result.clarificationItems.length).toBe(1);
    expect(result.clarificationItems[0].extracted_name).toBe('Custom Waterfall Feature');
  });
});
