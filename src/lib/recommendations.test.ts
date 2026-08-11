import { describe, expect, it } from 'vitest';
import { getRecommendedQuestions } from './recommendations';
import type { QuestionWithMeta } from '@/types';

function makeQuestion(overrides: Partial<QuestionWithMeta> & { id: string }): QuestionWithMeta {
  return {
    course_id: 'course-1',
    topic_id: 'topic-1',
    title: `Question ${overrides.id}`,
    question_text: 'Solve it.',
    difficulty: 'easy',
    year: 2023,
    exam_name: 'Long Exam 1',
    question_number: 1,
    answer: '4',
    solution: 'Because.',
    hint: 'Try factoring.',
    created_at: '2024-01-01T00:00:00.000Z',
    updated_at: '2024-01-01T00:00:00.000Z',
    course: { id: 'course-1', code: 'MATH 21', name: 'Elementary Analysis I', description: null, created_at: '2024-01-01' },
    topic: { id: 'topic-1', course_id: 'course-1', name: 'Limits', description: null },
    progress: null,
    bookmarked: false,
    ...overrides,
  };
}

const mastered = (id: string, topic = 'topic-1') =>
  makeQuestion({
    id,
    topic_id: topic,
    progress: { user_id: 'u', question_id: id, status: 'mastered', attempts: 2, last_attempted_at: '2025-01-01', mastered_at: '2025-01-01' },
  });

const learning = (id: string, topic = 'topic-1') =>
  makeQuestion({
    id,
    topic_id: topic,
    progress: { user_id: 'u', question_id: id, status: 'learning', attempts: 1, last_attempted_at: '2025-01-01', mastered_at: null },
  });

const unseen = (id: string, topic = 'topic-1', created_at = '2024-01-01') =>
  makeQuestion({ id, topic_id: topic, created_at });

describe('getRecommendedQuestions', () => {
  it('drops mastered questions', () => {
    const result = getRecommendedQuestions([
      mastered('a'),
      unseen('b'),
      learning('c'),
    ]);
    expect(result.map((q) => q.id)).toEqual(['b', 'c']);
  });

  it('surfaces the weakest topic first', () => {
    const result = getRecommendedQuestions([
      unseen('weak-a', 'weak'),
      unseen('weak-b', 'weak'),
      unseen('strong', 'strong'),
      mastered('strong-mastered', 'strong'),
    ]);
    // 'weak' is 100% unmastered, 'strong' is 50% unmastered.
    expect(result.map((q) => q.id)).toEqual(['weak-a', 'weak-b', 'strong']);
  });

  it('puts unseen questions ahead of learning ones within a topic', () => {
    const result = getRecommendedQuestions([
      learning('learn', 'topic-a'),
      unseen('fresh', 'topic-a'),
    ]);
    expect(result.map((q) => q.id)).toEqual(['fresh', 'learn']);
  });

  it('breaks ties with the newest question first', () => {
    const result = getRecommendedQuestions([
      unseen('old', 'topic-a', '2024-01-01'),
      unseen('new', 'topic-a', '2025-01-01'),
    ]);
    expect(result.map((q) => q.id)).toEqual(['new', 'old']);
  });

  it('respects the limit', () => {
    const result = getRecommendedQuestions(
      [unseen('a'), unseen('b'), unseen('c'), unseen('d')],
      2,
    );
    expect(result).toHaveLength(2);
  });

  it('returns an empty list when everything is mastered', () => {
    expect(getRecommendedQuestions([mastered('a'), mastered('b')])).toEqual([]);
  });
});
