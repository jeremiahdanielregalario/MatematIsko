import { describe, expect, it } from 'vitest';
import { mergeMutations } from './mutations';
import type { QuestionWithMeta } from '@/types';

function makeQuestion(): QuestionWithMeta {
  return {
    id: 'q1',
    course_id: 'c1',
    topic_id: 't1',
    title: 'Title',
    question_text: 'text',
    difficulty: 'easy',
    year: 2023,
    exam_name: 'LE1',
    question_number: 1,
    answer: '4',
    solution: 's',
    hint: null,
    created_at: '2024-01-01',
    updated_at: '2024-01-01',
    course: null,
    topic: null,
    progress: {
      user_id: 'u',
      question_id: 'q1',
      status: 'unseen',
      attempts: 0,
      last_attempted_at: null,
      mastered_at: null,
    },
    bookmarked: false,
  };
}

describe('mergeMutations', () => {
  it('returns the question unchanged with empty mutations', () => {
    const question = makeQuestion();
    const merged = mergeMutations(question, { bookmarks: {}, statuses: {}, attempts: {} });
    expect(merged).toEqual(question);
  });

  it('applies optimistic overrides on top of loaded data', () => {
    const question = makeQuestion();
    const merged = mergeMutations(question, {
      bookmarks: { q1: true },
      statuses: { q1: 'mastered' },
      attempts: { q1: 5 },
    });
    expect(merged.bookmarked).toBe(true);
    expect(merged.progress!.status).toBe('mastered');
    expect(merged.progress!.attempts).toBe(5);
  });

  it('falls back to loaded values when a question is untouched', () => {
    const question = makeQuestion();
    const merged = mergeMutations(question, { bookmarks: { other: true }, statuses: {}, attempts: {} });
    expect(merged.bookmarked).toBe(false);
    expect(merged.progress!.status).toBe('unseen');
  });
});
