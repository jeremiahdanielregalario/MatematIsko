import { useCallback } from 'react';
import { getTheoremById, getTheoremProgressForUser } from '@/lib/db';
import type { TheoremWithMeta } from '@/types';
import { useAsync } from './useAsync';
import { useAuth } from './useAuth';
import { useCourseScope } from './useCourseScope';

/**
 * Loads a single named theorem merged with the current student's progress.
 */
export function useTheorem(id: string | undefined) {
  const { user } = useAuth();
  const { courseIds } = useCourseScope();
  const userId = user?.id ?? null;

  const fn = useCallback(async (): Promise<TheoremWithMeta | null> => {
    if (!id) return null;
    if (!userId) return null;
    const [theorem, progress] = await Promise.all([
      getTheoremById(id, courseIds ?? undefined),
      getTheoremProgressForUser(userId),
    ]);
    if (!theorem) return null;
    return {
      ...theorem,
      progress: progress.find((p) => p.theorem_id === theorem.id) ?? null,
    };
  }, [id, userId, courseIds]);

  return useAsync(fn);
}
