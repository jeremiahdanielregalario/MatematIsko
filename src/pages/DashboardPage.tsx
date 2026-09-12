import {
  ArrowRight,
  BookOpenText,
  Bookmark,
  Clock3,
  Download,
  RefreshCw,
  Shuffle,
  Target,
} from 'lucide-react';
import { useMemo } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { ProgressBar } from '@/components/common/ProgressBar';
import { MathRenderer } from '@/components/math/MathRenderer';
import { QuestionCard } from '@/components/questions/QuestionCard';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { useAuth } from '@/hooks/useAuth';
import { usePwaInstall } from '@/hooks/usePwaInstall';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { mergeMutations } from '@/lib/mutations';
import { pickRandomProblem } from '@/lib/questionFilter';
import { getRecommendedQuestions } from '@/lib/recommendations';
import { computeStats } from '@/lib/stats';
import { cn } from '@/lib/cn';

const FILTERS = [
  ['recommended', 'Suggested'],
  ['learning', 'Needs review'],
  ['unseen', 'Unseen'],
  ['bookmarked', 'Saved'],
] as const;
const PAGE_SIZE = 6;

export function DashboardPage() {
  const { profile } = useAuth();
  const { data, loading, error, reload } = useQuestions();
  const [params, setParams] = useSearchParams();
  const navigate = useNavigate();
  const { install, isInstallable } = usePwaInstall();
  const mutations = useQuestionMutations((id) => data?.find((q) => q.id === id));
  const merged = useMemo(
    () => (data ?? []).map((q) => mergeMutations(q, mutations)),
    [data, mutations],
  );
  const courses = [
    ...new Map(merged.filter((q) => q.course).map((q) => [q.course_id, q.course!])).values(),
  ].sort((a, b) => a.code.localeCompare(b.code));
  const courseId = courses.some((c) => c.id === params.get('course')) ? params.get('course')! : '';
  const questions = courseId ? merged.filter((q) => q.course_id === courseId) : merged;
  const stats = computeStats(questions);
  const filter = FILTERS.find(([key]) => key === params.get('filter'))?.[0] ?? 'recommended';
  const progressView = params.get('tab') === 'progress';
  const recommended = getRecommendedQuestions(questions, questions.length);
  const learning = questions
    .filter((q) => q.progress?.status === 'learning')
    .sort(
      (a, b) =>
        (a.progress?.last_attempted_at ?? '').localeCompare(b.progress?.last_attempted_at ?? '') ||
        a.id.localeCompare(b.id),
    );
  const next = learning[0] ?? recommended[0];
  const queue =
    filter === 'recommended'
      ? recommended
      : filter === 'learning'
        ? learning
        : filter === 'bookmarked'
          ? questions.filter((q) => q.bookmarked)
          : questions.filter((q) => !q.progress || q.progress.status === 'unseen');
  const requestedPage = Number(params.get('page') ?? 1);
  const page = Math.min(
    Math.max(1, Number.isSafeInteger(requestedPage) ? requestedPage : 1),
    Math.max(1, Math.ceil(queue.length / PAGE_SIZE)),
  );
  const update = (values: Record<string, string>) => {
    const nextParams = new URLSearchParams(params);
    Object.entries(values).forEach(([key, value]) =>
      value ? nextParams.set(key, value) : nextParams.delete(key),
    );
    setParams(nextParams);
  };
  const randomProblem = () => {
    // Random mode continues across the student's selected-course scope.
    const picked = pickRandomProblem(merged);
    if (picked) navigate(`/questions/${picked.id}?mode=random`);
  };
  const counts = {
    recommended: recommended.length,
    learning: stats.learning,
    unseen: stats.unseen,
    bookmarked: stats.bookmarked,
  };
  const topicStats = [...stats.byTopic].sort(
    (a, b) => a.masteryPercent - b.masteryPercent || a.topicName.localeCompare(b.topicName),
  );
  const firstName = profile?.full_name?.trim().split(/\s+/)[0] || 'student';

  if (loading) return <LoadingState label="Loading your dashboard" />;
  if (error)
    return (
      <ErrorState title="Could not load your dashboard" message={error.message} onRetry={reload} />
    );

  return (
    <div className="space-y-7">
      <header className="flex flex-wrap items-start justify-between gap-3">
        <div>
          <p className="text-xs font-semibold uppercase tracking-widest text-brand-800 dark:text-brand-300">
            Your study desk
          </p>
          <h1 className="mt-1 font-serif text-3xl font-bold text-stone-900 dark:text-stone-50">
            Ready to review, {firstName}?
          </h1>
          <p className="mt-2 text-sm text-stone-500 dark:text-stone-400">
            Revisit what needs work. Try something new. Build understanding one problem at a time.
          </p>
        </div>
        <Button variant="outline" size="sm" onClick={reload}>
          <RefreshCw className="size-4" /> Refresh
        </Button>
      </header>

      <section aria-label="Start reviewing" className="grid gap-4 lg:grid-cols-[1.5fr_1fr]">
        <Card className="min-w-0 border-brand-200 bg-brand-50/50 p-5 sm:p-6 dark:border-brand-900 dark:bg-brand-950/30">
          <p className="text-xs font-semibold uppercase tracking-wider text-brand-800 dark:text-brand-300">
            {next
              ? 'A good place to start'
              : stats.total
                ? 'Keep your skills fresh'
                : 'Start with your courses'}
          </p>
          <h2 className="mt-3 font-serif text-2xl font-semibold">
            {next
              ? learning.length
                ? 'Return to a problem you’re learning'
                : 'Try an unseen problem'
              : stats.total
                ? 'Every loaded problem is mastered'
                : 'Your next review starts here'}
          </h2>
          {next ? (
            <>
              <p className="mt-2 text-sm text-stone-500 dark:text-stone-400">
                {next.course?.code} · {next.topic?.name}
              </p>
              <div className="mt-2 min-w-0 font-medium">
                <MathRenderer inline>{next.title}</MathRenderer>
              </div>
              <Button asChild className="mt-5">
                <Link to={`/questions/${next.id}?course=${next.course_id}&topic=${next.topic_id}`}>
                  Review this problem <ArrowRight className="size-4" />
                </Link>
              </Button>
            </>
          ) : (
            <>
              <p className="mt-2 text-sm text-stone-600 dark:text-stone-400">
                {stats.total
                  ? 'Revisit a saved problem or test yourself with a timed paper.'
                  : 'Choose courses in your profile, then explore their problems and notes.'}
              </p>
              <Button asChild className="mt-5">
                <Link to={stats.total ? '/practice/exam' : '/profile'}>
                  {stats.total ? 'Set up a timed paper' : 'Choose your courses'}{' '}
                  <ArrowRight className="size-4" />
                </Link>
              </Button>
            </>
          )}
        </Card>
        <div className="grid gap-3">
          <Button
            onClick={randomProblem}
            disabled={!merged.length}
            className="h-auto min-h-14 whitespace-normal py-4"
          >
            <Shuffle className="size-4 shrink-0" /> Give me a random problem
          </Button>
          <p className="px-1 text-xs text-stone-500 dark:text-stone-400">
            Prioritizes non-mastered problems across your selected courses.
          </p>
          <div className="grid grid-cols-2 gap-3">
            <Link
              to="/practice"
              className="rounded-xl border border-stone-200 p-4 hover:bg-stone-50 focus-visible:outline-2 focus-visible:outline-brand-600 dark:border-stone-800 dark:hover:bg-stone-800"
            >
              <Target className="mb-2 size-5 text-brand-700 dark:text-brand-300" />
              <span className="block font-semibold">Guided practice</span>
              <span className="mt-1 block text-xs text-stone-500 dark:text-stone-400">
                Hints, solutions, self-checks
              </span>
            </Link>
            <Link
              to="/practice/exam"
              className="rounded-xl border border-stone-200 p-4 hover:bg-stone-50 focus-visible:outline-2 focus-visible:outline-brand-600 dark:border-stone-800 dark:hover:bg-stone-800"
            >
              <Clock3 className="mb-2 size-5 text-brand-700 dark:text-brand-300" />
              <span className="block font-semibold">Timed paper</span>
              <span className="mt-1 block text-xs text-stone-500 dark:text-stone-400">
                Attempt first, review after
              </span>
            </Link>
          </div>
        </div>
      </section>

      <section aria-label="Review workspace" className="space-y-5">
        <div className="flex flex-wrap items-end justify-between gap-4">
          <div>
            <h2 className="font-serif text-2xl font-semibold">Your review workspace</h2>
            <p className="mt-1 text-sm text-stone-500 dark:text-stone-400">
              Question mastery is your self-assessment, not an exam grade.
            </p>
          </div>
          <label className="text-sm font-medium">
            Focus course
            <select
              value={courseId}
              onChange={(e) => update({ course: e.target.value, page: '' })}
              className="mt-1 block w-full max-w-xs rounded-lg border border-stone-300 bg-white px-3 py-2 dark:border-stone-700 dark:bg-stone-900"
            >
              <option value="">All selected courses</option>
              {courses.map((c) => (
                <option key={c.id} value={c.id}>
                  {c.code}
                </option>
              ))}
            </select>
          </label>
        </div>
        <dl className="grid grid-cols-3 gap-3 rounded-xl border border-stone-200 p-4 dark:border-stone-800">
          {[
            [stats.learning, 'Learning'],
            [stats.unseen, 'Unseen'],
            [stats.mastered, 'Mastered'],
          ].map(([value, label]) => (
            <div key={label} className="min-w-0">
              <dt className="text-xs text-stone-500 dark:text-stone-400">{label}</dt>
              <dd className="mt-1 text-2xl font-semibold tabular-nums">{value}</dd>
            </div>
          ))}
        </dl>
        <nav
          aria-label="Dashboard views"
          className="flex flex-wrap gap-2 border-b border-stone-200 pb-3 dark:border-stone-800"
        >
          <Button
            variant={!progressView ? 'default' : 'ghost'}
            aria-pressed={!progressView}
            onClick={() => update({ tab: '', page: '' })}
          >
            Review list
          </Button>
          <Button
            variant={progressView ? 'default' : 'ghost'}
            aria-pressed={progressView}
            onClick={() => update({ tab: 'progress', page: '' })}
          >
            Course & topic progress
          </Button>
        </nav>
        {progressView ? (
          <div className="grid items-start gap-5 lg:grid-cols-2">
            <Card className="space-y-4 p-5">
              <h3 className="font-serif text-xl font-semibold">Course overview</h3>
              {courses
                .filter((c) => !courseId || c.id === courseId)
                .map((c) => {
                  const courseStats = computeStats(questions.filter((q) => q.course_id === c.id));
                  return (
                    <div
                      key={c.id}
                      className="space-y-2 border-b border-stone-100 pb-4 last:border-0 dark:border-stone-800"
                    >
                      <Link
                        className="font-semibold text-brand-800 hover:underline dark:text-brand-300"
                        to={`/courses/${c.id}`}
                      >
                        {c.code} · {c.name}
                      </Link>
                      <p className="text-sm text-stone-500 dark:text-stone-400">
                        {courseStats.mastered}/{courseStats.total} mastered · {courseStats.learning}{' '}
                        learning
                      </p>
                      <ProgressBar
                        value={
                          courseStats.total
                            ? Math.round((courseStats.mastered / courseStats.total) * 100)
                            : 0
                        }
                        label={`${c.code} question mastery`}
                      />
                      <div className="flex flex-wrap gap-4 text-sm">
                        <Link
                          className="underline underline-offset-4"
                          to={`/courses/${c.id}?tab=notes`}
                        >
                          Read notes
                        </Link>
                        <Link
                          className="underline underline-offset-4"
                          to={`/practice?courseId=${c.id}`}
                        >
                          Practice course
                        </Link>
                      </div>
                    </div>
                  );
                })}
              {!courses.length && (
                <p className="text-sm text-stone-500">No course questions loaded yet.</p>
              )}
            </Card>
            <Card className="space-y-4 p-5">
              <h3 className="font-serif text-xl font-semibold">Topics to build on</h3>
              <p className="text-sm text-stone-500 dark:text-stone-400">
                Lowest share of mastered questions first, including topics you haven’t started.
              </p>
              {topicStats.map((topic) => {
                const question = questions.find((q) => q.topic_id === topic.topicId)!;
                return (
                  <div key={topic.topicId} className="space-y-2">
                    <div className="flex items-start justify-between gap-3">
                      <Link
                        className="min-w-0 text-sm font-medium hover:underline"
                        to={`/practice?courseId=${question.course_id}&topicId=${topic.topicId}`}
                      >
                        <span className="block text-xs text-stone-500">{topic.courseCode}</span>
                        <MathRenderer inline>{topic.topicName}</MathRenderer>
                      </Link>
                      <span className="shrink-0 text-xs text-stone-500">
                        {topic.mastered}/{topic.total}
                      </span>
                    </div>
                    <ProgressBar
                      label={`${topic.topicName} mastery`}
                      value={topic.masteryPercent}
                    />
                  </div>
                );
              })}
              {!topicStats.length && (
                <p className="text-sm text-stone-500">
                  Topics appear here when course questions are available.
                </p>
              )}
            </Card>
          </div>
        ) : (
          <>
            <div aria-label="Filter review list" className="flex flex-wrap gap-2">
              {FILTERS.map(([key, label]) => (
                <button
                  key={key}
                  aria-pressed={filter === key}
                  onClick={() => update({ filter: key, page: '' })}
                  className={cn(
                    'rounded-full border px-3 py-2 text-sm focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
                    filter === key
                      ? 'border-brand-800 bg-brand-50 font-semibold text-brand-900 dark:border-brand-400 dark:bg-brand-950 dark:text-brand-200'
                      : 'border-stone-200 text-stone-600 dark:border-stone-700 dark:text-stone-300',
                  )}
                >
                  {label} <span className="ml-1 tabular-nums">{counts[key]}</span>
                </button>
              ))}
            </div>
            <p className="text-sm text-stone-500 dark:text-stone-400">
              {filter === 'recommended'
                ? 'Non-mastered questions balanced across courses and topics.'
                : filter === 'learning'
                  ? 'Problems marked learning, with the oldest recorded attempts first.'
                  : filter === 'unseen'
                    ? 'Problems you have not marked learning or mastered.'
                    : 'Your bookmarked problems, including mastered ones.'}
            </p>
            {queue.length ? (
              <>
                <div className="grid gap-4 md:grid-cols-2 xl:grid-cols-3">
                  {queue.slice((page - 1) * PAGE_SIZE, page * PAGE_SIZE).map((question) => (
                    <QuestionCard
                      key={question.id}
                      question={question}
                      to={`/questions/${question.id}?course=${question.course_id}&topic=${question.topic_id}`}
                      onToggleBookmark={mutations.toggleBookmark}
                      onSetStatus={mutations.setStatus}
                    />
                  ))}
                </div>
                <nav
                  aria-label="Review list pages"
                  className="flex flex-wrap items-center justify-between gap-3"
                >
                  <Button
                    variant="outline"
                    disabled={page === 1}
                    onClick={() => update({ page: String(page - 1) })}
                  >
                    Previous
                  </Button>
                  <p role="status" className="text-sm text-stone-500">
                    {(page - 1) * PAGE_SIZE + 1}–{Math.min(page * PAGE_SIZE, queue.length)} of{' '}
                    {queue.length} problems
                  </p>
                  <Button
                    variant="outline"
                    disabled={page * PAGE_SIZE >= queue.length}
                    onClick={() => update({ page: String(page + 1) })}
                  >
                    Next
                  </Button>
                </nav>
              </>
            ) : (
              <Card className="space-y-2 p-6">
                <h3 className="font-serif text-xl font-semibold">
                  {!stats.total
                    ? 'No questions in this focus yet'
                    : filter === 'bookmarked'
                      ? 'Build your saved review list'
                      : filter === 'learning'
                        ? 'No problems marked learning'
                        : filter === 'unseen'
                          ? 'You’ve started every loaded problem'
                          : 'All loaded problems are mastered'}
                </h3>
                <p className="text-sm text-stone-500 dark:text-stone-400">
                  {filter === 'bookmarked'
                    ? 'Use the bookmark button on a problem to save it for later.'
                    : 'Choose another review filter or explore your courses for the next step.'}
                </p>
                <Button variant="outline" asChild>
                  <Link to="/courses">Browse courses</Link>
                </Button>
              </Card>
            )}
          </>
        )}
      </section>
      <footer className="flex flex-wrap items-center gap-x-5 gap-y-3 border-t border-stone-200 pt-5 text-sm dark:border-stone-800">
        <Link className="inline-flex items-center gap-2 underline underline-offset-4" to="/courses">
          <BookOpenText className="size-4" />
          Courses & notes
        </Link>
        <Link
          className="inline-flex items-center gap-2 underline underline-offset-4"
          to="/theorems/flashcards"
        >
          Theorem flashcards
        </Link>
        <Link
          className="inline-flex items-center gap-2 underline underline-offset-4"
          to="/bookmarks"
        >
          <Bookmark className="size-4" />
          All bookmarks
        </Link>
        {isInstallable && (
          <Button size="sm" variant="ghost" onClick={() => void install()}>
            <Download className="size-4" />
            Install app
          </Button>
        )}
      </footer>
    </div>
  );
}
