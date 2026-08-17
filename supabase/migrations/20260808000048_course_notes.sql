-- ============================================================================
-- Course notes table
-- Stores markdown + KaTeX notes per course, displayed in a Notes tab.
-- ============================================================================

create table public.course_notes (
  id uuid primary key default gen_random_uuid(),
  course_id uuid not null references public.courses (id) on delete cascade,
  title text not null,
  content text not null default '',
  sort_order integer not null default 0,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index course_notes_course_id_idx on public.course_notes (course_id);
create index course_notes_sort_idx on public.course_notes (course_id, sort_order);

-- RLS: anyone authenticated can read; only admins can write
alter table public.course_notes enable row level security;

create policy "Anyone authenticated can read course notes"
  on public.course_notes for select
  to authenticated
  using (true);

create policy "Admins can insert course notes"
  on public.course_notes for insert
  to authenticated
  with check (public.is_admin());

create policy "Admins can update course notes"
  on public.course_notes for update
  to authenticated
  using (public.is_admin());

create policy "Admins can delete course notes"
  on public.course_notes for delete
  to authenticated
  using (public.is_admin());
