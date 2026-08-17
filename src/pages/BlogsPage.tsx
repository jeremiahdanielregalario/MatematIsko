import { useEffect, useState } from 'react';
import { BookOpenText, Calendar, Clock } from 'lucide-react';
import { Link } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Input } from '@/components/ui/input';
import { useAuth } from '@/hooks/useAuth';
import type { BlogPost } from '@/types';

function useBlogPosts() {
  const { user } = useAuth();
  const [posts, setPosts] = useState<BlogPost[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!user) {
      setLoading(false);
      return;
    }

    import('@/lib/supabase').then(({ supabase, isSupabaseConfigured }) => {
      if (!isSupabaseConfigured || !supabase) {
        setLoading(false);
        return;
      }
      supabase
        .from('blog_posts')
        .select('*')
        .eq('published', true)
        .order('created_at', { ascending: false })
        .then(({ data, error: err }) => {
          if (err) setError(err.message);
          else setPosts((data ?? []) as BlogPost[]);
          setLoading(false);
        });
    });
  }, [user]);

  return { posts, loading, error };
}

function formatDate(dateStr: string): string {
  return new Date(dateStr).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
  });
}

function readingTime(content: string): number {
  const words = content.trim().split(/\s+/).length;
  return Math.max(1, Math.ceil(words / 200));
}

export function BlogsPage() {
  const { posts, loading, error } = useBlogPosts();
  const [search, setSearch] = useState('');

  const filtered = posts.filter(
    (p) =>
      p.title.toLowerCase().includes(search.toLowerCase()) ||
      p.excerpt.toLowerCase().includes(search.toLowerCase()),
  );

  if (loading) return <LoadingState label="Loading blogs" />;
  if (error) return <ErrorState title="Could not load blogs" message={error} />;

  return (
    <div className="space-y-8">
      <section>
        <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
          Blogs
        </h1>
        <p className="mt-2 text-stone-500 dark:text-stone-400">
          Stories, guides, and reflections from the UP Math community.
        </p>
      </section>

      <div>
        <Input
          placeholder="Search posts..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
          className="max-w-md"
        />
      </div>

      {filtered.length === 0 ? (
        <EmptyState
          icon={<BookOpenText className="size-8" />}
          title={search ? 'No posts match your search' : 'No posts yet'}
          description="Check back later for new posts from the community."
        />
      ) : (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {filtered.map((post) => (
            <BlogCard key={post.id} post={post} />
          ))}
        </div>
      )}
    </div>
  );
}

function BlogCard({ post }: { post: BlogPost }) {
  return (
    <Link
      to={`/blogs/${post.slug}`}
      className="group flex flex-col overflow-hidden rounded-xl border border-stone-200 bg-white shadow-sm transition-all duration-200 hover:-translate-y-1 hover:shadow-md dark:border-stone-700 dark:bg-stone-800"
    >
      {post.featured_image && (
        <div className="aspect-[16/10] overflow-hidden bg-stone-100 dark:bg-stone-700">
          <img
            src={post.featured_image}
            alt={post.title}
            className="h-full w-full object-cover transition-transform duration-300 group-hover:scale-105"
          />
        </div>
      )}
      <div className="flex flex-1 flex-col p-5">
        <h2 className="font-serif text-lg font-bold leading-snug text-stone-900 group-hover:text-brand-700 dark:text-stone-50 dark:group-hover:text-brand-300">
          {post.title}
        </h2>
        {post.excerpt && (
          <p className="mt-2 line-clamp-3 flex-1 text-sm text-stone-500 dark:text-stone-400">
            {post.excerpt}
          </p>
        )}
        <div className="mt-4 flex items-center gap-3 text-xs text-stone-400 dark:text-stone-500">
          <span className="inline-flex items-center gap-1">
            <Calendar className="size-3" />
            {formatDate(post.created_at)}
          </span>
          <span className="inline-flex items-center gap-1">
            <Clock className="size-3" />
            {readingTime(post.content)} min read
          </span>
        </div>
      </div>
    </Link>
  );
}
