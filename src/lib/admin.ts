import { supabase, isSupabaseConfigured } from './supabase';
import type { Difficulty, Question, Theorem, Topic, Course } from '@/types';

function notConfigured(): never {
  throw new Error(
    'Supabase is not configured. Add VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY to your .env file.',
  );
}

export interface QuestionDraft {
  id?: string;
  course_id: string;
  topic_id: string;
  title: string;
  question_text: string;
  difficulty: Difficulty;
  year: number;
  exam_name: string;
  question_number: number;
  answer: string;
  solution: string;
  hint: string | null;
}

/**
 * Upserts a question via the security-definer RPC (the only write path to the
 * question bank). Pass an existing id to update, omit it to create.
 */
export async function adminUpsertQuestion(draft: QuestionDraft): Promise<Question> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('admin_upsert_question', {
    p_id: draft.id ?? null,
    p_course_id: draft.course_id,
    p_topic_id: draft.topic_id,
    p_title: draft.title,
    p_question_text: draft.question_text,
    p_difficulty: draft.difficulty,
    p_year: draft.year,
    p_exam_name: draft.exam_name,
    p_question_number: draft.question_number,
    p_answer: draft.answer,
    p_solution: draft.solution,
    p_hint: draft.hint,
  });
  if (error) throw new Error(error.message);
  return data as Question;
}

export async function adminDeleteQuestion(id: string): Promise<void> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { error } = await supabase.rpc('admin_delete_question', { p_id: id });
  if (error) throw new Error(error.message);
}

/** Creates (or re-uses) a topic under a course. */
export async function adminUpsertTopic(
  courseId: string,
  name: string,
  description?: string | null,
): Promise<Topic> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('admin_upsert_topic', {
    p_course_id: courseId,
    p_name: name,
    p_description: description ?? null,
  });
  if (error) throw new Error(error.message);
  return data as Topic;
}

export async function adminDeleteTopic(id: string): Promise<void> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { error } = await supabase.rpc('admin_delete_topic', { p_id: id });
  if (error) throw new Error(error.message);
}

/** Database-side admin check (kept in sync with the client-side email check). */
export async function adminIsAdmin(): Promise<boolean> {
  if (!isSupabaseConfigured) return false;
  if (!supabase) return false;
  const { data, error } = await supabase.rpc('is_admin');
  if (error) return false;
  return Boolean(data);
}

// ---------------------------------------------------------------------------
// Named Theorems
// ---------------------------------------------------------------------------

export interface TheoremDraft {
  id?: string;
  course_id: string;
  topic_id: string;
  name: string;
  reference: string | null;
  statement: string;
  formal_notation: string | null;
}

export async function adminUpsertTheorem(draft: TheoremDraft): Promise<Theorem> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('admin_upsert_theorem', {
    p_id: draft.id ?? null,
    p_course_id: draft.course_id,
    p_topic_id: draft.topic_id,
    p_name: draft.name,
    p_reference: draft.reference,
    p_statement: draft.statement,
    p_formal_notation: draft.formal_notation,
  });
  if (error) throw new Error(error.message);
  return data as Theorem;
}

export async function adminDeleteTheorem(id: string): Promise<void> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { error } = await supabase.rpc('admin_delete_theorem', { p_id: id });
  if (error) throw new Error(error.message);
}

// ---------------------------------------------------------------------------
// Courses
// ---------------------------------------------------------------------------

export interface CourseDraft {
  id?: string;
  code: string;
  name: string;
  description: string | null;
}

export async function adminUpsertCourse(draft: CourseDraft): Promise<Course> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { data, error } = await supabase.rpc('admin_upsert_course', {
    p_id: draft.id ?? null,
    p_code: draft.code,
    p_name: draft.name,
    p_description: draft.description,
  });
  if (error) throw new Error(error.message);
  return data as Course;
}

export async function adminDeleteCourse(id: string): Promise<void> {
  if (!isSupabaseConfigured) notConfigured();
  if (!supabase) notConfigured();
  const { error } = await supabase.rpc('admin_delete_course', { p_id: id });
  if (error) throw new Error(error.message);
}
