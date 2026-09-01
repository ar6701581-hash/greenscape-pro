import { NextResponse } from 'next/server';
import { supabaseAdmin } from '@/lib/supabase/server';

export async function GET(req: Request) {
  try {
    const { searchParams } = new URL(req.url);
    const query = searchParams.get('q');

    let dbQuery = supabaseAdmin
      .from('pricing_items')
      .select('id, item_id, name, category, subcategory, unit, unit_price, min_quantity, max_quantity, active')
      .eq('active', true)
      .order('category', { ascending: true })
      .order('name', { ascending: true });

    if (query) {
      dbQuery = dbQuery.or(`name.ilike.%${query}%,category.ilike.%${query}%,item_id.ilike.%${query}%`);
    }

    const { data: items, error } = await dbQuery;

    if (error) {
      return NextResponse.json({ error: error.message }, { status: 500 });
    }

    return NextResponse.json({ items: items || [] });
  } catch (err) {
    return NextResponse.json({ error: (err as Error).message }, { status: 500 });
  }
}
