import { describe, expect, it } from 'vitest';
import {
  computePracticeResults,
  shuffleQuestions,
  toMetaQuestions,
  type PracticeAnswer,
} from './practice';
import type { QuestionWithMeta } from '@/types';

describe('shuffleQuestions', () => {
  it('keeps all elements and does not mutate the input', () => {
    const input = [1, 2, 3, 4, 5];
    const copy = [...input];
    const result = shuffleQuestions(input);
    expect(result).toHaveLength(input.length);
    expect(result.sort()).toEqual(copy);
    expect(input).toEqual(copy);
  });
});

describe('computePracticeResults', () => {
  const answers: PracticeAnswer[] = [
    { questionId: 'a', result: 'correct' },
    { questionId: 'b', result: 'correct' },
    { questionId: 'c', result: 'incorrect' },
    { questionId: 'd', result: 'unsure' },
  ];

  it('computes counts and accuracy', () => {
    const summary = computePracticeResults(answers, 5);
    expect(summary.correct).toBe(2);
    expect(summary.incorrect).toBe(1);
    expect(summary.unsure).toBe(1);
    expect(summary.attempted).toBe(4);
    expect(summary.total).toBe(5);
    expect(summary.accuracy).toBe(50);
  });

  it('collects the ids that need review', () => {
    const summary = computePracticeResults(answers, 5);
    expect(summary.reviewIds).toEqual(['c', 'd']);
  });

  it('handles an empty session', () => {
    const summary = computePracticeResults([], 10);
    expect(summary.accuracy).toBe(0);
    expect(summary.reviewIds).toEqual([]);
  });
});

describe('toMetaQuestions', () => {
  const bank: QuestionWithMeta[] = [
    { id: 'a', title: 'A' } as QuestionWithMeta,
    { id: 'b', title: 'B' } as QuestionWithMeta,
  ];

  it('maps ids to questions preserving order and dropping unknowns', () => {
    const result = toMetaQuestions(['b', 'a', 'missing'], bank);
    expect(result.map((q) => q.id)).toEqual(['b', 'a']);
  });
});
