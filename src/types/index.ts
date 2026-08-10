export type Difficulty = 'easy' | 'medium' | 'hard';

export type ProgressStatus = 'unseen' | 'learning' | 'mastered';

export interface Profile {
  id: string;
  email: string;
  full_name: string | null;
  avatar_url: string | null;
  degree_program: string | null;
  year_level: string | null;
  upmmc_member: boolean;
  created_at: string;
}

export interface UserCourse {
  user_id: string;
  course_id: string;
  created_at: string;
}

export interface Course {
  id: string;
  code: string;
  name: string;
  description: string | null;
  created_at: string;
}

export interface Topic {
  id: string;
  course_id: string;
  name: string;
  description?: string | null;
}

export interface Question {
  id: string;
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
  created_at: string;
  updated_at: string;
}

export interface QuestionWithRelations extends Question {
  course?: Course | null;
  topic?: Topic | null;
}

export interface QuestionProgress {
  user_id: string;
  question_id: string;
  status: ProgressStatus;
  attempts: number;
  last_attempted_at: string | null;
  mastered_at: string | null;
}

export interface Bookmark {
  user_id: string;
  question_id: string;
  created_at: string;
}

export interface QuestionWithMeta extends QuestionWithRelations {
  progress?: QuestionProgress | null;
  bookmarked: boolean;
}

export interface CourseWithStats extends Course {
  topic_count?: number;
  question_count?: number;
  mastered_count?: number;
  mastery_percent?: number;
}

export interface TopicWithStats extends Topic {
  question_count: number;
  mastered_count: number;
  mastery_percent: number;
}

export type QuestionFilter = {
  search?: string;
  courseId?: string;
  topicId?: string;
  difficulty?: Difficulty;
  year?: number;
  status?: 'bookmarked' | 'mastered' | 'learning' | 'unseen';
  sort?: 'newest' | 'oldest' | 'difficulty' | 'random' | 'recent';
};

export const DIFFICULTY_ORDER: Record<Difficulty, number> = {
  easy: 0,
  medium: 1,
  hard: 2,
};

// ---------------------------------------------------------------------------
// Question Reports
// ---------------------------------------------------------------------------

export type ReportCategory = 'rendering' | 'question' | 'hint' | 'answer' | 'solution' | 'other';

export type ReportStatus = 'open' | 'resolved';

export interface QuestionReport {
  id: string;
  question_id: string;
  user_id: string;
  category: ReportCategory;
  description: string;
  status: ReportStatus;
  created_at: string;
}

export type TheoremReportCategory = 'rendering' | 'statement' | 'formal_notation' | 'name' | 'other';

export interface TheoremReport {
  id: string;
  theorem_id: string;
  user_id: string;
  category: TheoremReportCategory;
  description: string;
  status: ReportStatus;
  created_at: string;
}

export interface QuestionReportRow extends QuestionReport {
  question_title?: string;
  course_code?: string;
  user_email?: string;
}

export interface TheoremReportRow extends TheoremReport {
  theorem_name?: string;
  course_code?: string;
  user_email?: string;
}

// ---------------------------------------------------------------------------
// Named Theorems
// ---------------------------------------------------------------------------

export interface Theorem {
  id: string;
  course_id: string;
  topic_id: string;
  name: string;
  reference: string | null;
  statement: string;
  formal_notation: string | null;
  created_at: string;
  updated_at: string;
}

export interface TheoremWithRelations extends Theorem {
  course?: Course | null;
  topic?: Topic | null;
}

export interface TheoremProgress {
  user_id: string;
  theorem_id: string;
  status: ProgressStatus;
  last_reviewed_at: string | null;
  mastered_at: string | null;
}

export interface TheoremWithMeta extends TheoremWithRelations {
  progress?: TheoremProgress | null;
}
