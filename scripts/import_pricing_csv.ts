import fs from 'fs';
import path from 'path';
import { createClient } from '@supabase/supabase-js';
import dotenv from 'dotenv';

dotenv.config({ path: '.env.local' });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

function parseCSVLine(line: string): string[] {
  const result: string[] = [];
  let current = '';
  let inQuotes = false;

  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      if (inQuotes && line[i + 1] === '"') {
        current += '"';
        i++;
      } else {
        inQuotes = !inQuotes;
      }
    } else if (char === ',' && !inQuotes) {
      result.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  result.push(current.trim());
  return result;
}

function escapeSQLString(val: string | null): string {
  if (val === null || val === undefined || val === '') return 'NULL';
  return `'${val.replace(/'/g, "''")}'`;
}

function escapeSQLArray(synonymsStr: string): string {
  if (!synonymsStr) return "'{}'";
  const items = synonymsStr.split(';').map(s => s.trim()).filter(Boolean);
  if (items.length === 0) return "'{}'";
  const escapedItems = items.map(s => `"${s.replace(/"/g, '\\"')}"`);
  return `'${JSON.stringify(escapedItems).replace(/'/g, "''")}'::text[]`;
}

async function main() {
  console.log('📦 Reading Greenscape Pro pricing catalog CSV...');
  const csvPath = path.join(process.cwd(), 'greenscape_pro_pricing_catalog.csv');
  const fileContent = fs.readFileSync(csvPath, 'utf8');
  const lines = fileContent.split(/\r?\n/).filter(line => line.trim().length > 0);

  const header = parseCSVLine(lines[0]);
  console.log(`Found ${lines.length - 1} pricing items in CSV.`);

  const seedStatements: string[] = [
    '-- Demo Pricing Catalog Seed Data (201 Items)',
    '-- Sourced from greenscape_pro_pricing_catalog.csv',
    'TRUNCATE TABLE pricing_items CASCADE;'
  ];

  const pricingRows = [];

  for (let i = 1; i < lines.length; i++) {
    const cols = parseCSVLine(lines[i]);
    if (cols.length < 17) continue;

    const row = {
      item_id: cols[0],
      category: cols[1],
      subcategory: cols[2] || null,
      name: cols[3],
      description: cols[4] || null,
      unit: cols[5],
      unit_price: parseFloat(cols[6]),
      min_quantity: cols[7] ? parseFloat(cols[7]) : null,
      typical_quantity: cols[8] ? parseFloat(cols[8]) : null,
      max_quantity: cols[9] ? parseFloat(cols[9]) : null,
      synonyms: cols[10] ? cols[10].split(';').map(s => s.trim()).filter(Boolean) : [],
      requires_dimensions: cols[11]?.toUpperCase() === 'TRUE',
      requires_material: cols[12]?.toUpperCase() === 'TRUE',
      requires_site_verify: cols[13]?.toUpperCase() === 'TRUE',
      clarification_question: cols[14] || null,
      confidence_notes: cols[15] || null,
      active: cols[16]?.toUpperCase() === 'TRUE'
    };

    pricingRows.push(row);

    const sql = `INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      ${escapeSQLString(row.item_id)},
      ${escapeSQLString(row.category)},
      ${escapeSQLString(row.subcategory)},
      ${escapeSQLString(row.name)},
      ${escapeSQLString(row.description)},
      ${escapeSQLString(row.unit)},
      ${row.unit_price},
      ${row.min_quantity ?? 'NULL'},
      ${row.typical_quantity ?? 'NULL'},
      ${row.max_quantity ?? 'NULL'},
      ARRAY[${row.synonyms.map(s => escapeSQLString(s)).join(', ')}]::text[],
      ${row.requires_dimensions},
      ${row.requires_material},
      ${row.requires_site_verify},
      ${escapeSQLString(row.clarification_question)},
      ${escapeSQLString(row.confidence_notes)},
      ${row.active}
    );`;

    seedStatements.push(sql);
  }

  // Write SQL seed file
  const seedPath = path.join(process.cwd(), 'supabase', 'seed', 'pricing_catalog_seed.sql');
  fs.mkdirSync(path.dirname(seedPath), { recursive: true });
  fs.writeFileSync(seedPath, seedStatements.join('\n'), 'utf8');
  console.log(`✅ SQL Seed file generated at: ${seedPath}`);

  // Attempt direct API import to Supabase if credentials exist
  if (supabaseUrl && supabaseServiceKey && !supabaseUrl.includes('your-project')) {
    console.log('🚀 Supabase credentials detected. Upserting rows directly...');
    const supabase = createClient(supabaseUrl, supabaseServiceKey);
    const { error } = await supabase.from('pricing_items').upsert(pricingRows, { onConflict: 'item_id' });
    if (error) {
      console.error('❌ Direct Supabase upsert error:', error.message);
    } else {
      console.log(`🎉 Successfully imported ${pricingRows.length} catalog items into Supabase!`);
    }
  } else {
    console.log('ℹ️ No live Supabase credentials found in .env.local. The SQL seed file can be executed in Supabase SQL Editor.');
  }
}

main().catch(err => {
  console.error('Import failed:', err);
  process.exit(1);
});
