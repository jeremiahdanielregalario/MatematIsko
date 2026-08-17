import {
  BookMarked,
  BookOpenText,
  Bookmark,
  CheckCircle2,
  Layers,
  RefreshCw,
  Shuffle,
  Sparkles,
  Target,
} from 'lucide-react';
import { useMemo } from 'react';
import { Link, useNavigate, useSearchParams } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { ProgressBar } from '@/components/common/ProgressBar';
import { ProgressCard } from '@/components/common/ProgressCard';
import { Reveal } from '@/components/common/Reveal';
import { QuestionCard } from '@/components/questions/QuestionCard';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/hooks/useAuth';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { cn } from '@/lib/cn';
import { mergeMutations } from '@/lib/mutations';
import { pickRandom } from '@/lib/questionFilter';
import { getRecommendedQuestions } from '@/lib/recommendations';
import { computeStats } from '@/lib/stats';
import type { QuestionWithMeta } from '@/types';

const EMPTY_QUESTIONS: QuestionWithMeta[] = [];

type DashboardTab = 'overview' | 'progress';

const TABS: { key: DashboardTab; label: string; icon: typeof Layers }[] = [
  { key: 'overview', label: 'Overview', icon: Layers },
  { key: 'progress', label: 'Progress', icon: BookMarked },
];

function greeting(): string {
  const hour = new Date().getHours();
  if (hour < 12) return 'Good morning';
  if (hour < 18) return 'Good afternoon';
  return 'Good evening';
}

