import { useCallback, useRef, useState } from 'react';
import { upsertTheoremProgress } from '@/lib/db';
import type { ProgressStatus, TheoremWithMeta } from '@/types';
import { useAuth } from './useAuth';

export interface TheoremMutations {
  statuses: Record<string, ProgressStatus>;
  lastError: string | null;
  clearError: () => void;
  setStatus: (theoremId: string, next: ProgressStatus) => void;
}

/**
 * Optimistic mutation for theorem mastery status. Keeps prior overlay state in
 * a ref so failed writes cleanly roll back even when a theorem had no prior
 * progress row (`unseen`).
 */
export function useTheoremMutations(
  getTheorem: (id: string) => TheoremWithMeta | undefined,
): TheoremMutations {
  const { user } = useAuth();
  const getTheoremRef = useRef(getTheorem);
  getTheoremRef.current = getTheorem;

  const [statuses, setStatuses] = useState<Record<string, ProgressStatus>>({});
  const [lastError, setLastError] = useState<string | null>(null);
  const statusesRef = useRef<Record<string, ProgressStatus>>({});

  const clearError = useCallback(() => setLastError(null), []);

  const setStatus = useCallback(
    (theoremId: string, next: ProgressStatus) => {
      if (!user) return;
      const hadPrev = Object.hasOwn(statusesRef.current, theoremId);
      const prevStatus = statusesRef.current[theoremId];

      statusesRef.current = { ...statusesRef.current, [theoremId]: next };
      setStatuses(statusesRef.current);
      setLastError(null);

      const masteredAt = next === 'mastered' ? new Date().toISOString() : null;
      void upsertTheoremProgress(user.id, theoremId, next, masteredAt).catch((err: unknown) => {
        const reverted = { ...statusesRef.current };
        if (hadPrev) {
          reverted[theoremId] = prevStatus;
        } else {
          delete reverted[theoremId];
        }
        statusesRef.current = reverted;
        setStatuses(reverted);
        setLastError(err instanceof Error ? err.message : 'Could not save theorem status.');
      });
    },
    [user],
  );

  return { statuses, lastError, clearError, setStatus };
}
