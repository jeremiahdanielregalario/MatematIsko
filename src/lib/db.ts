import { supabase, isSupabaseConfigured } from './supabase';
import type {
  Bookmark,
  Course,
  Profile,
  ProgressStatus,
  QuestionProgress,
  QuestionWithRelations,
  TheoremProgress,
  TheoremWithRelations,
  Topic,
} from '@/types';

function notConfigured(): never {
  throw new Error(
    'Supabase is not configured. Add VITE_SUPABASE_URL and VITE_SUPABASE_ANON_KEY to your .env file.',
  );
}

export async function getCourses(): Promise<Course[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  const { data, error } = await supabase.from('courses').select('*').order('code');
  if (error) throw new Error(error.message);
  return (data ?? []) as Course[];
}

export async function getTopics(courseId?: string): Promise<Topic[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  let query = supabase.from('topics').select('*').order('name');
  if (courseId) query = query.eq('course_id', courseId);
  const { data, error } = await query;
  if (error) throw new Error(error.message);
  return (data ?? []) as Topic[];
}

export async function getQuestionsWithRelations(courseIds?: string[]): Promise<QuestionWithRelations[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  let query = supabase
    .from('questions')
    .select('*, course:courses(*), topic:topics(*)')
    .order('created_at', { ascending: false });
  if (courseIds && courseIds.length > 0) query = query.in('course_id', courseIds);
  const { data, error } = await query;
  if (error) throw new Error(error.message);
  return (data ?? []) as QuestionWithRelations[];
}

export async function getQuestionById(
  id: string,
  courseIds?: string[],
): Promise<QuestionWithRelations | null> {
  if (!isSupabaseConfigured) return null;
  if (!supabase) notConfigured();
  let query = supabase
    .from('questions')
    .select('*, course:courses(*), topic:topics(*)')
    .eq('id', id);
  if (courseIds && courseIds.length > 0) query = query.in('course_id', courseIds);
  const { data, error } = await query.maybeSingle();
  if (error) throw new Error(error.message);
  return (data as QuestionWithRelations | null) ?? null;
}

// ---------------------------------------------------------------------------
// Named Theorems
// ---------------------------------------------------------------------------

export async function getTheorems(courseIds?: string[]): Promise<TheoremWithRelations[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  let query = supabase
    .from('theorems')
    .select('*, course:courses(*), topic:topics(*)')
    .order('created_at', { ascending: false });
  if (courseIds && courseIds.length > 0) query = query.in('course_id', courseIds);
  const { data, error } = await query;
  if (error) throw new Error(error.message);
  return (data ?? []) as TheoremWithRelations[];
}

export async function getTheoremById(
  id: string,
  courseIds?: string[],
): Promise<TheoremWithRelations | null> {
  if (!isSupabaseConfigured) return null;
  if (!supabase) notConfigured();
  let query = supabase
    .from('theorems')
    .select('*, course:courses(*), topic:topics(*)')
    .eq('id', id);
  if (courseIds && courseIds.length > 0) query = query.in('course_id', courseIds);
  const { data, error } = await query.maybeSingle();
  if (error) throw new Error(error.message);
  return (data as TheoremWithRelations | null) ?? null;
}

export async function getTheoremProgressForUser(
  userId: string,
): Promise<TheoremProgress[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  const { data, error } = await supabase
    .from('theorem_progress')
    .select('*')
    .eq('user_id', userId);
  if (error) throw new Error(error.message);
  return (data ?? []) as TheoremProgress[];
}

export async function upsertTheoremProgress(
  userId: string,
  theoremId: string,
  status: ProgressStatus,
  masteredAt: string | null,
): Promise<void> {
  if (!isSupabaseConfigured) return;
  if (!supabase) notConfigured();
  const { error } = await supabase.from('theorem_progress').upsert(
    {
      user_id: userId,
      theorem_id: theoremId,
      status,
      mastered_at: masteredAt,
      last_reviewed_at: new Date().toISOString(),
    },
    { onConflict: 'user_id,theorem_id' },
  );
  if (error) throw new Error(error.message);
}

