import { useCallback } from 'react';
import { getBookmarksForUser, getProgressForUser, getQuestionsWithRelations } from '@/lib/db';
import type { QuestionWithMeta } from '@/types';
import { useAsync } from './useAsync';
import { useAuth } from './useAuth';

/**
 * Loads the full question bank merged with the current student's
 * bookmarks and progress. Filtering/sorting happen client-side.
 */
export function useQuestions() {
  const { user } = useAuth();
  const userId = user?.id ?? null;

  const fn = useCallback(async (): Promise<QuestionWithMeta[]> => {
    if (!userId) return [];
    const [questions, progress, bookmarks] = await Promise.all([
      getQuestionsWithRelations(),
      getProgressForUser(userId),
      getBookmarksForUser(userId),
    ]);
    const progressById = new Map(progress.map((p) => [p.question_id, p]));
    const bookmarkSet = new Set(bookmarks.map((b) => b.question_id));
    return questions.map((q) => ({
      ...q,
      progress: progressById.get(q.id) ?? null,
      bookmarked: bookmarkSet.has(q.id),
    }));
  }, [userId]);

  return useAsync(fn);
}
