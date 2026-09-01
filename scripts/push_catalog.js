const { createClient } = require('@supabase/supabase-js');
const dotenv = require('dotenv');
const path = require('path');
const fs = require('fs');

dotenv.config({ path: path.join(__dirname, '../.env.local') });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing Supabase URL or Service Key in .env.local');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

function parseCSVLine(line) {
  const result = [];
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

async function runSetup() {
  console.log(`🚀 Connecting to Supabase project at ${supabaseUrl}...`);

  // 1. Parse CSV catalog
  const csvPath = path.join(__dirname, '../greenscape_pro_pricing_catalog.csv');
  const fileContent = fs.readFileSync(csvPath, 'utf8');
  const lines = fileContent.split(/\r?\n/).filter(line => line.trim().length > 0);

  const catalogRows = [];

  for (let i = 1; i < lines.length; i++) {
    const cols = parseCSVLine(lines[i]);
    if (cols.length < 17) continue;

    catalogRows.push({
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
    });
  }

  console.log(`📦 Upserting ${catalogRows.length} catalog items via Supabase REST API...`);

  // Upsert catalog items in chunks of 50
  for (let i = 0; i < catalogRows.length; i += 50) {
    const chunk = catalogRows.slice(i, i + 50);
    const { error } = await supabase.from('pricing_items').upsert(chunk, { onConflict: 'item_id' });
    if (error) {
      console.error(`⚠️ Chunk ${i / 50 + 1} upsert error (table might not exist yet):`, error.message);
    } else {
      console.log(`  ✓ Batch ${i / 50 + 1} (${chunk.length} items) upserted successfully.`);
    }
  }
}

runSetup().catch(console.error);
