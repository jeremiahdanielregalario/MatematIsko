import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { beforeEach, expect, it, vi } from 'vitest';
import type { Profile } from '@/types';
const { load, reset } = vi.hoisted(() => ({ load: vi.fn(), reset: vi.fn() }));
vi.mock('@/lib/adminProgress', () => ({ adminUserProgress: load, adminResetUserProgress: reset }));
import { UserProgressDialog } from './UserProgressDialog';
const profile = {
  id: 'student',
  full_name: 'Sample Student',
  email: 'sample@example.test',
} as Profile;
const course = {
  id: 'course',
  code: 'MATH 21',
  name: 'Calculus',
  selected: true,
  questions_total: 10,
  questions_learning: 2,
  questions_mastered: 3,
  question_records: 5,
  attempts: 8,
  theorems_total: 4,
  theorems_learning: 1,
  theorems_mastered: 1,
  theorem_records: 2,
  last_activity: null,
};
beforeEach(() => {
  vi.clearAllMocks();
  load.mockResolvedValue([course]);
  reset.mockResolvedValue(undefined);
});
it('shows course choices and separate question/theorem progress', async () => {
  render(<UserProgressDialog profile={profile} onClose={vi.fn()} />);
  expect(await screen.findByText('Selected course')).toBeInTheDocument();
  expect(screen.getByText(/Questions: 3\/10 mastered/)).toHaveTextContent('5 unseen');
  expect(screen.getByText(/Theorems: 1\/4 mastered/)).toBeInTheDocument();
  expect(load).toHaveBeenCalledWith('student');
});
it('confirms the scope before resetting and reloads after success', async () => {
  render(<UserProgressDialog profile={profile} onClose={vi.fn()} />);
  fireEvent.click(await screen.findByRole('button', { name: 'Reset MATH 21 progress' }));
  expect(reset).not.toHaveBeenCalled();
  fireEvent.click(screen.getByRole('button', { name: 'Cancel reset' }));
  expect(reset).not.toHaveBeenCalled();
  fireEvent.click(screen.getByRole('button', { name: 'Reset MATH 21 progress' }));
  fireEvent.click(screen.getByRole('button', { name: 'Confirm reset' }));
  await screen.findByText('Progress reset for MATH 21.');
  expect(reset).toHaveBeenCalledWith('student', 'course');
  await waitFor(() => expect(load).toHaveBeenCalledTimes(2));
});
it('keeps failed all-course resets available for retry', async () => {
  reset.mockRejectedValue(new Error('Permission denied'));
  render(<UserProgressDialog profile={profile} onClose={vi.fn()} />);
  fireEvent.click(await screen.findByRole('button', { name: 'Reset all progress' }));
  fireEvent.click(screen.getByRole('button', { name: 'Confirm reset' }));
  expect(await screen.findByRole('alert')).toHaveTextContent('Permission denied');
  expect(reset).toHaveBeenCalledWith('student', null);
  expect(screen.queryByRole('status')).not.toBeInTheDocument();
  expect(screen.getByRole('button', { name: 'Confirm reset' })).toBeEnabled();
});
it('shows load errors and permits retry', async () => {
  load.mockRejectedValueOnce(new Error('Unavailable'));
  render(<UserProgressDialog profile={profile} onClose={vi.fn()} />);
  await screen.findByText('Unavailable');
  fireEvent.click(screen.getByRole('button', { name: /try again/i }));
  await screen.findByText('Selected course');
});
it('disables resets when no progress exists', async () => {
  load.mockResolvedValue([{ ...course, question_records: 0, theorem_records: 0 }]);
  render(<UserProgressDialog profile={profile} onClose={vi.fn()} />);
  expect(await screen.findByRole('button', { name: 'Reset all progress' })).toBeDisabled();
  expect(screen.getByRole('button', { name: 'Reset MATH 21 progress' })).toBeDisabled();
});
