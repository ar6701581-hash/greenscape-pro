import { GoogleGenerativeAI, SchemaType, ResponseSchema } from '@google/generative-ai';

const apiKey = process.env.GEMINI_API_KEY || 'placeholder-key-for-build';
const genAI = new GoogleGenerativeAI(apiKey);

// Gemini OpenAPI-style Schema definition matching ExtractionOutputSchema
const geminiResponseSchema: ResponseSchema = {
  type: SchemaType.OBJECT,
  properties: {
    project_summary: { type: SchemaType.STRING },
    scope_items: {
      type: SchemaType.ARRAY,
      items: {
        type: SchemaType.OBJECT,
        properties: {
          extracted_name: { type: SchemaType.STRING },
          catalog_item_id: { type: SchemaType.STRING, nullable: true },
          catalog_item_name: { type: SchemaType.STRING, nullable: true },
          category: { type: SchemaType.STRING },
          quantity: { type: SchemaType.NUMBER, nullable: true },
          unit: { type: SchemaType.STRING },
          confidence: { type: SchemaType.NUMBER },
          requires_clarification: { type: SchemaType.BOOLEAN },
          clarification_question: { type: SchemaType.STRING, nullable: true },
          special_conditions: { type: SchemaType.STRING, nullable: true },
          notes: { type: SchemaType.STRING, nullable: true }
        },
        required: ["extracted_name", "category", "unit", "confidence", "requires_clarification"]
      }
    },
    missing_information: {
      type: SchemaType.ARRAY,
      items: { type: SchemaType.STRING }
    },
    general_clarification_questions: {
      type: SchemaType.ARRAY,
      items: { type: SchemaType.STRING }
    },
    render_likely_required: { type: SchemaType.BOOLEAN },
    render_reason: { type: SchemaType.STRING, nullable: true },
    extraction_notes: { type: SchemaType.STRING, nullable: true }
  },
  required: ["project_summary", "scope_items", "missing_information", "general_clarification_questions", "render_likely_required"]
};

export const GEMINI_MODEL_NAME = process.env.GEMINI_MODEL || 'gemini-3.6-flash';

export function getGeminiModel() {
  return genAI.getGenerativeModel({
    model: GEMINI_MODEL_NAME,
    generationConfig: {
      responseMimeType: 'application/json',
      responseSchema: geminiResponseSchema,
      temperature: 0.1,
      maxOutputTokens: 8192
    }
  });
}
