-- Self-declared membership does not grant solution access. Existing users start
-- unverified; administrators explicitly verify membership in App users.
alter table public.profiles add column upmmc_verified boolean not null default false;

create function public.protect_upmmc_verification()
returns trigger language plpgsql set search_path = '' as $$
begin
  if (case when TG_OP = 'INSERT' then new.upmmc_verified
      else new.upmmc_verified is distinct from old.upmmc_verified end)
     and not coalesce(public.is_admin(), false) then
    raise exception 'Only administrators can verify UPMMC membership' using errcode = '42501';
  end if;
  return new;
end;
$$;
create trigger profiles_protect_upmmc_verification
before insert or update on public.profiles
for each row execute function public.protect_upmmc_verification();

create function public.can_read_complete_solution(p_course_id uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select auth.uid() is not null and (
    coalesce(public.is_admin(), false)
    or exists (select 1 from public.profiles where id = auth.uid() and upmmc_verified)
    or exists (select 1 from public.courses where id = p_course_id
      and upper(regexp_replace(code, '\s+', '', 'g')) in ('MATH20','MATH21','MATH22','MATH23','STAT101'))
  );
$$;
revoke all on function public.can_read_complete_solution(uuid) from public, anon;
grant execute on function public.can_read_complete_solution(uuid) to authenticated;

-- Block direct table and embedded relationship reads of restricted solutions.
drop policy questions_read on public.questions;
create policy questions_read on public.questions for select to authenticated
using (public.can_read_complete_solution(course_id));

-- Owner execution intentionally supplies the non-sensitive parts of every
-- question. The explicit signed-in predicate and CASE are the access boundary.
create view public.study_questions with (security_barrier = true) as
select q.id, q.course_id, q.topic_id, q.title, q.question_text, q.difficulty,
  q.year, q.exam_name, q.question_number, q.answer, q.hint,
  case when public.can_read_complete_solution(q.course_id) then q.solution
    else 'Not available' end as solution,
  q.created_at, q.updated_at, to_jsonb(c) as course, to_jsonb(t) as topic
from public.questions q
join public.courses c on c.id = q.course_id
join public.topics t on t.id = q.topic_id
where auth.uid() is not null;
revoke all on public.study_questions from public, anon, authenticated;
grant select on public.study_questions to authenticated;

-- Keep old clients compatible; the original editor cannot grant verification.
create function public.admin_update_profile_verified(
  p_id uuid, p_full_name text, p_degree_program text, p_year_level text,
  p_upmmc_member boolean, p_upmmc_verified boolean, p_expected jsonb
)
returns public.profiles language plpgsql security definer set search_path = '' as $$
declare v_profile public.profiles;
begin
  if auth.uid() is null or not coalesce(public.is_admin(), false) then
    raise exception 'Only administrators can verify UPMMC membership' using errcode = '42501';
  end if;
  if p_upmmc_verified is null then
    raise exception 'Verification status is required' using errcode = '22023';
  end if;
  select * into v_profile from public.profiles where id = p_id for update;
  if not found then raise exception 'User profile no longer exists' using errcode = 'P0002'; end if;
  if to_jsonb(v_profile.upmmc_verified) is distinct from p_expected->'upmmc_verified' then
    raise exception 'This profile changed. Refresh the directory and try again.' using errcode = '40001';
  end if;
  perform public.admin_update_profile(p_id, p_full_name, p_degree_program, p_year_level,
    p_upmmc_member, p_expected - 'upmmc_verified');
  update public.profiles set upmmc_verified = p_upmmc_verified where id = p_id
    returning * into v_profile;
  return v_profile;
end;
$$;
revoke all on function public.admin_update_profile_verified(uuid,text,text,text,boolean,boolean,jsonb) from public, anon;
grant execute on function public.admin_update_profile_verified(uuid,text,text,text,boolean,boolean,jsonb) to authenticated;

create or replace function public.admin_list_profiles(
  p_search text default '', p_offset integer default 0, p_limit integer default 25
)
returns jsonb
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_search text := lower(btrim(coalesce(p_search, '')));
  v_result jsonb;
begin
  if auth.uid() is null or not coalesce(public.is_admin(), false) then
    raise exception 'Only administrators can view users' using errcode = '42501';
  end if;
  if p_offset is null or p_offset < 0 or p_limit is null or p_limit < 1 or p_limit > 100 or char_length(v_search) > 200 then
    raise exception 'Invalid user search or page size' using errcode = '22023';
  end if;
  -- strpos treats wildcard characters literally; no dynamic SQL.
  with matches as materialized (
    select p.id, p.email, p.full_name, p.avatar_url, p.degree_program,
      p.year_level, p.upmmc_member, p.upmmc_verified, p.created_at,
      (exists (select 1 from public.admin_roles r where r.user_id = p.id)
       or exists (select 1 from auth.users u where u.id = p.id and lower(u.email) = 'jeremiah.regalario@gmail.com')) as is_admin,
      exists (select 1 from auth.users u where u.id = p.id and lower(u.email) = 'jeremiah.regalario@gmail.com') as is_super_admin
    from public.profiles p
    where v_search = '' or strpos(lower(coalesce(p.full_name, '')), v_search) > 0
      or strpos(lower(p.email), v_search) > 0
  ), page as (
    select * from matches order by created_at desc, id limit p_limit offset p_offset
  )
  select jsonb_build_object(
    'users', coalesce((select jsonb_agg(to_jsonb(page) order by created_at desc, id) from page), '[]'::jsonb),
    'total', (select count(*) from matches),
    'can_revoke_admin', public.is_super_admin()
  ) into v_result;
  return v_result;
end;
$$;


notify pgrst, 'reload schema';

