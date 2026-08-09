import { Check, Eye, GraduationCap, RotateCcw, Undo2, X } from 'lucide-react';
import { useCallback, useEffect, useMemo, useState } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { MathRenderer } from '@/components/math/MathRenderer';
import { TheoremStatement } from '@/components/theorems/TheoremStatement';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { cn } from '@/lib/cn';
import { useAuth } from '@/hooks/useAuth';
import { upsertTheoremProgress } from '@/lib/db';
import { useTheorems } from '@/hooks/useTheorems';
import type { ProgressStatus, TheoremWithMeta } from '@/types';

type CardState = 'front' | 'back';

interface FlashcardSessionProps {
  theorems: TheoremWithMeta[];
  onRate: (theorem: TheoremWithMeta, status: ProgressStatus) => void;
  onFinish: () => void;
}

function FlashcardDeck({ theorems, onRate, onFinish }: FlashcardSessionProps) {
  const [deck, setDeck] = useState(() => [...theorems]);
  const [index, setIndex] = useState(0);
  const [side, setSide] = useState<CardState>('front');
  const [results, setResults] = useState<
    { theorem: TheoremWithMeta; status: ProgressStatus }[]
  >([]);

  const current = deck[index] ?? null;
  const remaining = deck.length - index;

  const next = useCallback(() => {
    if (index + 1 < deck.length) {
      setIndex((i) => i + 1);
      setSide('front');
    } else {
      onFinish();
    }
  }, [index, deck.length, onFinish]);

  const rate = (status: ProgressStatus) => {
    if (!current) return;
    setResults((r) => [...r, { theorem: current, status }]);
    onRate(current, status);
    next();
  };

  const restart = () => {
    setDeck((d) => [...d].sort(() => Math.random() - 0.5));
    setIndex(0);
    setSide('front');
    setResults([]);
  };

  if (!current) return null;

  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between text-sm text-stone-500 dark:text-stone-400">
        <span>
          Card {index + 1} of {deck.length}
        </span>
        <span className="flex items-center gap-2">
          <span className="inline-flex items-center gap-1 text-emerald-600 dark:text-emerald-400">
            <Check className="size-3.5" />
            {results.filter((r) => r.status === 'mastered').length} mastered
          </span>
          <span className="inline-flex items-center gap-1 text-amber-600 dark:text-amber-400">
            <X className="size-3.5" />
            {results.filter((r) => r.status === 'learning').length} learning
          </span>
        </span>
      </div>

      {/* Card */}
      <button
        type="button"
        onClick={() => setSide((s) => (s === 'front' ? 'back' : 'front'))}
        className="perspective w-full text-left"
        aria-label="Flip card"
      >
        <div
          key={current.id}
          className={cn(
            'relative min-h-80 animate-fade-in transition-transform duration-500 [transform-style:preserve-3d]',
            side === 'back' && '[transform:rotateY(180deg)]',
          )}
        >
          {/* Front: theorem name */}
          <div className="absolute inset-0 [backface-visibility:hidden]">
            <Card className="flex h-full min-h-80 flex-col items-center justify-center gap-4 p-8 text-center shadow-md">
              <span className="text-4xl">📜</span>
              <div className="flex flex-wrap items-center justify-center gap-2 text-xs text-stone-500 dark:text-stone-400">
                <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
                  {current.course?.code ?? '—'}
                </span>
                {current.reference ? (
                  <Badge variant="outline" className="font-mono">
                    {current.reference}
                  </Badge>
                ) : null}
              </div>
              <h2 className="font-serif text-2xl font-bold leading-tight tracking-tight text-stone-900 dark:text-stone-50">
                <MathRenderer inline>{current.name}</MathRenderer>
              </h2>
              <span className="inline-flex items-center gap-1.5 text-xs font-medium text-stone-400 dark:text-stone-500">
                <Eye className="size-3.5" />
                Tap to reveal the statement
              </span>
            </Card>
          </div>

          {/* Back: statement */}
          <div className="absolute inset-0 [transform:rotateY(180deg)] [backface-visibility:hidden]">
            <Card className="flex h-full min-h-80 flex-col p-6 shadow-md">
              <TheoremStatement theorem={current} className="flex-1" />
            </Card>
          </div>
        </div>
      </button>

      {/* Rating buttons */}
      {side === 'back' ? (
        <div className="flex items-center justify-center gap-3">
          <Button
            variant="outline"
            className="border-amber-300 text-amber-700 hover:bg-amber-50 dark:border-amber-700 dark:text-amber-300 dark:hover:bg-amber-950/40"
            onClick={() => rate('learning')}
          >
            <X className="size-4" />
            Still learning
          </Button>
          <Button
            className="bg-emerald-600 hover:bg-emerald-700"
            onClick={() => rate('mastered')}
          >
            <Check className="size-4" />
            Got it
          </Button>
        </div>
      ) : (
        <div className="flex h-10 items-center justify-center text-sm text-stone-400 dark:text-stone-500">
          {remaining} remaining
        </div>
      )}

      <div className="flex items-center justify-center">
        <Button variant="ghost" size="sm" onClick={restart}>
          <RotateCcw className="size-4" />
          Shuffle & restart
        </Button>
      </div>
    </div>
  );
}

