import { Eye, EyeOff, NotebookPen, Trash2 } from 'lucide-react';
import { useEffect, useRef, useState } from 'react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Button } from '@/components/ui/button';
import { Textarea } from '@/components/ui/textarea';
import { useAuth } from '@/hooks/useAuth';

const memoryScratchpad = new Map<string, string>();

function storageKey(userId: string | null | undefined, questionId: string): string {
  return `matematisko-scratchpad-v1:${userId ?? 'anon'}:${questionId}`;
}

function readScratchpad(userId: string | null | undefined, questionId: string): string {
  const key = storageKey(userId, questionId);
  try {
    const stored = localStorage.getItem(key);
    if (stored !== null) return stored;
  } catch {
    // Fall back to in-memory map if browser storage is restricted.
  }
  return memoryScratchpad.get(key) ?? '';
}

function writeScratchpad(userId: string | null | undefined, questionId: string, value: string): void {
  const key = storageKey(userId, questionId);
  const trimmed = value.trim();
  if (trimmed) {
    memoryScratchpad.set(key, value);
  } else {
    memoryScratchpad.delete(key);
  }
  try {
    if (trimmed) {
      localStorage.setItem(key, value);
    } else {
      localStorage.removeItem(key);
    }
  } catch {
    // Ignore storage write errors; memoryScratchpad retains the session value.
  }
}

const SNIPPETS: { label: string; insert: string }[] = [
  { label: 'Inline $x$', insert: '$x$' },
  { label: 'Display $$', insert: '\n$$\n\n$$\n' },
  { label: 'Fraction', insert: '$\\frac{a}{b}$' },
  { label: 'Integral', insert: '$\\int_{a}^{b} f(x)\\,dx$' },
  { label: 'Sum', insert: '$\\sum_{n=1}^{\\infty} a_n$' },
  { label: 'Limit', insert: '$\\lim_{x \\to a} f(x)$' },
  {
    label: 'Aligned',
    insert: '\n$$\n\\begin{aligned}\nf(x) &= \\\\\n     &= \n\\end{aligned}\n$$\n',
  },
];

export function Scratchpad({ questionId }: { questionId: string }) {
  const { user } = useAuth();
  const userId = user?.id ?? null;
  const [content, setContent] = useState(() => readScratchpad(userId, questionId));
  const [open, setOpen] = useState(() => Boolean(readScratchpad(userId, questionId).trim()));
  const [showPreview, setShowPreview] = useState(true);
  const textareaRef = useRef<HTMLTextAreaElement>(null);

  useEffect(() => {
    const saved = readScratchpad(userId, questionId);
    setContent(saved);
    setOpen(Boolean(saved.trim()));
  }, [userId, questionId]);

  const updateContent = (next: string) => {
    setContent(next);
    writeScratchpad(userId, questionId, next);
  };

  const insertSnippet = (snippet: string) => {
    const el = textareaRef.current;
    if (!el) {
      updateContent(content + snippet);
      return;
    }
    const start = el.selectionStart ?? content.length;
    const end = el.selectionEnd ?? content.length;
    const next = content.slice(0, start) + snippet + content.slice(end);
    updateContent(next);
    requestAnimationFrame(() => {
      el.focus();
      const cursor = start + snippet.length;
      el.setSelectionRange(cursor, cursor);
    });
  };

  return (
    <div className="rounded-xl border border-stone-200 bg-stone-50/70 p-4 dark:border-stone-800 dark:bg-stone-900/50">
      <div className="flex flex-wrap items-center justify-between gap-2">
        <div className="flex items-center gap-2">
          <NotebookPen className="size-4 text-brand-800 dark:text-brand-300" />
          <span className="text-sm font-semibold text-stone-800 dark:text-stone-100">
            Scratchpad & working notes
          </span>
          {content.trim() && (
            <span className="rounded-full bg-brand-100 px-2 py-0.5 text-[11px] font-medium text-brand-900 dark:bg-brand-950 dark:text-brand-200">
              Saved locally
            </span>
          )}
        </div>
        <Button
          type="button"
          variant="outline"
          size="sm"
          aria-expanded={open}
          onClick={() => setOpen((prev) => !prev)}
        >
          {open ? 'Hide scratchpad' : 'Open scratchpad'}
        </Button>
      </div>

      {open && (
        <div className="mt-3 space-y-3">
          <div className="flex flex-wrap items-center gap-1.5" aria-label="Math snippets">
            {SNIPPETS.map((item) => (
              <button
                key={item.label}
                type="button"
                onClick={() => insertSnippet(item.insert)}
                className="rounded-md border border-stone-200 bg-white px-2 py-1 font-mono text-xs text-stone-700 hover:border-brand-300 hover:bg-brand-50/50 dark:border-stone-700 dark:bg-stone-900 dark:text-stone-200 dark:hover:border-brand-700"
              >
                {item.label}
              </button>
            ))}
          </div>

          <label className="block text-xs font-medium text-stone-600 dark:text-stone-300">
            Write your steps in plain text, Markdown, or LaTeX ($...$ and separate-line $$...$$)
            <Textarea
              ref={textareaRef}
              aria-label="Scratchpad working notes"
              rows={4}
              value={content}
              onChange={(e) => updateContent(e.target.value)}
              placeholder="Work out the algebra, set up an integral, or test your proof steps before revealing the answer…"
              className="mt-1.5 bg-white font-mono text-sm dark:bg-stone-950"
            />
          </label>

          <div className="flex flex-wrap items-center justify-between gap-2">
            <Button
              type="button"
              variant="ghost"
              size="sm"
              onClick={() => setShowPreview((p) => !p)}
            >
              {showPreview ? <EyeOff className="size-3.5" /> : <Eye className="size-3.5" />}
              {showPreview ? 'Hide math preview' : 'Show math preview'}
            </Button>
            {content.trim() && (
              <Button
                type="button"
                variant="ghost"
                size="sm"
                onClick={() => updateContent('')}
                className="text-stone-500 hover:text-red-600 dark:hover:text-red-400"
              >
                <Trash2 className="size-3.5" />
                Clear scratchpad
              </Button>
            )}
          </div>

          {showPreview && content.trim() && (
            <div
              role="region"
              aria-label="Scratchpad math preview"
              className="rounded-lg border border-stone-200 bg-white p-3.5 dark:border-stone-800 dark:bg-stone-950"
            >
              <p className="mb-1.5 text-[11px] font-semibold uppercase tracking-wider text-stone-400 dark:text-stone-500">
                Live math preview
              </p>
              <MathRenderer className="text-sm">{content}</MathRenderer>
            </div>
          )}
        </div>
      )}
    </div>
  );
}
