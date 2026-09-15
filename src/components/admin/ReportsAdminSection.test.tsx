import { render, screen, waitFor, within } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { expect, it, vi } from 'vitest';
import { ReportsAdminSection } from './ReportsAdminSection';
import { adminDeleteReport } from '@/lib/reports';
vi.mock('@/lib/reports', () => ({
  adminListQuestionReports: async () => [
    {
      id: 'report-1',
      question_id: 'question-1',
      question_title: 'Test question',
      course_code: 'MATH 21',
      status: 'open',
      category: 'other',
      description: 'Test report',
      created_at: new Date().toISOString(),
    },
  ],
  adminListTheoremReports: async () => [],
  adminDeleteReport: vi.fn(async () => {}),
  adminResolveReport: vi.fn(),
  adminReopenReport: vi.fn(),
}));
it('returns focus on cancellation and updates the inbox after confirmed deletion', async () => {
  const user = userEvent.setup();
  render(<ReportsAdminSection />);
  const trigger = await screen.findByRole('button', { name: 'Delete report' });
  await user.click(trigger);
  await user.click(screen.getByRole('button', { name: 'Keep report' }));
  await waitFor(() => expect(trigger).toHaveFocus());
  expect(adminDeleteReport).not.toHaveBeenCalled();
  await user.click(trigger);
  await user.click(
    within(screen.getByRole('dialog')).getByRole('button', { name: 'Delete report' }),
  );
  await screen.findByText('No question reports');
  expect(screen.getByRole('status')).toHaveTextContent('Report deleted.');
  expect(screen.getByText('0 open · 0 resolved')).toBeInTheDocument();
  expect(adminDeleteReport).toHaveBeenCalledExactlyOnceWith('question_reports', 'report-1');
  await waitFor(() => expect(screen.getByRole('heading', { name: 'Reports' })).toHaveFocus());
});
