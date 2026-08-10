import { supabase, isSupabaseConfigured } from './supabase';
import type {
  QuestionReport,
  QuestionReportRow,
  ReportCategory,
  TheoremReport,
  TheoremReportRow,
  TheoremReportCategory,
} from '@/types';

function notConfigured(): never {
  throw new Error(
    'Supabase is not configured. Add VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY to your .env file.',
  );
}

// ---------------------------------------------------------------------------
// Question reports
// ---------------------------------------------------------------------------

export async function submitQuestionReport(
  questionId: string,
  category: ReportCategory,
  description?: string,
): Promise<QuestionReport> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('submit_question_report', {
    p_question_id: questionId,
    p_category: category,
    p_description: description ?? '',
  });
  if (error) throw new Error(error.message);
  return data as QuestionReport;
}

export async function adminListQuestionReports(
  status?: string,
): Promise<QuestionReportRow[]> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('admin_list_question_reports', {
    p_status: status ?? null,
  });
  if (error) throw new Error(error.message);
  return (data ?? []) as QuestionReportRow[];
}

// ---------------------------------------------------------------------------
// Theorem reports
// ---------------------------------------------------------------------------

export async function submitTheoremReport(
  theoremId: string,
  category: TheoremReportCategory,
  description?: string,
): Promise<TheoremReport> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('submit_theorem_report', {
    p_theorem_id: theoremId,
    p_category: category,
    p_description: description ?? '',
  });
  if (error) throw new Error(error.message);
  return data as TheoremReport;
}

export async function adminListTheoremReports(
  status?: string,
): Promise<TheoremReportRow[]> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('admin_list_theorem_reports', {
    p_status: status ?? null,
  });
  if (error) throw new Error(error.message);
  return (data ?? []) as TheoremReportRow[];
}

// ---------------------------------------------------------------------------
// Admin: resolve / reopen
// ---------------------------------------------------------------------------

export async function adminResolveReport(
  table: 'question_reports' | 'theorem_reports',
  id: string,
): Promise<void> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { error } = await supabase.rpc('admin_resolve_report', {
    p_table: table,
    p_id: id,
  });
  if (error) throw new Error(error.message);
}

export async function adminReopenReport(
  table: 'question_reports' | 'theorem_reports',
  id: string,
): Promise<void> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { error } = await supabase.rpc('admin_reopen_report', {
    p_table: table,
    p_id: id,
  });
  if (error) throw new Error(error.message);
}
