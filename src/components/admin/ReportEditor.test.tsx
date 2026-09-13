import { fireEvent, render, screen } from '@testing-library/react';
import { describe, expect, it, vi } from 'vitest';
import { ReportEditor } from './ReportEditor';
import { getQuestionById, getTheoremById } from '@/lib/db';
vi.mock('@/lib/db', () => ({
  getCourses: vi.fn().mockResolvedValue([]),
  getTopics: vi.fn().mockResolvedValue([]),
  getQuestionById: vi.fn(),
  getTheoremById: vi.fn(),
}));
vi.mock('./QuestionForm', () => ({
  QuestionForm: ({
    initial,
    onSaved,
  }: {
    initial: { id: string };
    onSaved: (value: { id: string }) => void;
  }) => <button onClick={() => onSaved(initial)}>Save test content</button>,
}));
vi.mock('./TheoremForm', () => ({
  TheoremForm: ({ onSaved }: { onSaved: () => void }) => (
    <button onClick={onSaved}>Save theorem</button>
  ),
}));
describe('ReportEditor', () => {
  it('loads the exact reported question and closes after a successful save', async () => {
    vi.mocked(getQuestionById).mockResolvedValue({ id: 'reported-id' } as never);
    const close = vi.fn();
    render(<ReportEditor kind="question" contentId="reported-id" onClose={close} />);
    fireEvent.click(await screen.findByText('Save test content'));
    expect(getQuestionById).toHaveBeenCalledWith('reported-id');
    expect(close).toHaveBeenCalledOnce();
  });
  it('shows an actionable error when reported content no longer exists', async () => {
    vi.mocked(getQuestionById).mockResolvedValue(null);
    render(<ReportEditor kind="question" contentId="missing" onClose={() => {}} />);
    expect(await screen.findByRole('alert')).toHaveTextContent('no longer available');
    expect(screen.getByRole('button', { name: 'Retry' })).toBeInTheDocument();
  });
});

it('closes the theorem editor after a successful save', async () => {
  vi.mocked(getTheoremById).mockResolvedValue({ id: 'theorem-id' } as never);
  const close = vi.fn();
  render(<ReportEditor kind="theorem" contentId="theorem-id" onClose={close} />);
  const save = await screen.findByText('Save theorem');
  expect(close).not.toHaveBeenCalled();
  fireEvent.click(save);
  expect(close).toHaveBeenCalledOnce();
});
