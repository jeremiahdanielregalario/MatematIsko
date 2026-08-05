import type { Difficulty } from '@/types';
import { DIFFICULTY_LABELS } from '@/lib/constants';
import { Badge, type BadgeProps } from '@/components/ui/badge';

const DIFFICULTY_VARIANT: Record<Difficulty, BadgeProps['variant']> = {
  easy: 'success',
  medium: 'warning',
  hard: 'destructive',
};

export function DifficultyBadge({ difficulty, className }: { difficulty: Difficulty; className?: string }) {
  return (
    <Badge variant={DIFFICULTY_VARIANT[difficulty]} className={className}>
      {DIFFICULTY_LABELS[difficulty]}
    </Badge>
  );
}
