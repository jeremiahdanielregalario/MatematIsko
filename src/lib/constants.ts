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

/** Force users to re-authenticate this long after signing in. */
export const SESSION_LIFETIME_MS = 8 * 60 * 60 * 1000;
export const SESSION_START_KEY = 'matematisko_session_started_at';
export const SESSION_EXPIRED_MESSAGE =
  'Your session has expired. Please sign in again to continue.';

/** Only re-prompt "What would you like to study today?" after a long period of inactivity. */
export const STUDY_PROMPT_IDLE_MS = 4 * 60 * 60 * 1000;
export const STUDY_PROMPT_LAST_ACTIVE_KEY_PREFIX = 'matematisko_study_last_active_v1:';
