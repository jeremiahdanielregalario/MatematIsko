-- ============================================================================
-- Question & theorem reports
-- Lets students flag rendering issues, incorrect content, or problems with
-- hints/answers/solutions. Admins view and resolve reports in the Reports tab.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Tables
-- ---------------------------------------------------------------------------
create table public.question_reports (
  id uuid primary key default gen_random_uuid(),
  question_id uuid not null references public.questions (id) on delete cascade,
  user_id uuid not null references public.profiles (id) on delete cascade,
  category text not null check (category in (
    'rendering', 'question', 'hint', 'answer', 'solution', 'other'
  )),
  description text not null default '',
  status text not null default 'open' check (status in ('open', 'resolved')),
  created_at timestamptz not null default now()
);

create index question_reports_status_idx on public.question_reports (status);
create index question_reports_question_id_idx on public.question_reports (question_id);

create table public.theorem_reports (
  id uuid primary key default gen_random_uuid(),
  theorem_id uuid not null references public.theorems (id) on delete cascade,
  user_id uuid not null references public.profiles (id) on delete cascade,
  category text not null check (category in (
    'rendering', 'statement', 'formal_notation', 'name', 'other'
  )),
  description text not null default '',
  status text not null default 'open' check (status in ('open', 'resolved')),
  created_at timestamptz not null default now()
);

create index theorem_reports_status_idx on public.theorem_reports (status);
create index theorem_reports_theorem_id_idx on public.theorem_reports (theorem_id);

-- ---------------------------------------------------------------------------
-- Row Level Security
-- ---------------------------------------------------------------------------
alter table public.question_reports enable row level security;
alter table public.theorem_reports enable row level security;

-- Students can insert reports they own and read their own.
create policy "question_reports_insert_own" on public.question_reports
  for insert with check (auth.uid() = user_id);
create policy "question_reports_select_own" on public.question_reports
  for select using (auth.uid() = user_id);

create policy "theorem_reports_insert_own" on public.theorem_reports
  for insert with check (auth.uid() = user_id);
create policy "theorem_reports_select_own" on public.theorem_reports
  for select using (auth.uid() = user_id);

-- Admins can read all reports via RPC, but the RLS policies above are
-- sufficient for the direct queries the client makes.

-- ---------------------------------------------------------------------------
-- Grants
-- ---------------------------------------------------------------------------
grant select, insert on public.question_reports to authenticated;
grant select, insert on public.theorem_reports to authenticated;

-- ---------------------------------------------------------------------------
-- RPC: Submit a question report (security-definer so the admin can also use it)
-- ---------------------------------------------------------------------------
create or replace function public.submit_question_report(
  p_question_id uuid,
  p_category text,
  p_description text default ''
)
returns public.question_reports
language plpgsql
security definer
set search_path = public
as $$
declare
  current_user_id uuid := auth.uid();
  result public.question_reports;
begin
  if current_user_id is null then
    raise exception 'You must be signed in to report an issue';
  end if;
  if p_category not in ('rendering', 'question', 'hint', 'answer', 'solution', 'other') then
    raise exception 'Invalid category';
  end if;
  if p_question_id is null then
    raise exception 'Question ID is required';
  end if;
  insert into public.question_reports (question_id, user_id, category, description)
  values (p_question_id, current_user_id, p_category, btrim(coalesce(p_description, '')))
  returning * into result;
  return result;
end;
$$;

revoke execute on function public.submit_question_report(uuid, text, text) from public, anon;
grant execute on function public.submit_question_report(uuid, text, text) to authenticated;

-- ---------------------------------------------------------------------------
-- RPC: Submit a theorem report
-- ---------------------------------------------------------------------------
create or replace function public.submit_theorem_report(
  p_theorem_id uuid,
  p_category text,
  p_description text default ''
)
returns public.theorem_reports
language plpgsql
security definer
set search_path = public
as $$
declare
  current_user_id uuid := auth.uid();
  result public.theorem_reports;
