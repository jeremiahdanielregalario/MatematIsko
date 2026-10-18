import { useCallback, useRef, useState } from 'react';
import { setBookmark, upsertProgress } from '@/lib/db';
import type { ProgressStatus, QuestionWithMeta } from '@/types';
import { useAuth } from './useAuth';

export interface QuestionMutations {
  bookmarks: Record<string, boolean>;
  statuses: Record<string, ProgressStatus>;
  attempts: Record<string, number>;
  lastAttemptedAt: Record<string, string | null>;
  masteredAt: Record<string, string | null>;
  lastError: string | null;
  clearError: () => void;
  toggleBookmark: (questionId: string, next: boolean) => void;
  setStatus: (questionId: string, next: ProgressStatus) => void;
  recordAttempt: (questionId: string, correct: boolean) => void;
}

function restoreKey<T>(
  record: Record<string, T>,
  key: string,
  hadPrev: boolean,
  prevValue: T,
): Record<string, T> {
  const next = { ...record };
  if (hadPrev) {
    next[key] = prevValue;
  } else {
    delete next[key];
  }
  return next;
}

/**
 * Optimistic mutations for bookmarks and progress. The getter and latest
 * optimistic overlays are kept in refs so rapid or repeated calls always read
 * current attempt counts and cleanly roll back on failure.
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
  const [lastAttemptedAt, setLastAttemptedAt] = useState<Record<string, string | null>>({});
  const [masteredAt, setMasteredAt] = useState<Record<string, string | null>>({});
  const [lastError, setLastError] = useState<string | null>(null);

  const bookmarksRef = useRef<Record<string, boolean>>({});
  const statusesRef = useRef<Record<string, ProgressStatus>>({});
  const attemptsRef = useRef<Record<string, number>>({});
  const lastAttemptedRef = useRef<Record<string, string | null>>({});
  const masteredRef = useRef<Record<string, string | null>>({});

  const clearError = useCallback(() => setLastError(null), []);

  const toggleBookmark = useCallback(
    (questionId: string, next: boolean) => {
      if (!user) return;
      const hadPrev = Object.hasOwn(bookmarksRef.current, questionId);
      const prevValue = bookmarksRef.current[questionId];

      bookmarksRef.current = { ...bookmarksRef.current, [questionId]: next };
      setBookmarks(bookmarksRef.current);
      setLastError(null);

      void setBookmark(user.id, questionId, next).catch((err: unknown) => {
        bookmarksRef.current = restoreKey(bookmarksRef.current, questionId, hadPrev, prevValue);
        setBookmarks(bookmarksRef.current);
        setLastError(err instanceof Error ? err.message : 'Could not update bookmark.');
      });
    },
    [user],
  );

  const setStatus = useCallback(
    (questionId: string, next: ProgressStatus) => {
      if (!user) return;
      const currentQuestion = getQuestionRef.current(questionId);
      const baseAttempts =
        attemptsRef.current[questionId] ?? currentQuestion?.progress?.attempts ?? 0;
      const nextAttempts = next === 'unseen' ? baseAttempts : Math.max(1, baseAttempts);
      const nextMasteredAt = next === 'mastered' ? new Date().toISOString() : null;

      const hadPrevStatus = Object.hasOwn(statusesRef.current, questionId);
      const prevStatus = statusesRef.current[questionId];
      const hadPrevAttempts = Object.hasOwn(attemptsRef.current, questionId);
      const prevAttempts = attemptsRef.current[questionId];
      const hadPrevMastered = Object.hasOwn(masteredRef.current, questionId);
      const prevMastered = masteredRef.current[questionId];

      statusesRef.current = { ...statusesRef.current, [questionId]: next };
      attemptsRef.current = { ...attemptsRef.current, [questionId]: nextAttempts };
      masteredRef.current = { ...masteredRef.current, [questionId]: nextMasteredAt };

      setStatuses(statusesRef.current);
      setAttempts(attemptsRef.current);
      setMasteredAt(masteredRef.current);
      setLastError(null);

      void upsertProgress(user.id, questionId, next, nextAttempts, nextMasteredAt).catch(
        (err: unknown) => {
          statusesRef.current = restoreKey(
            statusesRef.current,
            questionId,
            hadPrevStatus,
            prevStatus,
          );
          attemptsRef.current = restoreKey(
            attemptsRef.current,
            questionId,
            hadPrevAttempts,
            prevAttempts,
          );
          masteredRef.current = restoreKey(
            masteredRef.current,
            questionId,
            hadPrevMastered,
            prevMastered,
          );
          setStatuses(statusesRef.current);
          setAttempts(attemptsRef.current);
          setMasteredAt(masteredRef.current);
          setLastError(err instanceof Error ? err.message : 'Could not save mastery status.');
        },
      );
    },
    [user],
  );

  const recordAttempt = useCallback(
    (questionId: string, correct: boolean) => {
      if (!user) return;
      const currentQuestion = getQuestionRef.current(questionId);
      const baseAttempts =
        attemptsRef.current[questionId] ?? currentQuestion?.progress?.attempts ?? 0;
      const nextAttempts = baseAttempts + 1;
      const nextStatus: ProgressStatus = correct ? 'mastered' : 'learning';
      const now = new Date().toISOString();
      const nextMasteredAt = correct ? now : null;

      const hadPrevStatus = Object.hasOwn(statusesRef.current, questionId);
      const prevStatus = statusesRef.current[questionId];
      const hadPrevAttempts = Object.hasOwn(attemptsRef.current, questionId);
      const prevAttempts = attemptsRef.current[questionId];
      const hadPrevAttemptedAt = Object.hasOwn(lastAttemptedRef.current, questionId);
      const prevAttemptedAt = lastAttemptedRef.current[questionId];
      const hadPrevMastered = Object.hasOwn(masteredRef.current, questionId);
      const prevMastered = masteredRef.current[questionId];

      statusesRef.current = { ...statusesRef.current, [questionId]: nextStatus };
      attemptsRef.current = { ...attemptsRef.current, [questionId]: nextAttempts };
      lastAttemptedRef.current = { ...lastAttemptedRef.current, [questionId]: now };
      masteredRef.current = { ...masteredRef.current, [questionId]: nextMasteredAt };

      setStatuses(statusesRef.current);
      setAttempts(attemptsRef.current);
      setLastAttemptedAt(lastAttemptedRef.current);
      setMasteredAt(masteredRef.current);
      setLastError(null);

      void upsertProgress(user.id, questionId, nextStatus, nextAttempts, nextMasteredAt).catch(
        (err: unknown) => {
          statusesRef.current = restoreKey(
            statusesRef.current,
            questionId,
            hadPrevStatus,
            prevStatus,
          );
          attemptsRef.current = restoreKey(
            attemptsRef.current,
            questionId,
            hadPrevAttempts,
            prevAttempts,
          );
          lastAttemptedRef.current = restoreKey(
            lastAttemptedRef.current,
            questionId,
            hadPrevAttemptedAt,
            prevAttemptedAt,
          );
          masteredRef.current = restoreKey(
            masteredRef.current,
            questionId,
            hadPrevMastered,
            prevMastered,
          );
          setStatuses(statusesRef.current);
          setAttempts(attemptsRef.current);
          setLastAttemptedAt(lastAttemptedRef.current);
          setMasteredAt(masteredRef.current);
          setLastError(err instanceof Error ? err.message : 'Could not record attempt.');
        },
      );
    },
    [user],
  );

  return {
    bookmarks,
    statuses,
    attempts,
    lastAttemptedAt,
    masteredAt,
    lastError,
    clearError,
    toggleBookmark,
    setStatus,
    recordAttempt,
  };
}
