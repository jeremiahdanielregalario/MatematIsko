import {
  BookOpenText,
  Bookmark,
  CheckCircle2,
  Layers,
  Shuffle,
  Sparkles,
  Target,
} from 'lucide-react';
import { useMemo } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { EmptyState } from '@/components/common/EmptyState';
import { LoadingState } from '@/components/common/LoadingState';
import { ProgressCard } from '@/components/common/ProgressCard';
import { Reveal } from '@/components/common/Reveal';
import { QuestionCard } from '@/components/questions/QuestionCard';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/hooks/useAuth';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { mergeMutations } from '@/lib/mutations';
import { pickRandom } from '@/lib/questionFilter';
import { getRecommendedQuestions } from '@/lib/recommendations';
import { computeStats } from '@/lib/stats';
import type { QuestionWithMeta } from '@/types';

const EMPTY_QUESTIONS: QuestionWithMeta[] = [];

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

  const questions = useMemo(() => data ?? EMPTY_QUESTIONS, [data]);

  const getQuestion = (id: string) => questions.find((q) => q.id === id);
  const mutations = useQuestionMutations(getQuestion);

  const merged = useMemo(
    () => questions.map((q) => mergeMutations(q, mutations)),
    [questions, mutations],
  );

  const stats = useMemo(() => computeStats(merged), [merged]);

  const recommended = useMemo(() => getRecommendedQuestions(merged), [merged]);

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

  const firstName = profile?.full_name?.split(/\s+/)[0] ?? 'student';

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
