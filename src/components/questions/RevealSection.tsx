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

const LEVELS: RevealLevel[] = ['hidden', 'hint', 'answer', 'solution'];

export function RevealSection({
  level,
  onReveal,
  onReset,
  hint,
  answer,
  solution,
  className,
}: RevealSectionProps) {
  const levelIndex = LEVELS.indexOf(level);
  const showHint = levelIndex === LEVELS.indexOf('hint');
  const showAnswer = levelIndex >= LEVELS.indexOf('answer');
  const showSolution = levelIndex >= LEVELS.indexOf('solution');
  const canRevealHint = levelIndex === LEVELS.indexOf('hidden') && !!hint;
  const canRevealAnswer =
    levelIndex === LEVELS.indexOf('hidden') || levelIndex === LEVELS.indexOf('hint');
  const canRevealSolution = levelIndex === LEVELS.indexOf('answer');

  return (
    <div className={cn('space-y-4', className)}>
      <div className="flex flex-wrap items-center gap-2">
        {canRevealHint ? (
          <Button variant="outline" size="sm" onClick={() => onReveal('hint')}>
            Show hint
            <Shortcut label="H" />
          </Button>
        ) : null}
        {canRevealAnswer ? (
          <Button variant="outline" size="sm" onClick={() => onReveal('answer')}>
            Show answer
            <Shortcut label="A" />
          </Button>
        ) : null}
        {canRevealSolution ? (
          <Button variant="outline" size="sm" onClick={() => onReveal('solution')}>
            Show solution
            <Shortcut label="S" />
          </Button>
        ) : null}
        {showSolution ? (
          <Button
            variant="ghost"
            size="sm"
            onClick={() => (onReset ? onReset() : onReveal('hidden'))}
          >
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
