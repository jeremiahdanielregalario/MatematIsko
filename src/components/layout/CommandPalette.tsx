import {
  BookMarked,
  Bookmark,
  BookOpenText,
  Clock3,
  FilePlus2,
  GraduationCap,
  HelpCircle,
  LayoutDashboard,
  Search,
  Target,
} from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { MathRenderer } from '@/components/math/MathRenderer';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogTitle,
} from '@/components/ui/dialog';
import { Input } from '@/components/ui/input';
import { useAuth } from '@/hooks/useAuth';
import { useCourseScope } from '@/hooks/useCourseScope';
import { cn } from '@/lib/cn';
import { getCourses, getQuestionsWithRelations, getTheorems } from '@/lib/db';
import type { Course, QuestionWithRelations, TheoremWithRelations } from '@/types';

interface PaletteItem {
  id: string;
  group: 'Quick actions' | 'Courses' | 'Problems' | 'Theorems';
  title: string;
  subtitle?: string;
  mathTitle?: boolean;
  to: string;
  icon: typeof Search;
}

const QUICK_ACTIONS: PaletteItem[] = [
  {
    id: 'nav-dashboard',
    group: 'Quick actions',
    title: 'Dashboard & review queue',
    subtitle: 'Your study desk and topic progress',
    to: '/dashboard',
    icon: LayoutDashboard,
  },
  {
    id: 'nav-practice',
    group: 'Quick actions',
    title: 'Guided practice session',
    subtitle: 'Randomized practice with hints and solutions',
    to: '/practice',
    icon: Target,
  },
  {
    id: 'nav-exam',
    group: 'Quick actions',
    title: 'Timed quiz & exam builder',
    subtitle: 'Full paper with timer and post-exam review',
    to: '/practice/exam',
    icon: Clock3,
  },
  {
    id: 'nav-flashcards',
    group: 'Quick actions',
    title: 'Theorem flashcards',
    subtitle: 'Recall theorem statements with active self-rating',
    to: '/theorems/flashcards',
    icon: GraduationCap,
  },
  {
    id: 'nav-bookmarks',
    group: 'Quick actions',
    title: 'Saved bookmarks',
    subtitle: 'Revisit problems you saved for later',
    to: '/bookmarks',
    icon: Bookmark,
  },
  {
    id: 'nav-contributions',
    group: 'Quick actions',
    title: 'Contribute a question or course note',
    subtitle: 'Submit study material for moderation',
    to: '/contributions',
    icon: FilePlus2,
  },
  {
    id: 'nav-blogs',
    group: 'Quick actions',
    title: 'Community math blogs',
    subtitle: 'Read student and faculty articles',
    to: '/blogs',
    icon: BookOpenText,
  },
];

