import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
import type { Profile } from '@/types';
const { list, update, refreshProfile } = vi.hoisted(() => ({
  list: vi.fn(),
  update: vi.fn(),
  refreshProfile: vi.fn(),
}));
vi.mock('@/lib/adminUsers', async (importOriginal) => ({
  ...(await importOriginal<typeof import('@/lib/adminUsers')>()),
  adminListProfiles: list,
  adminUpdateProfile: update,
}));
vi.mock('@/hooks/useAuth', () => ({ useAuth: () => ({ user: { id: 'admin' }, refreshProfile }) }));
import { UsersAdminSection, ProfileEditor } from './UsersAdminSection';
const profile: Profile = {
  id: 'u',
  email: 'student@example.test',
  full_name: 'Sample Student',
  degree_program: 'BS Mathematics',
  year_level: '1st Year',
  upmmc_member: false,
  avatar_url: null,
  created_at: '2026-01-01T00:00:00Z',
};
beforeEach(() => {
  vi.clearAllMocks();
  list.mockResolvedValue({ users: [profile], total: 26 });
  update.mockResolvedValue({ ...profile, full_name: 'Updated Student' });
  refreshProfile.mockResolvedValue(undefined);
});
describe('admin users', () => {
  it('searches and paginates on the server, resetting page for a new search', async () => {
    render(<UsersAdminSection />);
    await screen.findByText('Sample Student');
    fireEvent.click(screen.getByRole('button', { name: 'Next' }));
    await waitFor(() => expect(list).toHaveBeenCalledWith('', 1));
    fireEvent.change(screen.getByRole('textbox', { name: 'Search users by name or email' }), {
      target: { value: 'student' },
    });
    fireEvent.click(screen.getByRole('button', { name: 'Search' }));
    await waitFor(() => expect(list).toHaveBeenCalledWith('student', 0));
  });
  it('edits a user and refreshes after saving', async () => {
    render(<UsersAdminSection />);
    fireEvent.click(await screen.findByRole('button', { name: 'Edit Sample Student' }));
    fireEvent.change(screen.getByRole('textbox', { name: 'Full name' }), {
      target: { value: 'Updated Student' },
    });
    expect(screen.queryByRole('textbox', { name: 'Email' })).not.toBeInTheDocument();
    fireEvent.click(screen.getByRole('button', { name: 'Save profile' }));
    await screen.findByText('Profile updated.');
    expect(update).toHaveBeenCalledWith(
      profile,
      expect.objectContaining({ full_name: 'Updated Student' }),
    );
    expect(screen.queryByRole('dialog')).not.toBeInTheDocument();
  });
  it('retains edits on conflict and does not claim success', async () => {
    update.mockRejectedValue(new Error('This profile changed. Refresh and try again.'));
    const saved = vi.fn();
    render(<ProfileEditor profile={profile} onClose={vi.fn()} onSaved={saved} />);
    fireEvent.change(screen.getByRole('textbox', { name: 'Full name' }), {
      target: { value: 'My edit' },
    });
    fireEvent.click(screen.getByRole('button', { name: 'Save profile' }));
    expect(await screen.findByRole('alert')).toHaveTextContent('profile changed');
    expect(screen.getByRole('textbox', { name: 'Full name' })).toHaveValue('My edit');
    expect(saved).not.toHaveBeenCalled();
  });
  it('shows permission errors rather than an empty directory', async () => {
    list.mockRejectedValue(new Error('Only administrators can view users'));
    render(<UsersAdminSection />);
    await screen.findByText('Only administrators can view users');
    expect(screen.queryByText('Sample Student')).not.toBeInTheDocument();
  });
});
