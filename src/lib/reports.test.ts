import { beforeEach, describe, expect, it, vi } from 'vitest';

const { mockRpc } = vi.hoisted(() => ({ mockRpc: vi.fn() }));

vi.mock('./supabase', () => ({
  isSupabaseConfigured: true,
  supabase: { rpc: mockRpc },
}));

import {
  adminListQuestionReports,
  adminListTheoremReports,
  adminReopenReport,
  adminResolveReport,
  submitQuestionReport,
  submitTheoremReport,
} from './reports';

const questionReport = {
  id: 'r1',
  question_id: 'q1',
  user_id: 'u1',
  category: 'rendering',
  description: 'The $$ block is broken',
  status: 'open',
  created_at: '2024-01-01',
};

const theoremReport = {
  id: 'r2',
  theorem_id: 't1',
  user_id: 'u1',
  category: 'statement',
  description: 'Missing a quantifier',
  status: 'open',
  created_at: '2024-01-01',
};

beforeEach(() => {
  mockRpc.mockReset();
});

describe('submitQuestionReport', () => {
  it('submits a question report and returns the created row', async () => {
    mockRpc.mockResolvedValue({ data: questionReport, error: null });
    const result = await submitQuestionReport('q1', 'rendering', 'The $$ block is broken');
    expect(result).toEqual(questionReport);
    expect(mockRpc).toHaveBeenCalledWith('submit_question_report', {
      p_question_id: 'q1',
      p_category: 'rendering',
      p_description: 'The $$ block is broken',
    });
  });

  it('defaults the description to an empty string', async () => {
    mockRpc.mockResolvedValue({ data: questionReport, error: null });
    await submitQuestionReport('q1', 'answer');
    expect(mockRpc).toHaveBeenCalledWith('submit_question_report', {
      p_question_id: 'q1',
      p_category: 'answer',
      p_description: '',
    });
  });

  it('throws when the database rejects the report', async () => {
    mockRpc.mockResolvedValue({ data: null, error: { message: 'Invalid category' } });
    await expect(submitQuestionReport('q1', 'nope' as never)).rejects.toThrow('Invalid category');
  });
});

describe('submitTheoremReport', () => {
  it('submits a theorem report and returns the created row', async () => {
    mockRpc.mockResolvedValue({ data: theoremReport, error: null });
    const result = await submitTheoremReport('t1', 'statement', 'Missing a quantifier');
    expect(result).toEqual(theoremReport);
    expect(mockRpc).toHaveBeenCalledWith('submit_theorem_report', {
      p_theorem_id: 't1',
      p_category: 'statement',
      p_description: 'Missing a quantifier',
    });
  });

  it('defaults the description to an empty string', async () => {
    mockRpc.mockResolvedValue({ data: theoremReport, error: null });
    await submitTheoremReport('t1', 'name');
    expect(mockRpc).toHaveBeenCalledWith('submit_theorem_report', {
      p_theorem_id: 't1',
      p_category: 'name',
      p_description: '',
    });
  });
});

describe('adminListQuestionReports', () => {
  it('lists reports with a status filter', async () => {
    mockRpc.mockResolvedValue({ data: [questionReport], error: null });
    const result = await adminListQuestionReports('open');
    expect(result).toEqual([questionReport]);
    expect(mockRpc).toHaveBeenCalledWith('admin_list_question_reports', { p_status: 'open' });
  });

  it('defaults to null status for the full list', async () => {
    mockRpc.mockResolvedValue({ data: [], error: null });
    await adminListQuestionReports();
    expect(mockRpc).toHaveBeenCalledWith('admin_list_question_reports', { p_status: null });
  });
});

describe('adminListTheoremReports', () => {
  it('lists theorem reports', async () => {
    mockRpc.mockResolvedValue({ data: [theoremReport], error: null });
    const result = await adminListTheoremReports();
    expect(result).toEqual([theoremReport]);
    expect(mockRpc).toHaveBeenCalledWith('admin_list_theorem_reports', { p_status: null });
  });
});

describe('adminResolveReport', () => {
  it('resolves a question report', async () => {
    mockRpc.mockResolvedValue({ data: null, error: null });
    await adminResolveReport('question_reports', 'r1');
    expect(mockRpc).toHaveBeenCalledWith('admin_resolve_report', {
      p_table: 'question_reports',
      p_id: 'r1',
    });
  });

  it('resolves a theorem report', async () => {
    mockRpc.mockResolvedValue({ data: null, error: null });
    await adminResolveReport('theorem_reports', 'r2');
    expect(mockRpc).toHaveBeenCalledWith('admin_resolve_report', {
      p_table: 'theorem_reports',
      p_id: 'r2',
    });
  });
});

describe('adminReopenReport', () => {
  it('reopens a report', async () => {
    mockRpc.mockResolvedValue({ data: null, error: null });
    await adminReopenReport('question_reports', 'r1');
    expect(mockRpc).toHaveBeenCalledWith('admin_reopen_report', {
      p_table: 'question_reports',
      p_id: 'r1',
    });
  });
});