export async function getProgressForUser(
  userId: string,
): Promise<QuestionProgress[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  const { data, error } = await supabase
    .from('progress')
    .select('*')
    .eq('user_id', userId);
  if (error) throw new Error(error.message);
  return (data ?? []) as QuestionProgress[];
}

export async function getBookmarksForUser(userId: string): Promise<Bookmark[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  const { data, error } = await supabase
    .from('bookmarks')
    .select('*')
    .eq('user_id', userId)
    .order('created_at', { ascending: false });
  if (error) throw new Error(error.message);
  return (data ?? []) as Bookmark[];
}

export async function upsertProgress(
  userId: string,
  questionId: string,
  status: ProgressStatus,
  attempts: number,
  masteredAt: string | null,
): Promise<void> {
  if (!isSupabaseConfigured) return;
  if (!supabase) notConfigured();
  const { error } = await supabase.from('progress').upsert(
    {
      user_id: userId,
      question_id: questionId,
      status,
      attempts,
      mastered_at: masteredAt,
      last_attempted_at: new Date().toISOString(),
    },
    { onConflict: 'user_id,question_id' },
  );
  if (error) throw new Error(error.message);
}

export async function setBookmark(
  userId: string,
  questionId: string,
  bookmarked: boolean,
): Promise<void> {
  if (!isSupabaseConfigured) return;
  if (!supabase) notConfigured();
  if (bookmarked) {
    const { error } = await supabase.from('bookmarks').insert({
      user_id: userId,
      question_id: questionId,
    });
    if (error) throw new Error(error.message);
  } else {
    const { error } = await supabase
      .from('bookmarks')
      .delete()
      .eq('user_id', userId)
      .eq('question_id', questionId);
    if (error) throw new Error(error.message);
  }
}

export async function getProfile(userId: string): Promise<Profile | null> {
  if (!isSupabaseConfigured) return null;
  if (!supabase) notConfigured();
  const { data, error } = await supabase
    .from('profiles')
    .select('*')
    .eq('id', userId)
    .maybeSingle();
  if (error) throw new Error(error.message);
  return (data as Profile | null) ?? null;
}

export async function ensureProfile(
  userId: string,
  email: string,
  fullName: string | null,
  avatarUrl: string | null,
): Promise<Profile | null> {
  if (!isSupabaseConfigured) return null;
  if (!supabase) notConfigured();
  const existing = await getProfile(userId);
  if (existing) return existing;
  const { data, error } = await supabase
    .from('profiles')
    .insert({ id: userId, email, full_name: fullName, avatar_url: avatarUrl })
    .select()
    .maybeSingle();
  if (error) throw new Error(error.message);
  return (data as Profile | null) ?? null;
}

export async function updateProfileOnboarding(
  userId: string,
  fields: { degree_program: string; year_level: string; upmmc_member: boolean },
): Promise<Profile | null> {
  if (!isSupabaseConfigured) return null;
  if (!supabase) notConfigured();
  const { data, error } = await supabase
    .from('profiles')
    .update(fields)
    .eq('id', userId)
    .select()
    .maybeSingle();
  if (error) throw new Error(error.message);
  return (data as Profile | null) ?? null;
}

export async function setUserCourses(userId: string, courseIds: string[]): Promise<void> {
  if (!isSupabaseConfigured) return;
  if (!supabase) notConfigured();
  const { error: deleteError } = await supabase
    .from('user_courses')
    .delete()
    .eq('user_id', userId);
  if (deleteError) throw new Error(deleteError.message);
  if (courseIds.length === 0) return;
  const { error } = await supabase
    .from('user_courses')
    .insert(courseIds.map((course_id) => ({ user_id: userId, course_id })));
  if (error) throw new Error(error.message);
}

export async function getUserCourses(userId: string): Promise<Course[]> {
  if (!isSupabaseConfigured) return [];
  if (!supabase) notConfigured();
  const { data, error } = await supabase
    .from('user_courses')
    .select('course:courses(*)')
    .eq('user_id', userId);
  if (error) throw new Error(error.message);
  const courses = (data ?? []).map((row) => (row as unknown as { course: Course }).course);
  return courses.sort((a, b) => {
    const number = (code: string) => parseFloat(code.replace('MATH', '').trim()) || 0;
    return number(a.code) - number(b.code);
  });
}
