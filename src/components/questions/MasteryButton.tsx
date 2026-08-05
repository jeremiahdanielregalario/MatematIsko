import type { ProgressStatus } from '@/types';
import { cn } from '@/lib/cn';

interface MasteryButtonProps {
  status: ProgressStatus;
  onChange: (status: ProgressStatus) => void;
}

const OPTIONS: { value: ProgressStatus; label: string; active: string }[] = [
  {
    value: 'learning',
    label: 'Learning',
    active: 'bg-amber-100 text-amber-800 dark:bg-amber-950 dark:text-amber-300',
  },
  {
    value: 'mastered',
    label: 'Mastered',
    active: 'bg-emerald-100 text-emerald-800 dark:bg-emerald-950 dark:text-emerald-300',
  },
];

export function MasteryButton({ status, onChange }: MasteryButtonProps) {
  return (
    <div
      role="group"
      aria-label="Mastery status"
      className="inline-flex items-center rounded-lg border border-stone-200 bg-stone-50 p-0.5 dark:border-stone-800 dark:bg-stone-900"
    >
      {OPTIONS.map((option) => {
        const active = status === option.value;
        return (
          <button
            key={option.value}
            type="button"
            aria-pressed={active}
            onClick={(event) => {
              event.preventDefault();
              event.stopPropagation();
              onChange(active ? 'unseen' : option.value);
            }}
            className={cn(
              'rounded-md px-3 py-1 text-xs font-medium transition-colors',
              'focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
              active ? option.active : 'text-stone-500 hover:text-stone-800 dark:text-stone-400 dark:hover:text-stone-200',
            )}
          >
            {option.label}
          </button>
        );
      })}
    </div>
  );
}
