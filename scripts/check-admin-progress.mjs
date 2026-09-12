// Isolated PostgreSQL verification. Supply a locally installed PGlite module path:
// node scripts/check-admin-users.mjs /path/to/pglite/dist/index.js
// No production connections. Auth helpers below model verified Supabase JWT claims.
import assert from 'node:assert/strict';
import { readFile, readdir } from 'node:fs/promises';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
const { PGlite } = await import(process.argv[2] ? pathToFileURL(resolve(process.argv[2])).href : '@electric-sql/pglite');
const root = new URL('../supabase/migrations/', import.meta.url);
const files = (await readdir(root)).filter(name => name.endsWith('.sql')).sort();
const target = '20260912000004_admin_user_progress.sql';
const source = await readFile(new URL('20260808000004_admin_question_management.sql', root), 'utf8');
// Derive the existing admin identity without copying it into fixtures or output.
const adminEmail = source.match(/any\(array\['([^']+)'\]/)?.[1];
assert.ok(adminEmail);
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
  const student = '00000000-0000-0000-0000-000000000001';
  const other = '00000000-0000-0000-0000-000000000002';
  const admin = '00000000-0000-0000-0000-000000000003';
  await db.query('insert into auth.users(id,email) values($1,$2),($3,$4),($5,$6)', [student,'fixture-one@up.edu.ph',other,'fixture-two@up.edu.ph',admin,adminEmail]);
  await migrate(db, [target]);
  async function asRole(role, id, operation) {
    await db.exec('begin');
    try {
      await db.query("select set_config('request.jwt.claims',$1,true)",[JSON.stringify({sub:id,role})]);
      await db.exec(`set local role ${role}`);
      const result=await operation(); await db.exec('commit'); return result;
    } catch(error) { await db.exec('rollback'); throw error; }
  }
  const read=()=>db.query('select public.admin_user_progress($1) as result',[student]);
  const reset=(course=null)=>db.query('select public.admin_reset_user_progress($1,$2)',[student,course]);
  for (const [role,id] of [['anon',null],['authenticated',student],['authenticated',other]]) {
    await assert.rejects(asRole(role,id,read),{code:'42501'});
    await assert.rejects(asRole(role,id,()=>reset()),{code:'42501'});
  }
  const questions=(await db.query('select distinct on (course_id) id,course_id from public.questions order by course_id,id limit 2')).rows;
  assert.equal(questions.length,2);
  const [q1,q2]=questions;
  const theorem=(await db.query('select id,course_id from public.theorems order by id limit 1')).rows[0];
  assert.ok(theorem);
  await db.query('insert into public.user_courses(user_id,course_id) values($1,$2)',[student,q1.course_id]);
  await db.query("insert into public.progress(user_id,question_id,status,attempts,last_attempted_at) values($1,$2,'mastered',3,now()),($1,$3,'learning',2,now()),($4,$2,'learning',1,now())",[student,q1.id,q2.id,other]);
  await db.query("insert into public.theorem_progress(user_id,theorem_id,status,last_reviewed_at) values($1,$2,'learning',now()),($3,$2,'mastered',now())",[student,theorem.id,other]);
  await db.query('insert into public.bookmarks(user_id,question_id) values($1,$2)',[student,q1.id]);
  let courses=(await asRole('authenticated',admin,read)).rows[0].result;
  assert.equal(courses.find(c=>c.id===q1.course_id).selected,true);
  assert.equal(courses.find(c=>c.id===q1.course_id).questions_mastered,1);
  assert.equal(courses.find(c=>c.id===q1.course_id).attempts,3);
  assert.equal(courses.find(c=>c.id===q2.course_id).selected,false);
  assert.equal(courses.find(c=>c.id===theorem.course_id).theorems_learning,1);
  await asRole('authenticated',admin,()=>reset(q1.course_id));
  assert.equal((await db.query('select * from public.progress where user_id=$1',[student])).rows.length,1);
  assert.equal((await db.query('select * from public.theorem_progress where user_id=$1',[student])).rows.length,theorem.course_id===q1.course_id?0:1);
  await asRole('authenticated',admin,()=>reset());
  await asRole('authenticated',admin,()=>reset());
  for (const table of ['progress','theorem_progress']) {
    assert.equal((await db.query(`select * from public.${table} where user_id=$1`,[student])).rows.length,0);
    assert.equal((await db.query(`select * from public.${table} where user_id=$1`,[other])).rows.length,1);
  }
  for (const table of ['bookmarks','user_courses','profiles']) {
    const key=table==='profiles'?'id':'user_id';
    assert.equal((await db.query(`select * from public.${table} where ${key}=$1`,[student])).rows.length,1);
  }
  courses=(await asRole('authenticated',admin,read)).rows[0].result;
  assert.equal(courses.length,1); assert.equal(courses[0].question_records,0);
  await assert.rejects(asRole('authenticated',admin,()=>reset('00000000-0000-0000-0000-000000000099')),{code:'P0002'});
  await asRole('authenticated',admin,()=>db.query('select public.admin_grant_access($1)',[other]));
  await asRole('authenticated',other,read);
  await asRole('authenticated',other,()=>reset());
  console.log('PASS: admin/delegated monitoring and resets, anon/student denial, selected and historical courses, separate aggregates, course/all reset, repeat reset, other-user isolation, retained bookmarks/enrollment/profile, missing course.');
} finally { await db.close(); }
const clean=await database();
try {await migrate(clean,files);console.log(`PASS: clean replay of ${files.length} ordered migrations (synthetic Auth).`);} finally {await clean.close();}
