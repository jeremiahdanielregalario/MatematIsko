import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { DeleteReportDialog, type ReportToDelete } from './DeleteReportDialog';
import { adminDeleteReport } from '@/lib/reports';
vi.mock('@/lib/reports', () => ({ adminDeleteReport: vi.fn() }));
const report: ReportToDelete = {
  table: 'question_reports',
  id: 'report-1',
  title: 'Derivative question',
  course: 'MATH 21',
  category: 'incorrect_answer',
  status: 'open',
  description: 'Check the sign.',
};
beforeEach(() => vi.clearAllMocks());
describe('report deletion confirmation', () => {
  it('shows report context, focuses the safe action, and cancels without deleting', async () => {
    const close = vi.fn();
    render(
      <DeleteReportDialog
        report={report}
        onClose={close}
        onDeleted={vi.fn()}
        onReturnFocus={vi.fn()}
      />,
    );
    expect(screen.getByRole('dialog')).toHaveTextContent('Derivative question');
    expect(screen.getByRole('dialog')).toHaveTextContent('Check the sign.');
    await waitFor(() => expect(screen.getByRole('button', { name: 'Keep report' })).toHaveFocus());
    fireEvent.click(screen.getByRole('button', { name: 'Keep report' }));
    expect(close).toHaveBeenCalledOnce();
    expect(adminDeleteReport).not.toHaveBeenCalled();
  });

  it.each(['question_reports', 'theorem_reports'] as const)(
    'deletes only the selected %s record and blocks dismissal while pending',
    async (table) => {
      let finish!: () => void;
      vi.mocked(adminDeleteReport).mockImplementation(
        () =>
          new Promise<void>((resolve) => {
            finish = resolve;
          }),
      );
      const close = vi.fn();
      const deleted = vi.fn();
      render(
        <DeleteReportDialog
          report={{ ...report, table }}
          onClose={close}
          onDeleted={deleted}
          onReturnFocus={vi.fn()}
        />,
      );
      fireEvent.click(screen.getByRole('button', { name: 'Delete report' }));
      expect(screen.getByRole('button', { name: 'Deleting…' })).toBeDisabled();
      expect(screen.getByRole('button', { name: 'Keep report' })).toBeDisabled();
      fireEvent.click(screen.getByRole('button', { name: 'Close' }));
      expect(close).not.toHaveBeenCalled();
      expect(adminDeleteReport).toHaveBeenCalledExactlyOnceWith(table, 'report-1');
      finish();
      await waitFor(() => expect(deleted).toHaveBeenCalledWith({ ...report, table }));
      expect(close).toHaveBeenCalledOnce();
    },
  );

  it('keeps a failed deletion open and allows retry', async () => {
    vi.mocked(adminDeleteReport)
      .mockRejectedValueOnce(new Error('Connection lost'))
      .mockResolvedValueOnce(undefined);
    const close = vi.fn();
    const deleted = vi.fn();
    render(
      <DeleteReportDialog
        report={report}
        onClose={close}
        onDeleted={deleted}
        onReturnFocus={vi.fn()}
      />,
    );
    fireEvent.click(screen.getByRole('button', { name: 'Delete report' }));
    expect(await screen.findByRole('alert')).toHaveTextContent('Connection lost');
    expect(close).not.toHaveBeenCalled();
    expect(deleted).not.toHaveBeenCalled();
    fireEvent.click(screen.getByRole('button', { name: 'Delete report' }));
    await waitFor(() => expect(deleted).toHaveBeenCalledOnce());
  });
});
