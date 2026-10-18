import { fireEvent, render, screen } from '@testing-library/react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import { Scratchpad } from './Scratchpad';

let mockUserId = 'student-a';

vi.mock('@/hooks/useAuth', () => ({
  useAuth: () => ({ user: { id: mockUserId } }),
}));

describe('Scratchpad', () => {
  beforeEach(() => {
    localStorage.clear();
    mockUserId = 'student-a';
  });

  it('opens, inserts math snippets, renders live math preview, and persists per user and question', () => {
    const view = render(<Scratchpad questionId="q-101" />);
    fireEvent.click(screen.getByRole('button', { name: 'Open scratchpad' }));

    const input = screen.getByRole('textbox', { name: 'Scratchpad working notes' });
    fireEvent.change(input, { target: { value: 'Let $f(x) = x^2$.' } });
    expect(screen.getByText('Saved locally')).toBeInTheDocument();
    expect(screen.getByRole('region', { name: 'Scratchpad math preview' })).toBeInTheDocument();

    fireEvent.click(screen.getByRole('button', { name: 'Integral' }));
    expect(input).toHaveValue('Let $f(x) = x^2$.$\\int_{a}^{b} f(x)\\,dx$');

    view.unmount();

    // Remounting for the same user and question automatically restores and opens notes
    const restored = render(<Scratchpad questionId="q-101" />);
    expect(screen.getByRole('textbox', { name: 'Scratchpad working notes' })).toHaveValue(
      'Let $f(x) = x^2$.$\\int_{a}^{b} f(x)\\,dx$',
    );
    restored.unmount();

    // Different question starts empty and collapsed
    const otherQuestion = render(<Scratchpad questionId="q-102" />);
    expect(screen.queryByRole('textbox', { name: 'Scratchpad working notes' })).not.toBeInTheDocument();
    otherQuestion.unmount();

    // Different user on the same question does not see student-a's scratchpad
    mockUserId = 'student-b';
    render(<Scratchpad questionId="q-101" />);
    expect(screen.queryByRole('textbox', { name: 'Scratchpad working notes' })).not.toBeInTheDocument();
  });

  it('clears notes and toggles math preview', () => {
    render(<Scratchpad questionId="q-clear" />);
    fireEvent.click(screen.getByRole('button', { name: 'Open scratchpad' }));
    const input = screen.getByRole('textbox', { name: 'Scratchpad working notes' });
    fireEvent.change(input, { target: { value: '$x + 1 = 2$' } });

    fireEvent.click(screen.getByRole('button', { name: 'Hide math preview' }));
    expect(screen.queryByRole('region', { name: 'Scratchpad math preview' })).not.toBeInTheDocument();

    fireEvent.click(screen.getByRole('button', { name: 'Clear scratchpad' }));
    expect(input).toHaveValue('');
    expect(screen.queryByText('Saved locally')).not.toBeInTheDocument();
  });
});
