import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, it, vi } from 'vitest';
import { RevealSection } from './RevealSection';

const CONTENT = {
  hint: 'Factor the numerator.',
  answer: '$$4$$',
  solution: 'Cancel the common factor and substitute.',
};

function renderAt(level: 'hidden' | 'hint' | 'answer' | 'solution') {
  const onReveal = vi.fn();
  const onReset = vi.fn();
  const utils = render(
    <RevealSection
      level={level}
      onReveal={onReveal}
      onReset={onReset}
      hint={CONTENT.hint}
      answer={CONTENT.answer}
      solution={CONTENT.solution}
    />,
  );
  return { onReveal, onReset, ...utils };
}

describe('RevealSection', () => {
  it('shows action buttons but no panels when hidden', () => {
    renderAt('hidden');
    expect(screen.getByRole('button', { name: /show hint/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /show answer/i })).toBeInTheDocument();
    expect(screen.getByRole('button', { name: /show solution/i })).toBeInTheDocument();
    expect(screen.queryByText('Factor the numerator.')).not.toBeInTheDocument();
  });

  it('reveals the hint panel on request', async () => {
    const user = userEvent.setup();
    const { onReveal, onReset, rerender } = renderAt('hidden');
    await user.click(screen.getByRole('button', { name: /show hint/i }));
    expect(onReveal).toHaveBeenCalledWith('hint');

    rerender(
      <RevealSection
        level="hint"
        onReveal={onReveal}
        onReset={onReset}
        hint={CONTENT.hint}
        answer={CONTENT.answer}
        solution={CONTENT.solution}
      />,
    );
    expect(screen.getByText('Factor the numerator.')).toBeInTheDocument();
    expect(screen.getByText('Hint')).toBeInTheDocument();
  });

  it('progressive reveal shows panels cumulatively', () => {
    const { onReveal, onReset, rerender } = renderAt('answer');
    expect(screen.getByText('Hint')).toBeInTheDocument();
    expect(screen.getByText('Answer')).toBeInTheDocument();
    expect(screen.queryByText('Complete solution')).not.toBeInTheDocument();

    rerender(
      <RevealSection
        level="solution"
        onReveal={onReveal}
        onReset={onReset}
        hint={CONTENT.hint}
        answer={CONTENT.answer}
        solution={CONTENT.solution}
      />,
    );
    expect(screen.getByText('Complete solution')).toBeInTheDocument();
    expect(screen.getByText('Cancel the common factor and substitute.')).toBeInTheDocument();
  });

  it('shows a hide-all control once the solution is revealed and resets on click', async () => {
    const user = userEvent.setup();
    const { onReset } = renderAt('solution');
    const hideButton = screen.getByRole('button', { name: /hide all/i });
    await user.click(hideButton);
    expect(onReset).toHaveBeenCalled();
  });
});