begin
  if current_user_id is null then
    raise exception 'You must be signed in to report an issue';
  end if;
  if p_category not in ('rendering', 'statement', 'formal_notation', 'name', 'other') then
    raise exception 'Invalid category';
  end if;
  if p_theorem_id is null then
    raise exception 'Theorem ID is required';
  end if;
  insert into public.theorem_reports (theorem_id, user_id, category, description)
  values (p_theorem_id, current_user_id, p_category, btrim(coalesce(p_description, '')))
  returning * into result;
  return result;
end;
$$;

revoke execute on function public.submit_theorem_report(uuid, text, text) from public, anon;
grant execute on function public.submit_theorem_report(uuid, text, text) to authenticated;

-- ---------------------------------------------------------------------------
-- RPC: Admin list question reports (joined with question title, course code)
-- ---------------------------------------------------------------------------
create or replace function public.admin_list_question_reports(
  p_status text default null
)
returns table (
  id uuid,
  question_id uuid,
  question_title text,
  course_code text,
  user_email text,
  category text,
  description text,
  status text,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can view reports';
  end if;
  return query
  select
    r.id,
    r.question_id,
    q.title,
    c.code,
    p.email,
    r.category,
    r.description,
    r.status,
    r.created_at
  from public.question_reports r
  join public.questions q on q.id = r.question_id
  join public.courses c on c.id = q.course_id
  join public.profiles p on p.id = r.user_id
  where (p_status is null or r.status = p_status)
  order by r.created_at desc;
end;
$$;

revoke execute on function public.admin_list_question_reports(text) from public, anon;
grant execute on function public.admin_list_question_reports(text) to authenticated;

-- ---------------------------------------------------------------------------
-- RPC: Admin list theorem reports
-- ---------------------------------------------------------------------------
create or replace function public.admin_list_theorem_reports(
  p_status text default null
)
returns table (
  id uuid,
  theorem_id uuid,
  theorem_name text,
  course_code text,
  user_email text,
  category text,
  description text,
  status text,
  created_at timestamptz
)
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can view reports';
  end if;
  return query
  select
    r.id,
    r.theorem_id,
    t.name,
    c.code,
    p.email,
    r.category,
    r.description,
    r.status,
    r.created_at
  from public.theorem_reports r
  join public.theorems t on t.id = r.theorem_id
  join public.courses c on c.id = t.course_id
  join public.profiles p on p.id = r.user_id
  where (p_status is null or r.status = p_status)
  order by r.created_at desc;
end;
$$;

revoke execute on function public.admin_list_theorem_reports(text) from public, anon;
grant execute on function public.admin_list_theorem_reports(text) to authenticated;

-- ---------------------------------------------------------------------------
-- RPC: Admin resolve a report
-- ---------------------------------------------------------------------------
create or replace function public.admin_resolve_report(
  p_table text,
  p_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage reports';
  end if;
  if p_table = 'question_reports' then
    update public.question_reports set status = 'resolved' where id = p_id;
  elsif p_table = 'theorem_reports' then
    update public.theorem_reports set status = 'resolved' where id = p_id;
  else
    raise exception 'Invalid table name';
  end if;
end;
$$;

revoke execute on function public.admin_resolve_report(text, uuid) from public, anon;
grant execute on function public.admin_resolve_report(text, uuid) to authenticated;

-- ---------------------------------------------------------------------------
-- RPC: Admin reopen a report
-- ---------------------------------------------------------------------------
create or replace function public.admin_reopen_report(
  p_table text,
  p_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage reports';
  end if;
  if p_table = 'question_reports' then
    update public.question_reports set status = 'open' where id = p_id;
  elsif p_table = 'theorem_reports' then
    update public.theorem_reports set status = 'open' where id = p_id;
  else
    raise exception 'Invalid table name';
  end if;
end;
$$;

revoke execute on function public.admin_reopen_report(text, uuid) from public, anon;
grant execute on function public.admin_reopen_report(text, uuid) to authenticated;
