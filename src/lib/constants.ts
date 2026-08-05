import type { Difficulty, ProgressStatus } from '@/types';

export const DIFFICULTY_LABELS: Record<Difficulty, string> = {
  easy: 'Easy',
  medium: 'Medium',
  hard: 'Hard',
};

export const STATUS_LABELS: Record<ProgressStatus, string> = {
  unseen: 'Unseen',
  learning: 'Learning',
  mastered: 'Mastered',
};
