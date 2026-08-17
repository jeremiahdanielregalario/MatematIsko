-- ============================================================================
-- Blog posts table
-- ============================================================================

create table public.blog_posts (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  slug text not null unique,
  excerpt text not null default '',
  content text not null default '',
  author_id uuid references public.profiles (id) on delete set null,
  featured_image text,
  published boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create index blog_posts_slug_idx on public.blog_posts (slug);
create index blog_posts_published_idx on public.blog_posts (published, created_at desc);

create trigger blog_posts_set_updated_at
  before update on public.blog_posts
  for each row execute function public.set_updated_at();

-- RLS: anyone authenticated can read published posts
alter table public.blog_posts enable row level security;

create policy "Published blog posts readable by authenticated"
  on public.blog_posts for select
  to authenticated
  using (published = true);

create policy "Admins can read all blog posts"
  on public.blog_posts for select
  to authenticated
  using (public.is_admin());

create policy "Admins can insert blog posts"
  on public.blog_posts for insert
  to authenticated
  with check (public.is_admin());

create policy "Admins can update blog posts"
  on public.blog_posts for update
  to authenticated
  using (public.is_admin());

create policy "Admins can delete blog posts"
  on public.blog_posts for delete
  to authenticated
  using (public.is_admin());

-- Admin CRUD RPC
create or replace function public.admin_upsert_blog_post(
  p_title text,
  p_slug text,
  p_excerpt text default '',
  p_content text default '',
  p_featured_image text default null,
  p_published boolean default false,
  p_id uuid default null
)
returns public.blog_posts
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.blog_posts;
begin
  if not public.is_admin() then
    raise exception 'Only administrators can manage blog posts';
  end if;
  if p_title = '' then
    raise exception 'Title is required';
  end if;
  if p_slug = '' then
    raise exception 'Slug is required';
  end if;

  if p_id is not null then
    update public.blog_posts
    set title = p_title,
        slug = p_slug,
        excerpt = p_excerpt,
        content = p_content,
        featured_image = nullif(p_featured_image, ''),
        published = p_published,
        updated_at = now()
    where id = p_id
    returning * into result;
  else
    insert into public.blog_posts (title, slug, excerpt, content, featured_image, published)
    values (p_title, p_slug, p_excerpt, p_content, nullif(p_featured_image, ''), p_published)
    returning * into result;
  end if;

  return result;
end;
$$;

revoke execute on function public.admin_upsert_blog_post(text, text, text, text, text, boolean, uuid) from public, anon;
grant execute on function public.admin_upsert_blog_post(text, text, text, text, text, boolean, uuid) to authenticated;

create or replace function public.admin_delete_blog_post(
  p_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can delete blog posts';
  end if;
  delete from public.blog_posts where id = p_id;
end;
$$;

revoke execute on function public.admin_delete_blog_post(uuid) from public, anon;
grant execute on function public.admin_delete_blog_post(uuid) to authenticated;
