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
const target = '20260912000001_delegated_admin_access.sql';
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
  await db.query(`insert into auth.users(id,email) values ($1,'fixture-one@up.edu.ph'),($2,'fixture-two@up.edu.ph'),($3,$4)`, [student,other,admin,adminEmail]);
  await migrate(db, [target]);
  async function asRole(role, claims, operation) {
    await db.exec('begin');
    try {
      await db.query("select set_config('request.jwt.claims',$1,true)",[JSON.stringify({...claims,role})]);
      await db.exec(`set local role ${role}`);
      const result = await operation();
      await db.exec('commit');
      return result;
    } catch(error) { await db.exec('rollback'); throw error; }
  }
  const studentClaims={sub:student,email:'fixture-one@up.edu.ph'};
  const adminClaims={sub:admin,email:adminEmail};
  const list=()=>db.query("select public.admin_list_profiles('',0,25) as result");
  const expected={full_name:null,degree_program:null,year_level:null,upmmc_member:false};
  const update=(snapshot=expected,year='2nd Year',id=student)=>db.query('select * from public.admin_update_profile($1,$2,$3,$4,$5,$6::jsonb)',[id,' Updated name ','BS Mathematics',year,true,JSON.stringify(snapshot)]);
  await assert.rejects(asRole('anon',{},list),{code:'42501'});
  await assert.rejects(asRole('anon',{},()=>update()),{code:'42501'});
  await assert.rejects(asRole('authenticated',studentClaims,list),{code:'42501'});
  await assert.rejects(asRole('authenticated',studentClaims,()=>update()),{code:'42501'});
  // User-supplied metadata is not an administrator identity.
  await assert.rejects(asRole('authenticated',{...studentClaims,user_metadata:{email:adminEmail}},list),{code:'42501'});
  const visible=await asRole('authenticated',studentClaims,()=>db.query('select id from public.profiles'));
  assert.deepEqual(visible.rows.map(row=>row.id),[student]);
  const forbidden=await asRole('authenticated',studentClaims,()=>db.query("update public.profiles set full_name='Forbidden' where id=$1 returning id",[other]));
  assert.equal(forbidden.rows.length,0);
  const directory=await asRole('authenticated',adminClaims,list);
  assert.equal(directory.rows[0].result.total,3);
  const page=await asRole('authenticated',adminClaims,()=>db.query("select public.admin_list_profiles('fixture-',1,1) as result"));
  assert.equal(page.rows[0].result.total,2);assert.equal(page.rows[0].result.users.length,1);
  const literal=await asRole('authenticated',adminClaims,()=>db.query("select public.admin_list_profiles('%',0,25) as result"));
  assert.equal(literal.rows[0].result.total,0);
  await assert.rejects(asRole('authenticated',adminClaims,()=>db.query("select public.admin_list_profiles('',0,101)")),{code:'22023'});
  const edited=await asRole('authenticated',adminClaims,()=>update());
  assert.equal(edited.rows[0].full_name,'Updated name');
  assert.equal(edited.rows[0].email,'fixture-one@up.edu.ph');
  assert.equal(edited.rows[0].upmmc_member,true);
  await assert.rejects(asRole('authenticated',adminClaims,()=>update()),{code:'40001'});
  await assert.rejects(asRole('authenticated',adminClaims,()=>update(expected,'Invalid year')),{code:'22023'});
  await assert.rejects(asRole('authenticated',adminClaims,()=>update(expected,'1st Year','00000000-0000-0000-0000-000000000099')),{code:'P0002'});
  const stored=await db.query('select email from auth.users where id=$1',[student]);
  assert.equal(stored.rows[0].email,'fixture-one@up.edu.ph');
  const grant = id => db.query('select public.admin_grant_access($1)', [id]);
  await assert.rejects(asRole('anon',{},()=>grant(student)),{code:'42501'});
  await assert.rejects(asRole('authenticated',studentClaims,()=>grant(student)),{code:'42501'});
  await assert.rejects(asRole('authenticated',adminClaims,()=>db.query('insert into public.admin_roles(user_id) values($1)',[student])),{code:'42501'});
  await assert.rejects(asRole('authenticated',studentClaims,()=>db.query('select * from public.admin_roles')),{code:'42501'});
  await asRole('authenticated',adminClaims,()=>grant(student));
  await asRole('authenticated',adminClaims,()=>grant(student));
  const role = await db.query('select granted_by from public.admin_roles where user_id=$1',[student]);
  assert.equal(role.rows.length,1); assert.equal(role.rows[0].granted_by,admin);
  assert.equal((await asRole('authenticated',studentClaims,()=>db.query('select public.is_admin() as allowed'))).rows[0].allowed,true);
  const delegated = await asRole('authenticated',studentClaims,list);
  assert.equal(delegated.rows[0].result.users.find(p=>p.id===student).is_admin,true);
  await asRole('authenticated',studentClaims,()=>grant(other));
  await assert.rejects(asRole('authenticated',adminClaims,()=>grant('00000000-0000-0000-0000-000000000099')),{code:'P0002'});
  console.log('PASS: delegated role grant, duplicate grant, grant attribution, delegated directory access and onward delegation; anonymous/student/direct-table escalation denied.');
  console.log('PASS: upgrade replay, anonymous/student denial, own-row RLS, metadata spoof denial, admin search/pagination, literal search, update, validation, conflict, missing user, and unchanged Auth identity.');
} finally { await db.close(); }
const clean=await database();
try {await migrate(clean,files);console.log(`PASS: clean replay of ${files.length} ordered migrations (pgcrypto declaration omitted; synthetic Auth helpers).`);} finally {await clean.close();}
