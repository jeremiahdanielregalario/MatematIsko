// Isolated PostgreSQL verification. Supply a locally installed PGlite module path:
// node scripts/check-blog-authors.mjs /path/to/pglite/dist/index.js
// No production connections. Auth helpers below model verified Supabase JWT claims.
import assert from 'node:assert/strict';
import { readFile, readdir } from 'node:fs/promises';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
const { PGlite } = await import(process.argv[2] ? pathToFileURL(resolve(process.argv[2])).href : '@electric-sql/pglite');
const root = new URL('../supabase/migrations/', import.meta.url);
const files = (await readdir(root)).filter(name => name.endsWith('.sql')).sort();
const target = '20260913000001_question_report_duplicates.sql';
async function database() {
  const db = new PGlite();
  await db.exec(`create role anon; create role authenticated; create schema auth;
    create table auth.users(id uuid primary key, email text, raw_user_meta_data jsonb default '{}'::jsonb);
    create function auth.jwt() returns jsonb language sql stable as $$select coalesce(nullif(current_setting('request.jwt.claims', true), '')::jsonb, '{}'::jsonb)$$;
    create function auth.uid() returns uuid language sql stable as $$select (auth.jwt()->>'sub')::uuid$$;
    create function auth.role() returns text language sql stable as $$select auth.jwt()->>'role'$$;
    grant usage on schema auth to anon, authenticated;
    grant execute on function auth.jwt(), auth.uid(), auth.role() to anon, authenticated;`);
  return db;
}
async function migrate(db, names) {
  for (const name of names) {
    // Core gen_random_uuid() is built in; pgcrypto itself is unavailable in this WASM build.
    const sql = (await readFile(new URL(name, root), 'utf8')).replace(/^\uFEFF/, '').replace('create extension if not exists pgcrypto;', '');
    try { await db.exec(sql); } catch (error) { throw new Error(`Migration ${name}: ${error.message}`); }
  }
}


const db = await database();
try {
  await migrate(db, files.filter(name => name < target));
  const user = '00000000-0000-0000-0000-000000000001';
  const other = '00000000-0000-0000-0000-000000000002';
  await db.query('insert into auth.users(id,email) values($1,$2),($3,$4)', [user,'first@up.edu.ph',other,'second@up.edu.ph']);
  const question = (await db.query('select id from questions limit 1')).rows[0].id;
  await db.query("insert into question_reports(question_id,user_id,category) values($1,$2,'answer'),($1,$2,'answer')", [question,user]);
  await migrate(db, [target]);
  assert.equal((await db.query('select count(*)::int as n from question_reports')).rows[0].n, 2);
  await db.query("select set_config('request.jwt.claims',$1,false)",[JSON.stringify({sub:other,role:'authenticated'})]);
  await db.exec('set role authenticated');
  const submit = category => db.query('select submit_question_report($1,$2,$3)',[question,category,'Different wording']);
  await assert.rejects(submit('answer'), /already been sent/);
  await submit('hint');
  await assert.rejects(submit('hint'), /already been sent/);
  await assert.rejects(db.query("insert into question_reports(question_id,user_id,category) values($1,$2,'hint')",[question,other]), /already been sent/);
  assert.equal((await db.query('select * from question_reports')).rows.length, 1);
  await assert.rejects(db.query('select * from open_question_report_reasons'), /permission denied/);
  await db.exec('reset role');
  const legacy = (await db.query("select id from question_reports where category='answer'")).rows;
  await db.query("update question_reports set status='resolved' where id=$1",[legacy[0].id]);
  await assert.rejects(submit('answer'), /already been sent/);
  await db.query("update question_reports set status='resolved' where id=$1",[legacy[1].id]);
  await submit('answer');
  await assert.rejects(db.query("update question_reports set status='open' where id=$1",[legacy[0].id]), /already been sent/);
  await db.exec("delete from question_reports where category='hint'");
  await submit('hint');
  await db.exec('set role anon');
  await assert.rejects(submit('solution'), /permission denied/);
  await db.exec('reset role');
  console.log('PASS: legacy duplicates preserved; cross-user/category rejection; direct insert protection; resolve/reopen/delete lifecycle; private report boundaries; anonymous denial.');
} finally { await db.close(); }
const clean = await database();
try { await migrate(clean,files); console.log('PASS: clean replay of ' + files.length + ' migrations.'); }
finally { await clean.close(); }
