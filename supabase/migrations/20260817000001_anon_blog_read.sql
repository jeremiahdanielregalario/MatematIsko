-- Allow anonymous (non-signed-in) users to read published, approved blog posts
create policy "Anonymous can read published approved posts"
  on public.blog_posts for select
  to anon
  using (published = true and approval_status = 'approved');
