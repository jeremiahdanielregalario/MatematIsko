-- ============================================================================
-- Admin question management
-- Security-definer RPCs that let the admin edit the question bank from the
-- web app without granting write access through Row-Level Security. Only the
-- hardcoded admin email can invoke them; the check runs inside the function
-- so it cannot be bypassed client-side.
--
-- Students never get INSERT/UPDATE/DELETE policies on courses/topics/
-- questions — these functions are the ONLY write path to the question bank.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Admin check: true when the signed-in user's JWT email is an admin.
-- ---------------------------------------------------------------------------
create or replace function public.is_admin()
returns boolean
language sql
stable
security definer
set search_path = public
as $$
  select coalesce(auth.jwt() ->> 'email', '') = any(array['jeremiah.regalario@gmail.com'])
$$;

revoke execute on function public.is_admin() from public, anon;
grant execute on function public.is_admin() to authenticated;

-- ---------------------------------------------------------------------------
-- Upsert a topic for a course. Returns the topic row (existing or created).
-- ---------------------------------------------------------------------------
create or replace function public.admin_upsert_topic(
  p_course_id uuid,
  p_name text,
  p_description text default null
)
returns public.topics
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.topics;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage topics';
  end if;
  if p_course_id is null or p_name is null or btrim(p_name) = '' then
    raise exception 'Topic name is required';
  end if;
  insert into public.topics (course_id, name, description)
  values (p_course_id, btrim(p_name), nullif(btrim(coalesce(p_description, '')), ''))
  on conflict (course_id, name) do update
    set description = excluded.description
  returning * into result;
  return result;
end;
$$;

revoke execute on function public.admin_upsert_topic(uuid, text, text) from public, anon;
grant execute on function public.admin_upsert_topic(uuid, text, text) to authenticated;

-- ---------------------------------------------------------------------------
-- Upsert a question (insert when p_id is null, update otherwise).
-- ---------------------------------------------------------------------------
create or replace function public.admin_upsert_question(
  p_id uuid default null,
  p_course_id uuid default null,
  p_topic_id uuid default null,
  p_title text default null,
  p_question_text text default null,
  p_difficulty text default null,
  p_year integer default null,
  p_exam_name text default null,
  p_question_number integer default null,
  p_answer text default null,
  p_solution text default null,
  p_hint text default null
)
returns public.questions
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.questions;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage questions';
  end if;
  if p_course_id is null or p_topic_id is null or p_year is null
     or p_exam_name is null or p_question_number is null
     or btrim(coalesce(p_title, '')) = ''
     or btrim(coalesce(p_question_text, '')) = ''
     or btrim(coalesce(p_answer, '')) = ''
     or btrim(coalesce(p_solution, '')) = '' then
    raise exception 'Required fields are missing';
  end if;
  if p_difficulty not in ('easy', 'medium', 'hard') then
    raise exception 'Difficulty must be easy, medium, or hard';
  end if;
  if not exists (select 1 from public.topics where id = p_topic_id and course_id = p_course_id) then
    raise exception 'Topic does not belong to the selected course';
  end if;

  insert into public.questions
    (id, course_id, topic_id, title, question_text, difficulty, year,
     exam_name, question_number, answer, solution, hint)
  values
    (coalesce(p_id, gen_random_uuid()), p_course_id, p_topic_id,
     btrim(p_title), p_question_text, p_difficulty, p_year, btrim(p_exam_name),
     p_question_number, p_answer, p_solution, nullif(btrim(coalesce(p_hint, '')), ''))
  on conflict (id) do update
    set course_id = excluded.course_id,
        topic_id = excluded.topic_id,
        title = excluded.title,
        question_text = excluded.question_text,
        difficulty = excluded.difficulty,
        year = excluded.year,
        exam_name = excluded.exam_name,
        question_number = excluded.question_number,
        answer = excluded.answer,
        solution = excluded.solution,
        hint = excluded.hint
  returning * into result;
  return result;
end;
$$;

revoke execute on function public.admin_upsert_question(uuid, uuid, uuid, text, text, text, integer, text, integer, text, text, text) from public, anon;
grant execute on function public.admin_upsert_question(uuid, uuid, uuid, text, text, text, integer, text, integer, text, text, text) to authenticated;

-- ---------------------------------------------------------------------------
-- Delete a question. Cascades to the student's bookmarks/progress rows.
-- ---------------------------------------------------------------------------
create or replace function public.admin_delete_question(p_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage questions';
  end if;
  delete from public.questions where id = p_id;
  if not found then
    raise exception 'Question not found';
  end if;
end;
$$;

revoke execute on function public.admin_delete_question(uuid) from public, anon;
grant execute on function public.admin_delete_question(uuid) to authenticated;

-- ---------------------------------------------------------------------------
-- Delete an empty topic. Refuses while it still has questions so content is
-- never silently destroyed.
-- ---------------------------------------------------------------------------
create or replace function public.admin_delete_topic(p_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  question_count integer;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage topics';
  end if;
  select count(*) into question_count from public.questions where topic_id = p_id;
  if question_count > 0 then
    raise exception 'Cannot delete a topic that still has questions';
  end if;
  delete from public.topics where id = p_id;
  if not found then
    raise exception 'Topic not found';
  end if;
end;
$$;

revoke execute on function public.admin_delete_topic(uuid) from public, anon;
grant execute on function public.admin_delete_topic(uuid) to authenticated;
