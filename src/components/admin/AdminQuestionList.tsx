import { Pencil, Trash2 } from 'lucide-react';
import { DifficultyBadge } from '@/components/questions/DifficultyBadge';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/cn';
import type { QuestionWithMeta } from '@/types';

interface AdminQuestionListProps {
  questions: QuestionWithMeta[];
  selectedId: string | null;
  deleting?: boolean;
  onSelect: (question: QuestionWithMeta) => void;
  onDelete: (question: QuestionWithMeta) => void;
}

export function AdminQuestionList({
  questions,
  selectedId,
  deleting = false,
  onSelect,
  onDelete,
}: AdminQuestionListProps) {
  return (
    <ul className="space-y-2">
      {questions.map((question) => {
        const selected = question.id === selectedId;
        return (
          <li key={question.id}>
            <div
              className={cn(
                'group rounded-lg border p-3 transition-colors',
                selected
                  ? 'border-brand-600 bg-brand-50 dark:border-brand-500 dark:bg-brand-950/40'
                  : 'border-stone-200 bg-white hover:bg-stone-50 dark:border-stone-800 dark:bg-stone-900 dark:hover:bg-stone-800/60',
              )}
            >
              <button
                type="button"
                onClick={() => onSelect(question)}
                className="w-full text-left"
                aria-label={`Edit ${question.title}`}
              >
                <p className="line-clamp-1 text-sm font-medium text-stone-900 dark:text-stone-100">
                  {question.title}
                </p>
                <p className="mt-0.5 text-xs text-stone-500 dark:text-stone-400">
                  {question.course?.code ?? '—'} · {question.topic?.name ?? '—'} · {question.year}
                </p>
                <div className="mt-1.5">
                  <DifficultyBadge difficulty={question.difficulty} />
                </div>
              </button>
              <div className="mt-2 flex items-center justify-end gap-1.5">
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => onSelect(question)}
                  className="text-stone-500 dark:text-stone-400"
                >
                  <Pencil className="size-4" />
                  Edit
                </Button>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => onDelete(question)}
                  disabled={deleting}
                  className="text-red-600 hover:bg-red-50 hover:text-red-700 dark:text-red-400 dark:hover:bg-red-950/40 dark:hover:text-red-300"
                >
                  <Trash2 className="size-4" />
                  {deleting ? 'Deleting…' : 'Delete'}
                </Button>
              </div>
            </div>
          </li>
        );
      })}
    </ul>
  );
}
