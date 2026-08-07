-- ============================================================================
-- MatematIsko — First-login onboarding
-- Captures degree program, year level, UPMMC membership, and course interests
-- the student wants to study. Existing/new profiles start un-onboarded
-- (degree_program/year_level NULL) and the client gates on those.
-- ============================================================================

alter table public.profiles
  add column degree_program text,
  add column year_level text,
  add column upmmc_member boolean not null default false;

-- ---------------------------------------------------------------------------
-- Per-student course interests (pre-selected during onboarding)
-- ---------------------------------------------------------------------------
create table public.user_courses (
  user_id uuid not null references public.profiles (id) on delete cascade,
  course_id uuid not null references public.courses (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, course_id)
);

create index user_courses_user_id_idx on public.user_courses (user_id);

-- ---------------------------------------------------------------------------
-- Row Level Security
-- ---------------------------------------------------------------------------
alter table public.user_courses enable row level security;

-- Students manage only their own course interests.
create policy "user_courses_select_own" on public.user_courses
  for select using (auth.uid() = user_id);
create policy "user_courses_insert_own" on public.user_courses
  for insert with check (auth.uid() = user_id);
create policy "user_courses_delete_own" on public.user_courses
  for delete using (auth.uid() = user_id);

-- ---------------------------------------------------------------------------
-- Default grants (defense in depth alongside RLS)
-- ---------------------------------------------------------------------------
grant select on public.user_courses to anon, authenticated;
grant insert, update, delete on public.user_courses to authenticated;
