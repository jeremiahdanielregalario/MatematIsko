import { describe, expect, it } from 'vitest';

vi.mock('./supabase', () => ({
  isSupabaseConfigured: false,
  supabase: null,
}));

import {
  adminListQuestionReports,
  adminListTheoremReports,
  adminReopenReport,
  adminResolveReport,
  submitQuestionReport,
  submitTheoremReport,
} from './reports';

describe('reports when Supabase is not configured', () => {
  it('throws for submitQuestionReport', async () => {
    await expect(submitQuestionReport('q1', 'other')).rejects.toThrow(
      'Supabase is not configured',
    );
  });

  it('throws for submitTheoremReport', async () => {
    await expect(submitTheoremReport('t1', 'other')).rejects.toThrow(
      'Supabase is not configured',
    );
  });

  it('throws for adminListQuestionReports', async () => {
    await expect(adminListQuestionReports()).rejects.toThrow('Supabase is not configured');
  });

  it('throws for adminListTheoremReports', async () => {
    await expect(adminListTheoremReports()).rejects.toThrow('Supabase is not configured');
  });

  it('throws for adminResolveReport', async () => {
    await expect(adminResolveReport('question_reports', 'r1')).rejects.toThrow(
      'Supabase is not configured',
    );
  });

  it('throws for adminReopenReport', async () => {
    await expect(adminReopenReport('theorem_reports', 'r1')).rejects.toThrow(
      'Supabase is not configured',
    );
  });
});
