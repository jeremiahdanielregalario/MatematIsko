-- ============================================================================
-- Admin course management
-- Security-definer RPCs for course CRUD + MATH 158 description update.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Upsert a course (insert when p_id is null, update otherwise).
-- Code must be unique; name is required; description is optional.
-- ---------------------------------------------------------------------------
create or replace function public.admin_upsert_course(
  p_id uuid default null,
  p_code text default null,
  p_name text default null,
  p_description text default null
)
returns public.courses
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.courses;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage courses';
  end if;
  if btrim(coalesce(p_code, '')) = '' or btrim(coalesce(p_name, '')) = '' then
    raise exception 'Course code and name are required';
  end if;

  insert into public.courses (id, code, name, description)
  values (coalesce(p_id, gen_random_uuid()), btrim(p_code), btrim(p_name), nullif(btrim(coalesce(p_description, '')), ''))
  on conflict (code) do update
    set name = excluded.name, description = excluded.description
  returning * into result;
  return result;
end;
$$;

revoke execute on function public.admin_upsert_course(uuid, text, text, text) from public, anon;
grant execute on function public.admin_upsert_course(uuid, text, text, text) to authenticated;

-- ---------------------------------------------------------------------------
-- Delete a course. Refuses if the course still has topics or questions.
-- ---------------------------------------------------------------------------
create or replace function public.admin_delete_course(p_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
declare
  topic_count integer;
  question_count integer;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage courses';
  end if;
  select count(*) into topic_count from public.topics where course_id = p_id;
  select count(*) into question_count from public.questions where course_id = p_id;
  if topic_count > 0 or question_count > 0 then
    raise exception 'Cannot delete a course that still has topics or questions';
  end if;
  delete from public.courses where id = p_id;
  if not found then
    raise exception 'Course not found';
  end if;
end;
$$;

revoke execute on function public.admin_delete_course(uuid) from public, anon;
grant execute on function public.admin_delete_course(uuid) to authenticated;

-- ---------------------------------------------------------------------------
-- Add official MATH 158 description from the UP Diliman Math catalog.
-- ---------------------------------------------------------------------------
update public.courses
set description = 'Permutations and combinations; binomial and multinomial coefficients; the Principle of Inclusion and Exclusion; graphs and their properties; families of graphs, distance and connectivity in graphs, selected topics in discrete mathematics.'
where code = 'MATH 158';
