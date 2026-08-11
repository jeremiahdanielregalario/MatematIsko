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

  it('spreads recommendations across as many courses as possible', () => {
    const result = getRecommendedQuestions([
      unseen('a1', 'topic-1', '2024-01-01'),
      unseen('b1', 'topic-1', '2024-01-01'),
      unseen('c1', 'topic-1', '2024-01-01'),
      unseen('a2', 'topic-1', '2024-01-02'),
      unseen('b2', 'topic-1', '2024-01-02'),
      unseen('c2', 'topic-1', '2024-01-02'),
    ].map((q, index) => {
      const courses = ['course-a', 'course-b', 'course-c'];
      return {
        ...q,
        course_id: courses[index % 3],
        topic_id: `topic-${index % 3}`,
        course: {
          id: courses[index % 3],
          code: courses[index % 3].toUpperCase(),
          name: courses[index % 3],
          description: null,
          created_at: '2024-01-01',
        },
        topic: {
          id: `topic-${index % 3}`,
          course_id: courses[index % 3],
          name: `Topic ${index % 3}`,
          description: null,
        },
      };
    }));
    expect(result.map((q) => q.id)).toEqual(['a2', 'b2', 'c2', 'a1', 'b1', 'c1']);
  });

  it('fills extra slots from courses with more questions after a balanced rotation', () => {
    const courseA = {
      id: 'course-a',
      code: 'A',
      name: 'Course A',
      description: null,
      created_at: '2024-01-01',
    };
    const courseB = {
      id: 'course-b',
      code: 'B',
      name: 'Course B',
      description: null,
      created_at: '2024-01-01',
    };
    const question = (id: string, courseId: string, topicId: string) =>
      makeQuestion({
        id,
        course_id: courseId,
        topic_id: topicId,
        course: courseId === 'course-a' ? courseA : courseB,
        topic: { id: topicId, course_id: courseId, name: topicId, description: null },
      });
    const result = getRecommendedQuestions([
      question('a1', 'course-a', 'topic-a'),
      question('a2', 'course-a', 'topic-a'),
      question('b1', 'course-b', 'topic-b'),
      question('b2', 'course-b', 'topic-b'),
      question('b3', 'course-b', 'topic-b'),
    ]);
    expect(result.map((q) => q.id)).toEqual(['a1', 'b1', 'a2', 'b2', 'b3']);
  });
});
