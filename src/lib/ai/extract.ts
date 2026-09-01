import { getGeminiModel } from './gemini';
import { SYSTEM_PROMPT, buildUserPrompt } from './prompts';
import { ExtractionOutputSchema, ExtractionOutput } from './schemas';

export interface CatalogItemManifest {
  id: string;
  item_id: string;
  name: string;
  category: string;
  subcategory: string | null;
  unit: string;
  synonyms: string[];
  requires_dimensions: boolean;
  requires_material: boolean;
  clarification_question: string | null;
}

export async function extractScopeFromNotes(
  rawNotes: string,
  catalogManifest: CatalogItemManifest[]
): Promise<{ output: ExtractionOutput; rawResponseText: string; latencyMs: number; isRetry: boolean }> {
  const startTime = Date.now();
  
  // Format manifest as compact JSON string
  const manifestJson = JSON.stringify(
    catalogManifest.map(item => ({
      id: item.id,
      item_id: item.item_id,
      name: item.name,
      category: item.category,
      subcategory: item.subcategory,
      unit: item.unit,
      synonyms: item.synonyms,
      requires_dimensions: item.requires_dimensions,
      requires_material: item.requires_material,
      clarification_question: item.clarification_question
    })),
    null,
    2
  );

  const fullSystemPrompt = SYSTEM_PROMPT.replace('{{CATALOG_MANIFEST}}', manifestJson);
  const userPrompt = buildUserPrompt(rawNotes);

  const model = getGeminiModel();

  let rawResponseText = '';

  try {
    const result = await model.generateContent({
      contents: [
        { role: 'user', parts: [{ text: fullSystemPrompt + '\n\n' + userPrompt }] }
      ]
    });

    rawResponseText = result.response.text();
    const cleanedText = rawResponseText.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/i, '').trim();
    const jsonParsed = JSON.parse(cleanedText);
    const validatedOutput = ExtractionOutputSchema.parse(jsonParsed);

    return {
      output: validatedOutput,
      rawResponseText,
      latencyMs: Date.now() - startTime,
      isRetry: false
    };
  } catch (firstError) {
    console.warn('⚠️ First Gemini extraction attempt failed or returned invalid JSON schema. Retrying once...', firstError);

    try {
      const retryResult = await model.generateContent({
        contents: [
          {
            role: 'user',
            parts: [
              {
                text: `${fullSystemPrompt}\n\nATTENTION: Previous attempt failed schema validation or returned malformed JSON. Output strictly valid JSON conforming to schema without truncation or Markdown backticks.\n\n${userPrompt}`
              }
            ]
          }
        ]
      });

      rawResponseText = retryResult.response.text();
      const cleanedRetryText = rawResponseText.replace(/^```(?:json)?\s*/i, '').replace(/\s*```$/i, '').trim();
      const retryJsonParsed = JSON.parse(cleanedRetryText);
      const retryValidatedOutput = ExtractionOutputSchema.parse(retryJsonParsed);

      return {
        output: retryValidatedOutput,
        rawResponseText,
        latencyMs: Date.now() - startTime,
        isRetry: true
      };
    } catch (retryError) {
      console.error('❌ Controlled retry also failed Gemini extraction:', retryError);
      throw new Error(`AI extraction failed schema validation after 1 retry: ${(retryError as Error).message}`);
    }
  }
}
