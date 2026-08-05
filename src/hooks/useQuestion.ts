import { useCallback } from 'react';
import { getBookmarksForUser, getProgressForUser, getQuestionById } from '@/lib/db';
import type { QuestionWithMeta } from '@/types';
import { useAsync } from './useAsync';
import { useAuth } from './useAuth';

export function useQuestion(id: string | undefined) {
  const { user } = useAuth();
  const userId = user?.id ?? null;

  const fn = useCallback(async (): Promise<QuestionWithMeta | null> => {
    if (!id) return null;
    const [question, progress, bookmarks] = await Promise.all([
      getQuestionById(id),
      userId ? getProgressForUser(userId) : Promise.resolve([]),
      userId ? getBookmarksForUser(userId) : Promise.resolve([]),
    ]);
    if (!question) return null;
    return {
      ...question,
      progress: progress.find((p) => p.question_id === id) ?? null,
      bookmarked: bookmarks.some((b) => b.question_id === id),
    };
  }, [id, userId]);

  return useAsync(fn);
}
