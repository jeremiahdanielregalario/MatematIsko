import {
  ArrowRight,
  Bookmark,
  BookOpenText,
  CheckCircle2,
  Shuffle,
  Sparkles,
  Target,
} from 'lucide-react';
import { Link, useNavigate } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { EmptyState } from '@/components/common/EmptyState';
import { LoadingState } from '@/components/common/LoadingState';
import { ProgressCard } from '@/components/common/ProgressCard';
import { QuestionCard } from '@/components/questions/QuestionCard';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/hooks/useAuth';
import { useQuestions } from '@/hooks/useQuestions';
import { computeStats } from '@/lib/stats';
import { pickRandom } from '@/lib/questionFilter';
import type { QuestionWithMeta } from '@/types';

function greeting(): string {
  const hour = new Date().getHours();
  if (hour < 12) return 'Good morning';
  if (hour < 18) return 'Good afternoon';
  return 'Good evening';
}

export function DashboardPage() {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const { data, loading, error, reload } = useQuestions();

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

  const questions = data ?? [];
  const stats = computeStats(questions);

  const firstName = profile?.full_name?.split(/\s+/)[0] ?? 'student';

  const recent = [...questions]
    .filter((q) => q.progress?.last_attempted_at)
    .sort((a, b) => (b.progress?.last_attempted_at ?? '').localeCompare(a.progress?.last_attempted_at ?? ''))
    .slice(0, 3);

  const recommended = [...questions]
    .sort((a, b) => {
      const rank = (q: QuestionWithMeta) =>
        (q.bookmarked ? 4 : 0) + (q.progress?.status === 'learning' ? 3 : 0) + (q.progress?.status === 'unseen' ? 1 : 0);
      return rank(b) - rank(a);
    })
    .slice(0, 3);

  const startRandom = () => {
    const random = pickRandom(questions);
    if (random) navigate(`/questions/${random.id}`);
  };

  return (
    <div className="space-y-8">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {greeting()}, {firstName}.
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            Ready to review? {stats.unseen > 0 ? `${stats.unseen} questions left to try.` : 'You have seen every question in the bank.'}
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
        <ProgressCard label="Questions available" value={stats.total} icon={<BookOpenText className="size-4" />} />
        <ProgressCard label="Completed" value={stats.completed} icon={<CheckCircle2 className="size-4 text-emerald-600 dark:text-emerald-400" />} hint="Attempted at least once" />
        <ProgressCard label="Mastered" value={stats.mastered} icon={<Sparkles className="size-4 text-brand-700 dark:text-brand-400" />} />
        <ProgressCard label="Bookmarked" value={stats.bookmarked} icon={<Bookmark className="size-4 text-amber-600 dark:text-amber-400" />} />
      </section>

      <section className="rounded-xl border border-stone-200 bg-white p-5 dark:border-stone-800 dark:bg-stone-900">
        <div className="mb-2 flex items-center justify-between text-sm">
          <span className="font-medium text-stone-700 dark:text-stone-200">Overall mastery</span>
          <span className="font-semibold text-stone-900 dark:text-stone-100">
            {stats.masteryRate !== null ? `${stats.masteryRate}%` : '—'}
          </span>
        </div>
        <div
          className="h-2.5 overflow-hidden rounded-full bg-stone-100 dark:bg-stone-800"
          role="progressbar"
          aria-valuemin={0}
          aria-valuemax={100}
          aria-valuenow={stats.masteryRate ?? 0}
          aria-label="Overall mastery progress"
        >
          <div
            className="h-full rounded-full bg-gradient-to-r from-brand-700 to-brand-500 transition-all duration-500 dark:from-brand-500 dark:to-brand-300"
            style={{ width: `${stats.masteryRate ?? 0}%` }}
          />
        </div>
      </section>

      {recent.length > 0 ? (
        <section>
          <div className="mb-3 flex items-center justify-between">
            <h2 className="font-serif text-xl font-semibold text-stone-900 dark:text-stone-100">
              Continue studying
            </h2>
            <Link
              to="/progress"
              className="inline-flex items-center gap-1 text-sm font-medium text-brand-800 hover:underline dark:text-brand-300"
            >
              View progress <ArrowRight className="size-4" />
            </Link>
          </div>
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {recent.map((q) => (
              <QuestionCard
                key={q.id}
                question={q}
                onToggleBookmark={() => undefined}
                onSetStatus={undefined}
              />
            ))}
          </div>
        </section>
      ) : (
        <EmptyState
          icon={<Shuffle className="size-8" />}
          title="Nothing attempted yet"
          description="Attempt your first problem to start tracking your study progress."
          action={
            <Button asChild>
              <Link to="/questions">Browse questions</Link>
            </Button>
          }
        />
      )}

      {recommended.length > 0 ? (
        <section>
          <div className="mb-3">
            <h2 className="font-serif text-xl font-semibold text-stone-900 dark:text-stone-100">
              Recommended for you
            </h2>
            <p className="text-sm text-stone-500 dark:text-stone-400">
              Bookmarked and in-progress questions worth revisiting.
            </p>
          </div>
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {recommended.map((q) => (
              <QuestionCard
                key={q.id}
                question={q}
                onToggleBookmark={() => undefined}
                onSetStatus={undefined}
              />
            ))}
          </div>
        </section>
      ) : null}
    </div>
  );
}
