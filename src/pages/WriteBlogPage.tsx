import { ArrowLeft, Send } from 'lucide-react';
import { useState } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { useAuth } from '@/hooks/useAuth';
import { submitBlogPost } from '@/lib/db';

function slugify(text: string): string {
  return text
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');
}

export function WriteBlogPage() {
  const { user } = useAuth();
  const navigate = useNavigate();
  const [title, setTitle] = useState('');
  const [slug, setSlug] = useState('');
  const [slugEdited, setSlugEdited] = useState(false);
  const [excerpt, setExcerpt] = useState('');
  const [content, setContent] = useState('');
  const [featuredImage, setFeaturedImage] = useState('');
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleTitleChange = (value: string) => {
    setTitle(value);
    if (!slugEdited) setSlug(slugify(value));
  };

  const handleSubmit = async () => {
    if (!title.trim() || !slug.trim()) {
      setError('Title and slug are required');
      return;
    }
    if (!content.trim()) {
      setError('Content cannot be empty');
      return;
    }
    setSaving(true);
    setError(null);
    try {
      await submitBlogPost(title, slug, excerpt, content, featuredImage);
      navigate('/blogs');
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setSaving(false);
    }
  };

  if (!user) return null;

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Link
        to="/blogs"
        className="inline-flex items-center gap-1 text-sm text-stone-500 transition-colors hover:text-stone-800 dark:text-stone-400 dark:hover:text-stone-200"
      >
        <ArrowLeft className="size-3.5" />
        Back to blogs
      </Link>

      <div className="rounded-2xl border border-stone-200 bg-white p-6 shadow-sm dark:border-stone-700 dark:bg-stone-800 sm:p-8">
        <div className="mb-6">
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Write a Post
          </h1>
          <p className="mt-2 text-stone-500 dark:text-stone-400">
            Share your experience, study tips, or math insights with the community.
            Posts are reviewed by admins before they appear publicly.
          </p>
        </div>

        <div className="space-y-5">
          <div className="grid gap-4 sm:grid-cols-2">
            <div>
              <Label htmlFor="blog-title">Title</Label>
              <Input
                id="blog-title"
                value={title}
                onChange={(e) => handleTitleChange(e.target.value)}
                placeholder="Your blog post title"
                className="mt-1"
              />
            </div>
            <div>
              <Label htmlFor="blog-slug">URL slug</Label>
              <Input
                id="blog-slug"
                value={slug}
                onChange={(e) => {
                  setSlug(e.target.value);
                  setSlugEdited(true);
                }}
                placeholder="your-blog-post-title"
                className="mt-1 font-mono text-sm"
              />
            </div>
          </div>
          <div>
            <Label htmlFor="blog-excerpt">Caption / Excerpt</Label>
            <Input
              id="blog-excerpt"
              value={excerpt}
              onChange={(e) => setExcerpt(e.target.value)}
              placeholder="A short caption shown in the blog listing..."
              className="mt-1"
            />
          </div>
          <div>
            <Label htmlFor="blog-image">Featured image URL (optional)</Label>
            <Input
              id="blog-image"
              value={featuredImage}
              onChange={(e) => setFeaturedImage(e.target.value)}
              placeholder="https://..."
              className="mt-1"
            />
          </div>
          <div>
            <Label htmlFor="blog-content">Content (Markdown + LaTeX)</Label>
            <Textarea
              id="blog-content"
              value={content}
              onChange={(e) => setContent(e.target.value)}
              placeholder="# My Post&#10;&#10;Write your content here with $math$ and **bold**."
              className="mt-1 min-h-[280px] font-mono text-sm"
            />
          </div>

          {error && (
            <p className="text-sm text-red-600 dark:text-red-400">{error}</p>
          )}

          <div className="flex items-center gap-3">
            <Button onClick={handleSubmit} disabled={saving}>
              <Send className="size-4" />
              {saving ? 'Submitting...' : 'Submit for Review'}
            </Button>
          </div>
        </div>
      </div>

      {content && (
        <div className="space-y-2">
          <p className="text-sm font-medium text-stone-500 dark:text-stone-400">Preview</p>
          <div className="rounded-xl border border-stone-200 bg-white p-6 shadow-sm dark:border-stone-700 dark:bg-stone-800">
            <MathRenderer>{content}</MathRenderer>
          </div>
        </div>
      )}
    </div>
  );
}
