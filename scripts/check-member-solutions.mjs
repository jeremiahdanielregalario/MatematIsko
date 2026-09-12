// Isolated PostgreSQL verification. Supply a locally installed PGlite module path:
// node scripts/check-member-solutions.mjs /path/to/pglite/dist/index.js
// No production connections. Auth helpers below model verified Supabase JWT claims.
import assert from 'node:assert/strict';
import { readFile, readdir } from 'node:fs/promises';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
const { PGlite } = await import(process.argv[2] ? pathToFileURL(resolve(process.argv[2])).href : '@electric-sql/pglite');
const root = new URL('../supabase/migrations/', import.meta.url);
const files = (await readdir(root)).filter(name => name.endsWith('.sql')).sort();
const target = '20260912000008_verified_member_solutions.sql';
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
  await migrate(db,files.filter(n=>n<target));
  const student='00000000-0000-0000-0000-000000000001';
  const admin='00000000-0000-0000-0000-000000000002';
  const other='00000000-0000-0000-0000-000000000003';
  await db.query('insert into auth.users(id,email) values($1,$2),($3,$4),($5,$6)',[student,'fixture-one@up.edu.ph',admin,'fixture-admin@up.edu.ph',other,'fixture-other@up.edu.ph']);
  await db.query('insert into admin_roles(user_id,granted_by) values($1,$1)',[admin]);
  await db.query('update profiles set upmmc_member=true where id=$1',[student]);
  const fixtures=[];
  for (const code of ['MATH 20','Math 21','MATH 22','MATH 23','STAT 101','MATH 126','MATH 210']) {
    let c=(await db.query('select id from courses where code=$1',[code])).rows[0];
    if (!c) c=(await db.query('insert into courses(code,name) values($1,$1) returning id',[code])).rows[0];
    const t=(await db.query("insert into topics(course_id,name) values($1,'Access fixture') returning id",[c.id])).rows[0];
    const q=(await db.query("insert into questions(course_id,topic_id,title,question_text,difficulty,year,exam_name,question_number,answer,solution,hint) values($1,$2,'Access fixture','Prompt','easy',2026,'Test',1,'Answer','Protected worked content','Hint') returning id",[c.id,t.id])).rows[0];
    fixtures.push({id:q.id,open:fixtures.length<5});
  }
  await migrate(db,[target]);
  async function asRole(role,id,fn) {
    await db.exec('begin');
    try {
      await db.query("select set_config('request.jwt.claims',$1,true)",[JSON.stringify({sub:id,role})]);
      await db.exec(`set local role ${role}`);
      const result=await fn(); await db.exec('commit'); return result;
    } catch(e) {await db.exec('rollback');throw e;}
  }
  const asStudent=fn=>asRole('authenticated',student,fn);
  const asAdmin=fn=>asRole('authenticated',admin,fn);
  async function verify(value,expected) {
    return asAdmin(()=>db.query('select public.admin_update_profile_verified($1,null,null,null,true,$2,$3)',[student,value,expected]));
  }
  const snapshot={full_name:null,degree_program:null,year_level:null,upmmc_member:true,upmmc_verified:false};
  // Auth seed may set a default display name; use synthetic record's current snapshot.
  snapshot.full_name=(await db.query('select full_name from profiles where id=$1',[student])).rows[0].full_name;
  for (const f of fixtures) {
    const row=(await asStudent(()=>db.query('select * from study_questions where id=$1',[f.id]))).rows[0];
    assert.equal(row.solution,f.open?'Protected worked content':'Not available');
    assert.equal(row.answer,'Answer'); assert.equal(row.hint,'Hint'); assert.equal(row.question_text,'Prompt');
    assert.ok(row.course); assert.ok(row.topic);
    assert.equal((await asStudent(()=>db.query('select solution from questions where id=$1',[f.id]))).rows.length,f.open?1:0);
  }
  await assert.rejects(asRole('anon',null,()=>db.query('select * from study_questions')),{code:'42501'});
  await assert.rejects(asStudent(()=>db.query('update profiles set upmmc_verified=true where id=$1',[student])),{code:'42501'});
  await assert.rejects(asStudent(()=>db.query('select admin_update_profile_verified($1,null,null,null,true,true,$2)',[student,snapshot])),{code:'42501'});
  await assert.rejects(asStudent(()=>db.query("update study_questions set solution='changed'")));
  const restricted=fixtures[5].id;
  assert.equal((await asAdmin(()=>db.query('select solution from study_questions where id=$1',[restricted]))).rows[0].solution,'Protected worked content');
  await verify(true,snapshot);
  assert.equal((await asStudent(()=>db.query('select solution from study_questions where id=$1',[restricted]))).rows[0].solution,'Protected worked content');
  assert.equal((await asStudent(()=>db.query('select solution from questions where id=$1',[restricted]))).rows[0].solution,'Protected worked content');
  assert.equal((await asRole('authenticated',other,()=>db.query('select solution from study_questions where id=$1',[restricted]))).rows[0].solution,'Not available');
  const directory=(await asAdmin(()=>db.query("select admin_list_profiles('',0,25) as result"))).rows[0].result;
  assert.equal(directory.users.find(p=>p.id===student).upmmc_verified,true);
  await assert.rejects(verify(false,snapshot),{code:'40001'});
  await verify(false,{...snapshot,upmmc_verified:true});
  assert.equal((await asStudent(()=>db.query('select solution from study_questions where id=$1',[restricted]))).rows[0].solution,'Not available');
  console.log('PASS: all five course exceptions, near-match denial, self-declaration denial, anonymous and direct-table boundaries, admin editing, verification, cross-user isolation, stale edits, revocation.');
} finally {await db.close();}
const clean=await database();
try {await migrate(clean,files);console.log(`PASS: clean replay of ${files.length} migrations.`);}
finally {await clean.close();}
