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
const target = '20260912000007_public_blog_authors.sql';
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
  const author = '00000000-0000-0000-0000-000000000001';
  const reader = '00000000-0000-0000-0000-000000000002';
  await db.query('insert into auth.users(id,email) values($1,$2),($3,$4)', [author,'writer@up.edu.ph',reader,'reader@up.edu.ph']);
  await db.query("update profiles set full_name='Test Writer', avatar_url='https://example.test/avatar' where id=$1",[author]);
  for (const [slug,published,status] of [['visible',true,'approved'],['draft',false,'approved'],['pending',true,'pending'],['rejected',true,'rejected']]) {
    await db.query('insert into blog_posts(title,slug,author_id,published,approval_status) values($1,$1,$2,$3,$4)',[slug,author,published,status]);
  }
  await migrate(db,[target]);
  for (const [role,id] of [['anon',null],['authenticated',reader],['authenticated',author]]) {
    await db.exec('begin');
    await db.query("select set_config('request.jwt.claims',$1,true)",[JSON.stringify({sub:id,role})]);
    await db.exec(`set local role ${role}`);
    const rows=(await db.query('select * from published_blog_posts')).rows;
    assert.equal(rows.length,1);
    assert.equal(rows[0].slug,'visible');
    assert.deepEqual(rows[0].author,{full_name:'Test Writer',avatar_url:'https://example.test/avatar'});
    assert.ok(!JSON.stringify(rows).includes('@up.edu.ph'));
    if (role==='authenticated') assert.equal((await db.query('select id from profiles')).rows.length,1);
    await db.exec('rollback');
    await db.exec(`set role ${role}`);
    await assert.rejects(db.exec("update published_blog_posts set title='changed'"));
    await db.exec('reset role');
  }
  await db.query('delete from auth.users where id=$1',[author]);
  assert.equal((await db.query('select author from published_blog_posts')).rows[0].author,null);
  console.log('PASS: upgrade; anonymous/other-account/author attribution; moderation filtering; private profiles; write denial; deleted author.');
} finally { await db.close(); }
const clean = await database();
try { await migrate(clean,files); console.log(`PASS: clean replay of ${files.length} migrations.`); }
finally { await clean.close(); }

