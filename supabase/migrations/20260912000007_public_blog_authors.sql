-- Deliberately owner-executed: profile RLS remains private, while this bounded
-- projection exposes attribution only alongside publicly readable posts.
create view public.published_blog_posts
with (security_barrier = true) as
select b.id, b.title, b.slug, b.excerpt, b.content, b.author_id,
       b.featured_image, b.published, b.created_at, b.updated_at,
       b.approval_status,
       case when p.id is null then null else
         jsonb_build_object('full_name', p.full_name, 'avatar_url', p.avatar_url)
       end as author
from public.blog_posts b
left join public.profiles p on p.id = b.author_id
where b.published = true and b.approval_status = 'approved';

revoke all on public.published_blog_posts from public, anon, authenticated;
grant select on public.published_blog_posts to anon, authenticated;
