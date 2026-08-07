import { Pencil, Trash2 } from 'lucide-react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { cn } from '@/lib/cn';
import type { TheoremWithRelations } from '@/types';

interface AdminTheoremListProps {
  theorems: TheoremWithRelations[];
  selectedId: string | null;
  deleting?: boolean;
  onSelect: (theorem: TheoremWithRelations) => void;
  onDelete: (theorem: TheoremWithRelations) => void;
}

export function AdminTheoremList({
  theorems,
  selectedId,
  deleting = false,
  onSelect,
  onDelete,
}: AdminTheoremListProps) {
  return (
    <ul className="space-y-2">
      {theorems.map((theorem) => {
        const selected = theorem.id === selectedId;
        return (
          <li key={theorem.id}>
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
                onClick={() => onSelect(theorem)}
                className="w-full text-left"
                aria-label={`Edit ${theorem.name}`}
              >
                <p className="text-sm font-medium text-stone-900 dark:text-stone-100">
                  <MathRenderer inline>{theorem.name}</MathRenderer>
                </p>
                <p className="mt-0.5 flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
                  <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
                    {theorem.course?.code ?? '—'}
                  </span>
                  <span>{theorem.topic?.name ?? '—'}</span>
                  {theorem.reference ? (
                    <Badge variant="outline" className="font-mono">
                      {theorem.reference}
                    </Badge>
                  ) : null}
                </p>
              </button>
              <div className="mt-2 flex items-center justify-end gap-1.5">
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => onSelect(theorem)}
                  className="text-stone-500 dark:text-stone-400"
                >
                  <Pencil className="size-4" />
                  Edit
                </Button>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => onDelete(theorem)}
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
