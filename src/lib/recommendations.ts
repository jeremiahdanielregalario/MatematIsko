import type { QuestionWithMeta } from '@/types';

export const RECOMMENDATION_LIMIT = 6;

/**
 * Picks questions a student should study next: mastered problems are dropped,
 * and the rest are ordered by weakest topic first (highest share of unmastered
 * questions), with unseen problems ahead of in-progress ones within a topic.
 * Newest questions break ties so recommendations stay fresh.
 */
export function getRecommendedQuestions(
  questions: QuestionWithMeta[],
  limit: number = RECOMMENDATION_LIMIT,
): QuestionWithMeta[] {
  const topicUnmastered = new Map<string, number>();
  const topicTotal = new Map<string, number>();

  for (const q of questions) {
    topicTotal.set(q.topic_id, (topicTotal.get(q.topic_id) ?? 0) + 1);
    if (q.progress?.status !== 'mastered') {
      topicUnmastered.set(q.topic_id, (topicUnmastered.get(q.topic_id) ?? 0) + 1);
    }
  }

  const weaknessOf = (q: QuestionWithMeta): number => {
    const total = topicTotal.get(q.topic_id) ?? 1;
    const unmastered = topicUnmastered.get(q.topic_id) ?? 0;
    return unmastered / total;
  };

  const statusRank = (q: QuestionWithMeta): number =>
    (q.progress?.status ?? 'unseen') === 'unseen' ? 0 : 1;

  return questions
    .filter((q) => q.progress?.status !== 'mastered')
    .sort((a, b) => {
      const byWeakness = weaknessOf(b) - weaknessOf(a);
      if (byWeakness !== 0) return byWeakness;
      const byStatus = statusRank(a) - statusRank(b);
      if (byStatus !== 0) return byStatus;
      return b.created_at.localeCompare(a.created_at);
    })
    .slice(0, limit);
}
