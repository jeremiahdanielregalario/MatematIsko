import { BookOpenText, Check, Plus, Trash2, X } from 'lucide-react';
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
import { adminUpsertBlogPost, adminDeleteBlogPost, adminSetBlogApproval } from '@/lib/db';
import type { BlogPostWithAuthor } from '@/types';

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
  const [posts, setPosts] = useState<BlogPostWithAuthor[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [filter, setFilter] = useState<'all' | 'pending' | 'approved' | 'rejected'>('pending');

  const [selected, setSelected] = useState<BlogPostWithAuthor | null>(null);
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
      .select('*, author:profiles(full_name, avatar_url)')
      .order('created_at', { ascending: false });
    if (err) setError(err.message);
    else setPosts((data ?? []) as BlogPostWithAuthor[]);
    setLoading(false);
  };

  useEffect(() => {
    fetchPosts();
  }, []);

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

  const filtered = posts
    .filter((p) => filter === 'all' || p.approval_status === filter)
    .filter(
      (p) =>
        p.title.toLowerCase().includes(search.toLowerCase()) ||
        (p.author?.full_name ?? '').toLowerCase().includes(search.toLowerCase()),
    );

  const pendingCount = posts.filter((p) => p.approval_status === 'pending').length;

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

  const handleApprove = async (post: BlogPostWithAuthor) => {
    try {
      await adminSetBlogApproval(post.id, 'approved');
      fetchPosts();
    } catch {
      // silent
    }
  };

  const handleReject = async (post: BlogPostWithAuthor) => {
    try {
      await adminSetBlogApproval(post.id, 'rejected');
      fetchPosts();
    } catch {
      // silent
    }
  };

  const handleDelete = (post: BlogPostWithAuthor) => {
    if (!window.confirm(`Delete "${post.title}"?`)) return;
    adminDeleteBlogPost(post.id).then(() => {
      if (selected?.id === post.id) resetForm();
      fetchPosts();
    });
  };

  const statusBadge = (status: string) => {
    switch (status) {
      case 'pending':
        return <Badge className="bg-amber-100 text-amber-700 dark:bg-amber-900/50 dark:text-amber-300">Pending</Badge>;
      case 'approved':
        return <Badge className="bg-emerald-100 text-emerald-700 dark:bg-emerald-900/50 dark:text-emerald-300">Approved</Badge>;
      case 'rejected':
        return <Badge className="bg-red-100 text-red-700 dark:bg-red-900/50 dark:text-red-300">Rejected</Badge>;
      default:
        return null;
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <h2 className="font-serif text-2xl font-bold text-stone-900 dark:text-stone-50">
          Blog Posts {pendingCount > 0 && (
            <Badge className="ml-2 bg-amber-500 text-white">{pendingCount} pending</Badge>
          )}
        </h2>
        <Button onClick={resetForm} size="sm">
          <Plus className="size-4" />
          New post
        </Button>
      </div>

      {/* Filter tabs */}
      <div className="flex items-center gap-1 rounded-lg border border-stone-200 bg-stone-50 p-1 dark:border-stone-800 dark:bg-stone-900">
        {(['pending', 'approved', 'rejected', 'all'] as const).map((f) => (
          <button
            key={f}
            type="button"
            onClick={() => setFilter(f)}
            className={`inline-flex items-center gap-1.5 rounded-md px-3 py-1.5 text-sm font-medium transition-colors ${
              filter === f
                ? 'bg-white text-stone-900 shadow-sm dark:bg-stone-800 dark:text-stone-50'
                : 'text-stone-500 hover:text-stone-700 dark:text-stone-400'
            }`}
          >
            {f.charAt(0).toUpperCase() + f.slice(1)}
            {f === 'pending' && pendingCount > 0 && (
              <span className="flex size-5 items-center justify-center rounded-full bg-amber-500 text-[10px] font-bold text-white">
                {pendingCount}
              </span>
            )}
          </button>
        ))}
      </div>

      {/* Editor */}
      <Card className="space-y-4 p-5">
        <h3 className="text-sm font-semibold text-stone-700 dark:text-stone-200">
          {selected ? `Editing: ${selected.title}` : 'New Post (Admin)'}
        </h3>
        <div className="grid gap-4 sm:grid-cols-2">
          <div>
            <Label htmlFor="post-title">Title</Label>
            <Input id="post-title" value={title} onChange={(e) => handleTitleChange(e.target.value)} placeholder="Post title" className="mt-1" />
          </div>
          <div>
            <Label htmlFor="post-slug">Slug</Label>
            <Input id="post-slug" value={slug} onChange={(e) => { setSlug(e.target.value); setSlugEdited(true); }} className="mt-1 font-mono text-sm" />
          </div>
        </div>
        <div>
          <Label htmlFor="post-excerpt">Excerpt</Label>
          <Input id="post-excerpt" value={excerpt} onChange={(e) => setExcerpt(e.target.value)} className="mt-1" />
        </div>
        <div>
          <Label htmlFor="post-image">Featured image URL</Label>
          <Input id="post-image" value={featuredImage} onChange={(e) => setFeaturedImage(e.target.value)} className="mt-1" />
        </div>
        <div>
          <Label htmlFor="post-content">Content (Markdown + LaTeX)</Label>
          <Textarea id="post-content" value={content} onChange={(e) => setContent(e.target.value)} className="mt-1 min-h-[200px] font-mono text-sm" />
        </div>
        <div className="flex items-center gap-4">
          <label className="inline-flex items-center gap-2 text-sm">
            <input type="checkbox" checked={published} onChange={(e) => setPublished(e.target.checked)} className="size-4 rounded border-stone-300" />
            Published
          </label>
        </div>
        {saveError && <p className="text-sm text-red-600 dark:text-red-400">{saveError}</p>}
        <div className="flex items-center gap-2">
          <Button onClick={handleSave} disabled={saving}>{saving ? 'Saving...' : selected ? 'Update' : 'Create'}</Button>
          {selected && <Button variant="ghost" onClick={resetForm}>Cancel</Button>}
        </div>
        {content && (
          <div className="rounded-lg border border-stone-200 bg-stone-50 p-4 dark:border-stone-700 dark:bg-stone-800">
            <p className="mb-2 text-xs font-medium text-stone-500">Preview</p>
            <div className="max-h-64 overflow-y-auto"><MathRenderer>{content}</MathRenderer></div>
          </div>
        )}
      </Card>

      <Input placeholder="Search posts..." value={search} onChange={(e) => setSearch(e.target.value)} />

      {loading ? (
        <LoadingState label="Loading posts" />
      ) : error ? (
        <ErrorState title="Could not load posts" message={error} onRetry={fetchPosts} />
      ) : filtered.length === 0 ? (
        <EmptyState icon={<BookOpenText className="size-8" />} title="No posts" description="No posts match this filter." />
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
                  {statusBadge(post.approval_status)}
                </div>
                <div className="mt-0.5 flex items-center gap-2 text-xs text-stone-400 dark:text-stone-500">
                  <span>by {post.author?.full_name ?? 'Anonymous'}</span>
                  <span>/blogs/{post.slug}</span>
                </div>
              </div>
              <div className="flex shrink-0 gap-1">
                {post.approval_status === 'pending' && (
                  <>
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => handleApprove(post)}
                      className="text-emerald-600 hover:text-emerald-700 hover:bg-emerald-50 dark:text-emerald-400 dark:hover:bg-emerald-950"
                    >
                      <Check className="size-4" />
                    </Button>
                    <Button
                      variant="ghost"
                      size="sm"
                      onClick={() => handleReject(post)}
                      className="text-red-500 hover:text-red-700 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-950"
                    >
                      <X className="size-4" />
                    </Button>
                  </>
                )}
                <Button variant="ghost" size="sm" onClick={() => handleEdit(post)}>
                  Edit
                </Button>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => handleDelete(post)}
                  className="text-red-500 hover:text-red-700 hover:bg-red-50 dark:text-red-400 dark:hover:bg-red-950"
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

  function handleEdit(post: BlogPostWithAuthor) {
    setSelected(post);
    setTitle(post.title);
    setSlug(post.slug);
    setSlugEdited(true);
    setExcerpt(post.excerpt);
    setContent(post.content);
    setFeaturedImage(post.featured_image ?? '');
    setPublished(post.published);
    setSaveError(null);
  }
}
