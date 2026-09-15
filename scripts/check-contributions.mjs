// Isolated PostgreSQL verification. Supply a locally installed PGlite module path:
// node scripts/check-contributions.mjs /path/to/pglite/dist/index.js
// No production connections. Auth helpers below model verified Supabase JWT claims.
import assert from 'node:assert/strict';
import { readFile, readdir } from 'node:fs/promises';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';
const { PGlite } = await import(process.argv[2] ? pathToFileURL(resolve(process.argv[2])).href : '@electric-sql/pglite');
const root = new URL('../supabase/migrations/', import.meta.url);
const files = (await readdir(root)).filter(name => name.endsWith('.sql')).sort();
const target = '20260915000001_content_contributions.sql';
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
  const users = ['00000000-0000-4000-8000-000000000001','00000000-0000-4000-8000-000000000002','00000000-0000-4000-8000-000000000003'];
  await db.query('insert into auth.users(id,email) values($1,$2),($3,$4),($5,$6)', [users[0],'writer@up.edu.ph',users[1],'other@up.edu.ph',users[2],'admin@up.edu.ph']);
  await db.query('insert into admin_roles(user_id,granted_by) values($1,$1)', [users[2]]);
  const topic = (await db.query('select id,course_id from topics limit 1')).rows[0];
  const course = topic.course_id;
  const otherCourse = (await db.query('select id from courses where id<>$1 limit 1',[course])).rows[0].id;
  const count = async table => (await db.query(`select count(*)::int as n from ${table}`)).rows[0].n;
  const originalQuestions = await count('questions');
  const originalNotes = await count('course_notes');
  await migrate(db, [target]);
  assert.equal(await count('questions'),originalQuestions);
  assert.equal(await count('course_notes'),originalNotes);
  async function login(id, role='authenticated') {
    await db.exec('reset role');
    await db.query("select set_config('request.jwt.claims',$1,false)",[JSON.stringify({sub:id,role})]);
    await db.exec(`set role ${role}`);
  }
  const questionPayload = {topic_id:topic.id,question_text:'Find the derivative.\n\n$$\nf(x) = x^2\n$$\n', answer:'$2x$', solution:'By the power rule, $f\u0027(x) = 2x$.',hint:null,difficulty:'easy',year:2026,question_number:1,exam_name:'Original practice',status:'approved',author_id:users[1]};
  const ids=['10000000-0000-4000-8000-000000000001','10000000-0000-4000-8000-000000000002','10000000-0000-4000-8000-000000000003'];
  const submit = (id,kind='question',payload=questionPayload,selectedCourse=course) => db.query('select (submit_content_contribution($1,$2,$3,$4,$5)).*',[id,kind,selectedCourse,'Synthetic contribution',payload]);
  const review = (id,decision,note=null) => db.query('select (admin_review_contribution($1,$2,$3)).*',[id,decision,note]);
  await login(null,'anon');
  await assert.rejects(submit(ids[0]),/permission denied/);
  await assert.rejects(db.query('select * from content_contributions'),/permission denied/);
  await login(users[0]);
  await assert.rejects(submit(ids[0],'question',questionPayload,otherCourse),/Topic does not belong/);
  await assert.rejects(submit(ids[0],'question',{...questionPayload,answer:''}),/Required field/);
  await assert.rejects(submit(ids[0],'question',{...questionPayload,year:0}),/Invalid question/);
  const submitted=(await submit(ids[0])).rows[0];
  assert.equal(submitted.status,'pending');
  assert.equal(submitted.author_id,users[0]);
  assert.equal(submitted.payload.status,undefined);
  assert.equal(submitted.payload.author_id,undefined);
  assert.equal((await submit(ids[0])).rows[0].id,ids[0]);
  await assert.rejects(submit(ids[0],'question',{...questionPayload,answer:'different'}),/already in use/);
  await submit(ids[1],'note',{content:'# Definition\n\nA synthetic course note.'});
  await submit(ids[2],'note',{content:'Needs revision.'});
  assert.equal(await count('content_contributions'),3);
  await assert.rejects(review(ids[0],'approved'),/Only administrators/);
  await assert.rejects(db.query("update content_contributions set status='approved' where id=$1",[ids[0]]),/permission denied/);
  await assert.rejects(db.query('delete from content_contributions where id=$1',[ids[0]]),/permission denied/);
  await assert.rejects(db.query("insert into content_contributions(id,author_id,author_name,kind,course_id,title,payload,status) values(gen_random_uuid(),$1,'Spoof','note',$2,'Spoof','{}','approved')",[users[1],course]),/permission denied/);
  await assert.rejects(db.query("insert into course_notes(course_id,title,content) values($1,'Bypass','Unreviewed')",[course]),/permission denied|row-level security/);
  await assert.rejects(db.query('select admin_upsert_question()'),/Only administrators/);
  await login(users[1]);
  assert.equal(await count('content_contributions'),0);
  await assert.rejects(submit(ids[0]),/already in use/);
  await db.exec('reset role');
  assert.equal(await count('questions'),originalQuestions);
  assert.equal(await count('course_notes'),originalNotes);
  await login(users[2]);
  assert.equal(await count('content_contributions'),3);
  const approved=(await review(ids[0],'approved','Looks good')).rows[0];
  assert.equal(approved.status,'approved');
  assert.ok(approved.published_id);
  assert.equal((await review(ids[0],'approved')).rows[0].published_id,approved.published_id);
  await assert.rejects(review(ids[0],'rejected','Changed my mind'),/already been reviewed/);
  const note=(await review(ids[1],'approved')).rows[0];
  await assert.rejects(review(ids[2],'rejected'),/Explain what needs to change/);
  await review(ids[2],'rejected','Please explain the definition.');
  await assert.rejects(review(ids[2],'approved'),/already been reviewed/);
  await db.exec('reset role');
  assert.equal(await count('questions'),originalQuestions+1);
  assert.equal(await count('course_notes'),originalNotes+1);
  assert.equal((await db.query('select question_text from questions where id=$1',[approved.published_id])).rows[0].question_text,questionPayload.question_text);
  assert.equal((await db.query('select content from course_notes where id=$1',[note.published_id])).rows[0].content,'# Definition\n\nA synthetic course note.');
  // Approval failure must roll back publication and keep the queue item pending.
  await login(users[0]);
  const broken='10000000-0000-4000-8000-000000000004';
  await submit(broken);
  await db.exec('reset role');
  await db.query("update content_contributions set payload=jsonb_set(payload,'{topic_id}',to_jsonb(gen_random_uuid()::text)) where id=$1",[broken]);
  await login(users[2]);
  await assert.rejects(review(broken,'approved'),/no longer available/);
  assert.equal((await db.query('select status from content_contributions where id=$1',[broken])).rows[0].status,'pending');
  await db.exec('reset role');
  assert.equal(await count('questions'),originalQuestions+1);
  await login(users[0]);
  assert.equal((await db.query('select review_note from content_contributions where id=$1',[ids[2]])).rows[0].review_note,'Please explain the definition.');
  console.log('PASS: upgrade; author isolation; anonymous and direct-write denial; validation; immutable pending submissions; question/note approval; idempotent retries; rejection feedback; conflicting decisions; failed-publication rollback.');
} finally { await db.close(); }
const clean = await database();
try { await migrate(clean,files); console.log(`PASS: clean replay of ${files.length} migrations.`); }
finally { await clean.close(); }
