import { Quote } from 'lucide-react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Card } from '@/components/ui/card';
import type { TheoremWithMeta } from '@/types';

interface TheoremStatementProps {
  theorem: TheoremWithMeta;
  className?: string;
}

/** Renders a theorem's statement and (optional) formal notation. */
export function TheoremStatement({ theorem, className }: TheoremStatementProps) {
  return (
    <div className={className}>
      <Card className="p-5">
        <div className="mb-3 flex items-center gap-2 text-xs font-medium uppercase tracking-wide text-stone-400 dark:text-stone-500">
          <Quote className="size-3.5" />
          Statement
        </div>
        <div className="prose prose-stone max-w-none dark:prose-invert">
          <MathRenderer>{theorem.statement}</MathRenderer>
        </div>
      </Card>

      {theorem.formal_notation ? (
        <Card className="mt-4 p-5">
          <div className="mb-3 flex items-center gap-2 text-xs font-medium uppercase tracking-wide text-stone-400 dark:text-stone-500">
            <span className="size-1.5 rounded-full bg-brand-600" />
            Formal notation
          </div>
          <div className="prose prose-stone max-w-none dark:prose-invert">
            <MathRenderer>{theorem.formal_notation}</MathRenderer>
          </div>
        </Card>
      ) : null}
    </div>
  );
}
