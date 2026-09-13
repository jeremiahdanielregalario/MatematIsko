import { fireEvent, render, screen } from '@testing-library/react';
import { expect, it, vi } from 'vitest';
import { ReportDialog } from './ReportButton';

it('explains a duplicate rejection and retains the report details', async () => {
  const message =
    'A report has already been sent for this question with the same reason. Please wait for it to be addressed.';
  const submit = vi.fn().mockRejectedValue(new Error(message));
  render(<ReportDialog open onOpenChange={vi.fn()} kind="question" onSubmit={submit} />);
  fireEvent.change(screen.getByRole('textbox'), { target: { value: 'My details' } });
  fireEvent.click(screen.getByRole('button', { name: 'Submit Report' }));
  expect(await screen.findByRole('alert')).toHaveTextContent(message);
  expect(screen.getByRole('textbox')).toHaveValue('My details');
  expect(screen.queryByText(/Thank you for your feedback/)).not.toBeInTheDocument();
  expect(screen.getByRole('button', { name: 'Submit Report' })).toBeEnabled();
});
