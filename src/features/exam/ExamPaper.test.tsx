import { act, fireEvent, render, screen, within } from '@testing-library/react';
import { afterEach, describe, expect, it, vi } from 'vitest';
import { useState } from 'react';
import type { QuestionWithMeta } from '@/types';
import { ExamPaper } from './ExamPaper';
import { ExamSetup } from './ExamSetup';
import { ExamWorkspace } from './ExamWorkspace';
import { createExam, type ExamSession } from './exam';

const questions = [
  {
    id: 'a',
    topic_id: 't1',
    course_id: 'c',
    title: 'First problem',
    question_text: 'Solve $x+1=2$.',
    answer: 'Secret answer',
    solution: 'Secret worked solution',
    hint: 'Secret hint',
    topic: { id: 't1', name: 'Algebra' },
    bookmarked: false,
  },
  {
    id: 'b',
    topic_id: 't2',
    course_id: 'c',
    title: 'Second problem',
    question_text: 'Solve $x+2=3$.',
    answer: 'Second answer',
    solution: 'Second solution',
    bookmarked: false,
  },
] as QuestionWithMeta[];
function Paper({ initial }: { initial?: ExamSession }) {
  const [session, setSession] = useState(initial ?? createExam(['a', 'b'], 45));
  return (
    <ExamPaper
      session={session}
      questions={questions}
      onChange={setSession}
      onNew={vi.fn()}
      onRetry={vi.fn()}
    />
  );
}
afterEach(() => {
  vi.useRealTimers();
  sessionStorage.clear();
});

it('confirms replacement, clears only replaced work and persists the new paper', () => {
  const key = 'exam-replace';
  const spare = { ...questions[0], id: 'spare', title: 'Replacement problem' };
  const initial = {
    ...createExam(['a', 'b'], 20),
    notes: { a: 'Old work', b: 'Keep work' },
    flagged: ['a'],
    attempted: ['a'],
  };
  sessionStorage.setItem(key, JSON.stringify(initial));
  const view = render(
    <ExamWorkspace storageKey={key} questions={[...questions, spare]} courses={[]} />,
  );
  expect(screen.getByRole('button', { name: 'Replace question 2' })).toBeDisabled();
  fireEvent.click(screen.getByRole('button', { name: 'Replace question 1' }));
  fireEvent.click(screen.getByRole('button', { name: 'Keep question' }));
  expect(screen.getByDisplayValue('Old work')).toBeInTheDocument();
  fireEvent.click(screen.getByRole('button', { name: 'Replace question 1' }));
  fireEvent.click(screen.getByRole('button', { name: 'Replace & clear working' }));
  expect(screen.getByText('Replacement problem')).toBeInTheDocument();
  expect(screen.queryByText('First problem')).not.toBeInTheDocument();
  expect(screen.getByDisplayValue('Keep work')).toBeInTheDocument();
  expect(screen.queryByText('Secret answer')).not.toBeInTheDocument();
  const saved = JSON.parse(sessionStorage.getItem(key)!);
  expect(saved.ids).toEqual(['spare', 'b']);
  expect(saved.deadline).toBe(initial.deadline);
  expect(saved.attempted).toEqual([]);
  expect(saved.flagged).toEqual([]);
  view.unmount();
  render(<ExamWorkspace storageKey={key} questions={[...questions, spare]} courses={[]} />);
  expect(screen.getByText('Replacement problem')).toBeInTheDocument();
});

