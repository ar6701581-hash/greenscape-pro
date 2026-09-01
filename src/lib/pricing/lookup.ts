import { supabaseAdmin } from '../supabase/server';
import { CatalogItemManifest } from '../ai/extract';

export interface PricingItemRecord {
  id: string;
  item_id: string;
  category: string;
  subcategory: string | null;
  name: string;
  description: string | null;
  unit: string;
  unit_price: number;
  min_quantity: number | null;
  typical_quantity: number | null;
  max_quantity: number | null;
  synonyms: string[];
  requires_dimensions: boolean;
  requires_material: boolean;
  requires_site_verify: boolean;
  clarification_question: string | null;
  confidence_notes: string | null;
  active: boolean;
}

export async function fetchActiveCatalogManifest(): Promise<CatalogItemManifest[]> {
  const { data, error } = await supabaseAdmin
    .from('pricing_items')
    .select('id, item_id, name, category, subcategory, unit, synonyms, requires_dimensions, requires_material, clarification_question')
    .eq('active', true);

  if (error) {
    console.error('Failed to fetch pricing catalog manifest from Supabase:', error.message);
    return [];
  }

  return (data || []).map(item => ({
    id: item.id,
    item_id: item.item_id,
    name: item.name,
    category: item.category,
    subcategory: item.subcategory,
    unit: item.unit,
    synonyms: item.synonyms || [],
    requires_dimensions: item.requires_dimensions,
    requires_material: item.requires_material,
    clarification_question: item.clarification_question
  }));
}

export async function getPricingItemById(id: string): Promise<PricingItemRecord | null> {
  const { data, error } = await supabaseAdmin
    .from('pricing_items')
    .select('*')
    .eq('id', id)
    .eq('active', true)
    .single();

  if (error || !data) return null;
  return data as PricingItemRecord;
}
