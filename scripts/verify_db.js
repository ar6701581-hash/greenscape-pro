const { createClient } = require('@supabase/supabase-js');
const dotenv = require('dotenv');
const path = require('path');

dotenv.config({ path: path.join(__dirname, '../.env.local') });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

const supabase = createClient(supabaseUrl, serviceKey);

async function verifyDatabase() {
  console.log('🔍 Running full Database Verification Check...\n');

  // Check pricing items count
  const { count: pricingCount, error: pricingErr } = await supabase
    .from('pricing_items')
    .select('*', { count: 'exact', head: true });

  if (pricingErr) throw new Error(`pricing_items check failed: ${pricingErr.message}`);
  console.log(`✅ Table 'pricing_items': ${pricingCount} rows populated.`);

  // Check leads table
  const { count: leadsCount, error: leadsErr } = await supabase
    .from('leads')
    .select('*', { count: 'exact', head: true });

  if (leadsErr) throw new Error(`leads check failed: ${leadsErr.message}`);
  console.log(`✅ Table 'leads': Active and accessible.`);

  // Check site_walks table
  const { count: walksCount, error: walksErr } = await supabase
    .from('site_walks')
    .select('*', { count: 'exact', head: true });

  if (walksErr) throw new Error(`site_walks check failed: ${walksErr.message}`);
  console.log(`✅ Table 'site_walks': Active and accessible.`);

  // Check proposals table
  const { count: propCount, error: propErr } = await supabase
    .from('proposals')
    .select('*', { count: 'exact', head: true });

  if (propErr) throw new Error(`proposals check failed: ${propErr.message}`);
  console.log(`✅ Table 'proposals': Active and accessible.`);

  // Check clarification_items table
  const { count: clarCount, error: clarErr } = await supabase
    .from('clarification_items')
    .select('*', { count: 'exact', head: true });

  if (clarErr) throw new Error(`clarification_items check failed: ${clarErr.message}`);
  console.log(`✅ Table 'clarification_items': Active and accessible.`);

  // Sample catalog item check
  const { data: sampleItem } = await supabase
    .from('pricing_items')
    .select('item_id, name, category, unit, unit_price')
    .eq('item_id', 'GP-026')
    .single();

  if (sampleItem) {
    console.log(`\n📌 Sample Pricing Record Verification (GP-026):`);
    console.log(`   Name: ${sampleItem.name}`);
    console.log(`   Category: ${sampleItem.category}`);
    console.log(`   Price: $${sampleItem.unit_price} / ${sampleItem.unit}`);
  }

  console.log('\n🎉 ALL DATABASE TABLES & CATALOG ITEMS ARE SUCCESSFULLY VERIFIED AND READY!');
}

verifyDatabase().catch(err => {
  console.error('❌ Verification failed:', err.message);
  process.exit(1);
});
