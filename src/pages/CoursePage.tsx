import { ArrowLeft, ArrowRight, BookMarked, BookOpenText, FileText, SearchX } from 'lucide-react';
import { useMemo, useState } from 'react';
import { Link, Navigate, useNavigate, useSearchParams, useParams } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { ProgressBar } from '@/components/common/ProgressBar';
import { QuestionCard } from '@/components/questions/QuestionCard';
import { SearchBar } from '@/components/questions/SearchBar';
import { TheoremCard } from '@/components/theorems/TheoremCard';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { useCourses } from '@/hooks/useCourses';
import { useCourseNotes } from '@/hooks/useCourseNotes';
import { useCourseScope } from '@/hooks/useCourseScope';
import { useDebounce } from '@/hooks/useDebounce';
import { useQuestionMutations, type QuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { useTheoremMutations } from '@/hooks/useTheoremMutations';
import { useTheorems } from '@/hooks/useTheorems';
import { cn } from '@/lib/cn';
import { mergeMutations, mergeTheoremMutations } from '@/lib/mutations';
import { applyFilterAndSort, pickRandom } from '@/lib/questionFilter';
import type { Difficulty, QuestionFilter, QuestionWithMeta, TopicWithStats } from '@/types';

type CourseTab = 'questions' | 'notes' | 'theorems';

const PAGE_SIZE = 9;

export function CoursePage() {
  const { courseId } = useParams<{ courseId: string }>();
  const [searchParams, setSearchParams] = useSearchParams();
  const { data: coursesData } = useCourses();
  const { courseIds } = useCourseScope();
  const courses = coursesData ?? [];
  const { data: loaded, loading, error, reload } = useQuestions();
  const mutations = useQuestionMutations((id) => loaded?.find((q) => q.id === id));

  const tabParam = searchParams.get('tab');
  const activeTab: CourseTab =
    tabParam === 'notes' || tabParam === 'theorems' ? tabParam : 'questions';
  const setActiveTab = (tab: CourseTab) => setSearchParams(tab === 'questions' ? {} : { tab });

  const questions = useMemo(
    () => (loaded ?? []).map((q) => mergeMutations(q, mutations)),
    [loaded, mutations],
  );

  if (loading) return <LoadingState label="Loading course" />;

  const course =
    courses.find((c) => c.id === courseId) ??
    questions.find((q) => q.course_id === courseId)?.course;

  if (courseIds !== null && courseId && !courseIds.includes(courseId)) {
    return <Navigate to="/dashboard" replace />;
  }

  if (error) {
    return (
      <ErrorState
        title="Could not load this course"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  if (!course) {
    return (
      <EmptyState
        icon={<BookOpenText className="size-8" />}
        title="Course not found"
        description="This course does not exist or you do not have access."
        action={
          <Button asChild>
            <Link to="/courses">Back to courses</Link>
          </Button>
        }
      />
    );
  }

  return (
    <div className="space-y-6">
      <header className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <Link
            to="/courses"
            className="mb-1 inline-flex items-center gap-1 text-sm text-stone-500 transition-colors hover:text-stone-800 dark:text-stone-400 dark:hover:text-stone-200"
          >
            <ArrowLeft className="size-3.5" />
            All courses
          </Link>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {course.code}
          </h1>
          {course.name && (
            <p className="text-stone-500 dark:text-stone-400">{course.name}</p>
          )}
        </div>
        <div className="flex flex-wrap gap-2">
          <Button variant="outline" asChild>
            <Link to={`/contributions?courseId=${courseId}`}>Contribute to this course</Link>
          </Button>
          <Button variant="outline" asChild>
            <Link to={`/practice?courseId=${courseId}`}>
              Practice this course
              <ArrowRight className="size-4" />
            </Link>
          </Button>
        </div>
      </header>

      {/* Tab bar */}
      <div className="flex flex-wrap items-center gap-1 rounded-lg border border-stone-200 bg-stone-50 p-1 dark:border-stone-800 dark:bg-stone-900">
        <TabButton
          active={activeTab === 'questions'}
          onClick={() => setActiveTab('questions')}
        >
          <BookOpenText className="size-4" />
          Questions
        </TabButton>
        <TabButton
          active={activeTab === 'notes'}
          onClick={() => setActiveTab('notes')}
        >
          <FileText className="size-4" />
          Notes
        </TabButton>
        <TabButton
          active={activeTab === 'theorems'}
          onClick={() => setActiveTab('theorems')}
        >
          <BookMarked className="size-4" />
          Theorems
        </TabButton>
      </div>

      {activeTab === 'questions' ? (
        <QuestionsTab courseId={courseId} questions={questions} mutations={mutations} />
      ) : activeTab === 'notes' ? (
        <NotesTab courseId={courseId} />
      ) : (
        <TheoremsTab courseId={courseId} />
      )}
    </div>
  );
}

function TabButton({
  active,
  onClick,
  children,
}: {
  active: boolean;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        'inline-flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors',
        active
          ? 'bg-white text-stone-900 shadow-sm dark:bg-stone-800 dark:text-stone-50'
          : 'text-stone-500 hover:text-stone-700 dark:text-stone-400 dark:hover:text-stone-200',
      )}
    >
      {children}
    </button>
  );
}

// ---------------------------------------------------------------------------
// Questions tab
// ---------------------------------------------------------------------------

function QuestionsTab({
  courseId,
  questions,
  mutations,
}: {
  courseId: string | undefined;
  questions: QuestionWithMeta[];
  mutations: QuestionMutations;
}) {
  const navigate = useNavigate();
  const [searchInput, setSearchInput] = useState('');
  const search = useDebounce(searchInput, 200);
  const [selectedTopicId, setSelectedTopicId] = useState<string>('');
  const [difficulty, setDifficulty] = useState<Difficulty | ''>('');
  const [statusFilter, setStatusFilter] = useState<QuestionFilter['status'] | ''>('');
  const [sort, setSort] = useState<NonNullable<QuestionFilter['sort']>>('newest');
  const [page, setPage] = useState(1);

  const courseQuestions = useMemo(
    () => questions.filter((q) => q.course_id === courseId),
    [questions, courseId],
  );

  const topics = useMemo(() => {
    const byTopic = new Map<string, TopicWithStats>();
    for (const q of courseQuestions) {
      const topic = q.topic;
      if (!topic) continue;
      const isMastered = q.progress?.status === 'mastered';
      const existing = byTopic.get(topic.id);
      if (existing) {
        existing.question_count += 1;
        if (isMastered) existing.mastered_count += 1;
        existing.mastery_percent = Math.round(
          (existing.mastered_count / existing.question_count) * 100,
        );
      } else {
        byTopic.set(topic.id, {
          id: topic.id,
          course_id: courseId!,
          name: topic.name,
          question_count: 1,
          mastered_count: isMastered ? 1 : 0,
          mastery_percent: isMastered ? 100 : 0,
        });
      }
    }
    return [...byTopic.values()].sort((a, b) => a.name.localeCompare(b.name));
  }, [courseQuestions, courseId]);

  const hasTopics = topics.length > 0;

  const filteredQuestions = useMemo(() => {
    return applyFilterAndSort(courseQuestions, {
      search,
      topicId: selectedTopicId || undefined,
      difficulty: difficulty || undefined,
      status: statusFilter || undefined,
      sort,
    });
  }, [courseQuestions, search, selectedTopicId, difficulty, statusFilter, sort]);

  const totalPages = Math.max(1, Math.ceil(filteredQuestions.length / PAGE_SIZE));
  const currentPage = Math.min(page, totalPages);
  const pagedQuestions = filteredQuestions.slice(
    (currentPage - 1) * PAGE_SIZE,
    currentPage * PAGE_SIZE,
  );

  const startRandom = () => {
    const pick = pickRandom(courseQuestions);
    if (pick) navigate(`/questions/${pick.id}`);
  };

  const startTopic = (topicId: string) => {
    const pool = courseQuestions.filter((q) => q.topic?.id === topicId);
    const pick = pickRandom(pool);
    if (pick) {
      navigate(`/questions/${pick.id}?course=${courseId}&topic=${topicId}`);
    }
  };

  return (
    <div className="space-y-8">
      <div className="space-y-4">
        <div className="flex flex-wrap items-center justify-between gap-3">
          <h2 className="font-serif text-2xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Topics
          </h2>
          <Button variant="outline" onClick={startRandom} disabled={!hasTopics}>
            Random problem
          </Button>
        </div>

        {!hasTopics ? (
          <EmptyState
            icon={<BookOpenText className="size-8" />}
            title="No topics yet"
            description="No questions have been added to this course yet."
          />
        ) : (
          <ul className="space-y-3">
            {topics.map((topic) => (
              <li key={topic.id}>
                <button
                  type="button"
                  onClick={() => startTopic(topic.id)}
                  className="group block w-full text-left"
                >
                  <Card className="transition-colors group-hover:border-brand-300 group-hover:bg-brand-50/40 dark:group-hover:border-brand-700 dark:group-hover:bg-brand-950/40">
                    <CardContent className="space-y-2.5 px-5 py-4">
                      <div className="flex items-center justify-between gap-4">
                        <div className="min-w-0">
                          <h3 className="truncate font-semibold text-stone-800 group-hover:text-brand-700 dark:text-stone-100 dark:group-hover:text-brand-300">
                            {topic.name}
                          </h3>
                          <p className="mt-0.5 text-xs text-stone-500 dark:text-stone-400">
                            {topic.mastered_count} / {topic.question_count} mastered (
                            {topic.mastery_percent}%)
                          </p>
                        </div>
                        <ArrowRight className="size-4 shrink-0 text-stone-400 transition-transform group-hover:translate-x-1 group-hover:text-brand-600 dark:text-stone-500 dark:group-hover:text-brand-400" />
                      </div>
                      <ProgressBar
                        value={topic.mastery_percent}
                        label={`${topic.name} mastery`}
                      />
                    </CardContent>
                  </Card>
                </button>
              </li>
            ))}
          </ul>
        )}
      </div>

      {hasTopics && (
        <section aria-label="Course question bank" className="space-y-4 border-t border-stone-200 pt-6 dark:border-stone-800">
          <div className="flex flex-wrap items-end justify-between gap-3">
            <div>
              <h2 className="font-serif text-2xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
                Browse course problems
              </h2>
              <p className="mt-1 text-sm text-stone-500 dark:text-stone-400">
                {filteredQuestions.length} of {courseQuestions.length} problem
                {courseQuestions.length === 1 ? '' : 's'} shown
              </p>
            </div>
          </div>

          <SearchBar
            value={searchInput}
            onChange={(val) => {
              setSearchInput(val);
              setPage(1);
            }}
            placeholder="Search by title, prompt, topic, or exam…"
          />

          <div className="grid gap-3 sm:grid-cols-2 lg:grid-cols-4">
            <label className="text-xs font-medium text-stone-600 dark:text-stone-300">
              Topic filter
              <select
                value={selectedTopicId}
                onChange={(e) => {
                  setSelectedTopicId(e.target.value);
                  setPage(1);
                }}
                className="mt-1 block w-full rounded-lg border border-stone-300 bg-white px-3 py-2 text-sm text-stone-900 dark:border-stone-700 dark:bg-stone-900 dark:text-stone-100"
              >
                <option value="">All topics</option>
                {topics.map((t) => (
                  <option key={t.id} value={t.id}>
                    {t.name}
                  </option>
                ))}
              </select>
            </label>

            <label className="text-xs font-medium text-stone-600 dark:text-stone-300">
              Difficulty
              <select
                value={difficulty}
                onChange={(e) => {
                  setDifficulty(e.target.value as Difficulty | '');
                  setPage(1);
                }}
                className="mt-1 block w-full rounded-lg border border-stone-300 bg-white px-3 py-2 text-sm text-stone-900 dark:border-stone-700 dark:bg-stone-900 dark:text-stone-100"
              >
                <option value="">Any difficulty</option>
                <option value="easy">Easy</option>
                <option value="medium">Medium</option>
                <option value="hard">Hard</option>
              </select>
            </label>

            <label className="text-xs font-medium text-stone-600 dark:text-stone-300">
              Mastery status
              <select
                value={statusFilter}
                onChange={(e) => {
                  setStatusFilter(e.target.value as QuestionFilter['status'] | '');
                  setPage(1);
                }}
                className="mt-1 block w-full rounded-lg border border-stone-300 bg-white px-3 py-2 text-sm text-stone-900 dark:border-stone-700 dark:bg-stone-900 dark:text-stone-100"
              >
                <option value="">All statuses</option>
                <option value="unseen">Unseen</option>
                <option value="learning">Needs review</option>
                <option value="mastered">Mastered</option>
                <option value="bookmarked">Saved / bookmarked</option>
              </select>
            </label>

            <label className="text-xs font-medium text-stone-600 dark:text-stone-300">
              Sort by
              <select
                value={sort}
                onChange={(e) => {
                  setSort(e.target.value as NonNullable<QuestionFilter['sort']>);
                  setPage(1);
                }}
                className="mt-1 block w-full rounded-lg border border-stone-300 bg-white px-3 py-2 text-sm text-stone-900 dark:border-stone-700 dark:bg-stone-900 dark:text-stone-100"
              >
                <option value="newest">Newest first</option>
                <option value="oldest">Oldest first</option>
                <option value="difficulty">Difficulty (Easy → Hard)</option>
                <option value="recent">Recently attempted</option>
              </select>
            </label>
          </div>

          {pagedQuestions.length > 0 ? (
            <>
              <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                {pagedQuestions.map((question) => (
                  <QuestionCard
                    key={question.id}
                    question={question}
                    to={`/questions/${question.id}?course=${courseId}&topic=${question.topic_id}`}
                    onToggleBookmark={mutations.toggleBookmark}
                    onSetStatus={mutations.setStatus}
                  />
                ))}
              </div>
              {totalPages > 1 && (
                <nav
                  aria-label="Course questions pagination"
                  className="flex items-center justify-between gap-3 pt-2"
                >
                  <Button
                    variant="outline"
                    size="sm"
                    disabled={currentPage <= 1}
                    onClick={() => setPage((p) => Math.max(1, p - 1))}
                  >
                    Previous
                  </Button>
                  <span className="text-sm text-stone-500">
                    Page {currentPage} of {totalPages}
                  </span>
                  <Button
                    variant="outline"
                    size="sm"
                    disabled={currentPage >= totalPages}
                    onClick={() => setPage((p) => Math.min(totalPages, p + 1))}
                  >
                    Next
                  </Button>
                </nav>
              )}
            </>
          ) : (
            <EmptyState
              icon={<SearchX className="size-8" />}
              title="No matching problems"
              description="Try clearing your search or adjusting the topic, difficulty, or status filters."
              action={
                <Button
                  variant="outline"
                  size="sm"
                  onClick={() => {
                    setSearchInput('');
                    setSelectedTopicId('');
                    setDifficulty('');
                    setStatusFilter('');
                    setPage(1);
                  }}
                >
                  Reset filters
                </Button>
              }
            />
          )}
        </section>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Notes tab
// ---------------------------------------------------------------------------

function NotesTab({ courseId }: { courseId: string | undefined }) {
  const { data: notes, loading, error, reload } = useCourseNotes(courseId);

  if (loading) return <LoadingState label="Loading notes" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load notes"
        message={error}
        onRetry={reload}
      />
    );
  }

  if (!notes || notes.length === 0) {
    return (
      <EmptyState
        icon={<FileText className="size-8" />}
        title="No notes yet"
        description="Course notes will appear here once they are added."
      />
    );
  }

  return (
    <div className="grid gap-4 sm:grid-cols-2">
      {notes.map((note) => (
        <Link
          key={note.id}
          to={`/courses/${courseId}/notes/${note.id}`}
          className="group block"
        >
          <Card className="transition-all duration-200 hover:-translate-y-1 hover:shadow-md group-hover:border-brand-300 dark:group-hover:border-brand-700">
            <CardContent className="p-5">
              <div className="mb-3 flex size-10 items-center justify-center rounded-xl bg-brand-50 text-brand-700 transition-colors group-hover:bg-brand-100 dark:bg-brand-900/30 dark:text-brand-300 dark:group-hover:bg-brand-900/50">
                <FileText className="size-5" />
              </div>
              <h3 className="font-serif text-lg font-bold leading-snug text-stone-900 group-hover:text-brand-700 dark:text-stone-50 dark:group-hover:text-brand-300">
                {note.title}
              </h3>
              <p className="mt-2 line-clamp-2 text-sm text-stone-500 dark:text-stone-400">
                {note.content.replace(/[#*$`\\]/g, '').slice(0, 120)}...
              </p>
            </CardContent>
          </Card>
        </Link>
      ))}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Theorems tab
// ---------------------------------------------------------------------------

function TheoremsTab({ courseId }: { courseId: string | undefined }) {
  const { data: loaded, loading, error, reload } = useTheorems();
  const { statuses, setStatus } = useTheoremMutations((id) => loaded?.find((t) => t.id === id));

  const courseTheorems = useMemo(
    () =>
      (loaded ?? [])
        .filter((t) => t.course_id === courseId)
        .map((t) => mergeTheoremMutations(t, statuses)),
    [loaded, courseId, statuses],
  );

  if (loading) return <LoadingState label="Loading theorems" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load theorems"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  if (courseTheorems.length === 0) {
    return (
      <EmptyState
        icon={<BookMarked className="size-8" />}
        title="No theorems yet"
        description="Named theorems for this course will appear here once they are added."
      />
    );
  }

  return (
    <div className="space-y-4">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <p className="text-sm text-stone-500 dark:text-stone-400">
          {courseTheorems.length} named theorem{courseTheorems.length === 1 ? '' : 's'} in this
          course
        </p>
        <Button variant="outline" size="sm" asChild>
          <Link to={`/theorems/flashcards?course=${courseId}`}>Practice course flashcards</Link>
        </Button>
      </div>
      <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
        {courseTheorems.map((theorem) => (
          <TheoremCard key={theorem.id} theorem={theorem} onSetStatus={setStatus} />
        ))}
      </div>
    </div>
  );
}
