import { BookOpenText, Plus, Trash2 } from 'lucide-react';
import { useEffect, useState } from 'react';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { adminUpsertBlogPost, adminDeleteBlogPost } from '@/lib/db';
import type { BlogPost } from '@/types';

function slugify(text: string): string {
  return text
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

interface BlogAdminSectionProps {
  editId?: string | null;
  onEditHandled?: () => void;
}

export function BlogAdminSection({ editId, onEditHandled }: BlogAdminSectionProps) {
  const [posts, setPosts] = useState<BlogPost[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const [selected, setSelected] = useState<BlogPost | null>(null);
  const [title, setTitle] = useState('');
  const [slug, setSlug] = useState('');
  const [slugEdited, setSlugEdited] = useState(false);
  const [excerpt, setExcerpt] = useState('');
  const [content, setContent] = useState('');
  const [featuredImage, setFeaturedImage] = useState('');
  const [published, setPublished] = useState(false);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [search, setSearch] = useState('');

  const fetchPosts = async () => {
    const { supabase, isSupabaseConfigured } = await import('@/lib/supabase');
    if (!isSupabaseConfigured || !supabase) return;
    const { data, error: err } = await supabase
      .from('blog_posts')
      .select('*')
      .order('created_at', { ascending: false });
    if (err) setError(err.message);
    else setPosts((data ?? []) as BlogPost[]);
    setLoading(false);
  };

  useEffect(() => {
    fetchPosts();
  }, []);

  // Auto-select from editId
  useEffect(() => {
    if (!editId || posts.length === 0) return;
    const target = posts.find((p) => p.id === editId);
    if (target) {
      setSelected(target);
      setTitle(target.title);
      setSlug(target.slug);
      setSlugEdited(true);
      setExcerpt(target.excerpt);
      setContent(target.content);
      setFeaturedImage(target.featured_image ?? '');
      setPublished(target.published);
      onEditHandled?.();
    }
  }, [editId, posts, onEditHandled]);

  const filtered = posts.filter(
    (p) =>
      p.title.toLowerCase().includes(search.toLowerCase()) ||
      p.slug.toLowerCase().includes(search.toLowerCase()),
  );

  const resetForm = () => {
    setSelected(null);
    setTitle('');
    setSlug('');
    setSlugEdited(false);
    setExcerpt('');
    setContent('');
    setFeaturedImage('');
    setPublished(false);
    setSaveError(null);
  };

  const handleTitleChange = (value: string) => {
    setTitle(value);
    if (!slugEdited) setSlug(slugify(value));
  };

  const handleSave = async () => {
    if (!title.trim() || !slug.trim()) {
      setSaveError('Title and slug are required');
      return;
    }
    setSaving(true);
    setSaveError(null);
    try {
      await adminUpsertBlogPost(title, slug, excerpt, content, featuredImage, published, selected?.id ?? null);
      resetForm();
      fetchPosts();
    } catch (err) {
      setSaveError(err instanceof Error ? err.message : String(err));
    } finally {
      setSaving(false);
    }
  };

  const handleEdit = (post: BlogPost) => {
    setSelected(post);
    setTitle(post.title);
    setSlug(post.slug);
    setSlugEdited(true);
    setExcerpt(post.excerpt);
    setContent(post.content);
    setFeaturedImage(post.featured_image ?? '');
    setPublished(post.published);
    setSaveError(null);
  };

  const handleDelete = (post: BlogPost) => {
    if (!window.confirm(`Delete "${post.title}"?`)) return;
    adminDeleteBlogPost(post.id).then(() => {
      if (selected?.id === post.id) resetForm();
      fetchPosts();
    });
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <h2 className="font-serif text-2xl font-bold text-stone-900 dark:text-stone-50">
          Blog Posts
        </h2>
        <Button onClick={resetForm} size="sm">
          <Plus className="size-4" />
          New post
        </Button>
      </div>

      {/* Editor */}
      <Card className="space-y-4 p-5">
        <h3 className="text-sm font-semibold text-stone-700 dark:text-stone-200">
          {selected ? `Editing: ${selected.title}` : 'New Post'}
        </h3>
        <div className="grid gap-4 sm:grid-cols-2">
          <div>
            <Label htmlFor="post-title">Title</Label>
            <Input
              id="post-title"
              value={title}
              onChange={(e) => handleTitleChange(e.target.value)}
              placeholder="My first blog post"
              className="mt-1"
            />
          </div>
          <div>
            <Label htmlFor="post-slug">Slug</Label>
            <Input
              id="post-slug"
              value={slug}
              onChange={(e) => {
                setSlug(e.target.value);
                setSlugEdited(true);
              }}
              placeholder="my-first-blog-post"
              className="mt-1 font-mono text-sm"
            />
          </div>
        </div>
        <div>
          <Label htmlFor="post-excerpt">Excerpt</Label>
          <Input
            id="post-excerpt"
            value={excerpt}
            onChange={(e) => setExcerpt(e.target.value)}
            placeholder="A short summary of the post..."
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="post-image">Featured image URL (optional)</Label>
          <Input
            id="post-image"
            value={featuredImage}
            onChange={(e) => setFeaturedImage(e.target.value)}
            placeholder="https://..."
            className="mt-1"
          />
        </div>
        <div>
          <Label htmlFor="post-content">Content (Markdown + LaTeX)</Label>
          <Textarea
            id="post-content"
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder="# My Post&#10;&#10;Write your content here with $math$ and **bold**."
            className="mt-1 min-h-[240px] font-mono text-sm"
          />
        </div>
        <div className="flex items-center gap-4">
          <label className="inline-flex items-center gap-2 text-sm">
            <input
              type="checkbox"
              checked={published}
              onChange={(e) => setPublished(e.target.checked)}
              className="size-4 rounded border-stone-300"
            />
            Published
          </label>
        </div>
        {saveError && (
          <p className="text-sm text-red-600 dark:text-red-400">{saveError}</p>
        )}
        <div className="flex items-center gap-2">
          <Button onClick={handleSave} disabled={saving}>
            {saving ? 'Saving...' : selected ? 'Update' : 'Create'}
          </Button>
          {selected && (
            <Button variant="ghost" onClick={resetForm}>
              Cancel
            </Button>
          )}
        </div>
        {content && (
          <div className="rounded-lg border border-stone-200 bg-stone-50 p-4 dark:border-stone-700 dark:bg-stone-800">
            <p className="mb-2 text-xs font-medium text-stone-500 dark:text-stone-400">Preview</p>
            <div className="max-h-64 overflow-y-auto">
              <MathRenderer>{content}</MathRenderer>
            </div>
          </div>
        )}
      </Card>

      <Input
        placeholder="Search posts..."
        value={search}
        onChange={(e) => setSearch(e.target.value)}
      />

      {loading ? (
        <LoadingState label="Loading posts" />
      ) : error ? (
        <ErrorState title="Could not load posts" message={error} onRetry={fetchPosts} />
      ) : filtered.length === 0 ? (
        <EmptyState
          icon={<BookOpenText className="size-8" />}
          title="No posts"
          description={search ? 'No posts match your search.' : 'Create your first post above.'}
        />
      ) : (
        <div className="space-y-2">
          {filtered.map((post) => (
            <div
              key={post.id}
              className="flex items-center justify-between gap-3 rounded-lg border border-stone-200 bg-white px-4 py-3 transition-colors hover:bg-stone-50 dark:border-stone-700 dark:bg-stone-900 dark:hover:bg-stone-800"
            >
              <div className="min-w-0 flex-1">
                <div className="flex items-center gap-2">
                  <p className="truncate text-sm font-medium text-stone-800 dark:text-stone-100">
                    {post.title}
                  </p>
                  <Badge variant={post.published ? 'default' : 'secondary'}>
                    {post.published ? 'Published' : 'Draft'}
                  </Badge>
                </div>
                <p className="mt-0.5 text-xs text-stone-400 dark:text-stone-500">
                  /blogs/{post.slug}
                </p>
              </div>
              <div className="flex shrink-0 gap-1">
                <Button variant="ghost" size="sm" onClick={() => handleEdit(post)}>
                  Edit
                </Button>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => handleDelete(post)}
                  className="text-red-500 hover:text-red-700 hover:bg-red-50 dark:text-red-400 dark:hover:text-red-300 dark:hover:bg-red-950"
                >
                  <Trash2 className="size-4" />
                </Button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
