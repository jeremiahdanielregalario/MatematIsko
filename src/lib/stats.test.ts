import { describe, expect, it } from 'vitest';
import { computeStats } from './stats';
import type { QuestionWithMeta } from '@/types';

function makeQuestion(id: string, topic: string, status: 'unseen' | 'learning' | 'mastered', bookmarked = false): QuestionWithMeta {
  return {
    id,
    course_id: 'c1',
    topic_id: topic,
    title: `Q ${id}`,
    question_text: 'text',
    difficulty: 'medium',
    year: 2023,
    exam_name: 'LE1',
    question_number: 1,
    answer: 'a',
    solution: 's',
    hint: null,
    created_at: '2024-01-01',
    updated_at: '2024-01-01',
    course: { id: 'c1', code: 'MATH 21', name: 'Analysis', description: null, created_at: '2024-01-01' },
    topic: { id: topic, course_id: 'c1', name: `Topic ${topic}`, description: null },
    progress:
      status === 'unseen'
        ? null
        : { user_id: 'u', question_id: id, status, attempts: 1, last_attempted_at: '2025-01-01', mastered_at: status === 'mastered' ? '2025-01-01' : null },
    bookmarked,
  };
}

describe('computeStats', () => {
  it('returns zeros for an empty bank', () => {
    const stats = computeStats([]);
    expect(stats).toMatchObject({ total: 0, mastered: 0, learning: 0, unseen: 0, bookmarked: 0, masteryRate: null, byTopic: [] });
  });

  it('counts statuses across questions', () => {
    const stats = computeStats([
      makeQuestion('1', 't1', 'mastered'),
      makeQuestion('2', 't1', 'learning'),
      makeQuestion('3', 't2', 'mastered'),
      makeQuestion('4', 't2', 'unseen', true),
    ]);
    expect(stats.total).toBe(4);
    expect(stats.mastered).toBe(2);
    expect(stats.learning).toBe(1);
    expect(stats.unseen).toBe(1);
    expect(stats.bookmarked).toBe(1);
    expect(stats.completed).toBe(3);
    expect(stats.masteryRate).toBe(67);
  });

  it('reports null mastery when nothing has been attempted', () => {
    const stats = computeStats([makeQuestion('1', 't1', 'unseen')]);
    expect(stats.masteryRate).toBeNull();
  });

  it('groups mastery by topic', () => {
    const stats = computeStats([
      makeQuestion('1', 't1', 'mastered'),
      makeQuestion('2', 't1', 'mastered'),
      makeQuestion('3', 't1', 'unseen'),
      makeQuestion('4', 't2', 'mastered'),
    ]);
    const topic1 = stats.byTopic.find((t) => t.topicId === 't1');
    expect(topic1).toMatchObject({ total: 3, mastered: 2, masteryPercent: 67 });
  });
});
