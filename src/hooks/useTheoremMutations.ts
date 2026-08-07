import { useCallback, useRef, useState } from 'react';
import { upsertTheoremProgress } from '@/lib/db';
import type { ProgressStatus, TheoremWithMeta } from '@/types';
import { useAuth } from './useAuth';

export interface TheoremMutations {
  statuses: Record<string, ProgressStatus>;
  setStatus: (theoremId: string, next: ProgressStatus) => void;
}

/**
 * Optimistic mutation for theorem mastery status. The getter is kept in a
 * ref so callbacks stay stable while still reading the latest loaded data.
 */
export function useTheoremMutations(
  getTheorem: (id: string) => TheoremWithMeta | undefined,
): TheoremMutations {
  const { user } = useAuth();
  const getTheoremRef = useRef(getTheorem);
  getTheoremRef.current = getTheorem;

  const [statuses, setStatuses] = useState<Record<string, ProgressStatus>>({});

  const setStatus = useCallback(
    (theoremId: string, next: ProgressStatus) => {
      if (!user) return;
      const theorem = getTheoremRef.current(theoremId);
      setStatuses((current) => ({ ...current, [theoremId]: next }));
      const masteredAt =
        next === 'mastered' ? new Date().toISOString() : null;
      void upsertTheoremProgress(user.id, theoremId, next, masteredAt).catch(() => {
        if (theorem?.progress) {
          setStatuses((current) => ({
            ...current,
            [theoremId]: theorem.progress?.status ?? 'unseen',
          }));
        }
      });
    },
    [user],
  );

  return { statuses, setStatus };
}
