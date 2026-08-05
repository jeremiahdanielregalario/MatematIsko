import type { QuestionWithMeta } from '@/types';

export type AnswerResult = 'correct' | 'incorrect' | 'unsure';

export interface PracticeAnswer {
  questionId: string;
  result: AnswerResult;
}

export function shuffleQuestions<T>(list: T[]): T[] {
  const result = [...list];
  for (let i = result.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [result[i], result[j]] = [result[j], result[i]];
  }
  return result;
}

export interface PracticeResultsSummary {
  correct: number;
  incorrect: number;
  unsure: number;
  attempted: number;
  total: number;
  accuracy: number;
  reviewIds: string[];
}

export function computePracticeResults(
  answers: PracticeAnswer[],
  total: number,
): PracticeResultsSummary {
  const correct = answers.filter((a) => a.result === 'correct').length;
  const incorrect = answers.filter((a) => a.result === 'incorrect').length;
  const unsure = answers.filter((a) => a.result === 'unsure').length;
  const attempted = answers.length;
  return {
    correct,
    incorrect,
    unsure,
    attempted,
    total,
    accuracy: attempted === 0 ? 0 : Math.round((correct / attempted) * 100),
    reviewIds: answers.filter((a) => a.result !== 'correct').map((a) => a.questionId),
  };
}

export function toMetaQuestions(
  ids: string[],
  all: QuestionWithMeta[],
): QuestionWithMeta[] {
  const byId = new Map(all.map((q) => [q.id, q]));
  return ids.map((id) => byId.get(id)).filter((q): q is QuestionWithMeta => Boolean(q));
}