interface ResultsViewProps {
  results: { theorem: TheoremWithMeta; status: ProgressStatus }[];
  onDone: () => void;
  onReview: () => void;
}

function ResultsView({ results, onDone, onReview }: ResultsViewProps) {
  const mastered = results.filter((r) => r.status === 'mastered');
  const learning = results.filter((r) => r.status === 'learning');

  return (
    <div className="mx-auto max-w-2xl space-y-6">
      <Card className="p-8 text-center">
        <span className="text-5xl">🎓</span>
        <h2 className="mt-4 font-serif text-2xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
          Session complete!
        </h2>
        <p className="mt-2 text-stone-500 dark:text-stone-400">
          You reviewed {results.length} theorems.
        </p>
        <div className="mx-auto mt-6 grid max-w-md grid-cols-2 gap-4">
          <div className="rounded-lg bg-emerald-50 p-4 dark:bg-emerald-950/40">
            <p className="text-3xl font-bold text-emerald-700 dark:text-emerald-400">
              {mastered.length}
            </p>
            <p className="text-sm text-emerald-700/70 dark:text-emerald-400/70">Mastered</p>
          </div>
          <div className="rounded-lg bg-amber-50 p-4 dark:bg-amber-950/40">
            <p className="text-3xl font-bold text-amber-700 dark:text-amber-400">
              {learning.length}
            </p>
            <p className="text-sm text-amber-700/70 dark:text-amber-400/70">Still learning</p>
          </div>
        </div>
        <div className="mt-8 flex items-center justify-center gap-3">
          <Button variant="outline" onClick={onReview}>
            <RotateCcw className="size-4" />
            Review again
          </Button>
          <Button onClick={onDone}>
            <GraduationCap className="size-4" />
            Back to theorems
          </Button>
        </div>
      </Card>
    </div>
  );
}

export function FlashcardSessionPage() {
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const courseId = searchParams.get('course') ?? undefined;
  const { user } = useAuth();

  const { data: loaded, loading, error, reload } = useTheorems();
  const theorems = useMemo(() => {
    const all = loaded ?? [];
    const filtered = courseId ? all.filter((t) => t.course_id === courseId) : all;
    return [...filtered].sort(() => Math.random() - 0.5);
  }, [loaded, courseId]);

  const [finished, setFinished] = useState(false);
  const [lastResults, setLastResults] = useState<
    { theorem: TheoremWithMeta; status: ProgressStatus }[]
  >([]);

  useEffect(() => {
    setFinished(false);
    setLastResults([]);
  }, [courseId]);

  const handleRate = useCallback(
    (theorem: TheoremWithMeta, status: ProgressStatus) => {
      if (!user) return;
      const masteredAt = status === 'mastered' ? new Date().toISOString() : null;
      void upsertTheoremProgress(user.id, theorem.id, status, masteredAt).catch(() => {});
    },
    [user],
  );

  if (loading) return <LoadingState label="Preparing flashcards" />;
  if (error) {
    return <ErrorState title="Could not load theorems" message={error.message} onRetry={reload} />;
  }

  if (theorems.length === 0) {
    return (
      <div className="mx-auto max-w-md space-y-4 text-center">
        <p className="text-4xl">🗂️</p>
        <h1 className="font-serif text-2xl font-bold text-stone-900 dark:text-stone-50">
          No theorems yet
        </h1>
        <p className="text-sm text-stone-500 dark:text-stone-400">
          There are no named theorems for this selection yet.
        </p>
        <Button variant="outline" onClick={() => navigate('/theorems')}>
          <Undo2 className="size-4" />
          Back to theorems
        </Button>
      </div>
    );
  }

  if (finished) {
    return (
      <ResultsView
        results={lastResults}
        onDone={() => navigate('/theorems')}
        onReview={() => {
          setFinished(false);
          setLastResults([]);
        }}
      />
    );
  }

  return (
    <div className="mx-auto max-w-2xl space-y-4">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="font-serif text-2xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Theorem Flashcards
          </h1>
          <p className="mt-1 text-sm text-stone-500 dark:text-stone-400">
            Recall each statement, then rate how well you knew it.
          </p>
        </div>
        <Button variant="ghost" size="sm" onClick={() => navigate('/theorems')}>
          <Undo2 className="size-4" />
          Exit
        </Button>
      </div>

      <FlashcardDeck
        theorems={theorems}
        onRate={(theorem, status) => {
          setLastResults((r) => [...r, { theorem, status }]);
          handleRate(theorem, status);
        }}
        onFinish={() => setFinished(true)}
      />
    </div>
  );
}
