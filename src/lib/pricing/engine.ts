import { PricingItemRecord } from './lookup';

export interface CalculatedLineItem {
  pricing_item_id: string;
  name: string;
  description: string | null;
  category: string;
  unit: string;
  unit_price: number;
  quantity: number;
  line_total: number;
  ai_confidence: number;
  ai_extracted_name: string;
  out_of_range: boolean;
  out_of_range_note: string | null;
  special_conditions: string | null;
}

export interface CalculatedProposalTotals {
  subtotal: number;
  taxRate: number;
  taxAmount: number;
  totalAmount: number;
  renderRequired: boolean;
  renderFlagNote: string | null;
}

export function calculateLineTotal(
  item: PricingItemRecord,
  quantity: number,
  aiConfidence: number,
  aiExtractedName: string,
  specialConditions: string | null = null
): CalculatedLineItem {
  if (quantity <= 0) {
    throw new Error(`Quantity must be strictly positive (> 0). Sourced quantity: ${quantity}`);
  }

  // Exact integer cents pricing multiplication to eliminate IEEE floating point drift
  const unitPriceCents = Math.round(item.unit_price * 100);
  const lineTotalCents = Math.round(unitPriceCents * quantity);
  const lineTotal = lineTotalCents / 100;

  let outOfRange = false;
  let outOfRangeNote: string | null = null;

  if (item.min_quantity !== null && quantity < item.min_quantity) {
    outOfRange = true;
    outOfRangeNote = `Extracted quantity (${quantity} ${item.unit}) is below the typical minimum catalog quantity of ${item.min_quantity} ${item.unit}. Flagged for review.`;
  } else if (item.max_quantity !== null && quantity > item.max_quantity) {
    outOfRange = true;
    outOfRangeNote = `Extracted quantity (${quantity} ${item.unit}) exceeds the typical maximum catalog quantity of ${item.max_quantity} ${item.unit}. Flagged for review.`;
  }

  return {
    pricing_item_id: item.id,
    name: item.name,
    description: item.description,
    category: item.category,
    unit: item.unit,
    unit_price: item.unit_price, // AUTHORITATIVE DATABASE UNIT PRICE
    quantity,
    line_total: lineTotal,
    ai_confidence: aiConfidence,
    ai_extracted_name: aiExtractedName,
    out_of_range: outOfRange,
    out_of_range_note: outOfRangeNote,
    special_conditions: specialConditions
  };
}

export function calculateProposalTotals(
  lineItems: Array<{ line_total: number }>,
  taxRate: number = 0.0
): CalculatedProposalTotals {
  const subtotalCents = lineItems.reduce(
    (sum, item) => sum + Math.round(item.line_total * 100),
    0
  );
  const taxCents = Math.round(subtotalCents * taxRate);
  const totalCents = subtotalCents + taxCents;

  const subtotal = subtotalCents / 100;
  const taxAmount = taxCents / 100;
  const totalAmount = totalCents / 100;

  // Authoritative deterministic $30,000 threshold (>= $30,000) for Carlos Render
  const renderRequired = totalAmount >= 30000;
  const renderFlagNote = renderRequired ? 'CARLOS RENDER REQUIRED' : null;

  return {
    subtotal,
    taxRate,
    taxAmount,
    totalAmount,
    renderRequired,
    renderFlagNote
  };
}
