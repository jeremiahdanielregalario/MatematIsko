import { supabase } from './supabase';
import type { Difficulty } from '@/types';

export interface QuestionContributionContent {
  topic_id: string;
  question_text: string;
  answer: string;
  solution: string;
  hint: string | null;
  difficulty: Difficulty;
  year: number;
  exam_name: string;
  question_number: number;
}
export type ContributionDraft = { course_id: string; title: string } & (
  | { kind: 'question'; payload: QuestionContributionContent }
  | { kind: 'note'; payload: { content: string } }
);
export type Contribution = ContributionDraft & {
  id: string;
  author_id: string;
  author_name: string;
  status: 'pending' | 'approved' | 'rejected';
  review_note: string | null;
  reviewed_at: string | null;
  published_id: string | null;
  created_at: string;
};
export const CONTRIBUTIONS_PAGE_SIZE = 20;

export function validateContribution(draft: ContributionDraft): string | null {
  if (!draft.course_id || !draft.title.trim()) return 'Choose a course and enter a title.';
  if (draft.title.length > 300) return 'Keep the title within 300 characters.';
  let bodies: string[];
  if (draft.kind === 'question') {
    const q = draft.payload;
    if (
      !q.topic_id ||
      !q.exam_name.trim() ||
      !q.question_text.trim() ||
      !q.answer.trim() ||
      !q.solution.trim()
    ) {
      return 'Complete the topic, source, question, answer and solution.';
    }
    if (
      !Number.isInteger(q.year) ||
      q.year < 1900 ||
      q.year > 2200 ||
      !Number.isInteger(q.question_number) ||
      q.question_number < 1 ||
      q.question_number > 10000
    ) {
      return 'Use a year from 1900–2200 and a question number from 1–10000.';
    }
    bodies = [q.question_text, q.answer, q.solution, q.hint ?? ''];
  } else {
    if (!draft.payload.content.trim()) return 'Write your notes before submitting.';
    bodies = [draft.payload.content];
  }
  if (draft.title.includes('$$'))
    return 'Use inline math in the title; put display equations in the body.';
  for (const body of bodies) {
    let delimiters = 0;
    for (const line of body.split(/\r?\n/)) {
      if (!line.includes('$$')) continue;
      if (line.replace(/^[\s>]+/, '').trim() !== '$$')
        return 'Put each display math delimiter on its own line.';
      delimiters++;
    }
    if (delimiters % 2)
      return 'Close every display equation with a matching delimiter on its own line.';
    if (/\\\[|\\\]/.test(body))
      return 'Use separate-line display math delimiters instead of bracket delimiters.';
  }
  return null;
}

export async function submitContribution(
  id: string,
  draft: ContributionDraft,
): Promise<Contribution> {
  if (!supabase) throw new Error('Contributions are unavailable until the app is configured.');
  const validation = validateContribution(draft);
  if (validation) throw new Error(validation);
  const { data, error } = await supabase.rpc('submit_content_contribution', {
    p_id: id,
    p_kind: draft.kind,
    p_course_id: draft.course_id,
    p_title: draft.title,
    p_payload: draft.payload,
  });
  if (error) throw new Error(error.message);
  return data as Contribution;
}

export async function listContributions({
  authorId,
  status,
  page = 0,
}: {
  authorId?: string;
  status?: Contribution['status'];
  page?: number;
}): Promise<Contribution[]> {
  if (!supabase) throw new Error('Contributions are unavailable until the app is configured.');
  let query = supabase
    .from('content_contributions')
    .select('*')
    .order('created_at', { ascending: false })
    .order('id');
  if (authorId) query = query.eq('author_id', authorId);
  if (status) query = query.eq('status', status);
  const start = Math.max(0, page) * CONTRIBUTIONS_PAGE_SIZE;
  const { data, error } = await query.range(start, start + CONTRIBUTIONS_PAGE_SIZE);
  if (error) throw new Error(error.message);
  return data as Contribution[];
}

export async function reviewContribution(
  id: string,
  decision: 'approved' | 'rejected',
  note: string,
): Promise<Contribution> {
  if (!supabase) throw new Error('Contributions are unavailable until the app is configured.');
  const { data, error } = await supabase.rpc('admin_review_contribution', {
    p_id: id,
    p_decision: decision,
    p_review_note: note,
  });
  if (error) throw new Error(error.message);
  return data as Contribution;
}
