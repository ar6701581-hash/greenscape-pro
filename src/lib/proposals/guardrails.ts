import { ScopeItem, ExtractionOutput } from '../ai/schemas';

export interface GuardrailValidationResult {
  isValid: boolean;
  errors: string[];
  warnings: string[];
  cleanScopeItems: ScopeItem[];
  clarificationItems: Array<{
    extracted_name: string;
    question: string;
    proposed_catalog_item_id: string | null;
  }>;
}

export function validateInputNotes(rawNotes: string): { isValid: boolean; error?: string; warning?: string } {
  if (!rawNotes || rawNotes.trim().length === 0) {
    return { isValid: false, error: 'Site-walk notes cannot be empty.' };
  }

  const wordCount = rawNotes.trim().split(/\s+/).length;

  if (rawNotes.length > 15000) {
    return { isValid: false, error: 'Site-walk notes exceed maximum allowed length of 15,000 characters.' };
  }

  if (wordCount < 20) {
    return {
      isValid: true,
      warning: 'Notes appear very brief (< 20 words). AI scope extraction may yield limited or missing items.'
    };
  }

  return { isValid: true };
}

export function applyExtractionGuardrails(output: ExtractionOutput): GuardrailValidationResult {
  const errors: string[] = [];
  const warnings: string[] = [];
  const cleanScopeItems: ScopeItem[] = [];
  const clarificationItems: Array<{
    extracted_name: string;
    question: string;
    proposed_catalog_item_id: string | null;
  }> = [];

  if (!output.scope_items || output.scope_items.length === 0) {
    warnings.push('AI did not extract any scope items from the notes.');
  }

  for (const item of output.scope_items) {
    // Reject negative quantities
    if (item.quantity !== null && item.quantity <= 0) {
      warnings.push(`Discarded item "${item.extracted_name}" due to invalid non-positive quantity: ${item.quantity}`);
      continue;
    }

    // Unmatched catalog items → clarification
    if (!item.catalog_item_id) {
      clarificationItems.push({
        extracted_name: item.extracted_name,
        question: item.clarification_question || `Could not match "${item.extracted_name}" to a catalog item. Please select a matching pricing item.`,
        proposed_catalog_item_id: null
      });
      continue;
    }

    // Missing quantity or explicit clarification flag → clarification
    if (item.quantity === null || item.requires_clarification || item.confidence < 0.70) {
      clarificationItems.push({
        extracted_name: item.extracted_name,
        question: item.clarification_question || `Clarification needed for "${item.extracted_name}": please confirm quantity or specs.`,
        proposed_catalog_item_id: item.catalog_item_id
      });
      continue;
    }

    // Clean valid item
    cleanScopeItems.push(item);
  }

  return {
    isValid: errors.length === 0,
    errors,
    warnings,
    cleanScopeItems,
    clarificationItems
  };
}
