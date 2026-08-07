-- ============================================================================
-- Named Theorems — schema, RLS, admin RPCs
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Theorems table
-- ---------------------------------------------------------------------------
create table public.theorems (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.courses (id) on delete cascade,
  topic_id uuid not null references public.topics (id) on delete cascade,
  name text not null,
  reference text,
  statement text not null,
  formal_notation text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index theorems_course_id_idx on public.theorems (course_id);
create index theorems_topic_id_idx on public.theorems (topic_id);

create trigger theorems_set_updated_at
  before update on public.theorems
  for each row execute function public.set_updated_at();

-- ---------------------------------------------------------------------------
-- Per-student theorem progress
-- ---------------------------------------------------------------------------
create table public.theorem_progress (
  user_id uuid not null references public.profiles (id) on delete cascade,
  theorem_id uuid not null references public.theorems (id) on delete cascade,
  status text not null default 'unseen' check (status in ('unseen', 'learning', 'mastered')),
  last_reviewed_at timestamptz,
  mastered_at timestamptz,
  primary key (user_id, theorem_id)
);

create index theorem_progress_status_idx on public.theorem_progress (status);

-- ---------------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------------
alter table public.theorems enable row level security;
alter table public.theorem_progress enable row level security;

create policy "theorems_read" on public.theorems
  for select using (auth.role() = 'authenticated');

create policy "theorem_progress_select_own" on public.theorem_progress
  for select using (auth.uid() = user_id);
create policy "theorem_progress_insert_own" on public.theorem_progress
  for insert with check (auth.uid() = user_id);
create policy "theorem_progress_update_own" on public.theorem_progress
  for update using (auth.uid() = user_id);
create policy "theorem_progress_delete_own" on public.theorem_progress
  for delete using (auth.uid() = user_id);

grant select on public.theorems to anon, authenticated;
grant select, insert, update, delete on public.theorem_progress to authenticated;

-- ---------------------------------------------------------------------------
-- Admin RPCs — same pattern as question management
-- ---------------------------------------------------------------------------
create or replace function public.admin_upsert_theorem(
  p_id uuid default null,
  p_course_id uuid default null,
  p_topic_id uuid default null,
  p_name text default null,
  p_reference text default null,
  p_statement text default null,
  p_formal_notation text default null
)
returns public.theorems
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.theorems;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage theorems';
  end if;
  if p_course_id is null or p_topic_id is null
     or btrim(coalesce(p_name, '')) = ''
     or btrim(coalesce(p_statement, '')) = '' then
    raise exception 'Required fields are missing';
  end if;
  if not exists (select 1 from public.topics where id = p_topic_id and course_id = p_course_id) then
    raise exception 'Topic does not belong to the selected course';
  end if;
  insert into public.theorems
    (id, course_id, topic_id, name, reference, statement, formal_notation)
  values
    (coalesce(p_id, gen_random_uuid()), p_course_id, p_topic_id,
     btrim(p_name), nullif(btrim(coalesce(p_reference, '')), ''),
     p_statement, nullif(btrim(coalesce(p_formal_notation, '')), ''))
  on conflict (id) do update
    set course_id = excluded.course_id,
        topic_id = excluded.topic_id,
        name = excluded.name,
        reference = excluded.reference,
        statement = excluded.statement,
        formal_notation = excluded.formal_notation
  returning * into result;
  return result;
end;
$$;

revoke execute on function public.admin_upsert_theorem(uuid, uuid, uuid, text, text, text, text) from public, anon;
grant execute on function public.admin_upsert_theorem(uuid, uuid, uuid, text, text, text, text) to authenticated;

create or replace function public.admin_delete_theorem(p_id uuid)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage theorems';
  end if;
  delete from public.theorems where id = p_id;
  if not found then
    raise exception 'Theorem not found';
  end if;
end;
$$;

revoke execute on function public.admin_delete_theorem(uuid) from public, anon;
grant execute on function public.admin_delete_theorem(uuid) to authenticated;
