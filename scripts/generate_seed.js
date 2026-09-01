const fs = require('fs');
const path = require('path');

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

function escapeSQLString(val) {
  if (val === null || val === undefined || val === '') return 'NULL';
  return `'${val.replace(/'/g, "''")}'`;
}

function main() {
  console.log('📦 Reading Greenscape Pro pricing catalog CSV...');
  const csvPath = path.join(process.cwd(), 'greenscape_pro_pricing_catalog.csv');
  const fileContent = fs.readFileSync(csvPath, 'utf8');
  const lines = fileContent.split(/\r?\n/).filter(line => line.trim().length > 0);

  console.log(`Found ${lines.length - 1} pricing items in CSV.`);

  const seedStatements = [
    '-- Demo Pricing Catalog Seed Data (201 Items)',
    '-- Sourced from greenscape_pro_pricing_catalog.csv',
    'TRUNCATE TABLE pricing_items CASCADE;'
  ];

  for (let i = 1; i < lines.length; i++) {
    const cols = parseCSVLine(lines[i]);
    if (cols.length < 17) continue;

    const itemId = cols[0];
    const category = cols[1];
    const subcategory = cols[2] || null;
    const name = cols[3];
    const description = cols[4] || null;
    const unit = cols[5];
    const unitPrice = parseFloat(cols[6]);
    const minQty = cols[7] ? parseFloat(cols[7]) : null;
    const typQty = cols[8] ? parseFloat(cols[8]) : null;
    const maxQty = cols[9] ? parseFloat(cols[9]) : null;
    const synonyms = cols[10] ? cols[10].split(';').map(s => s.trim()).filter(Boolean) : [];
    const reqDim = cols[11]?.toUpperCase() === 'TRUE';
    const reqMat = cols[12]?.toUpperCase() === 'TRUE';
    const reqSite = cols[13]?.toUpperCase() === 'TRUE';
    const question = cols[14] || null;
    const notes = cols[15] || null;
    const active = cols[16]?.toUpperCase() === 'TRUE';

    const sql = `INSERT INTO pricing_items (
      item_id, category, subcategory, name, description, unit, unit_price,
      min_quantity, typical_quantity, max_quantity, synonyms,
      requires_dimensions, requires_material, requires_site_verify,
      clarification_question, confidence_notes, active
    ) VALUES (
      ${escapeSQLString(itemId)},
      ${escapeSQLString(category)},
      ${escapeSQLString(subcategory)},
      ${escapeSQLString(name)},
      ${escapeSQLString(description)},
      ${escapeSQLString(unit)},
      ${unitPrice},
      ${minQty ?? 'NULL'},
      ${typQty ?? 'NULL'},
      ${maxQty ?? 'NULL'},
      ARRAY[${synonyms.map(s => escapeSQLString(s)).join(', ')}]::text[],
      ${reqDim},
      ${reqMat},
      ${reqSite},
      ${escapeSQLString(question)},
      ${escapeSQLString(notes)},
      ${active}
    );`;

    seedStatements.push(sql);
  }

  const seedPath = path.join(process.cwd(), 'supabase', 'seed', 'pricing_catalog_seed.sql');
  fs.mkdirSync(path.dirname(seedPath), { recursive: true });
  fs.writeFileSync(seedPath, seedStatements.join('\n'), 'utf8');
  console.log(`✅ SQL Seed file successfully generated (${seedStatements.length - 3} rows) at:\n   ${seedPath}`);
}

main();
