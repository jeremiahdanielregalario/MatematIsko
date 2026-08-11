import type { QuestionWithMeta } from '@/types';

export const RECOMMENDATION_LIMIT = 6;

/**
 * Picks questions a student should study next: mastered problems are dropped,
 * and the rest are spread across as many different courses as possible.
 * Within a course, questions are ordered by weakest topic first (highest share
 * of unmastered questions), with unseen problems ahead of in-progress ones and
 * newest questions breaking ties. The weakest courses lead the rotation.
 */
export function getRecommendedQuestions(
  questions: QuestionWithMeta[],
  limit: number = RECOMMENDATION_LIMIT,
): QuestionWithMeta[] {
  const topicUnmastered = new Map<string, number>();
  const topicTotal = new Map<string, number>();
  const courseUnmastered = new Map<string, number>();
  const courseTotal = new Map<string, number>();

  for (const q of questions) {
    topicTotal.set(q.topic_id, (topicTotal.get(q.topic_id) ?? 0) + 1);
    courseTotal.set(q.course_id, (courseTotal.get(q.course_id) ?? 0) + 1);
    if (q.progress?.status !== 'mastered') {
      topicUnmastered.set(q.topic_id, (topicUnmastered.get(q.topic_id) ?? 0) + 1);
      courseUnmastered.set(q.course_id, (courseUnmastered.get(q.course_id) ?? 0) + 1);
    }
  }

  const weaknessOf = (q: QuestionWithMeta): number => {
    const total = topicTotal.get(q.topic_id) ?? 1;
    const unmastered = topicUnmastered.get(q.topic_id) ?? 0;
    return unmastered / total;
  };

  const courseWeakness = (courseId: string): number => {
    const total = courseTotal.get(courseId) ?? 1;
    const unmastered = courseUnmastered.get(courseId) ?? 0;
    return unmastered / total;
  };

  const statusRank = (q: QuestionWithMeta): number =>
    (q.progress?.status ?? 'unseen') === 'unseen' ? 0 : 1;

  const candidatesByCourse = new Map<string, QuestionWithMeta[]>();
  for (const q of questions) {
    if (q.progress?.status === 'mastered') continue;
    const list = candidatesByCourse.get(q.course_id) ?? [];
    list.push(q);
    candidatesByCourse.set(q.course_id, list);
  }

  const courses = [...candidatesByCourse.entries()]
    .map(([courseId, list]) => ({
      courseId,
      weakness: courseWeakness(courseId),
      list: list.sort((a, b) => {
        const byWeakness = weaknessOf(b) - weaknessOf(a);
        if (byWeakness !== 0) return byWeakness;
        const byStatus = statusRank(a) - statusRank(b);
        if (byStatus !== 0) return byStatus;
        return b.created_at.localeCompare(a.created_at);
      }),
    }))
    .sort(
      (a, b) =>
        b.weakness - a.weakness ||
        a.courseId.localeCompare(b.courseId),
    );

  const result: QuestionWithMeta[] = [];
  let progressed = true;
  while (result.length < limit && progressed) {
    progressed = false;
    for (const course of courses) {
      if (result.length >= limit) break;
      const next = course.list.shift();
      if (next) {
        result.push(next);
        progressed = true;
      }
    }
  }
  return result;
}
