import { z } from 'zod';

export const ScopeItemSchema = z.object({
  extracted_name: z.string().describe("Original term or feature described by the user in the site walk notes"),
  catalog_item_id: z.string().uuid().nullable().describe("Matched pricing item UUID from the catalog manifest, or null if unmatched"),
  catalog_item_name: z.string().nullable().describe("Canonical matched pricing item name, or null"),
  category: z.string().describe("Category of the item"),
  quantity: z.number().positive().nullable().describe("Inferred or extracted numeric quantity, or null if missing/ambiguous"),
  unit: z.string().describe("Unit of measurement (e.g. sqft, linear_ft, each, project, zone, cubic_yard)"),
  confidence: z.number().min(0).max(1).describe("Confidence score between 0.0 and 1.0"),
  requires_clarification: z.boolean().describe("True if quantity is missing, match is low-confidence, or required material/dimension info is missing"),
  clarification_question: z.string().nullable().describe("Clarification question to ask Marcus if ambiguity or missing info exists"),
  special_conditions: z.string().nullable().describe("Any special site conditions, access restrictions, or notes"),
  notes: z.string().nullable().describe("Additional extracted reasoning or notes")
});

export const ExtractionOutputSchema = z.object({
  project_summary: z.string().describe("Concise 2-3 sentence overview of the requested scope"),
  scope_items: z.array(ScopeItemSchema).describe("List of extracted scope items mapped to catalog items"),
  missing_information: z.array(z.string()).describe("List of critical missing details needed for complete pricing"),
  general_clarification_questions: z.array(z.string()).describe("General questions for the customer or site reviewer"),
  render_likely_required: z.boolean().describe("Advisory flag: true if project scope appears complex or high-value enough to likely need a 3D render"),
  render_reason: z.string().nullable().describe("Advisory note on why render is likely required"),
  extraction_notes: z.string().nullable().describe("General notes from the AI extraction pass")
});

export type ScopeItem = z.infer<typeof ScopeItemSchema>;
export type ExtractionOutput = z.infer<typeof ExtractionOutputSchema>;
