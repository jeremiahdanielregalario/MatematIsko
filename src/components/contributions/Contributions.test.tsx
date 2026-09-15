import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { beforeEach, expect, it, vi } from 'vitest';
import { ContributionForm } from './ContributionForm';
import { ContributionCard } from './ContributionCard';
import { submitContribution, reviewContribution, type Contribution } from '@/lib/contributions';
vi.mock('@/lib/contributions', async (original) => ({
  ...(await original<typeof import('@/lib/contributions')>()),
  submitContribution: vi.fn(),
  reviewContribution: vi.fn(),
}));
const courses = [
  { id: 'course', code: 'MATH 21', name: 'Calculus', description: null, created_at: '' },
];
const topics = [{ id: 'topic', course_id: 'course', name: 'Derivatives' }];
const note: Contribution = {
  kind: 'note',
  course_id: 'course',
  title: 'Derivative notes',
  payload: { content: 'Differentiate:\n\n$$\nf(x) = x^2\n$$\n' },
  id: 'submission',
  author_id: 'author',
  author_name: 'Writer',
  status: 'pending',
  review_note: null,
  reviewed_at: null,
  published_id: null,
  created_at: '2026-09-15T00:00:00Z',
};
beforeEach(() => vi.clearAllMocks());
it('submits notes with previews and retains the draft and submission ID for retries', async () => {
  vi.mocked(submitContribution)
    .mockRejectedValueOnce(new Error('Connection lost'))
    .mockResolvedValueOnce(note);
  const submitted = vi.fn();
  render(
    <ContributionForm
      courses={courses}
      topics={topics}
      onSubmitted={submitted}
      onCancel={vi.fn()}
      initial={note}
    />,
  );
  expect(document.querySelector('.katex')).toBeInTheDocument();
  fireEvent.click(screen.getByRole('button', { name: 'Submit for review' }));
  expect(await screen.findByRole('alert')).toHaveTextContent('Connection lost');
  expect(screen.getByLabelText('Notes content')).toHaveValue(note.payload.content);
  expect(submitted).not.toHaveBeenCalled();
  fireEvent.click(screen.getByRole('button', { name: 'Submit for review' }));
  await waitFor(() => expect(submitted).toHaveBeenCalledOnce());
  const calls = vi.mocked(submitContribution).mock.calls;
  expect(calls[1][0]).toEqual(calls[0][0]);
  expect(calls[1][1]).toEqual({
    kind: 'note',
    course_id: 'course',
    title: note.title,
    payload: note.payload,
  });
});
it('submits question content and clears topic when changing course', async () => {
  vi.mocked(submitContribution).mockResolvedValue(note);
  const done = vi.fn();
  render(
    <ContributionForm
      courses={[...courses, { ...courses[0], id: 'other', code: 'MATH 22' }]}
      topics={topics}
      onSubmitted={done}
      onCancel={vi.fn()}
    />,
  );
  fireEvent.change(screen.getByLabelText('Course'), { target: { value: 'course' } });
  fireEvent.change(screen.getByLabelText('Topic'), { target: { value: 'topic' } });
  fireEvent.change(screen.getByLabelText('Course'), { target: { value: 'other' } });
  expect(screen.getByLabelText('Topic')).toHaveValue('');
  fireEvent.change(screen.getByLabelText('Course'), { target: { value: 'course' } });
  fireEvent.change(screen.getByLabelText('Topic'), { target: { value: 'topic' } });
  for (const [label, value] of [
    ['Title', 'Derivative'],
    ['Source / exam name', 'Original'],
    ['Question text', 'Compute.'],
    ['Answer', '1'],
    ['Solution', 'Explanation.'],
  ])
    fireEvent.change(screen.getByLabelText(label), { target: { value } });
  fireEvent.click(screen.getByRole('button', { name: 'Submit for review' }));
  await waitFor(() => expect(done).toHaveBeenCalledOnce());
  expect(vi.mocked(submitContribution).mock.calls[0][1]).toMatchObject({
    kind: 'question',
    payload: { topic_id: 'topic', answer: '1', solution: 'Explanation.' },
  });
});
it('requires rejection feedback and preserves failed reviews for retry', async () => {
  vi.mocked(reviewContribution)
    .mockRejectedValueOnce(new Error('Network failure'))
    .mockResolvedValueOnce({ ...note, status: 'rejected' });
  const reviewed = vi.fn();
  render(
    <MemoryRouter>
      <ContributionCard item={note} courseName="MATH 21" admin onReviewed={reviewed} />
    </MemoryRouter>,
  );
  fireEvent.click(screen.getByRole('button', { name: 'Review submission' }));
  expect(document.querySelector('.katex')).toBeInTheDocument();
  fireEvent.click(screen.getByRole('button', { name: 'Reject submission' }));
  expect(reviewContribution).not.toHaveBeenCalled();
  fireEvent.change(screen.getByLabelText('Feedback (required when rejecting)'), {
    target: { value: 'Explain the power rule.' },
  });
  fireEvent.click(screen.getByRole('button', { name: 'Reject submission' }));
  expect(await screen.findByRole('alert')).toHaveTextContent('Network failure');
  fireEvent.click(screen.getByRole('button', { name: 'Reject submission' }));
  await waitFor(() => expect(reviewed).toHaveBeenCalledOnce());
  expect(reviewContribution).toHaveBeenLastCalledWith(
    'submission',
    'rejected',
    'Explain the power rule.',
  );
});
it('publishes through the review action and disables duplicate approvals while pending', async () => {
  let finish!: (value: Contribution) => void;
  vi.mocked(reviewContribution).mockImplementation(
    () =>
      new Promise((resolve) => {
        finish = resolve;
      }),
  );
  const reviewed = vi.fn();
  render(
    <MemoryRouter>
      <ContributionCard item={note} courseName="MATH 21" admin onReviewed={reviewed} />
    </MemoryRouter>,
  );
  fireEvent.click(screen.getByRole('button', { name: 'Review submission' }));
  fireEvent.click(screen.getByRole('button', { name: 'Approve and publish' }));
  expect(screen.getByRole('button', { name: 'Saving review…' })).toBeDisabled();
  expect(reviewContribution).toHaveBeenCalledExactlyOnceWith('submission', 'approved', '');
  finish({ ...note, status: 'approved' });
  await waitFor(() => expect(reviewed).toHaveBeenCalledOnce());
});
it('shows contributor feedback and revision controls without admin review actions', () => {
  const revise = vi.fn();
  render(
    <MemoryRouter>
      <ContributionCard
        item={{ ...note, status: 'rejected', review_note: 'Please add examples.' }}
        courseName="MATH 21"
        onReviewed={vi.fn()}
        onRevise={revise}
      />
    </MemoryRouter>,
  );
  expect(screen.getByText('Please add examples.')).toBeInTheDocument();
  expect(screen.queryByRole('button', { name: 'Approve and publish' })).not.toBeInTheDocument();
  fireEvent.click(screen.getByRole('button', { name: 'Revise and resubmit' }));
  expect(revise).toHaveBeenCalledOnce();
});
