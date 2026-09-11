-- Admin-only profile directory and bounded profile edits.
-- Student self-access policies remain unchanged. No auth.users writes or credentials.
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
      p.year_level, p.upmmc_member, p.created_at
    from public.profiles p
    where v_search = '' or strpos(lower(coalesce(p.full_name, '')), v_search) > 0
      or strpos(lower(p.email), v_search) > 0
  ), page as (
    select * from matches order by created_at desc, id limit p_limit offset p_offset
  )
  select jsonb_build_object(
    'users', coalesce((select jsonb_agg(to_jsonb(page) order by created_at desc, id) from page), '[]'::jsonb),
    'total', (select count(*) from matches)
  ) into v_result;
  return v_result;
end;
$$;

create or replace function public.admin_update_profile(
  p_id uuid, p_full_name text, p_degree_program text, p_year_level text,
  p_upmmc_member boolean, p_expected jsonb
)
returns public.profiles
language plpgsql
security definer
set search_path = ''
as $$
declare
  v_profile public.profiles;
  v_name text := nullif(btrim(p_full_name), '');
  v_degree text := nullif(btrim(p_degree_program), '');
  v_year text := nullif(btrim(p_year_level), '');
begin
  if auth.uid() is null or not coalesce(public.is_admin(), false) then
    raise exception 'Only administrators can edit users' using errcode = '42501';
  end if;
  if char_length(v_name) > 200 or char_length(v_degree) > 200 or p_upmmc_member is null
    or (v_year is not null and v_year not in ('1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year or more')) then
    raise exception 'Invalid profile fields' using errcode = '22023';
  end if;
  select * into v_profile from public.profiles where id = p_id for update;
  if not found then
    raise exception 'User profile no longer exists' using errcode = 'P0002';
  end if;
  if jsonb_build_object('full_name', v_profile.full_name, 'degree_program', v_profile.degree_program,
    'year_level', v_profile.year_level, 'upmmc_member', v_profile.upmmc_member) is distinct from p_expected then
    raise exception 'This profile changed since you opened it. Close the editor, refresh the list, and try again.' using errcode = '40001';
  end if;
  update public.profiles set full_name = v_name, degree_program = v_degree,
    year_level = v_year, upmmc_member = p_upmmc_member
  where id = p_id returning * into v_profile;
  return v_profile;
end;
$$;

revoke all on function public.admin_list_profiles(text, integer, integer) from public, anon;
revoke all on function public.admin_update_profile(uuid, text, text, text, boolean, jsonb) from public, anon;
grant execute on function public.admin_list_profiles(text, integer, integer) to authenticated;
grant execute on function public.admin_update_profile(uuid, text, text, text, boolean, jsonb) to authenticated;
