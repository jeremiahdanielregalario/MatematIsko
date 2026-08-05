import type { QuestionWithMeta } from '@/types';

export interface TopicStat {
  topicId: string;
  topicName: string;
  courseCode: string;
  total: number;
  mastered: number;
  masteryPercent: number;
}

export interface StudyStats {
  total: number;
  completed: number;
  mastered: number;
  learning: number;
  unseen: number;
  bookmarked: number;
  masteryRate: number | null;
  byTopic: TopicStat[];
}

export function computeStats(questions: QuestionWithMeta[]): StudyStats {
  const total = questions.length;
  let mastered = 0;
  let learning = 0;
  let bookmarked = 0;

  const topicMap = new Map<string, TopicStat>();

  for (const q of questions) {
    const status = q.progress?.status ?? 'unseen';
    if (status === 'mastered') mastered += 1;
    if (status === 'learning') learning += 1;
    if (q.bookmarked) bookmarked += 1;

    const topicId = q.topic_id;
    const entry = topicMap.get(topicId) ?? {
      topicId,
      topicName: q.topic?.name ?? 'Uncategorized',
      courseCode: q.course?.code ?? '—',
      total: 0,
      mastered: 0,
      masteryPercent: 0,
    };
    entry.total += 1;
    if (status === 'mastered') entry.mastered += 1;
    topicMap.set(topicId, entry);
  }

  const completed = mastered + learning;
  const byTopic = [...topicMap.values()]
    .map((t) => ({
      ...t,
      masteryPercent: t.total === 0 ? 0 : Math.round((t.mastered / t.total) * 100),
    }))
    .sort((a, b) => b.total - a.total);

  return {
    total,
    completed,
    mastered,
    learning,
    unseen: total - completed,
    bookmarked,
    masteryRate: completed === 0 ? null : Math.round((mastered / completed) * 100),
    byTopic,
  };
}
