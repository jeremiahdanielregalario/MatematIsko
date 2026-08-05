import { DIFFICULTY_ORDER, type QuestionFilter, type QuestionWithMeta } from '@/types';

function shuffle<T>(list: T[]): T[] {
  const result = [...list];
  for (let i = result.length - 1; i > 0; i -= 1) {
    const j = Math.floor(Math.random() * (i + 1));
    [result[i], result[j]] = [result[j], result[i]];
  }
  return result;
}

export function applyFilterAndSort(
  questions: QuestionWithMeta[],
  filter: QuestionFilter,
): QuestionWithMeta[] {
  let result = questions;

  const search = filter.search?.trim().toLowerCase();
  if (search) {
    result = result.filter((q) => {
      const haystack = [
        q.title,
        q.question_text,
        q.exam_name,
        q.course?.code,
        q.course?.name,
        q.topic?.name,
      ]
        .filter(Boolean)
        .join(' ')
        .toLowerCase();
      return haystack.includes(search);
    });
  }

  if (filter.courseId) result = result.filter((q) => q.course_id === filter.courseId);
  if (filter.topicId) result = result.filter((q) => q.topic_id === filter.topicId);
  if (filter.difficulty) result = result.filter((q) => q.difficulty === filter.difficulty);
  if (filter.year) result = result.filter((q) => q.year === filter.year);

  switch (filter.status) {
    case 'bookmarked':
      result = result.filter((q) => q.bookmarked);
      break;
    case 'mastered':
      result = result.filter((q) => q.progress?.status === 'mastered');
      break;
    case 'learning':
      result = result.filter((q) => q.progress?.status === 'learning');
      break;
    case 'unseen':
      result = result.filter((q) => !q.progress || q.progress.status === 'unseen');
      break;
    default:
      break;
  }

  const sorted = [...result];
  switch (filter.sort ?? 'newest') {
    case 'newest':
      sorted.sort((a, b) => b.created_at.localeCompare(a.created_at));
      break;
    case 'oldest':
      sorted.sort((a, b) => a.created_at.localeCompare(b.created_at));
      break;
    case 'difficulty':
      sorted.sort(
        (a, b) => DIFFICULTY_ORDER[a.difficulty] - DIFFICULTY_ORDER[b.difficulty],
      );
      break;
    case 'recent':
      sorted.sort((a, b) => {
        const at = a.progress?.last_attempted_at ?? '';
        const bt = b.progress?.last_attempted_at ?? '';
        return bt.localeCompare(at);
      });
      break;
    case 'random':
      return shuffle(sorted);
    default:
      break;
  }

  return sorted;
}

export function pickRandom<T>(list: T[]): T | undefined {
  if (list.length === 0) return undefined;
  return list[Math.floor(Math.random() * list.length)];
}
