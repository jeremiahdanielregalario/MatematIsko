import { act, renderHook } from '@testing-library/react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { useQuestionMutations } from './useQuestionMutations';
import { useTheoremMutations } from './useTheoremMutations';
import type { QuestionWithMeta, TheoremWithMeta } from '@/types';

const mockSetBookmark = vi.fn();
const mockUpsertProgress = vi.fn();
const mockUpsertTheoremProgress = vi.fn();

vi.mock('./useAuth', () => ({
  useAuth: () => ({ user: { id: 'user-1', email: 'student@up.edu.ph' } }),
}));

vi.mock('@/lib/db', () => ({
  setBookmark: (...args: unknown[]) => mockSetBookmark(...args),
  upsertProgress: (...args: unknown[]) => mockUpsertProgress(...args),
  upsertTheoremProgress: (...args: unknown[]) => mockUpsertTheoremProgress(...args),
}));

const baseQuestion: QuestionWithMeta = {
  id: 'q1',
  course_id: 'c1',
  topic_id: 't1',
  title: 'Limit problem',
  question_text: 'Find the limit.',
  difficulty: 'medium',
  year: 2024,
  exam_name: 'LE1',
  question_number: 1,
  answer: '2',
  solution: 'By direct substitution.',
  hint: null,
  created_at: '2024-01-01',
  updated_at: '2024-01-01',
  bookmarked: false,
  progress: {
    user_id: 'user-1',
    question_id: 'q1',
    status: 'unseen',
    attempts: 1,
    last_attempted_at: null,
    mastered_at: null,
  },
};

describe('useQuestionMutations', () => {
  beforeEach(() => {
    vi.clearAllMocks();
    mockSetBookmark.mockResolvedValue(undefined);
    mockUpsertProgress.mockResolvedValue(undefined);
    mockUpsertTheoremProgress.mockResolvedValue(undefined);
  });

  it('accumulates attempts across repeated session attempts on the same question', () => {
    const { result } = renderHook(() =>
      useQuestionMutations((id) => (id === 'q1' ? baseQuestion : undefined)),
    );

    act(() => {
      result.current.recordAttempt('q1', false);
    });
    expect(result.current.statuses.q1).toBe('learning');
    expect(result.current.attempts.q1).toBe(2);

    act(() => {
      result.current.recordAttempt('q1', true);
    });
    expect(result.current.statuses.q1).toBe('mastered');
    expect(result.current.attempts.q1).toBe(3);
    expect(mockUpsertProgress).toHaveBeenLastCalledWith(
      'user-1',
      'q1',
      'mastered',
      3,
      expect.any(String),
    );
  });

  it('reverts optimistic status and attempt count when recordAttempt fails', async () => {
    mockUpsertProgress.mockRejectedValueOnce(new Error('Network offline'));
    const { result } = renderHook(() =>
      useQuestionMutations((id) => (id === 'q1' ? baseQuestion : undefined)),
    );

    act(() => {
      result.current.recordAttempt('q1', true);
    });
    expect(result.current.statuses.q1).toBe('mastered');
    expect(result.current.attempts.q1).toBe(2);

    await act(async () => {
      await Promise.resolve();
    });

    expect(result.current.statuses.q1).toBeUndefined();
    expect(result.current.attempts.q1).toBeUndefined();
    expect(result.current.lastError).toBe('Network offline');

    act(() => {
      result.current.clearError();
    });
    expect(result.current.lastError).toBeNull();
  });

  it('reverts bookmark and status changes on failure', async () => {
    mockSetBookmark.mockRejectedValueOnce(new Error('Bookmark failed'));
    mockUpsertProgress.mockRejectedValueOnce(new Error('Status failed'));
    const { result } = renderHook(() =>
      useQuestionMutations((id) => (id === 'q1' ? baseQuestion : undefined)),
    );

    act(() => {
      result.current.toggleBookmark('q1', true);
      result.current.setStatus('q1', 'learning');
    });

    await act(async () => {
      await Promise.resolve();
    });

    expect(result.current.bookmarks.q1).toBeUndefined();
    expect(result.current.statuses.q1).toBeUndefined();
    expect(result.current.lastError).toBe('Status failed');
  });
});

describe('useTheoremMutations', () => {
  it('rolls back failed status updates even for unseen theorems with null progress', async () => {
    mockUpsertTheoremProgress.mockRejectedValueOnce(new Error('Database error'));
    const unseenTheorem: TheoremWithMeta = {
      id: 'th1',
      course_id: 'c1',
      topic_id: 't1',
      name: 'Mean Value Theorem',
      reference: null,
      statement: 'Statement',
      formal_notation: null,
      created_at: '2024-01-01',
      updated_at: '2024-01-01',
      progress: null,
    };

    const { result } = renderHook(() =>
      useTheoremMutations((id) => (id === 'th1' ? unseenTheorem : undefined)),
    );

    act(() => {
      result.current.setStatus('th1', 'mastered');
    });
    expect(result.current.statuses.th1).toBe('mastered');

    await act(async () => {
      await Promise.resolve();
    });

    expect(result.current.statuses.th1).toBeUndefined();
    expect(result.current.lastError).toBe('Database error');
  });
});
