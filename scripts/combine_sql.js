const fs = require('fs');
const path = require('path');

const p1 = fs.readFileSync(path.join(__dirname, '../supabase/migrations/0001_initial_schema.sql'), 'utf8');
const p2 = fs.readFileSync(path.join(__dirname, '../supabase/migrations/0002_indexes.sql'), 'utf8');
const p3 = fs.readFileSync(path.join(__dirname, '../supabase/migrations/0003_rls_policies.sql'), 'utf8');
const p4 = fs.readFileSync(path.join(__dirname, '../supabase/seed/pricing_catalog_seed.sql'), 'utf8');

const combined = [
  '-- ==========================================',
  '-- GREENSCAPE PRO - FULL DATABASE SETUP SCRIPT',
  '-- Run this entire script in Supabase SQL Editor',
  '-- ==========================================',
  '',
  p1,
  '',
  p2,
  '',
  p3,
  '',
  p4
].join('\n\n');

const outPath = path.join(__dirname, '../supabase/combined_setup.sql');
fs.writeFileSync(outPath, combined, 'utf8');
console.log('✅ Combined database setup script created at:', outPath);
