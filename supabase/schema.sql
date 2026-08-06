-- ============================================================================
-- MatematIsko — Supabase / PostgreSQL schema
-- Run this file in the Supabase SQL Editor (or via supabase db push) first,
-- then run seed.sql to populate the question bank.
-- ============================================================================

create extension if not exists pgcrypto;

-- ---------------------------------------------------------------------------
-- Profiles (one row per auth user)
-- ---------------------------------------------------------------------------
create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  email text not null,
  full_name text,
  avatar_url text,
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Course catalog
-- ---------------------------------------------------------------------------
create table public.courses (
  id uuid primary key default gen_random_uuid(),
  code text not null unique,
  name text not null,
  description text,
  created_at timestamptz not null default now()
);

create table public.topics (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.courses (id) on delete cascade,
  name text not null,
  description text,
  unique (course_id, name)
);

-- ---------------------------------------------------------------------------
-- Question bank (source Math/Markdown/LaTeX, never rendered HTML)
-- ---------------------------------------------------------------------------
create table public.questions (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.courses (id) on delete cascade,
  topic_id uuid not null references public.topics (id) on delete cascade,
  title text not null,
  question_text text not null,
  difficulty text not null check (difficulty in ('easy', 'medium', 'hard')),
  year integer not null,
  exam_name text not null,
  question_number integer not null,
  answer text not null,
  solution text not null,
  hint text,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index questions_course_id_idx on public.questions (course_id);
create index questions_topic_id_idx on public.questions (topic_id);
create index questions_difficulty_idx on public.questions (difficulty);
create index questions_year_idx on public.questions (year);

-- ---------------------------------------------------------------------------
-- Per-student bookmarks and progress
-- ---------------------------------------------------------------------------
create table public.bookmarks (
  user_id uuid not null references public.profiles (id) on delete cascade,
  question_id uuid not null references public.questions (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, question_id)
);

create table public.progress (
  user_id uuid not null references public.profiles (id) on delete cascade,
  question_id uuid not null references public.questions (id) on delete cascade,
  status text not null default 'unseen' check (status in ('unseen', 'learning', 'mastered')),
  attempts integer not null default 0,
  last_attempted_at timestamptz,
  mastered_at timestamptz,
  primary key (user_id, question_id)
);

create index progress_status_idx on public.progress (status);

-- ---------------------------------------------------------------------------
-- updated_at maintenance
-- ---------------------------------------------------------------------------
create or replace function public.set_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger questions_set_updated_at
  before update on public.questions
  for each row execute function public.set_updated_at();

-- ---------------------------------------------------------------------------
-- New-user hook: create the profile row AND enforce the @up.edu.ph domain.
-- The domain check runs on the database so it cannot be bypassed client-side.
-- ---------------------------------------------------------------------------
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
declare
  admin_emails text[] := array['jeremiah.regalario@gmail.com'];
  email_domain text;
begin
  -- Allow hardcoded admin emails to bypass the @up.edu.ph check
  if new.email is not null and new.email = any(admin_emails) then
    insert into public.profiles (id, email, full_name, avatar_url)
    values (
      new.id,
      new.email,
      new.raw_user_meta_data ->> 'full_name',
      new.raw_user_meta_data ->> 'avatar_url'
    )
    on conflict (id) do nothing;
    return new;
  end if;

  -- Enforce @up.edu.ph for all other accounts
  if new.email is null then
    raise exception 'Email is required';
  end if;

  email_domain := lower(split_part(new.email, '@', 2));
  if email_domain <> 'up.edu.ph' then
    raise exception 'MatematIsko is only available to @up.edu.ph email accounts';
  end if;

  insert into public.profiles (id, email, full_name, avatar_url)
  values (
    new.id,
    new.email,
    new.raw_user_meta_data ->> 'full_name',
    new.raw_user_meta_data ->> 'avatar_url'
  )
  on conflict (id) do nothing;

  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- ---------------------------------------------------------------------------
-- Row Level Security
-- ---------------------------------------------------------------------------
alter table public.profiles enable row level security;
alter table public.courses enable row level security;
alter table public.topics enable row level security;
alter table public.questions enable row level security;
alter table public.bookmarks enable row level security;
alter table public.progress enable row level security;

-- Profiles: students read/update only their own row.
create policy "profiles_select_own" on public.profiles
  for select using (auth.uid() = id);
create policy "profiles_insert_own" on public.profiles
  for insert with check (auth.uid() = id);
create policy "profiles_update_own" on public.profiles
  for update using (auth.uid() = id);

-- Question bank: read-only for signed-in students.
-- There are intentionally NO insert/update/delete policies here, so no
-- student can modify course/topic/question content.
create policy "courses_read" on public.courses
  for select using (auth.role() = 'authenticated');
create policy "topics_read" on public.topics
  for select using (auth.role() = 'authenticated');
create policy "questions_read" on public.questions
  for select using (auth.role() = 'authenticated');

-- Bookmarks: students manage only their own.
create policy "bookmarks_select_own" on public.bookmarks
  for select using (auth.uid() = user_id);
create policy "bookmarks_insert_own" on public.bookmarks
  for insert with check (auth.uid() = user_id);
create policy "bookmarks_delete_own" on public.bookmarks
  for delete using (auth.uid() = user_id);

-- Progress: students manage only their own.
create policy "progress_select_own" on public.progress
  for select using (auth.uid() = user_id);
create policy "progress_insert_own" on public.progress
  for insert with check (auth.uid() = user_id);
create policy "progress_update_own" on public.progress
  for update using (auth.uid() = user_id);
create policy "progress_delete_own" on public.progress
  for delete using (auth.uid() = user_id);

-- ---------------------------------------------------------------------------
-- Default grants (defense in depth alongside RLS)
-- ---------------------------------------------------------------------------
grant usage on schema public to anon, authenticated;
grant select on all tables in schema public to anon, authenticated;
grant insert, update, delete on public.profiles, public.bookmarks, public.progress to authenticated;
