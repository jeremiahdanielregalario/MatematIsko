-- Aggregate private study data through bounded, admin-only operations.
create function public.admin_user_progress(p_user_id uuid)
returns jsonb language plpgsql security definer set search_path = ''
as $$
declare v_result jsonb;
begin
  if auth.uid() is null or not coalesce(public.is_admin(), false) then
    raise exception 'Only administrators can view user progress' using errcode = '42501';
  end if;
  if not exists (select 1 from public.profiles where id = p_user_id) then
    raise exception 'User profile no longer exists' using errcode = 'P0002';
  end if;
  select coalesce(jsonb_agg(to_jsonb(s) order by s.code, s.id), '[]'::jsonb) into v_result
  from (
    select c.id, c.code, c.name,
      exists(select 1 from public.user_courses uc where uc.user_id = p_user_id and uc.course_id = c.id) as selected,
      q.total as questions_total, q.learning as questions_learning, q.mastered as questions_mastered,
      q.records as question_records, q.attempts,
      t.total as theorems_total, t.learning as theorems_learning, t.mastered as theorems_mastered,
      t.records as theorem_records, greatest(q.activity, t.activity) as last_activity
    from public.courses c
    cross join lateral (
      select count(*) as total, count(*) filter(where p.status = 'learning') as learning,
        count(*) filter(where p.status = 'mastered') as mastered, count(p.user_id) as records,
        coalesce(sum(p.attempts), 0) as attempts, max(greatest(p.last_attempted_at, p.mastered_at)) as activity
      from public.questions q left join public.progress p on p.question_id = q.id and p.user_id = p_user_id
      where q.course_id = c.id
    ) q
    cross join lateral (
      select count(*) as total, count(*) filter(where p.status = 'learning') as learning,
        count(*) filter(where p.status = 'mastered') as mastered, count(p.user_id) as records,
        max(greatest(p.last_reviewed_at, p.mastered_at)) as activity
      from public.theorems t left join public.theorem_progress p on p.theorem_id = t.id and p.user_id = p_user_id
      where t.course_id = c.id
    ) t
    where q.records > 0 or t.records > 0 or exists (
      select 1 from public.user_courses uc where uc.user_id = p_user_id and uc.course_id = c.id
    )
  ) s;
  return v_result;
end;
$$;
revoke all on function public.admin_user_progress(uuid) from public, anon;
grant execute on function public.admin_user_progress(uuid) to authenticated;

create function public.admin_reset_user_progress(p_user_id uuid, p_course_id uuid default null)
returns void language plpgsql security definer set search_path = ''
as $$
begin
  if auth.uid() is null or not coalesce(public.is_admin(), false) then
    raise exception 'Only administrators can reset user progress' using errcode = '42501';
  end if;
  if not exists (select 1 from public.profiles where id = p_user_id) then
    raise exception 'User profile no longer exists' using errcode = 'P0002';
  end if;
  if p_course_id is not null and not exists (select 1 from public.courses where id = p_course_id) then
    raise exception 'Course no longer exists' using errcode = 'P0002';
  end if;
  delete from public.progress p where p.user_id = p_user_id and
    (p_course_id is null or exists(select 1 from public.questions q where q.id = p.question_id and q.course_id = p_course_id));
  delete from public.theorem_progress p where p.user_id = p_user_id and
    (p_course_id is null or exists(select 1 from public.theorems t where t.id = p.theorem_id and t.course_id = p_course_id));
end;
$$;
revoke all on function public.admin_reset_user_progress(uuid, uuid) from public, anon;
grant execute on function public.admin_reset_user_progress(uuid, uuid) to authenticated;
notify pgrst, 'reload schema';
