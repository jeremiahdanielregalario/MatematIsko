import { useEffect, useRef, useState } from 'react';
import { ArrowUp, BookOpen, Clock } from 'lucide-react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { cn } from '@/lib/cn';
import type { CourseNote, TheoremWithMeta } from '@/types';

interface Heading {
  id: string;
  text: string;
  level: number;
}

function NoteArticle({ note, theorems }: { note: CourseNote; theorems: TheoremWithMeta[] }) {
  const contentRef = useRef<HTMLDivElement>(null);
  const contentsRef = useRef<HTMLDetailsElement>(null);
  const [headings, setHeadings] = useState<Heading[]>([]);
  const [activeId, setActiveId] = useState('');
  const [progress, setProgress] = useState(0);
  const [largeText, setLargeText] = useState(false);
  const minutes = Math.max(1, Math.ceil(note.content.trim().split(/\s+/).length / 180));

  useEffect(() => {
    const content = contentRef.current;
    if (!content) return;
    const elements = Array.from(content.querySelectorAll<HTMLElement>('h1, h2, h3'));
    const sections = elements.map((heading, index) => {
      heading.id = `note-${note.id}-section-${index + 1}`;
      heading.tabIndex = -1;
      // Use one copy of each formula in the navigation label, not both KaTeX outputs.
      const label = heading.cloneNode(true) as HTMLElement;
      label.querySelectorAll('.katex-html, annotation').forEach((node) => node.remove());
      return {
        id: heading.id,
        text: label.textContent?.trim() || `Section ${index + 1}`,
        level: Number(heading.tagName[1]),
      };
    });
    setHeadings(sections);
    let frame = 0;
    const update = () => {
      const top = content.getBoundingClientRect().top;
      const travel = content.offsetHeight - window.innerHeight + 160;
      setProgress(
        travel <= 0
          ? top < window.innerHeight
            ? 100
            : 0
          : Math.round(Math.min(100, Math.max(0, ((160 - top) / travel) * 100))),
      );
      const current = elements
        .filter((heading) => heading.getBoundingClientRect().top <= 224)
        .at(-1);
      setActiveId(current?.id ?? elements[0]?.id ?? '');
    };
    const schedule = () => {
      cancelAnimationFrame(frame);
      frame = requestAnimationFrame(update);
    };
    update();
    window.addEventListener('scroll', schedule, { passive: true });
    window.addEventListener('resize', schedule);
    const observer = typeof ResizeObserver !== 'undefined' ? new ResizeObserver(schedule) : null;
    observer?.observe(content);
    return () => {
      cancelAnimationFrame(frame);
      window.removeEventListener('scroll', schedule);
      window.removeEventListener('resize', schedule);
      observer?.disconnect();
    };
  }, [note.id, note.content]);

  const navigateTo = (id: string) => {
    if (contentsRef.current) contentsRef.current.open = false;
    const target = document.getElementById(id);
    target?.focus({ preventScroll: true });
    target?.scrollIntoView({ block: 'start' });
    setActiveId(id);
  };

  const contents = (
    <ul className="space-y-1">
      {headings.map((heading) => (
        <li key={heading.id}>
          <button
            type="button"
            onClick={() => navigateTo(heading.id)}
            aria-current={activeId === heading.id ? 'location' : undefined}
            className={cn(
              'w-full rounded-lg px-3 py-2 text-left text-sm leading-relaxed break-words transition-colors',
              heading.level === 2 && 'pl-5',
              heading.level === 3 && 'pl-7',
              activeId === heading.id
                ? 'bg-brand-50 font-medium text-brand-900 dark:bg-brand-950 dark:text-brand-200'
                : 'text-stone-600 hover:bg-stone-100 dark:text-stone-400 dark:hover:bg-stone-800',
            )}
          >
            {heading.text}
          </button>
        </li>
      ))}
    </ul>
  );

  return (
    <div className="mx-auto grid max-w-3xl items-start gap-8 xl:max-w-6xl xl:grid-cols-[minmax(0,1fr)_15rem]">
      <article className="min-w-0 rounded-2xl border border-stone-200 bg-white shadow-sm dark:border-stone-800 dark:bg-stone-900">
        <header className="space-y-4 border-b border-stone-200 px-4 py-6 dark:border-stone-800 sm:px-8 sm:py-9">
          <p className="flex items-center gap-2 text-xs font-semibold uppercase tracking-widest text-brand-800 dark:text-brand-300">
            <BookOpen className="size-4" /> Course notes
          </p>
          <h1 className="font-serif text-3xl font-bold leading-tight tracking-tight text-stone-900 dark:text-stone-50 sm:text-4xl">
            <MathRenderer inline>{note.title}</MathRenderer>
          </h1>
          <p className="flex items-center gap-2 text-sm text-stone-500 dark:text-stone-400">
            <Clock className="size-4" /> About {minutes} min read · Take your time with the math
          </p>
        </header>

        <div className="sticky top-16 z-20 border-b border-stone-200 bg-white/95 px-4 py-3 backdrop-blur dark:border-stone-800 dark:bg-stone-900/95 sm:px-8">
          <div className="flex flex-wrap items-center justify-between gap-2">
            <span className="text-xs tabular-nums text-stone-500 dark:text-stone-400">
              {progress}% through this note
            </span>
            <div role="group" aria-label="Reading text size" className="flex gap-1">
              <button
                type="button"
                aria-pressed={!largeText}
                onClick={() => setLargeText(false)}
                className={cn(
                  'min-h-10 rounded-lg px-3 text-sm',
                  !largeText && 'bg-stone-100 dark:bg-stone-800',
                )}
              >
                Standard
              </button>
              <button
                type="button"
                aria-pressed={largeText}
                onClick={() => setLargeText(true)}
                className={cn(
                  'min-h-10 rounded-lg px-3 text-sm',
                  largeText && 'bg-stone-100 dark:bg-stone-800',
                )}
              >
                Larger text
              </button>
            </div>
          </div>
          <div
            role="progressbar"
            aria-label="Reading position"
            aria-valuemin={0}
            aria-valuemax={100}
            aria-valuenow={progress}
            className="mt-2 h-1 overflow-hidden rounded-full bg-stone-100 dark:bg-stone-800"
          >
            <div
              className="h-full bg-brand-700 dark:bg-brand-400"
              style={{ width: `${progress}%` }}
            />
          </div>
          {headings.length > 0 && (
            <details ref={contentsRef} className="mt-3 xl:hidden">
              <summary className="cursor-pointer py-2 text-sm font-medium text-stone-700 dark:text-stone-200">
                On this page · {headings.length} sections
              </summary>
              <nav aria-label="Note sections" className="max-h-[40dvh] overflow-y-auto pt-2">
                {contents}
              </nav>
            </details>
          )}
        </div>

        <div
          ref={contentRef}
          className={cn(
            'note-reading px-4 py-6 sm:px-8 sm:py-8',
            largeText && 'note-reading-large',
          )}
        >
          <MathRenderer
            noteEnvironments={{
              theorems: theorems.filter((theorem) => theorem.course_id === note.course_id),
            }}
          >
            {note.content}
          </MathRenderer>
        </div>
        <footer className="border-t border-stone-200 px-4 py-5 dark:border-stone-800 sm:px-8">
          <button
            type="button"
            onClick={() => {
              contentRef.current?.closest('article')?.scrollIntoView({ block: 'start' });
            }}
            className="inline-flex min-h-11 items-center gap-2 text-sm font-medium text-brand-800 dark:text-brand-300"
          >
            <ArrowUp className="size-4" /> Back to beginning
          </button>
        </footer>
      </article>
      {headings.length > 0 && (
        <aside className="sticky top-24 hidden min-w-0 xl:block">
          <h2 className="mb-3 px-3 text-xs font-semibold uppercase tracking-widest text-stone-500">
            On this page
          </h2>
          <nav aria-label="Note sections" className="max-h-[calc(100dvh-8rem)] overflow-y-auto">
            {contents}
          </nav>
        </aside>
      )}
    </div>
  );
}

export function CourseNotesView({
  notes,
  theorems = [],
}: {
  notes: CourseNote[];
  theorems?: TheoremWithMeta[];
}) {
  return (
    <div className="space-y-10">
      {notes.map((note) => (
        <NoteArticle key={note.id} note={note} theorems={theorems} />
      ))}
    </div>
  );
}
