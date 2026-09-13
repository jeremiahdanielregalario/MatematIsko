import { fireEvent, render, screen } from '@testing-library/react';
import { MemoryRouter } from 'react-router-dom';
import { expect, it, vi } from 'vitest';
import { WelcomeGuide } from './WelcomeGuide';
import { setWelcomePending, welcomePending } from '@/lib/welcomeGuide';

function guide(userId: string, path = '/dashboard') {
  return render(
    <MemoryRouter initialEntries={[path]}>
      <WelcomeGuide userId={userId} />
    </MemoryRouter>,
  );
}

it('welcomes a newly onboarded user, supports back/next, and remembers completion', () => {
  setWelcomePending('new-user', true);
  const view = guide('new-user');
  expect(screen.getByRole('dialog')).toBeInTheDocument();
  fireEvent.click(screen.getByRole('button', { name: 'Next' }));
  expect(screen.getByText('Know what to work on next')).toBeInTheDocument();
  fireEvent.click(screen.getByRole('button', { name: 'Back' }));
  expect(screen.getByText('Your next math session starts here')).toBeInTheDocument();
  for (let i = 0; i < 6; i++) fireEvent.click(screen.getByRole('button', { name: 'Next' }));
  fireEvent.click(screen.getByRole('button', { name: 'Start exploring' }));
  expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
  expect(welcomePending('new-user')).toBe(false);
  view.unmount();
  guide('new-user');
  expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
});

it('does not interrupt existing users and allows a manual replay', () => {
  const view = guide('existing-user');
  expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
  view.unmount();
  guide('existing-user', '/dashboard?guide=1&filter=learning');
  expect(screen.getByRole('dialog')).toBeInTheDocument();
  fireEvent.click(screen.getByRole('button', { name: 'Skip tour' }));
  expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
});

it('isolates account state and supports dismissal when browser storage fails', () => {
  const storage = vi.spyOn(Storage.prototype, 'setItem').mockImplementation(() => {
    throw new Error('Unavailable');
  });
  setWelcomePending('offline-user', true);
  expect(welcomePending('different-user')).toBe(false);
  guide('offline-user');
  fireEvent.click(screen.getByRole('button', { name: 'Close' }));
  expect(welcomePending('offline-user')).toBe(false);
  expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
  storage.mockRestore();
});
