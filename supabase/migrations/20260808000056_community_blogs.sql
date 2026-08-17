-- ============================================================================
-- Migrate blog_posts to community model: anyone writes, admins approve
-- ============================================================================

-- Add approval status column
alter table public.blog_posts
  add column if not exists approval_status text not null default 'approved'
    check (approval_status in ('pending', 'approved', 'rejected'));

-- Update existing posts: if published, mark approved
update public.blog_posts set approval_status = 'approved' where published = true;

-- Drop old RLS policies
drop policy if exists "Published blog posts readable by authenticated" on public.blog_posts;
drop policy if exists "Admins can read all blog posts" on public.blog_posts;
drop policy if exists "Admins can insert blog posts" on public.blog_posts;
drop policy if exists "Admins can update blog posts" on public.blog_posts;
drop policy if exists "Admins can delete blog posts" on public.blog_posts;

-- Public/admins can read published + approved posts
create policy "Anyone can read published approved posts"
  on public.blog_posts for select
  to authenticated
  using (published = true and approval_status = 'approved');

-- Admins see everything
create policy "Admins can read all blog posts"
  on public.blog_posts for select
  to authenticated
  using (public.is_admin());

-- Authors can read their own posts (any status)
create policy "Authors can read own posts"
  on public.blog_posts for select
  to authenticated
  using (auth.uid() = author_id);

-- Any authenticated user can create a post (as their own)
create policy "Authenticated users can create own posts"
  on public.blog_posts for insert
  to authenticated
  with check (auth.uid() = author_id);

-- Authors can update own posts (only when not yet published or still pending)
create policy "Authors can update own pending posts"
  on public.blog_posts for update
  to authenticated
  using (auth.uid() = author_id)
  with check (auth.uid() = author_id);

-- Authors can delete own posts
create policy "Authors can delete own posts"
  on public.blog_posts for delete
  to authenticated
  using (auth.uid() = author_id);

-- Admins can do everything
create policy "Admins can update any blog post"
  on public.blog_posts for update
  to authenticated
  using (public.is_admin());

create policy "Admins can delete any blog post"
  on public.blog_posts for delete
  to authenticated
  using (public.is_admin());

-- ---------------------------------------------------------------------------
-- Update upsert RPC: users submit their own posts (default pending)
-- ---------------------------------------------------------------------------
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
    raise exception 'Only administrators can manage blog posts directly';
  end if;
  if p_title = '' then raise exception 'Title is required'; end if;
  if p_slug = '' then raise exception 'Slug is required'; end if;

  if p_id is not null then
    update public.blog_posts
    set title = p_title, slug = p_slug, excerpt = p_excerpt, content = p_content,
        featured_image = nullif(p_featured_image, ''), published = p_published,
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

-- ---------------------------------------------------------------------------
-- User-facing submit: creates a draft post (pending approval)
-- ---------------------------------------------------------------------------
create or replace function public.submit_blog_post(
  p_title text,
  p_slug text,
  p_excerpt text default '',
  p_content text default '',
  p_featured_image text default null
)
returns public.blog_posts
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.blog_posts;
begin
  if p_title = '' then raise exception 'Title is required'; end if;
  if p_slug = '' then raise exception 'Slug is required'; end if;

  insert into public.blog_posts (title, slug, excerpt, content, featured_image, author_id, published, approval_status)
  values (p_title, p_slug, p_excerpt, p_content, nullif(p_featured_image, ''), auth.uid(), true, 'pending')
  returning * into result;

  return result;
end;
$$;

revoke execute on function public.submit_blog_post(text, text, text, text, text) from public, anon;
grant execute on function public.submit_blog_post(text, text, text, text, text) to authenticated;

-- ---------------------------------------------------------------------------
-- Admin approve/reject
-- ---------------------------------------------------------------------------
create or replace function public.admin_set_blog_approval(
  p_id uuid,
  p_status text
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
    raise exception 'Only administrators can approve or reject posts';
  end if;
  if p_status not in ('pending', 'approved', 'rejected') then
    raise exception 'Invalid approval status';
  end if;

  update public.blog_posts
  set approval_status = p_status, updated_at = now()
  where id = p_id
  returning * into result;

  return result;
end;
$$;

revoke execute on function public.admin_set_blog_approval(uuid, text) from public, anon;
grant execute on function public.admin_set_blog_approval(uuid, text) to authenticated;

-- ---------------------------------------------------------------------------
-- Allow authors to update own draft (for editing before publishing)
-- ---------------------------------------------------------------------------
create or replace function public.update_own_blog_post(
  p_id uuid,
  p_title text,
  p_slug text,
  p_excerpt text default '',
  p_content text default '',
  p_featured_image text default null
)
returns public.blog_posts
language plpgsql
security definer
set search_path = public
as $$
declare
  result public.blog_posts;
begin
  update public.blog_posts
  set title = p_title, slug = p_slug, excerpt = p_excerpt, content = p_content,
      featured_image = nullif(p_featured_image, ''),
      approval_status = 'pending', updated_at = now()
  where id = p_id and author_id = auth.uid()
  returning * into result;

  if result is null then
    raise exception 'Post not found or not owned by you';
  end if;
  return result;
end;
$$;

revoke execute on function public.update_own_blog_post(uuid, text, text, text, text, text) from public, anon;
grant execute on function public.update_own_blog_post(uuid, text, text, text, text, text) to authenticated;