export function DashboardPage() {
  const { profile } = useAuth();
  const [searchParams, setSearchParams] = useSearchParams();
  const { data, loading, error, reload } = useQuestions();

  const activeTab = (searchParams.get('tab') as DashboardTab) || 'overview';
  const setActiveTab = (tab: DashboardTab) => setSearchParams({ tab });

  const questions = useMemo(() => data ?? EMPTY_QUESTIONS, [data]);

  const getQuestion = (id: string) => questions.find((q) => q.id === id);
  const mutations = useQuestionMutations(getQuestion);

  const merged = useMemo(
    () => questions.map((q) => mergeMutations(q, mutations)),
    [questions, mutations],
  );

  const stats = useMemo(() => computeStats(merged), [merged]);

  if (loading) return <LoadingState label="Loading your dashboard" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load your dashboard"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  return (
    <div className="space-y-6">
      {/* Tab bar */}
      <div className="flex items-center gap-1 rounded-lg border border-stone-200 bg-stone-50 p-1 dark:border-stone-800 dark:bg-stone-900">
        {TABS.map(({ key, label, icon: Icon }) => (
          <button
            key={key}
            type="button"
            onClick={() => setActiveTab(key)}
            className={cn(
              'inline-flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors',
              activeTab === key
                ? 'bg-white text-stone-900 shadow-sm dark:bg-stone-800 dark:text-stone-50'
                : 'text-stone-500 hover:text-stone-700 dark:text-stone-400 dark:hover:text-stone-200',
            )}
          >
            <Icon className="size-4" />
            {label}
          </button>
        ))}
      </div>

      {activeTab === 'overview' ? (
        <OverviewTab
          stats={stats}
          questions={questions}
          merged={merged}
          mutations={mutations}
          firstName={profile?.full_name?.split(/\s+/)[0] ?? 'student'}
        />
      ) : (
        <ProgressTab stats={stats} questions={questions} />
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Overview tab
// ---------------------------------------------------------------------------

function OverviewTab({
  stats,
  questions,
  merged,
  mutations,
  firstName,
}: {
  stats: ReturnType<typeof computeStats>;
  questions: QuestionWithMeta[];
  merged: QuestionWithMeta[];
  mutations: ReturnType<typeof useQuestionMutations>;
  firstName: string;
}) {
  const navigate = useNavigate();
  const recommended = useMemo(() => getRecommendedQuestions(merged), [merged]);

  const startRandom = () => {
    const random = pickRandom(questions);
    if (random) navigate(`/questions/${random.id}`);
  };

  return (
    <div className="space-y-8">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="animate-fade-in-down font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {greeting()}, {firstName}.
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            Here are the questions we think you should tackle next.
          </p>
        </div>
        <div className="flex flex-wrap gap-2">
          <Button onClick={startRandom}>
            <Shuffle className="size-4" />
            Give me a random problem
          </Button>
          <Button variant="outline" asChild>
            <Link to="/practice">
              <Target className="size-4" />
              Start Practice
            </Link>
          </Button>
        </div>
      </section>

      <section className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        <Reveal delay={0} className="h-full">
          <ProgressCard
            label="Questions available"
            value={stats.total}
            icon={<Layers className="size-4" />}
            className="h-full"
          />
        </Reveal>
        <Reveal delay={75} className="h-full">
          <ProgressCard
            label="Mastered"
            value={stats.mastered}
            icon={<CheckCircle2 className="size-4" />}
            hint={
              stats.masteryRate === null
                ? 'Answer questions to start tracking.'
                : `${stats.masteryRate}% of attempted questions mastered`
            }
            className="h-full"
          />
        </Reveal>
        <Reveal delay={150} className="h-full">
          <ProgressCard
            label="Learning"
            value={stats.learning}
            icon={<BookOpenText className="size-4" />}
            className="h-full"
          />
        </Reveal>
        <Reveal delay={225} className="h-full">
          <ProgressCard
            label="Bookmarked"
            value={stats.bookmarked}
            icon={<Bookmark className="size-4" />}
            className="h-full"
          />
        </Reveal>
      </section>

      <section className="space-y-4">
        <h2 className="font-serif text-2xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
          Recommended for you
        </h2>
        {recommended.length > 0 ? (
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {recommended.map((question, index) => (
              <Reveal key={question.id} delay={index * 60} className="h-full">
                <QuestionCard
                  question={question}
                  className="h-full"
                  to={`/questions/${question.id}?course=${question.course_id}`}
                  onToggleBookmark={mutations.toggleBookmark}
                  onSetStatus={mutations.setStatus}
                />
              </Reveal>
            ))}
          </div>
        ) : (
          <EmptyState
            icon={<Sparkles className="size-8" />}
            title="No questions to recommend yet"
            description="Once you have questions to study, we will surface the ones from your weakest topics here."
            action={
              <Button asChild>
                <Link to="/courses">Browse courses</Link>
              </Button>
            }
          />
        )}
      </section>
    </div>
  );
}

// ---------------------------------------------------------------------------
// Progress tab
// ---------------------------------------------------------------------------

function ProgressTab({
  stats,
  questions,
}: {
  stats: ReturnType<typeof computeStats>;
  questions: QuestionWithMeta[];
}) {
  const needsReview = questions.filter((q) => q.progress?.status === 'learning');

  return (
    <div className="space-y-8">
      <section className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        <Reveal delay={0} className="h-full">
          <ProgressCard label="Total questions" value={stats.total} icon={<BookOpenText className="size-4" />} className="h-full" />
        </Reveal>
        <Reveal delay={75} className="h-full">
          <ProgressCard label="Completed" value={stats.completed} icon={<CheckCircle2 className="size-4 text-emerald-600 dark:text-emerald-400" />} className="h-full" />
        </Reveal>
        <Reveal delay={150} className="h-full">
          <ProgressCard label="Mastered" value={stats.mastered} icon={<Sparkles className="size-4 text-brand-700 dark:text-brand-400" />} className="h-full" />
        </Reveal>
        <Reveal delay={225} className="h-full">
          <ProgressCard label="Bookmarked" value={stats.bookmarked} icon={<Bookmark className="size-4 text-amber-600 dark:text-amber-400" />} className="h-full" />
        </Reveal>
      </section>

      <div className="grid gap-6 lg:grid-cols-2">
        <Card>
          <CardHeader>
            <CardTitle className="font-serif text-xl">Mastery rate</CardTitle>
            <CardDescription>Mastered out of all completed questions.</CardDescription>
          </CardHeader>
          <CardContent>
            <p className="text-5xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
              {stats.masteryRate !== null ? `${stats.masteryRate}%` : '—'}
            </p>
            <p className="mt-1 text-sm text-stone-500 dark:text-stone-400">
              {stats.learning} question{stats.learning === 1 ? '' : 's'} still in progress
            </p>
          </CardContent>
        </Card>

        <Card>
          <CardHeader>
            <CardTitle className="font-serif text-xl">Questions by topic</CardTitle>
            <CardDescription>Mastered share of each topic, sorted by size.</CardDescription>
          </CardHeader>
          <CardContent className="space-y-3">
            {stats.byTopic.length === 0 ? (
              <p className="text-sm text-stone-500 dark:text-stone-400">No topics yet.</p>
            ) : (
              stats.byTopic.map((topic) => (
                <div key={topic.topicId}>
                  <div className="mb-1 flex items-center justify-between text-sm">
                    <span className="truncate text-stone-700 dark:text-stone-200">
                      <span className="mr-1.5 font-mono text-xs text-stone-400">
                        {topic.courseCode}
                      </span>
                      {topic.topicName}
                    </span>
                    <span className="ml-2 shrink-0 font-medium text-stone-500 dark:text-stone-400">
                      {topic.mastered}/{topic.total} · {topic.masteryPercent}%
                    </span>
                  </div>
                  <ProgressBar
                    value={topic.masteryPercent}
                    label={`${topic.topicName} mastery`}
                    className="h-2 bg-stone-100 dark:bg-stone-800"
                  />
                </div>
              ))
            )}
          </CardContent>
        </Card>
      </div>

      <section>
        <div className="mb-3 flex items-center gap-2">
          <RefreshCw className="size-4 text-amber-600 dark:text-amber-400" />
          <h2 className="font-serif text-xl font-semibold text-stone-900 dark:text-stone-100">
            Needs review
          </h2>
        </div>
        {needsReview.length === 0 ? (
          <EmptyState
            title="Nothing needs review"
            description="Questions you marked as learning will appear here. You are all caught up!"
            action={
              <Button asChild>
                <Link to="/practice">Start a practice session</Link>
              </Button>
            }
          />
        ) : (
          <Card>
            <ul className="divide-y divide-stone-100 dark:divide-stone-800">
              {needsReview.map((q) => (
                <li key={q.id}>
                  <Link
                    to={`/questions/${q.id}`}
                    className="flex items-center justify-between gap-3 px-5 py-3 text-sm transition-colors hover:bg-stone-50 dark:hover:bg-stone-800/50"
                  >
                    <span className="min-w-0 truncate font-medium text-stone-800 dark:text-stone-100">
                      {q.course?.code} — {q.title}
                    </span>
                    <span className="shrink-0 text-xs text-stone-400 dark:text-stone-500">
                      {q.topic?.name}
                    </span>
                  </Link>
                </li>
              ))}
            </ul>
          </Card>
        )}
      </section>
    </div>
  );
}
