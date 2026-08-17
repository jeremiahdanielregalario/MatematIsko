import { useEffect, useMemo, useRef, useState } from 'react';
import { ChevronRight, BookOpen, ArrowUp } from 'lucide-react';
import ReactMarkdown from 'react-markdown';
import rehypeKatex from 'rehype-katex';
import remarkGfm from 'remark-gfm';
import remarkMath from 'remark-math';
import { MathRenderer } from '@/components/math/MathRenderer';
import { cn } from '@/lib/cn';
import { decodeUnicodeEscapes } from '@/lib/unicode';
import type { CourseNote } from '@/types';

interface Heading {
  id: string;
  text: string;
  level: number;
}

/** Extract headings from markdown content for the table of contents. */
function extractHeadings(content: string): Heading[] {
  const headings: Heading[] = [];
  const seen = new Set<string>();
  for (const line of content.split('\n')) {
    const match = line.match(/^(#{1,3})\s+(.+)/);
    if (!match) continue;
    const level = match[1].length;
    const text = match[2].replace(/[*_`$\\[\]]/g, '').trim();
    const id = text
      .toLowerCase()
      .replace(/[^a-z0-9]+/g, '-')
      .replace(/^-|-$/g, '');
    if (seen.has(id)) continue;
    seen.add(id);
    headings.push({ id, text, level });
  }
  return headings;
}

/** Build a map from heading text → id for quick lookup during rendering. */
function buildHeadingIdMap(headings: Heading[]): Map<string, string> {
  return new Map(headings.map((h) => [h.text, h.id]));
}

// ---------------------------------------------------------------------------
// NoteContent — renders markdown with colored boxes for named elements
// ---------------------------------------------------------------------------

type BlockType = 'theorem' | 'definition' | 'corollary' | 'lemma' | 'remark' | 'proof' | 'normal';

interface MdBlock {
  type: BlockType;
  heading: string;
  body: string;
}

const BLOCK_PATTERNS: [RegExp, BlockType][] = [
  [/^theorem/i, 'theorem'],
  [/^definition/i, 'definition'],
  [/^corollary/i, 'corollary'],
  [/^lemma/i, 'lemma'],
  [/^remark/i, 'remark'],
  [/^proof/i, 'proof'],
];

function classifyHeading(text: string): BlockType {
  const trimmed = text.replace(/[*_`$\\[\]]/g, '').trim();
  for (const [pattern, type] of BLOCK_PATTERNS) {
    if (pattern.test(trimmed)) return type;
  }
  return 'normal';
}

/** Split markdown into blocks by headings. */
function splitIntoBlocks(content: string): MdBlock[] {
  const lines = content.split('\n');
  const blocks: MdBlock[] = [];
  let currentHeading = '';
  let currentLines: string[] = [];

  const flush = () => {
    if (currentHeading || currentLines.length > 0) {
      blocks.push({
        type: classifyHeading(currentHeading),
        heading: currentHeading,
        body: currentLines.join('\n').trim(),
      });
    }
  };

  for (const line of lines) {
    const match = line.match(/^(#{1,3})\s+(.+)/);
    if (match) {
      flush();
      currentHeading = match[2];
      currentLines = [];
    } else {
      currentLines.push(line);
    }
  }
  flush();
  return blocks;
}

const BLOCK_STYLES: Record<BlockType, { wrapper: string; label: string; labelStyle: string }> = {
  theorem: {
    wrapper: 'border-l-4 border-blue-500 bg-blue-50/70 dark:border-blue-400 dark:bg-blue-950/40',
    label: 'Theorem',
    labelStyle: 'bg-blue-600 text-white dark:bg-blue-500',
  },
  definition: {
    wrapper: 'border-l-4 border-violet-500 bg-violet-50/70 dark:border-violet-400 dark:bg-violet-950/40',
    label: 'Definition',
    labelStyle: 'bg-violet-600 text-white dark:bg-violet-500',
  },
  corollary: {
    wrapper: 'border-l-4 border-emerald-500 bg-emerald-50/70 dark:border-emerald-400 dark:bg-emerald-950/40',
    label: 'Corollary',
    labelStyle: 'bg-emerald-600 text-white dark:bg-emerald-500',
  },
  lemma: {
    wrapper: 'border-l-4 border-amber-500 bg-amber-50/70 dark:border-amber-400 dark:bg-amber-950/40',
    label: 'Lemma',
    labelStyle: 'bg-amber-600 text-white dark:bg-amber-500',
  },
  remark: {
    wrapper: 'border-l-4 border-stone-400 bg-stone-50/70 dark:border-stone-500 dark:bg-stone-800/60',
    label: 'Remark',
    labelStyle: 'bg-stone-500 text-white dark:bg-stone-600',
  },
  proof: {
    wrapper: 'border-l-4 border-stone-300 bg-stone-50/50 dark:border-stone-600 dark:bg-stone-800/40',
    label: 'Proof',
    labelStyle: 'bg-stone-400 text-white dark:bg-stone-600',
  },
  normal: {
    wrapper: '',
    label: '',
    labelStyle: '',
  },
};

function BlockRenderer({
  block,
  headingIds,
}: {
  block: MdBlock;
  headingIds: Map<string, string>;
}) {
  const ref = useRef<HTMLDivElement>(null);
  const style = BLOCK_STYLES[block.type];

  // Stamp heading IDs after render
  useEffect(() => {
    const el = ref.current;
    if (!el) return;
    const headings = el.querySelectorAll('h1, h2, h3');
    headings.forEach((h) => {
      const text = h.textContent?.trim() ?? '';
      const id = headingIds.get(text);
      if (id) h.id = id;
    });
  }, [block, headingIds]);

  if (block.type === 'normal') {
    const md = block.heading ? `### ${block.heading}\n${block.body}` : block.body;
    return (
      <div ref={ref} className="py-2">
        <MathRenderer>{md}</MathRenderer>
      </div>
    );
  }

  // Extract the part after "Theorem 1.3" etc. for the subtitle, stripping numbering
  const headingText = block.heading
    .replace(/^(theorem|definition|corollary|lemma|remark|proof)\s*/i, '')
    .replace(/^\d+(\.\d+)*\s*[-—–:.\s]*/, '')
    .trim();

  const md = block.body || '';

  return (
    <div ref={ref} className={cn('overflow-hidden rounded-xl', style.wrapper)}>
      <div className="flex items-center gap-2 px-5 pt-4 pb-1">
        <span className={cn('rounded-md px-2.5 py-0.5 text-xs font-bold uppercase tracking-wide', style.labelStyle)}>
          {style.label}
        </span>
        {headingText && (
          <span className="text-sm font-semibold text-stone-700 dark:text-stone-200">
            <ReactMarkdown
              remarkPlugins={[remarkMath, remarkGfm]}
              rehypePlugins={[[rehypeKatex, { throwOnError: false }]]}
              components={{ p: 'span' }}
            >
              {decodeUnicodeEscapes(headingText)}
            </ReactMarkdown>
          </span>
        )}
      </div>
      <div className="px-5 pb-5 pt-1">
        <MathRenderer>{md}</MathRenderer>
      </div>
    </div>
  );
}

function NoteContent({
  content,
  headingIds,
}: {
  content: string;
  headingIds: Map<string, string>;
}) {
  const blocks = useMemo(() => splitIntoBlocks(content), [content]);

  return (
    <div className="space-y-6">
      {blocks.map((block, i) => (
        <BlockRenderer key={i} block={block} headingIds={headingIds} />
      ))}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Reading progress bar
// ---------------------------------------------------------------------------

function ReadingProgress({ target }: { target: React.RefObject<HTMLDivElement | null> }) {
  const [progress, setProgress] = useState(0);

  useEffect(() => {
    const el = target.current;
    if (!el) return;

    const handleScroll = () => {
      const rect = el.getBoundingClientRect();
      const total = el.scrollHeight - window.innerHeight;
      const scrolled = -rect.top;
      setProgress(Math.min(100, Math.max(0, (scrolled / total) * 100)));
    };

    window.addEventListener('scroll', handleScroll, { passive: true });
    return () => window.removeEventListener('scroll', handleScroll);
  }, [target]);

  return (
    <div className="fixed top-0 left-0 right-0 z-50 h-0.5 bg-transparent">
      <div
        className="h-full bg-gradient-to-r from-brand-500 via-brand-400 to-brand-600 transition-[width] duration-150 ease-out dark:from-brand-400 dark:via-brand-300 dark:to-brand-500"
        style={{ width: `${progress}%` }}
      />
    </div>
  );
}

// ---------------------------------------------------------------------------
// Table of Contents (desktop sidebar)
// ---------------------------------------------------------------------------

function TableOfContents({
  headings,
  activeId,
  onNavigate,
}: {
  headings: Heading[];
  activeId: string | null;
  onNavigate: (id: string) => void;
}) {
  if (headings.length === 0) return null;

  return (
    <nav className="hidden xl:block" aria-label="Table of contents">
      <div className="sticky top-24">
        <h4 className="mb-3 text-xs font-semibold uppercase tracking-wider text-stone-400 dark:text-stone-500">
          On this page
        </h4>
        <ul className="space-y-0.5 border-l border-stone-200 dark:border-stone-700">
          {headings.map((h) => (
            <li key={h.id}>
              <button
                type="button"
                onClick={() => onNavigate(h.id)}
                className={cn(
                  'block w-full truncate border-l-2 py-1 text-[13px] leading-snug transition-all duration-200',
                  h.level === 1 && 'pl-3 font-medium',
                  h.level === 2 && 'pl-6',
                  h.level === 3 && 'pl-9 text-[12px]',
                  activeId === h.id
                    ? 'border-brand-500 text-brand-700 dark:border-brand-400 dark:text-brand-300'
                    : 'border-transparent text-stone-500 hover:border-stone-300 hover:text-stone-700 dark:text-stone-400 dark:hover:border-stone-600 dark:hover:text-stone-200',
                )}
              >
                {h.text}
              </button>
            </li>
          ))}
        </ul>
      </div>
    </nav>
  );
}

// ---------------------------------------------------------------------------
// Mobile TOC dropdown
// ---------------------------------------------------------------------------

function MobileTOC({
  headings,
  activeId,
  onNavigate,
}: {
  headings: Heading[];
  activeId: string | null;
  onNavigate: (id: string) => void;
}) {
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    if (!open) return;
    const handler = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, [open]);

  if (headings.length === 0) return null;

  const activeHeading = headings.find((h) => h.id === activeId);

  return (
    <div ref={ref} className="xl:hidden">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className="flex w-full items-center gap-2 rounded-lg border border-stone-200 bg-white px-4 py-2.5 text-sm font-medium text-stone-700 shadow-sm transition-colors hover:bg-stone-50 dark:border-stone-700 dark:bg-stone-800 dark:text-stone-200 dark:hover:bg-stone-750"
      >
        <BookOpen className="size-4 shrink-0 text-brand-600 dark:text-brand-400" />
        <span className="truncate">
          {activeHeading?.text ?? 'Table of contents'}
        </span>
        <ChevronRight
          className={cn(
            'ml-auto size-4 shrink-0 transition-transform duration-200',
            open && 'rotate-90',
          )}
        />
      </button>

      {open && (
        <div className="mt-2 rounded-xl border border-stone-200 bg-white p-3 shadow-lg dark:border-stone-700 dark:bg-stone-800">
          <ul className="max-h-64 space-y-0.5 overflow-y-auto">
            {headings.map((h) => (
              <li key={h.id}>
                <button
                  type="button"
                  onClick={() => {
                    onNavigate(h.id);
                    setOpen(false);
                  }}
                  className={cn(
                    'block w-full truncate rounded-md px-3 py-1.5 text-left text-sm transition-colors',
                    h.level === 1 && 'font-medium',
                    h.level === 2 && 'pl-6',
                    h.level === 3 && 'pl-9 text-[13px]',
                    activeId === h.id
                      ? 'bg-brand-50 text-brand-700 dark:bg-brand-950 dark:text-brand-300'
                      : 'text-stone-600 hover:bg-stone-50 dark:text-stone-300 dark:hover:bg-stone-700',
                  )}
                >
                  {h.text}
                </button>
              </li>
            ))}
          </ul>
        </div>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Note section with collapsible content
// ---------------------------------------------------------------------------

function NoteSection({
  note,
  headings,
  headingIds,
  defaultOpen,
}: {
  note: CourseNote;
  headings: Heading[];
  headingIds: Map<string, string>;
  defaultOpen?: boolean;
}) {
  const [open, setOpen] = useState(defaultOpen ?? true);

  return (
    <div className="group/section">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className="flex w-full items-center gap-3 rounded-xl border border-stone-200 bg-white px-5 py-4 text-left shadow-sm transition-all duration-200 hover:shadow-md hover:border-stone-300 dark:border-stone-700 dark:bg-stone-800 dark:hover:border-stone-600"
      >
        <div
          className={cn(
            'flex size-8 shrink-0 items-center justify-center rounded-lg transition-colors duration-200',
            open
              ? 'bg-brand-100 text-brand-700 dark:bg-brand-900/50 dark:text-brand-300'
              : 'bg-stone-100 text-stone-500 dark:bg-stone-700 dark:text-stone-400',
          )}
        >
          <ChevronRight
            className={cn(
              'size-4 transition-transform duration-300',
              open && 'rotate-90',
            )}
          />
        </div>
        <div className="min-w-0 flex-1">
          <h2 className="font-serif text-lg font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {note.title}
          </h2>
          <p className="mt-0.5 text-xs text-stone-400 dark:text-stone-500">
            {headings.length} section{headings.length === 1 ? '' : 's'}
          </p>
        </div>
      </button>

      <div
        className={cn(
          'grid transition-all duration-500 ease-[cubic-bezier(0.4,0,0.2,1)]',
          open ? 'grid-rows-[1fr] opacity-100' : 'grid-rows-[0fr] opacity-0',
        )}
      >
        <div className="overflow-hidden">
          <div className="rounded-2xl border border-stone-200 bg-stone-50 p-6 sm:p-8 dark:border-stone-700 dark:bg-stone-900">
            <NoteContent content={note.content} headingIds={headingIds} />
          </div>
        </div>
      </div>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Back to top button
// ---------------------------------------------------------------------------

function BackToTop() {
  const [show, setShow] = useState(false);

  useEffect(() => {
    const handler = () => setShow(window.scrollY > 400);
    window.addEventListener('scroll', handler, { passive: true });
    return () => window.removeEventListener('scroll', handler);
  }, []);

  if (!show) return null;

  return (
    <button
      type="button"
      onClick={() => window.scrollTo({ top: 0, behavior: 'smooth' })}
      className="fixed bottom-24 right-6 z-40 flex size-10 items-center justify-center rounded-full bg-white text-stone-600 shadow-lg transition-all duration-200 hover:scale-110 hover:shadow-xl dark:bg-stone-800 dark:text-stone-300 xl:bottom-8"
      aria-label="Back to top"
    >
      <ArrowUp className="size-5" />
    </button>
  );
}

// ---------------------------------------------------------------------------
// Main exported component
// ---------------------------------------------------------------------------

interface CourseNotesViewProps {
  notes: CourseNote[];
}

export function CourseNotesView({ notes }: CourseNotesViewProps) {
  const containerRef = useRef<HTMLDivElement>(null);
  const [activeId, setActiveId] = useState<string | null>(null);

  const allHeadings = useMemo(() => {
    const combined: Heading[] = [];
    for (const note of notes) {
      combined.push(...extractHeadings(note.content));
    }
    return combined;
  }, [notes]);

  const headingIds = useMemo(() => buildHeadingIdMap(allHeadings), [allHeadings]);

  useEffect(() => {
    const headingEls = allHeadings
      .map((h) => document.getElementById(h.id))
      .filter(Boolean) as HTMLElement[];

    if (headingEls.length === 0) return;

    const observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (entry.isIntersecting) {
            setActiveId(entry.target.id);
          }
        }
      },
      { rootMargin: '-80px 0px -60% 0px', threshold: 0 },
    );

    for (const el of headingEls) observer.observe(el);
    return () => observer.disconnect();
  }, [allHeadings]);

  const scrollTo = (id: string) => {
    const el = document.getElementById(id);
    if (el) {
      el.scrollIntoView({ behavior: 'smooth', block: 'start' });
      setActiveId(id);
    }
  };

  if (notes.length === 0) return null;

  return (
    <div ref={containerRef} className="relative rounded-2xl border border-stone-200 bg-white p-6 shadow-sm dark:border-stone-700 dark:bg-stone-800 sm:p-8">
      <ReadingProgress target={containerRef} />
      <BackToTop />

      <MobileTOC
        headings={allHeadings}
        activeId={activeId}
        onNavigate={scrollTo}
      />

      <div className="mt-6 gap-8 xl:mt-0 xl:grid xl:grid-cols-[1fr_220px]">
        <div className="space-y-6">
          {notes.map((note) => {
            const noteHeadings = extractHeadings(note.content);
            return (
              <NoteSection
                key={note.id}
                note={note}
                headings={noteHeadings}
                headingIds={headingIds}
                defaultOpen={true}
              />
            );
          })}
        </div>

        <TableOfContents
          headings={allHeadings}
          activeId={activeId}
          onNavigate={scrollTo}
        />
      </div>
    </div>
  );
}
