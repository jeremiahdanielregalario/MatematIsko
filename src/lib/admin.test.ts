import { beforeEach, describe, expect, it, vi } from 'vitest';
import type { Question, Topic } from '@/types';

const { mockRpc } = vi.hoisted(() => ({ mockRpc: vi.fn() }));

vi.mock('./supabase', () => ({
  isSupabaseConfigured: true,
  supabase: { rpc: mockRpc },
}));

import {
  adminDeleteQuestion,
  adminDeleteTopic,
  adminIsAdmin,
  adminUpsertQuestion,
  adminUpsertTopic,
  type QuestionDraft,
} from './admin';

function makeDraft(): QuestionDraft {
  return {
    course_id: 'c1',
    topic_id: 't1',
    title: 'Limits',
    question_text: 'Compute $x$',
    difficulty: 'medium',
    year: 2023,
    exam_name: 'LE1',
    question_number: 2,
    answer: '4',
    solution: 'Steps…',
    hint: null,
  };
}

const question: Question = {
  id: 'q1',
  course_id: 'c1',
  topic_id: 't1',
  title: 'Limits',
  question_text: 'Compute $x$',
  difficulty: 'medium',
  year: 2023,
  exam_name: 'LE1',
  question_number: 2,
  answer: '4',
  solution: 'Steps…',
  hint: null,
  created_at: '2024-01-01',
  updated_at: '2024-01-01',
};

const topic: Topic = {
  id: 't1',
  course_id: 'c1',
  name: 'Limits',
  description: null,
};

beforeEach(() => {
  mockRpc.mockReset();
});

describe('adminUpsertQuestion', () => {
  it('resolves with the saved question and maps the p_ params', async () => {
    mockRpc.mockResolvedValue({ data: question, error: null });
    const result = await adminUpsertQuestion(makeDraft());
    expect(result).toEqual(question);
    expect(mockRpc).toHaveBeenCalledWith('admin_upsert_question', {
      p_id: null,
      p_course_id: 'c1',
      p_topic_id: 't1',
      p_title: 'Limits',
      p_question_text: 'Compute $x$',
      p_difficulty: 'medium',
      p_year: 2023,
      p_exam_name: 'LE1',
      p_question_number: 2,
      p_answer: '4',
      p_solution: 'Steps…',
      p_hint: null,
    });
  });

  it('passes an existing id through for updates', async () => {
    mockRpc.mockResolvedValue({ data: question, error: null });
    await adminUpsertQuestion({ ...makeDraft(), id: 'q1' });
    expect(mockRpc).toHaveBeenCalledWith(
      'admin_upsert_question',
      expect.objectContaining({ p_id: 'q1' }),
    );
  });

  it('throws when the database rejects the write', async () => {
    mockRpc.mockResolvedValue({ data: null, error: { message: 'Only administrators can manage questions' } });
    await expect(adminUpsertQuestion(makeDraft())).rejects.toThrow(
      'Only administrators can manage questions',
    );
  });
});

describe('adminUpsertTopic', () => {
  it('creates a topic and returns it', async () => {
    mockRpc.mockResolvedValue({ data: topic, error: null });
    const result = await adminUpsertTopic('c1', 'Limits', 'Intro');
    expect(result).toEqual(topic);
    expect(mockRpc).toHaveBeenCalledWith('admin_upsert_topic', {
      p_course_id: 'c1',
      p_name: 'Limits',
      p_description: 'Intro',
    });
  });

  it('throws on a permission error', async () => {
    mockRpc.mockResolvedValue({ data: null, error: { message: 'denied' } });
    await expect(adminUpsertTopic('c1', 'Limits')).rejects.toThrow('denied');
  });
});

describe('adminDeleteQuestion', () => {
  it('deletes and resolves', async () => {
    mockRpc.mockResolvedValue({ data: null, error: null });
    await expect(adminDeleteQuestion('q1')).resolves.toBeUndefined();
    expect(mockRpc).toHaveBeenCalledWith('admin_delete_question', { p_id: 'q1' });
  });

  it('throws when the row is missing', async () => {
    mockRpc.mockResolvedValue({ data: null, error: { message: 'Question not found' } });
    await expect(adminDeleteQuestion('q1')).rejects.toThrow('Question not found');
  });
});

describe('adminDeleteTopic', () => {
  it('deletes and resolves', async () => {
    mockRpc.mockResolvedValue({ data: null, error: null });
    await expect(adminDeleteTopic('t1')).resolves.toBeUndefined();
    expect(mockRpc).toHaveBeenCalledWith('admin_delete_topic', { p_id: 't1' });
  });
});

describe('adminIsAdmin', () => {
  it('returns true when the RPC says so', async () => {
    mockRpc.mockResolvedValue({ data: true, error: null });
    await expect(adminIsAdmin()).resolves.toBe(true);
  });

  it('returns false on an error', async () => {
    mockRpc.mockResolvedValue({ data: null, error: { message: 'boom' } });
    await expect(adminIsAdmin()).resolves.toBe(false);
  });
});
