import { fireEvent, render, screen } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { expect, it, vi } from 'vitest';
import { FlashcardSessionPage } from './FlashcardSessionPage';

vi.mock('@/hooks/useAuth', () => ({ useAuth: () => ({ user: { id: 'student' } }) }));
vi.mock('@/hooks/useTheorems', () => ({ useTheorems: () => ({
  data: [
    { id: 'one', name: 'First theorem', statement: 'First statement', course_id: 'course' },
    { id: 'two', name: 'Second theorem', statement: 'Second statement', course_id: 'course' },
  ], loading: false, error: null,
}) }));
vi.mock('@/lib/db', () => ({ upsertTheoremProgress: vi.fn().mockResolvedValue(undefined) }));
vi.mock('@/lib/reports', () => ({ submitTheoremReport: vi.fn() }));

it('opens only the exact linked theorem', () => {
  render(<MemoryRouter initialEntries={['/theorems/flashcards?theorem=two']}><FlashcardSessionPage /></MemoryRouter>);
  expect(screen.getByRole('heading', { name: 'Second theorem' })).toBeInTheDocument();
  expect(screen.queryByRole('heading', { name: 'First theorem' })).not.toBeInTheDocument();
  expect(screen.getByText('Card 1 of 1')).toBeInTheDocument();
});

it('does not substitute another card for a missing link', () => {
  render(<MemoryRouter initialEntries={['/theorems/flashcards?theorem=missing']}><FlashcardSessionPage /></MemoryRouter>);
  expect(screen.getByRole('heading', { name: 'No theorems yet' })).toBeInTheDocument();
  expect(screen.queryByRole('button', { name: 'Flip card' })).not.toBeInTheDocument();
});

it('supports keyboard flip and rating shortcuts and retries still-learning cards', () => {
  render(
    <MemoryRouter initialEntries={['/theorems/flashcards']}>
      <FlashcardSessionPage />
    </MemoryRouter>,
  );

  expect(screen.getByText('Card 1 of 2')).toBeInTheDocument();
  // Flip card 1 via Space and mark Still learning via key '1'
  fireEvent.keyDown(window, { key: ' ' });
  expect(screen.getByRole('button', { name: /Still learning/i })).toBeInTheDocument();
  fireEvent.keyDown(window, { key: '1' });

  // Card 2: flip via Space and mark Got it via key '2'
  expect(screen.getByText('Card 2 of 2')).toBeInTheDocument();
  fireEvent.keyDown(window, { key: ' ' });
  fireEvent.keyDown(window, { key: '2' });

  // Results screen should offer "Review still learning (1)"
  expect(screen.getByRole('heading', { name: 'Session complete!' })).toBeInTheDocument();
  const retryBtn = screen.getByRole('button', { name: 'Review still learning (1)' });
  fireEvent.click(retryBtn);

  // Now deck contains only the 1 learning card
  expect(screen.getByText('Card 1 of 1')).toBeInTheDocument();
});
