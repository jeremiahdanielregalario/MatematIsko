-- Only the account with the owner's Auth email may revoke delegated admin access.
create or replace function public.is_super_admin()
returns boolean language sql stable security definer set search_path = ''
as $$
 select exists (select 1 from auth.users where id = auth.uid()
   and lower(email) = 'jeremiah.regalario@gmail.com');
$$;
revoke all on function public.is_super_admin() from public, anon;
grant execute on function public.is_super_admin() to authenticated;

create or replace function public.is_admin()
returns boolean language sql stable security definer set search_path = ''
as $$
 select public.is_super_admin() or exists (
   select 1 from public.admin_roles where user_id = auth.uid()
 );
$$;

create or replace function public.admin_revoke_access(p_user_id uuid)
returns void language plpgsql security definer set search_path = ''
as $$
begin
 -- Serialize role changes so a revoked admin cannot finish a queued grant afterward.
 lock table public.admin_roles in share row exclusive mode;
 if not public.is_super_admin() then
   raise exception 'Only the super admin can remove admin access' using errcode = '42501';
 end if;
 if exists (select 1 from auth.users where id = p_user_id
   and lower(email) = 'jeremiah.regalario@gmail.com') then
   raise exception 'Super admin access cannot be removed' using errcode = '42501';
 end if;
 if not exists (select 1 from public.profiles where id = p_user_id) then
   raise exception 'User profile no longer exists' using errcode = 'P0002';
 end if;
 delete from public.admin_roles where user_id = p_user_id;
end;
$$;
revoke all on function public.admin_revoke_access(uuid) from public, anon;
grant execute on function public.admin_revoke_access(uuid) to authenticated;

create or replace function public.admin_grant_access(p_user_id uuid)
returns void language plpgsql security definer set search_path = ''
as $$
begin
 lock table public.admin_roles in share row exclusive mode;
 if not coalesce(public.is_admin(), false) then
   raise exception 'Only administrators can grant admin access' using errcode = '42501';
 end if;
 if not exists (select 1 from public.profiles where id = p_user_id) then
   raise exception 'User profile no longer exists' using errcode = 'P0002';
 end if;
 insert into public.admin_roles(user_id, granted_by) values(p_user_id, auth.uid())
 on conflict (user_id) do nothing;
end;
$$;
revoke all on function public.admin_grant_access(uuid) from public, anon;
grant execute on function public.admin_grant_access(uuid) to authenticated;

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
      p.year_level, p.upmmc_member, p.created_at,
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
