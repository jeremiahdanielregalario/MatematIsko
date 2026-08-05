import { BookX, RotateCcw, Trophy } from 'lucide-react';
import type { PracticeResultsSummary } from '@/lib/practice';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { ProgressCard } from '@/components/common/ProgressCard';

interface PracticeResultsProps {
  summary: PracticeResultsSummary;
  onPracticeAgain: () => void;
  onReviewMistakes: () => void;
}

export function PracticeResults({
  summary,
  onPracticeAgain,
  onReviewMistakes,
}: PracticeResultsProps) {
  const hasMistakes = summary.reviewIds.length > 0;

  return (
    <div className="mx-auto max-w-2xl space-y-6">
      <Card className="text-center">
        <CardHeader className="items-center">
          <div className="mb-2 grid size-16 place-items-center rounded-full bg-brand-900 text-brand-50 dark:bg-brand-800">
            <Trophy className="size-8" />
          </div>
          <CardTitle className="font-serif text-3xl">Session complete!</CardTitle>
          <CardDescription>
            You answered {summary.attempted} of {summary.total} questions.
          </CardDescription>
        </CardHeader>
        <CardContent>
          <p className="text-6xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {summary.accuracy}
            <span className="text-3xl text-stone-400">%</span>
          </p>
          <p className="mt-1 text-sm text-stone-500 dark:text-stone-400">accuracy</p>
        </CardContent>
      </Card>

      <div className="grid grid-cols-3 gap-4">
        <ProgressCard label="Correct" value={summary.correct} />
        <ProgressCard label="Incorrect" value={summary.incorrect} />
        <ProgressCard label="Not sure" value={summary.unsure} />
      </div>

      <div className="flex flex-col justify-center gap-2 sm:flex-row">
        <Button onClick={onPracticeAgain}>
          <RotateCcw className="size-4" />
          Practice again
        </Button>
        {hasMistakes ? (
          <Button variant="outline" onClick={onReviewMistakes}>
            <BookX className="size-4" />
            Review mistakes ({summary.reviewIds.length})
          </Button>
        ) : null}
      </div>
    </div>
  );
}
