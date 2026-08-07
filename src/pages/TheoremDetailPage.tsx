import { ArrowLeft, ChevronLeft, ChevronRight, Eye, EyeOff } from 'lucide-react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { TheoremStatement } from '@/components/theorems/TheoremStatement';
import { MasteryButton } from '@/components/questions/MasteryButton';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Badge } from '@/components/ui/badge';
import { MathRenderer } from '@/components/math/MathRenderer';
import { useTheorem } from '@/hooks/useTheorem';
import { useTheoremMutations } from '@/hooks/useTheoremMutations';
import { useTheorems } from '@/hooks/useTheorems';
import { mergeTheoremMutations } from '@/lib/mutations';
import { useState } from 'react';

export function TheoremDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [revealed, setRevealed] = useState(false);

  const { data: theorem, loading, error, reload } = useTheorem(id);
  const { data: loadedTheorems = null } = useTheorems();
  const allTheorems = loadedTheorems ?? [];
  const getTheorem = (theoremId: string) => allTheorems.find((t) => t.id === theoremId);
  const mutations = useTheoremMutations(getTheorem);

  if (loading) return <LoadingState label="Loading theorem" />;

  if (error || !theorem) {
    return (
      <ErrorState
        title="Could not load theorem"
        message={error?.message ?? 'This theorem could not be found.'}
        onRetry={reload}
      />
    );
  }

  const merged = mergeTheoremMutations(theorem, mutations.statuses);
  const courseTheorems = allTheorems.filter((t) => t.course_id === theorem.course_id);
  const currentIndex = courseTheorems.findIndex((t) => t.id === theorem.id);
  const prevTheorem = currentIndex > 0 ? courseTheorems[currentIndex - 1] : null;
  const nextTheorem =
    currentIndex >= 0 && currentIndex < courseTheorems.length - 1
      ? courseTheorems[currentIndex + 1]
      : null;

  const goTo = (targetId: string) => {
    setRevealed(false);
    navigate(`/theorems/${targetId}`);
  };

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Link
        to="/theorems"
        className="inline-flex items-center gap-1.5 text-sm font-medium text-stone-500 hover:text-stone-900 dark:text-stone-400 dark:hover:text-stone-100"
      >
        <ArrowLeft className="size-4" />
        Back to theorems
      </Link>

      <Card className="overflow-hidden">
        <div className="border-b border-stone-100 p-6 dark:border-stone-800">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
              <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
                {merged.course?.code ?? '—'}
              </span>
              <span>{merged.topic?.name}</span>
              {merged.reference ? (
                <Badge variant="outline" className="font-mono">
                  {merged.reference}
                </Badge>
              ) : null}
            </div>
            <MasteryButton
              status={merged.progress?.status ?? 'unseen'}
              onChange={(next) => mutations.setStatus(merged.id, next)}
            />
          </div>
          <h1 className="mt-3 font-serif text-2xl font-bold leading-tight tracking-tight text-stone-900 dark:text-stone-50">
            <MathRenderer inline>{merged.name}</MathRenderer>
          </h1>
        </div>

        <div className="p-6">
          {revealed ? (
            <>
              <TheoremStatement theorem={merged} />
              <Button
                variant="outline"
                className="mt-4"
                onClick={() => setRevealed(false)}
              >
                <EyeOff className="size-4" />
                Hide statement
              </Button>
            </>
          ) : (
            <div className="flex flex-col items-center justify-center gap-4 py-10 text-center">
              <div className="text-4xl">📜</div>
              <p className="max-w-sm text-sm text-stone-500 dark:text-stone-400">
                Try to recall the statement of this theorem before revealing it.
              </p>
              <Button onClick={() => setRevealed(true)}>
                <Eye className="size-4" />
                Reveal statement
              </Button>
            </div>
          )}
        </div>
      </Card>

      <div className="flex items-center justify-between gap-2">
        {prevTheorem ? (
          <Button variant="outline" size="sm" onClick={() => goTo(prevTheorem.id)}>
            <ChevronLeft className="size-4" />
            Previous
          </Button>
        ) : (
          <span />
        )}
        {nextTheorem ? (
          <Button variant="outline" size="sm" onClick={() => goTo(nextTheorem.id)}>
            Next
            <ChevronRight className="size-4" />
          </Button>
        ) : (
          <span />
        )}
      </div>
    </div>
  );
}
