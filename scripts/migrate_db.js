const { Client } = require('pg');
const fs = require('fs');
const path = require('path');
const dotenv = require('dotenv');

dotenv.config({ path: path.join(__dirname, '../.env.local') });

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL || '';
const projectRef = supabaseUrl.replace('https://', '').replace('.supabase.co', '').trim();
const serviceKey = process.env.SUPABASE_SERVICE_ROLE_KEY || '';

// Extract JWT secret or use pooler password if available, or direct connection
// Supabase pooler: postgres.[projectRef]:[password]@aws-0-us-west-1.pooler.supabase.com:6543/postgres
// Direct connection using database password or Supabase REST endpoint SQL if available

console.log(`📡 Project Reference: ${projectRef}`);
console.log(`🔗 Supabase URL: ${supabaseUrl}`);
