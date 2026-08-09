import { ArrowUpRight, Landmark } from 'lucide-react';
import { Link } from 'react-router-dom';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Badge } from '@/components/ui/badge';
import { Card } from '@/components/ui/card';
import { MasteryButton } from '@/components/questions/MasteryButton';
import { cn } from '@/lib/cn';
import type { ProgressStatus, TheoremWithMeta } from '@/types';

interface TheoremCardProps {
  theorem: TheoremWithMeta;
  onSetStatus: (theoremId: string, status: ProgressStatus) => void;
  className?: string;
}

export function TheoremCard({ theorem, onSetStatus, className }: TheoremCardProps) {
  const status = theorem.progress?.status ?? 'unseen';

  return (
    <Card
      className={cn(
        'group relative flex flex-col gap-3 p-5 transition-all duration-200 hover:-translate-y-1 hover:shadow-md',
        'focus-within:outline-2 focus-within:outline-offset-2 focus-within:outline-brand-600',
        className,
      )}
    >
      <div className="flex items-start justify-between gap-2">
        <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
          <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
            {theorem.course?.code ?? '—'}
          </span>
          <span>{theorem.topic?.name}</span>
          {theorem.reference ? (
            <Badge variant="outline" className="font-mono">
              {theorem.reference}
            </Badge>
          ) : null}
        </div>
        <ArrowUpRight className="size-4 text-stone-300 transition-transform group-hover:-translate-y-0.5 group-hover:translate-x-0.5 group-hover:text-brand-600 dark:text-stone-600" />
      </div>

      <div className="flex-1">
        <MathRenderer preview inline>{theorem.name}</MathRenderer>
      </div>

      <div className="flex items-center justify-between gap-2">
        <Link
          to={`/theorems/${theorem.id}`}
          className="inline-flex items-center gap-1.5 text-sm font-medium text-brand-700 hover:text-brand-800 hover:underline dark:text-brand-400 dark:hover:text-brand-300"
        >
          <Landmark className="size-4" />
          View theorem
        </Link>
        <MasteryButton
          status={status}
          onChange={(next) => onSetStatus(theorem.id, next)}
        />
      </div>
    </Card>
  );
}
