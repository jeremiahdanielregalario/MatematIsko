import { describe, expect, it } from 'vitest';
import { applyFilterAndSort, pickRandom } from './questionFilter';
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

const QUESTIONS: QuestionWithMeta[] = [
  makeQuestion({
    id: 'a',
    title: 'Limit basics',
    difficulty: 'easy',
    year: 2023,
    bookmarked: true,
    progress: { user_id: 'u', question_id: 'a', status: 'mastered', attempts: 3, last_attempted_at: '2025-01-03', mastered_at: '2025-01-03' },
    created_at: '2024-01-01',
  }),
  makeQuestion({
    id: 'b',
    title: 'Partial fractions',
    question_text: 'Integrate by partial fractions with difficult algebra',
    difficulty: 'hard',
    year: 2024,
    progress: { user_id: 'u', question_id: 'b', status: 'learning', attempts: 1, last_attempted_at: '2025-02-01', mastered_at: null },
    created_at: '2024-02-01',
  }),
  makeQuestion({
    id: 'c',
    title: 'Derivative rules',
    difficulty: 'medium',
    year: 2023,
    progress: null,
    created_at: '2024-03-01',
  }),
];

describe('applyFilterAndSort', () => {
  it('returns all questions with no filters', () => {
    const result = applyFilterAndSort(QUESTIONS, {});
    expect(result).toHaveLength(3);
  });

  it('filters by search across title and text', () => {
    const byTitle = applyFilterAndSort(QUESTIONS, { search: 'partial' });
    expect(byTitle.map((q) => q.id)).toEqual(['b']);

    const byText = applyFilterAndSort(QUESTIONS, { search: 'difficult algebra' });
    expect(byText.map((q) => q.id)).toEqual(['b']);
  });

  it('filters by difficulty and year', () => {
    const result = applyFilterAndSort(QUESTIONS, { difficulty: 'easy', year: 2023 });
    expect(result.map((q) => q.id)).toEqual(['a']);
  });

  it('filters by status', () => {
    expect(applyFilterAndSort(QUESTIONS, { status: 'mastered' }).map((q) => q.id)).toEqual(['a']);
    expect(applyFilterAndSort(QUESTIONS, { status: 'learning' }).map((q) => q.id)).toEqual(['b']);
    expect(applyFilterAndSort(QUESTIONS, { status: 'unseen' }).map((q) => q.id)).toEqual(['c']);
    expect(applyFilterAndSort(QUESTIONS, { status: 'bookmarked' }).map((q) => q.id)).toEqual(['a']);
  });

  it('sorts by newest by default', () => {
    const result = applyFilterAndSort(QUESTIONS, {});
    expect(result.map((q) => q.id)).toEqual(['c', 'b', 'a']);
  });

  it('sorts by oldest', () => {
    const result = applyFilterAndSort(QUESTIONS, { sort: 'oldest' });
    expect(result.map((q) => q.id)).toEqual(['a', 'b', 'c']);
  });

  it('sorts by difficulty', () => {
    const result = applyFilterAndSort(QUESTIONS, { sort: 'difficulty' });
    expect(result.map((q) => q.difficulty)).toEqual(['easy', 'medium', 'hard']);
  });

  it('sorts random as a permutation of the input', () => {
    for (let i = 0; i < 10; i += 1) {
      const result = applyFilterAndSort(QUESTIONS, { sort: 'random' });
      expect(result.map((q) => q.id).sort()).toEqual(['a', 'b', 'c']);
    }
  });
});

describe('pickRandom', () => {
  it('returns an element from the list', () => {
    const picked = pickRandom(QUESTIONS);
    expect(QUESTIONS).toContain(picked);
  });

  it('returns undefined for an empty list', () => {
    expect(pickRandom([])).toBeUndefined();
  });
});
