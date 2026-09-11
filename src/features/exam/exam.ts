import type { QuestionWithMeta } from '@/types';
import { shuffleQuestions, type AnswerResult } from '@/lib/practice';

export interface ExamSession {
  version: 1;
  ids: string[];
  startedAt: number;
  deadline: number;
  finishedAt: number | null;
  revealed: boolean;
  notes: Record<string, string>;
  attempted: string[];
  flagged: string[];
  ratings: Record<string, AnswerResult>;
}

/** Round-robin across shuffled topic groups to keep a large topic from dominating. */
export function selectExamQuestions(
  questions: QuestionWithMeta[],
  topicIds: string[],
  count: number,
) {
  const groups = new Map<string, QuestionWithMeta[]>();
  for (const question of shuffleQuestions([...new Map(questions.map((q) => [q.id, q])).values()])) {
    if (topicIds.length && !topicIds.includes(question.topic_id)) continue;
    const group = groups.get(question.topic_id) ?? [];
    group.push(question);
    groups.set(question.topic_id, group);
  }
  const buckets = shuffleQuestions([...groups.values()]);
  const picked: string[] = [];
  while (picked.length < count && buckets.some((group) => group.length)) {
    for (const group of buckets) {
      const question = group.pop();
      if (question) picked.push(question.id);
      if (picked.length >= count) break;
    }
  }
  return shuffleQuestions(picked);
}

export function createExam(ids: string[], minutes: number, now = Date.now()): ExamSession {
  return {
    version: 1,
    ids,
    startedAt: now,
    deadline: now + minutes * 60_000,
    finishedAt: null,
    revealed: false,
    notes: {},
    attempted: [],
    flagged: [],
    ratings: {},
  };
}

export function examEnded(session: ExamSession, now: number) {
  return session.finishedAt !== null || now >= session.deadline;
}

export function formatExamTime(milliseconds: number) {
  const seconds = Math.max(0, Math.ceil(milliseconds / 1000));
  return `${Math.floor(seconds / 60)
    .toString()
    .padStart(2, '0')}:${(seconds % 60).toString().padStart(2, '0')}`;
}

/** Restore only our bounded session shape; never persist question content or solutions. */
export function parseExam(raw: string | null): ExamSession | null {
  try {
    if (!raw) return null;
    const value = JSON.parse(raw) as ExamSession;
    if (
      value.version !== 1 ||
      !Array.isArray(value.ids) ||
      !value.ids.length ||
      value.ids.length > 30 ||
      !value.ids.every((id) => typeof id === 'string') ||
      new Set(value.ids).size !== value.ids.length ||
      !Number.isFinite(value.startedAt) ||
      !Number.isFinite(value.deadline) ||
      value.deadline <= value.startedAt ||
      value.deadline - value.startedAt > 90 * 60_000 ||
      (value.finishedAt !== null &&
        (!Number.isFinite(value.finishedAt) ||
          value.finishedAt < value.startedAt ||
          value.finishedAt > value.deadline)) ||
      typeof value.revealed !== 'boolean'
    )
      return null;
    for (const list of [value.attempted, value.flagged]) {
      if (!Array.isArray(list) || !list.every((id) => value.ids.includes(id))) return null;
    }
    if (
      !value.notes ||
      !value.ratings ||
      typeof value.notes !== 'object' ||
      typeof value.ratings !== 'object'
    )
      return null;
    if (
      !Object.entries(value.notes).every(
        ([id, note]) => value.ids.includes(id) && typeof note === 'string' && note.length <= 10_000,
      )
    )
      return null;
    if (
      !Object.entries(value.ratings).every(
        ([id, rating]) =>
          value.ids.includes(id) && ['correct', 'incorrect', 'unsure'].includes(rating),
      )
    )
      return null;
    if (value.revealed && !examEnded(value, Date.now())) return null;
    return value;
  } catch {
    return null;
  }
}
