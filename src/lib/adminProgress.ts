import { supabase, isSupabaseConfigured } from './supabase';

export interface AdminCourseProgress {
  id: string;
  code: string;
  name: string;
  selected: boolean;
  questions_total: number;
  questions_learning: number;
  questions_mastered: number;
  question_records: number;
  attempts: number;
  theorems_total: number;
  theorems_learning: number;
  theorems_mastered: number;
  theorem_records: number;
  last_activity: string | null;
}

export async function adminUserProgress(userId: string): Promise<AdminCourseProgress[]> {
  if (!isSupabaseConfigured || !supabase) throw new Error('Supabase is not configured.');
  const { data, error } = await supabase.rpc('admin_user_progress', { p_user_id: userId });
  if (error) throw new Error(error.message);
  if (!Array.isArray(data)) throw new Error('Could not read user progress.');
  return data as AdminCourseProgress[];
}

export async function adminResetUserProgress(
  userId: string,
  courseId: string | null,
): Promise<void> {
  if (!isSupabaseConfigured || !supabase) throw new Error('Supabase is not configured.');
  const { error } = await supabase.rpc('admin_reset_user_progress', {
    p_user_id: userId,
    p_course_id: courseId,
  });
  if (error) throw new Error(error.message);
}
