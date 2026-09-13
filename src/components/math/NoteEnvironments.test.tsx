import { render, screen } from '@testing-library/react';
import { expect, it } from 'vitest';
import { MathRenderer } from './MathRenderer';

it('separates environments, preserves math and leaves code untouched', () => {
  const { container } = render(
    <MathRenderer noteEnvironments={{}}>
      {
        '### Definition: Norm\n\nA norm $N$.\n\n### Theorem: Bound\n\n$$\nx^2 \\ge 0\n$$\n\n**Proof.** Square $x$.\n\nDone. ∎\n\nOrdinary text.\n\n```md\n### Theorem: Example\n```'
      }
    </MathRenderer>,
  );
  expect(container.querySelectorAll('.note-environment')).toHaveLength(3);
  expect(container.querySelector('.note-environment-theorem .katex-display')).toBeInTheDocument();
  expect(container.querySelector('.note-environment-proof')).toHaveTextContent('Done. ∎');
  expect(screen.getByText('Ordinary text.').closest('section')).toBeNull();
  expect(screen.getByText('### Theorem: Example').closest('section')).toBeNull();
});

it('links a unique normalized name and supports explicit stable identities', () => {
  render(
    <MathRenderer
      noteEnvironments={{
        theorems: [
          { id: 'holder', name: "Hölder's Inequality" },
          { id: 'vitali', name: "Vitali's Theorem" },
        ],
      }}
    >
      {
        '### Theorem: Holder’s Inequality\n\nStatement.\n\n### Theorem: [Choice sets](/theorems/vitali)\n\nAnother statement.'
      }
    </MathRenderer>,
  );
  const links = screen.getAllByRole('link', { name: 'Practice this theorem →' });
  expect(links[0]).toHaveAttribute('href', '/theorems/flashcards?theorem=holder');
  expect(links[1]).toHaveAttribute('href', '/theorems/flashcards?theorem=vitali');
});

it('does not guess ambiguous, missing or invalid explicit references', () => {
  render(
    <MathRenderer
      noteEnvironments={{
        theorems: [
          { id: 'one', name: 'Bound' },
          { id: 'two', name: 'Bound' },
        ],
      }}
    >
      {
        '### Theorem: Bound\n\nStatement.\n\n### Theorem: Missing\n\nStatement.\n\n### Theorem: [Bound](/theorems/missing)\n\nStatement.'
      }
    </MathRenderer>,
  );
  expect(screen.queryByRole('link', { name: 'Practice this theorem →' })).not.toBeInTheDocument();
});

it('keeps ordinary Markdown rendering unchanged outside notes', () => {
  const { container } = render(<MathRenderer>{'### Theorem: Bound\n\nStatement.'}</MathRenderer>);
  expect(container.querySelector('section')).toBeNull();
});
