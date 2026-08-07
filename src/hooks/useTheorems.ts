import { useCallback } from 'react';
import { getTheoremProgressForUser, getTheorems } from '@/lib/db';
import type { TheoremWithMeta } from '@/types';
import { useAsync } from './useAsync';
import { useAuth } from './useAuth';
import { useCourseScope } from './useCourseScope';

/**
 * Loads named theorems (restricted to the courses the student preselected)
 * merged with the current student's progress.
 */
export function useTheorems() {
  const { user } = useAuth();
  const { courseIds } = useCourseScope();
  const userId = user?.id ?? null;

  const fn = useCallback(async (): Promise<TheoremWithMeta[]> => {
    if (!userId) return [];
    const [theorems, progress] = await Promise.all([
      getTheorems(courseIds ?? undefined),
      getTheoremProgressForUser(userId),
    ]);
    const progressById = new Map(progress.map((p) => [p.theorem_id, p]));
    return theorems.map((theorem) => ({
      ...theorem,
      progress: progressById.get(theorem.id) ?? null,
    }));
  }, [userId, courseIds]);

  return useAsync(fn);
}