export function CommandPalette() {
  const { user } = useAuth();
  const { courseIds } = useCourseScope();
  const navigate = useNavigate();

  const [open, setOpen] = useState(false);
  const [query, setQuery] = useState('');
  const [activeIndex, setActiveIndex] = useState(0);
  const [courses, setCourses] = useState<Course[]>([]);
  const [questions, setQuestions] = useState<QuestionWithRelations[]>([]);
  const [theorems, setTheorems] = useState<TheoremWithRelations[]>([]);
  const [loadingData, setLoadingData] = useState(false);

  const userId = user?.id ?? null;
  const scopeKey = courseIds === null ? '__all' : courseIds.join(',');

  useEffect(() => {
    if (!userId) return;
    const onKeyDown = (event: KeyboardEvent) => {
      if ((event.metaKey || event.ctrlKey) && event.key.toLowerCase() === 'k') {
        event.preventDefault();
        setOpen((prev) => !prev);
      }
    };
    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [userId]);

  useEffect(() => {
    if (!open || !userId) return;
    let active = true;
    setLoadingData(true);
    Promise.all([
      getCourses().catch(() => [] as Course[]),
      getQuestionsWithRelations(courseIds ?? undefined).catch(() => [] as QuestionWithRelations[]),
      getTheorems(courseIds ?? undefined).catch(() => [] as TheoremWithRelations[]),
    ])
      .then(([loadedCourses, loadedQuestions, loadedTheorems]) => {
        if (!active) return;
        const scopedCourses = loadedCourses.filter(
          (c) => courseIds === null || courseIds.includes(c.id),
        );
        setCourses(scopedCourses);
        setQuestions(loadedQuestions);
        setTheorems(loadedTheorems);
      })
      .finally(() => {
        if (active) setLoadingData(false);
      });
    return () => {
      active = false;
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, userId, scopeKey]);

  const items = useMemo<PaletteItem[]>(() => {
    const q = query.trim().toLowerCase();
    const matches = (fields: (string | number | null | undefined)[]) => {
      if (!q) return true;
      return fields
        .filter((f) => f !== null && f !== undefined)
        .join(' ')
        .toLowerCase()
        .includes(q);
    };

    const actionItems = QUICK_ACTIONS.filter((item) =>
      matches([item.title, item.subtitle, item.group]),
    );

    const courseItems: PaletteItem[] = courses
      .filter((c) => matches([c.code, c.name, c.description]))
      .slice(0, q ? 6 : 4)
      .map((c) => ({
        id: `course-${c.id}`,
        group: 'Courses',
        title: `${c.code} — ${c.name}`,
        subtitle: 'Open course hub, notes, and topics',
        to: `/courses/${c.id}`,
        icon: GraduationCap,
      }));

    const questionItems: PaletteItem[] = (q ? questions : questions.slice(0, 4))
      .filter((item) =>
        matches([
          item.title,
          item.question_text,
          item.course?.code,
          item.topic?.name,
          item.exam_name,
          item.year,
        ]),
      )
      .slice(0, 8)
      .map((item) => ({
        id: `question-${item.id}`,
        group: 'Problems',
        title: item.title,
        subtitle: [item.course?.code, item.topic?.name, `${item.exam_name} ${item.year}`]
          .filter(Boolean)
          .join(' · '),
        mathTitle: true,
        to: `/questions/${item.id}?course=${item.course_id}&topic=${item.topic_id}`,
        icon: HelpCircle,
      }));

    const theoremItems: PaletteItem[] = (q ? theorems : theorems.slice(0, 3))
      .filter((item) =>
        matches([item.name, item.reference, item.statement, item.course?.code, item.topic?.name]),
      )
      .slice(0, 6)
      .map((item) => ({
        id: `theorem-${item.id}`,
        group: 'Theorems',
        title: item.name,
        subtitle: [item.course?.code, item.topic?.name, item.reference].filter(Boolean).join(' · '),
        mathTitle: true,
        to: `/theorems/${item.id}`,
        icon: BookMarked,
      }));

    return [...actionItems, ...courseItems, ...questionItems, ...theoremItems];
  }, [query, courses, questions, theorems]);

  useEffect(() => {
    setActiveIndex(0);
  }, [query, open]);

  if (!user) return null;

  const selectItem = (item: PaletteItem) => {
    setOpen(false);
    setQuery('');
    navigate(item.to);
  };

  return (
    <>
      <button
        type="button"
        onClick={() => setOpen(true)}
        aria-label="Quick search"
        className="inline-flex h-9 items-center gap-2 rounded-lg border border-stone-200 bg-stone-50 px-2.5 text-xs font-medium text-stone-600 transition-colors hover:bg-stone-100 hover:text-stone-900 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600 dark:border-stone-800 dark:bg-stone-900 dark:text-stone-300 dark:hover:bg-stone-800 dark:hover:text-stone-100"
      >
        <Search className="size-3.5" />
        <span className="hidden sm:inline">Quick find</span>
        <kbd className="hidden rounded border border-stone-300 bg-white px-1.5 py-0.5 font-mono text-[10px] text-stone-500 sm:inline dark:border-stone-700 dark:bg-stone-950 dark:text-stone-400">
          ⌘K
        </kbd>
      </button>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="max-w-xl p-0">
          <div className="border-b border-stone-200 p-4 pr-12 dark:border-stone-800">
            <DialogTitle className="text-sm font-semibold text-stone-900 dark:text-stone-100">
              Quick study finder
            </DialogTitle>
            <DialogDescription className="text-xs text-stone-500 dark:text-stone-400">
              Jump to any course, problem, theorem, or study mode.
            </DialogDescription>
            <div className="relative mt-3">
              <Search className="pointer-events-none absolute left-3 top-1/2 size-4 -translate-y-1/2 text-stone-400" />
              <Input
                aria-label="Search courses, problems, theorems, and study tools"
                placeholder="Type a course code, theorem, topic, exam, or action…"
                value={query}
                onChange={(e) => setQuery(e.target.value)}
                onKeyDown={(e) => {
                  if (e.key === 'ArrowDown') {
                    e.preventDefault();
                    setActiveIndex((i) => (items.length ? (i + 1) % items.length : 0));
                  } else if (e.key === 'ArrowUp') {
                    e.preventDefault();
                    setActiveIndex((i) =>
                      items.length ? (i - 1 + items.length) % items.length : 0,
                    );
                  } else if (e.key === 'Enter' && items[activeIndex]) {
                    e.preventDefault();
                    selectItem(items[activeIndex]);
                  }
                }}
                className="pl-9"
              />
            </div>
          </div>

          <div
            role="listbox"
            aria-label="Search results"
            className="max-h-96 overflow-y-auto p-2"
          >
            {loadingData && items.length <= QUICK_ACTIONS.length && (
              <p className="px-3 py-2 text-xs text-stone-400">Loading study bank…</p>
            )}
            {items.length === 0 ? (
              <p className="px-3 py-8 text-center text-sm text-stone-500 dark:text-stone-400">
                No matching courses, problems, or theorems found.
              </p>
            ) : (
              items.map((item, idx) => {
                const Icon = item.icon;
                const active = idx === activeIndex;
                const showGroupHeader = idx === 0 || items[idx - 1].group !== item.group;
                return (
                  <div key={item.id}>
                    {showGroupHeader && (
                      <p className="px-3 pb-1 pt-2.5 text-[11px] font-semibold uppercase tracking-wider text-stone-400 dark:text-stone-500">
                        {item.group}
                      </p>
                    )}
                    <button
                      type="button"
                      role="option"
                      aria-selected={active}
                      onMouseEnter={() => setActiveIndex(idx)}
                      onClick={() => selectItem(item)}
                      className={cn(
                        'flex w-full items-start gap-3 rounded-lg px-3 py-2 text-left text-sm transition-colors',
                        active
                          ? 'bg-brand-50 text-brand-950 dark:bg-brand-950/60 dark:text-brand-100'
                          : 'text-stone-700 hover:bg-stone-100 dark:text-stone-200 dark:hover:bg-stone-800',
                      )}
                    >
                      <Icon className="mt-0.5 size-4 shrink-0 text-brand-800 dark:text-brand-300" />
                      <div className="min-w-0 flex-1">
                        <div className="truncate font-medium">
                          {item.mathTitle ? (
                            <MathRenderer inline>{item.title}</MathRenderer>
                          ) : (
                            item.title
                          )}
                        </div>
                        {item.subtitle && (
                          <p className="truncate text-xs text-stone-500 dark:text-stone-400">
                            {item.subtitle}
                          </p>
                        )}
                      </div>
                    </button>
                  </div>
                );
              })
            )}
          </div>
        </DialogContent>
      </Dialog>
    </>
  );
}
