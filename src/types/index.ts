export type Difficulty = 'easy' | 'medium' | 'hard';

export type ProgressStatus = 'unseen' | 'learning' | 'mastered';

export interface Profile {
  id: string;
  email: string;
  full_name: string | null;
  avatar_url: string | null;
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
