import { Bookmark, BookOpenText, CheckCircle2, RefreshCw, Sparkles } from 'lucide-react';
import { Link } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { ProgressBar } from '@/components/common/ProgressBar';
import { ProgressCard } from '@/components/common/ProgressCard';
import { Reveal } from '@/components/common/Reveal';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { useQuestions } from '@/hooks/useQuestions';
import { computeStats } from '@/lib/stats';

export function ProgressPage() {
  const { data, loading, error, reload } = useQuestions();

  if (loading) return <LoadingState label="Loading your progress" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load your progress"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  const questions = data ?? [];
  const stats = computeStats(questions);

  const needsReview = questions.filter((q) => q.progress?.status === 'learning');

  return (
    <div className="space-y-8">
      <header>
        <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
          Your Progress
        </h1>
        <p className="mt-1 text-stone-500 dark:text-stone-400">
          A snapshot of everything you have attempted and mastered.
        </p>
      </header>

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
