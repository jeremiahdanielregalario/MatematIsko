import { useCallback, useRef, useState } from 'react';
import { setBookmark, upsertProgress } from '@/lib/db';
import type { ProgressStatus, QuestionWithMeta } from '@/types';
import { useAuth } from './useAuth';

export interface QuestionMutations {
  bookmarks: Record<string, boolean>;
  statuses: Record<string, ProgressStatus>;
  attempts: Record<string, number>;
  toggleBookmark: (questionId: string, next: boolean) => void;
  setStatus: (questionId: string, next: ProgressStatus) => void;
  recordAttempt: (questionId: string, correct: boolean) => void;
}

/**
 * Optimistic mutations for bookmarks and progress. The getter is kept in a
 * ref so callbacks stay stable while still reading the latest loaded data.
 */
export function useQuestionMutations(
  getQuestion: (id: string) => QuestionWithMeta | undefined,
): QuestionMutations {
  const { user } = useAuth();
  const getQuestionRef = useRef(getQuestion);
  getQuestionRef.current = getQuestion;

  const [bookmarks, setBookmarks] = useState<Record<string, boolean>>({});
  const [statuses, setStatuses] = useState<Record<string, ProgressStatus>>({});
  const [attempts, setAttempts] = useState<Record<string, number>>({});

  const toggleBookmark = useCallback(
    (questionId: string, next: boolean) => {
      if (!user) return;
      setBookmarks((current) => ({ ...current, [questionId]: next }));
      void setBookmark(user.id, questionId, next).catch(() => {
        setBookmarks((current) => ({ ...current, [questionId]: !next }));
      });
    },
    [user],
  );

  const setStatus = useCallback(
    (questionId: string, next: ProgressStatus) => {
      if (!user) return;
      setStatuses((current) => ({ ...current, [questionId]: next }));
      const currentQuestion = getQuestionRef.current(questionId);
      const baseAttempts = currentQuestion?.progress?.attempts ?? 0;
      void upsertProgress(
        user.id,
        questionId,
        next,
        next === 'unseen' ? baseAttempts : Math.max(1, baseAttempts),
        next === 'mastered' ? new Date().toISOString() : null,
      ).catch(() => {
        setStatuses((current) => {
          const nextState = { ...current };
          delete nextState[questionId];
          return nextState;
        });
      });
    },
    [user],
  );

  const recordAttempt = useCallback(
    (questionId: string, correct: boolean) => {
      if (!user) return;
      const currentQuestion = getQuestionRef.current(questionId);
      const base = currentQuestion?.progress;
      const baseAttempts = base?.attempts ?? 0;
      const nextAttempts = baseAttempts + 1;
      const nextStatus: ProgressStatus = correct ? 'mastered' : 'learning';

      setStatuses((current) => ({ ...current, [questionId]: nextStatus }));
      setAttempts((current) => ({ ...current, [questionId]: nextAttempts }));

      void upsertProgress(
        user.id,
        questionId,
        nextStatus,
        nextAttempts,
        correct ? new Date().toISOString() : null,
      ).catch(() => {
        // Silently revert on failure; the next reload corrects state.
      });
    },
    [user],
  );

  return { bookmarks, statuses, attempts, toggleBookmark, setStatus, recordAttempt };
}
