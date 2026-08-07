import type { ProgressStatus, QuestionWithMeta, TheoremWithMeta } from '@/types';

export interface QuestionMutationState {
  bookmarks: Record<string, boolean>;
  statuses: Record<string, ProgressStatus>;
  attempts: Record<string, number>;
}

/** Applies optimistic local mutations on top of server-loaded question data. */
export function mergeMutations(
  question: QuestionWithMeta,
  mutations: QuestionMutationState,
): QuestionWithMeta {
  const bookmarked = mutations.bookmarks[question.id] ?? question.bookmarked;
  const status = mutations.statuses[question.id] ?? question.progress?.status ?? 'unseen';
  const attempts = mutations.attempts[question.id] ?? question.progress?.attempts ?? 0;

  return {
    ...question,
    bookmarked,
    progress: {
      user_id: question.progress?.user_id ?? '',
      question_id: question.id,
      status,
      attempts,
      last_attempted_at: question.progress?.last_attempted_at ?? null,
      mastered_at: question.progress?.mastered_at ?? null,
    },
  };
}

/** Applies optimistic local mutations on top of server-loaded theorem data. */
export function mergeTheoremMutations(
  theorem: TheoremWithMeta,
  statuses: Record<string, ProgressStatus>,
): TheoremWithMeta {
  const status = statuses[theorem.id] ?? theorem.progress?.status ?? 'unseen';
  return {
    ...theorem,
    progress: {
      user_id: theorem.progress?.user_id ?? '',
      theorem_id: theorem.id,
      status,
      last_reviewed_at: theorem.progress?.last_reviewed_at ?? null,
      mastered_at: theorem.progress?.mastered_at ?? null,
    },
  };
}
