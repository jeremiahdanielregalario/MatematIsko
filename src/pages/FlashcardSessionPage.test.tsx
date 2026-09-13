import { render, screen } from '@testing-library/react';
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
vi.mock('@/lib/db', () => ({ upsertTheoremProgress: vi.fn() }));
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