it('rejects a replacement confirmed after the deadline before a timer tick', () => {
  vi.useFakeTimers();
  const initial = createExam(['a', 'b'], 5);
  const onChange = vi.fn();
  render(
    <ExamPaper
      session={initial}
      questions={questions}
      bank={[...questions, { ...questions[0], id: 'spare' }]}
      onChange={onChange}
      onNew={vi.fn()}
      onRetry={vi.fn()}
    />,
  );
  fireEvent.click(screen.getByRole('button', { name: 'Replace question 1' }));
  vi.setSystemTime(initial.deadline);
  fireEvent.click(screen.getByRole('button', { name: 'Replace & clear working' }));
  expect(onChange).not.toHaveBeenCalled();
});
describe('exam review workflow', () => {
  it('preserves server-redacted solutions during completed-paper review', () => {
    const session = { ...createExam(['a'], 45), finishedAt: Date.now(), revealed: true };
    render(
      <ExamPaper
        session={session}
        questions={[{ ...questions[0], solution: 'Not available' }]}
        onChange={vi.fn()}
        onNew={vi.fn()}
        onRetry={vi.fn()}
      />,
    );
    expect(screen.getByText('Not available')).toBeInTheDocument();
    expect(screen.getByText('Secret answer')).toBeInTheDocument();
    expect(screen.queryByText('Secret worked solution')).not.toBeInTheDocument();
  });
  it('renders the full paper and locks all support until finish plus explicit reveal', () => {
    render(<Paper />);
    expect(screen.getByText('First problem')).toBeInTheDocument();
    expect(screen.getByText('Second problem')).toBeInTheDocument();
    fireEvent.keyDown(window, { key: 'a' });
    fireEvent.keyDown(window, { key: 's' });
    expect(screen.queryByText('Secret answer')).not.toBeInTheDocument();
    expect(screen.queryByText('Secret worked solution')).not.toBeInTheDocument();
    expect(screen.queryByText('Secret hint')).not.toBeInTheDocument();
    const response = screen.getAllByRole('textbox')[0];
    fireEvent.change(response, { target: { value: 'My answer' } });
    fireEvent.click(screen.getByRole('button', { name: "I'm done" }));
    fireEvent.click(screen.getByRole('button', { name: 'Keep working' }));
    expect(response).not.toHaveAttribute('readonly');
    fireEvent.click(screen.getByRole('button', { name: 'Finish paper' }));
    fireEvent.click(screen.getByRole('button', { name: 'Finish & lock responses' }));
    expect(response).toHaveAttribute('readonly');
    expect(response).toHaveValue('My answer');
    expect(screen.queryByText('Secret answer')).not.toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Reveal answers & solutions' }));
    expect(screen.getByText('Secret answer')).toBeInTheDocument();
    fireEvent.click(
      within(screen.getByRole('region', { name: 'Review question 1' })).getByRole('button', {
        name: 'Incorrect',
      }),
    );
    fireEvent.click(
      within(screen.getByRole('region', { name: 'Review question 2' })).getByRole('button', {
        name: 'Correct',
      }),
    );
    expect(screen.getByRole('button', { name: 'Retry missed & unsure (1)' })).toBeEnabled();
  });
  it('finishes on expiry without automatically revealing answers', () => {
    vi.useFakeTimers();
    render(<Paper initial={createExam(['a', 'b'], 5)} />);
    act(() => vi.advanceTimersByTime(300_000));
    expect(screen.getByText("Time's up — your paper is complete.")).toBeInTheDocument();
    expect(screen.getAllByRole('textbox')[0]).toHaveAttribute('readonly');
    expect(screen.queryByText('Secret answer')).not.toBeInTheDocument();
    expect(screen.getByRole('timer')).toHaveTextContent('05:00');
  });
  it('blocks a late edit even before the next timer tick', () => {
    vi.useFakeTimers();
    const initial = createExam(['a', 'b'], 5);
    const onChange = vi.fn();
    render(
      <ExamPaper
        session={initial}
        questions={questions}
        onChange={onChange}
        onNew={vi.fn()}
        onRetry={vi.fn()}
      />,
    );
    vi.setSystemTime(initial.deadline + 1);
    fireEvent.change(screen.getAllByRole('textbox')[0], { target: { value: 'Too late' } });
    expect(onChange).not.toHaveBeenCalled();
  });
  it('restores the same paper and notes after remount, isolated by user key', () => {
    const key = 'exam-test:student-a';
    sessionStorage.setItem(
      key,
      JSON.stringify({ ...createExam(['a', 'b'], 45), notes: { a: 'Saved working' } }),
    );
    const view = render(<ExamWorkspace storageKey={key} questions={questions} courses={[]} />);
    expect(screen.getAllByRole('textbox')[0]).toHaveValue('Saved working');
    view.unmount();
    render(<ExamWorkspace storageKey="exam-test:student-b" questions={questions} courses={[]} />);
    expect(screen.getByText('Build your paper')).toBeInTheDocument();
    expect(screen.queryByDisplayValue('Saved working')).not.toBeInTheDocument();
  });
  it('requires enough questions to cover explicitly selected topics', () => {
    render(<ExamSetup questions={questions} courses={[]} onStart={vi.fn()} />);
    screen.getAllByRole('checkbox').forEach((box) => fireEvent.click(box));
    fireEvent.change(screen.getByRole('spinbutton', { name: 'Number of questions' }), {
      target: { value: '1' },
    });
    expect(screen.getByRole('button', { name: 'Create paper & start timer' })).toBeDisabled();
  });
});

it('warns when saving is unavailable instead of promising refresh recovery', () => {
  const storage = vi.spyOn(Storage.prototype, 'setItem').mockImplementation(() => {
    throw new Error('Storage full');
  });
  render(<ExamWorkspace storageKey="exam-storage-failure" questions={questions} courses={[]} />);
  fireEvent.click(screen.getByRole('button', { name: 'Create paper & start timer' }));
  expect(screen.getByRole('alert')).toHaveTextContent('could not save your paper');
  expect(screen.getByText('First problem')).toBeInTheDocument();
  storage.mockRestore();
});

it('retries only missed questions with locked answers and a fresh timer', () => {
  const completed = {
    ...createExam(['a', 'b'], 20),
    finishedAt: Date.now(),
    revealed: true,
    ratings: { a: 'incorrect', b: 'correct' } as const,
  };
  sessionStorage.setItem('exam-retry', JSON.stringify(completed));
  render(<ExamWorkspace storageKey="exam-retry" questions={questions} courses={[]} />);
  fireEvent.click(screen.getByRole('button', { name: 'Retry missed & unsure (1)' }));
  expect(screen.getByText('First problem')).toBeInTheDocument();
  expect(screen.queryByText('Second problem')).not.toBeInTheDocument();
  expect(screen.queryByText('Secret answer')).not.toBeInTheDocument();
  expect(screen.getByRole('timer')).toHaveTextContent('20:00');
});
