import { EyeOff } from 'lucide-react';
import type { RevealLevel } from '@/hooks/useReveal';
import { cn } from '@/lib/cn';
import { Button } from '@/components/ui/button';
import { HintPanel, AnswerPanel, SolutionPanel } from './RevealPanels';

interface RevealSectionProps {
  level: RevealLevel;
  onReveal: (level: RevealLevel) => void;
  onReset?: () => void;
  hint: string | null;
  answer: string;
  solution: string;
  className?: string;
}

function Shortcut({ label }: { label: string }) {
  return (
    <kbd className="ml-1 rounded border border-stone-300 bg-stone-100 px-1.5 py-0.5 font-mono text-[10px] font-medium text-stone-500 dark:border-stone-700 dark:bg-stone-800 dark:text-stone-400">
      {label}
    </kbd>
  );
}

export function RevealSection({
  level,
  onReveal,
  onReset,
  hint,
  answer,
  solution,
  className,
}: RevealSectionProps) {
  const showHint = level === 'hint' || level === 'answer' || level === 'solution';
  const showAnswer = level === 'answer' || level === 'solution';
  const showSolution = level === 'solution';

  return (
    <div className={cn('space-y-4', className)}>
      <div className="flex flex-wrap items-center gap-2">
        {!showHint && hint ? (
          <Button variant="outline" size="sm" onClick={() => onReveal('hint')}>
            Show hint
            <Shortcut label="H" />
          </Button>
        ) : null}
        {!showAnswer ? (
          <Button variant="outline" size="sm" onClick={() => onReveal('answer')}>
            Show answer
            <Shortcut label="A" />
          </Button>
        ) : null}
        {!showSolution ? (
          <Button variant="outline" size="sm" onClick={() => onReveal('solution')}>
            Show solution
            <Shortcut label="S" />
          </Button>
        ) : null}
        {showSolution ? (
          <Button variant="ghost" size="sm" onClick={() => (onReset ? onReset() : onReveal('hidden'))}>
            <EyeOff className="size-4" />
            Hide all
          </Button>
        ) : null}
      </div>

      {showHint && hint ? <HintPanel hint={hint} /> : null}
      {showAnswer ? <AnswerPanel answer={answer} /> : null}
      {showSolution ? <SolutionPanel solution={solution} /> : null}
    </div>
  );
}
