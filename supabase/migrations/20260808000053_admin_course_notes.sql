-- ============================================================================
-- Admin CRUD for course_notes
-- ============================================================================

-- Upsert a course note (insert or update)
create or replace function public.admin_upsert_course_note(
  p_course_id uuid,
  p_title text,
  p_content text default '',
  p_sort_order integer default 0,
  p_id uuid default null
)
returns public.course_notes
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.course_notes;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage course notes';
  end if;
  if p_title = '' then
    raise exception 'Title is required';
  end if;

  if p_id is not null then
    update public.course_notes
    set title = p_title,
        content = p_content,
        sort_order = p_sort_order,
        updated_at = now()
    where id = p_id
    returning * into result;
  else
    insert into public.course_notes (course_id, title, content, sort_order)
    values (p_course_id, p_title, p_content, p_sort_order)
    returning * into result;
  end if;

  return result;
end;
$$;

revoke execute on function public.admin_upsert_course_note(uuid, text, text, integer, uuid) from public, anon;
grant execute on function public.admin_upsert_course_note(uuid, text, text, integer, uuid) to authenticated;

-- Delete a course note
create or replace function public.admin_delete_course_note(
  p_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can delete course notes';
  end if;
  delete from public.course_notes where id = p_id;
end;
$$;

revoke execute on function public.admin_delete_course_note(uuid) from public, anon;
grant execute on function public.admin_delete_course_note(uuid) to authenticated;
