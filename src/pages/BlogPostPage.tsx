import { useEffect, useState } from 'react';
import { Link, useParams } from 'react-router-dom';
import { ArrowLeft, Calendar, Clock, BookOpenText } from 'lucide-react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/hooks/useAuth';
import type { BlogPostWithAuthor } from '@/types';

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

function getInitials(name: string | null): string {
  if (!name) return '?';
  return name
    .split(' ')
    .map((w) => w[0])
    .join('')
    .toUpperCase()
    .slice(0, 2);
}

export function BlogPostPage() {
  const { slug } = useParams<{ slug: string }>();
  const { user } = useAuth();
  const [post, setPost] = useState<BlogPostWithAuthor | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    if (!slug || !user) {
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
        .select('*, author:profiles(full_name, avatar_url)')
        .eq('slug', slug)
        .eq('published', true)
        .eq('approval_status', 'approved')
        .single()
        .then(({ data, error: err }) => {
          if (err) setError(err.message);
          else setPost(data as BlogPostWithAuthor);
          setLoading(false);
        });
    });
  }, [slug, user]);

  if (loading) return <LoadingState label="Loading post" />;
  if (error) return <ErrorState title="Could not load post" message={error} />;
  if (!post) {
    return (
      <EmptyState
        icon={<BookOpenText className="size-8" />}
        title="Post not found"
        description="This blog post does not exist or has not been published yet."
        action={
          <Button asChild>
            <Link to="/blogs">Back to blogs</Link>
          </Button>
        }
      />
    );
  }

  const authorName = post.author?.full_name ?? 'Anonymous';
  const avatarUrl = post.author?.avatar_url;

  return (
    <article className="mx-auto max-w-3xl space-y-6">
      <Link
        to="/blogs"
        className="inline-flex items-center gap-1 text-sm text-stone-500 transition-colors hover:text-stone-800 dark:text-stone-400 dark:hover:text-stone-200"
      >
        <ArrowLeft className="size-3.5" />
        All posts
      </Link>

      {post.featured_image && (
        <div className="overflow-hidden rounded-2xl">
          <img
            src={post.featured_image}
            alt={post.title}
            className="aspect-[2/1] w-full object-cover"
          />
        </div>
      )}

      <header className="space-y-4">
        <h1 className="font-serif text-3xl font-bold leading-tight tracking-tight text-stone-900 dark:text-stone-50 sm:text-4xl">
          {post.title}
        </h1>
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-3">
            {avatarUrl ? (
              <img
                src={avatarUrl}
                alt={authorName}
                className="size-10 rounded-full object-cover"
              />
            ) : (
              <div className="flex size-10 items-center justify-center rounded-full bg-brand-100 text-sm font-bold text-brand-700 dark:bg-brand-900/50 dark:text-brand-300">
                {getInitials(authorName)}
              </div>
            )}
            <div>
              <p className="text-sm font-semibold text-stone-800 dark:text-stone-100">
                {authorName}
              </p>
              <div className="flex items-center gap-3 text-xs text-stone-500 dark:text-stone-400">
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
          </div>
        </div>
      </header>

      <div className="border-t border-stone-200 dark:border-stone-700" />

      <div className="prose-headings:font-serif">
        <MathRenderer>{post.content}</MathRenderer>
      </div>

      <div className="border-t border-stone-200 pt-6 dark:border-stone-700">
        <Button variant="outline" asChild>
          <Link to="/blogs">
            <ArrowLeft className="size-4" />
            Back to all posts
          </Link>
        </Button>
      </div>
    </article>
  );
}
