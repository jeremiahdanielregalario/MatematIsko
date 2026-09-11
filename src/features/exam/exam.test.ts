import { describe, expect, it, vi, afterEach } from 'vitest';
import type { QuestionWithMeta } from '@/types';
import { createExam, examEnded, formatExamTime, parseExam, selectExamQuestions } from './exam';
const bank = Array.from(
  { length: 12 },
  (_, i) => ({ id: String(i), topic_id: i < 10 ? 'a' : 'b' }) as QuestionWithMeta,
);
afterEach(() => vi.useRealTimers());
describe('exam generation', () => {
  it('covers selected topics without duplicates and never mutates the bank', () => {
    const ids = selectExamQuestions(bank, ['a', 'b'], 4);
    expect(new Set(ids).size).toBe(4);
    expect(ids.some((id) => Number(id) >= 10)).toBe(true);
    expect(bank[0].id).toBe('0');
  });
  it('restricts topics and caps the paper at available questions', () => {
    expect(selectExamQuestions(bank, ['b'], 20).sort()).toEqual(['10', '11']);
    expect(selectExamQuestions(bank, ['missing'], 5)).toEqual([]);
    expect(selectExamQuestions([...bank, bank[0]], [], 30)).toHaveLength(12);
    expect(selectExamQuestions(bank, [], 0)).toEqual([]);
  });
});
describe('exam clock and restore', () => {
  it('uses an absolute deadline across backgrounding and does not end early', () => {
    const exam = createExam(['a'], 45, 1000);
    expect(examEnded(exam, exam.deadline - 1)).toBe(false);
    expect(examEnded(exam, exam.deadline)).toBe(true);
    expect(examEnded({ ...exam, finishedAt: 2000 }, 2000)).toBe(true);
    expect(formatExamTime(61001)).toBe('01:02');
    expect(formatExamTime(-1000)).toBe('00:00');
  });
  it('restores notes and deadline without storing question content', () => {
    const exam = { ...createExam(['a'], 45), notes: { a: 'My working' }, attempted: ['a'] };
    expect(parseExam(JSON.stringify(exam))).toEqual(exam);
    expect(parseExam(null)).toBeNull();
    expect(parseExam('{')).toBeNull();
    expect(parseExam(JSON.stringify({ ...exam, ids: ['a', 'a'] }))).toBeNull();
    expect(parseExam(JSON.stringify({ ...exam, revealed: true }))).toBeNull();
    expect(parseExam(JSON.stringify({ ...exam, notes: { other: 'private' } }))).toBeNull();
    expect(
      parseExam(JSON.stringify({ ...exam, deadline: exam.startedAt + 91 * 60_000 })),
    ).toBeNull();
  });
});
