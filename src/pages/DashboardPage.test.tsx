import { fireEvent, render, screen, within } from '@testing-library/react';
import { beforeEach, expect, it, vi } from 'vitest';
import { MemoryRouter, useLocation } from 'react-router-dom';
import type { QuestionWithMeta } from '@/types';
const state = vi.hoisted(() => ({
  questions: [] as QuestionWithMeta[],
  loading: false,
  error: null as Error | null,
  reload: vi.fn(),
  statuses: {} as Record<string, 'mastered'>,
}));
vi.mock('@/hooks/useAuth', () => ({
  useAuth: () => ({ profile: { full_name: 'Sample Student' } }),
}));
vi.mock('@/hooks/useQuestions', () => ({
  useQuestions: () => ({
    data: state.questions,
    loading: state.loading,
    error: state.error,
    reload: state.reload,
  }),
}));
vi.mock('@/hooks/usePwaInstall', () => ({ usePwaInstall: () => ({ isInstallable: false }) }));
vi.mock('@/hooks/useQuestionMutations', () => ({
  useQuestionMutations: () => ({
    statuses: state.statuses,
    attempts: {},
    bookmarks: {},
    toggleBookmark: vi.fn(),
    setStatus: vi.fn(),
  }),
}));
import { DashboardPage } from './DashboardPage';
function Location() {
  const current = useLocation();
  return (
    <div aria-label="Location">
      {current.pathname}
      {current.search}
    </div>
  );
}
function mount(path = '/dashboard') {
  return render(
    <MemoryRouter initialEntries={[path]}>
      <DashboardPage />
      <Location />
    </MemoryRouter>,
  );
}
function question(
  id: string,
  status: 'learning' | 'mastered' | 'unseen' = 'unseen',
  course = 'a',
): QuestionWithMeta {
  return {
    id,
    course_id: course,
    topic_id: `topic-${course}`,
    title: `Problem ${id}`,
    question_text: 'Find $x$.',
    difficulty: 'easy',
    year: 2026,
    exam_name: 'Exam',
    question_number: 1,
    answer: 'Secret answer',
    solution: 'Secret solution',
    hint: null,
    created_at: '2026-01-01',
    updated_at: '2026-01-01',
    bookmarked: false,
    course: {
      id: course,
      code: `MATH ${course}`,
      name: 'Analysis',
      description: null,
      created_at: '2026-01-01',
    },
    topic: { id: `topic-${course}`, course_id: course, name: 'Limits' },
    progress: {
      user_id: 'user',
      question_id: id,
      status,
      attempts: 1,
      mastered_at: null,
      last_attempted_at: '2026-01-01',
    },
  };
}
beforeEach(() => {
  state.questions = [
    question('learning', 'learning'),
    question('new'),
    question('done', 'mastered', 'b'),
  ];
  state.loading = false;
  state.error = null;
  state.statuses = {};
  vi.clearAllMocks();
});
it('offers a learning problem first with study context and no revealed answers', () => {
  mount();
  expect(screen.getByRole('link', { name: /Review this problem/ })).toHaveAttribute(
    'href',
    '/questions/learning?course=a&topic=topic-a',
  );
  expect(screen.queryByText('Secret answer')).not.toBeInTheDocument();
  expect(screen.getByRole('link', { name: /Timed paper/ })).toHaveAttribute(
    'href',
    '/practice/exam',
  );
});
it('filters the queue and keeps course selection in the URL', () => {
  mount();
  fireEvent.click(screen.getByRole('button', { name: /^Needs review/ }));
  expect(screen.getByRole('link', { name: 'Problem learning' })).toBeInTheDocument();
  expect(screen.queryByRole('link', { name: 'Problem new' })).not.toBeInTheDocument();
  fireEvent.change(screen.getByRole('combobox', { name: 'Focus course' }), {
    target: { value: 'b' },
  });
  expect(screen.getByLabelText('Location')).toHaveTextContent('course=b');
  expect(screen.getByText('No problems marked learning')).toBeInTheDocument();
});
it('paginates six at a time and resets the page after a filter change', () => {
  state.questions = Array.from({ length: 8 }, (_, index) => question(String(index)));
  mount();
  expect(screen.getByRole('status')).toHaveTextContent('1–6 of 8');
  fireEvent.click(screen.getByRole('button', { name: 'Next' }));
  expect(screen.getByRole('status')).toHaveTextContent('7–8 of 8');
  fireEvent.click(screen.getByRole('button', { name: /^Unseen/ }));
  expect(screen.getByRole('status')).toHaveTextContent('1–6 of 8');
});
it('shows mastered and empty states accurately, and disables empty random selection', () => {
  state.questions = [];
  const empty = mount();
  expect(screen.getByRole('button', { name: 'Give me a random problem' })).toBeDisabled();
  expect(screen.getByRole('link', { name: /Choose your courses/ })).toHaveAttribute(
    'href',
    '/profile',
  );
  empty.unmount();
  state.questions = [question('done', 'mastered')];
  mount();
  expect(screen.getByText('Every loaded problem is mastered')).toBeInTheDocument();
});
it('uses current mastery overlays for progress and random priority', () => {
  state.questions = [question('one'), question('two')];
  state.statuses = { one: 'mastered' };
  mount('/dashboard?tab=progress');
  expect(screen.getByRole('progressbar', { name: 'MATH a question mastery' })).toHaveAttribute(
    'aria-valuenow',
    '50',
  );
  expect(screen.getByRole('link', { name: 'Read notes' })).toHaveAttribute(
    'href',
    '/courses/a?tab=notes',
  );
  fireEvent.click(screen.getByRole('button', { name: 'Give me a random problem' }));
  expect(screen.getByLabelText('Location')).toHaveTextContent('/questions/two?mode=random');
});
it('preserves saved mastered questions and recovers invalid filters', () => {
  state.questions = [{ ...question('saved', 'mastered'), bookmarked: true }];
  mount('/dashboard?filter=bad&course=missing&page=invalid');
  fireEvent.click(screen.getByRole('button', { name: /^Saved/ }));
  expect(screen.getByRole('link', { name: 'Problem saved' })).toBeInTheDocument();
  expect(
    within(screen.getByRole('navigation', { name: 'Review list pages' })).getByRole('button', {
      name: 'Previous',
    }),
  ).toBeDisabled();
});
it('shows a recoverable load error', () => {
  state.error = new Error('Network unavailable');
  mount();
  fireEvent.click(screen.getByRole('button', { name: 'Try again' }));
  expect(state.reload).toHaveBeenCalled();
});
