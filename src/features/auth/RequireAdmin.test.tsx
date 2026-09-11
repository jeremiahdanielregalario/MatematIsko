import { render, screen } from '@testing-library/react';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import { describe, expect, it, vi } from 'vitest';
const { auth } = vi.hoisted(() => ({
  auth: {
    user: { email: 'delegate@up.edu.ph' },
    loading: false,
    isAdmin: false,
    adminLoading: false,
  },
}));
vi.mock('@/hooks/useAuth', () => ({ useAuth: () => auth }));
import { RequireAdmin } from './RequireAdmin';
function renderGuard() {
  return render(
    <MemoryRouter initialEntries={['/admin']}>
      <Routes>
        <Route path="/admin" element={<RequireAdmin>Admin workspace</RequireAdmin>} />
        <Route path="/dashboard" element={<div>Student dashboard</div>} />
      </Routes>
    </MemoryRouter>,
  );
}
describe('database-backed admin guard', () => {
  it('allows an admin without a hardcoded email', () => {
    auth.isAdmin = true;
    auth.adminLoading = false;
    renderGuard();
    expect(screen.getByText('Admin workspace')).toBeInTheDocument();
  });
  it('waits for the database check', () => {
    auth.isAdmin = false;
    auth.adminLoading = true;
    renderGuard();
    expect(screen.getByText(/Checking access/)).toBeInTheDocument();
    expect(screen.queryByText('Student dashboard')).not.toBeInTheDocument();
  });
  it('denies non-admins after the check', () => {
    auth.isAdmin = false;
    auth.adminLoading = false;
    renderGuard();
    expect(screen.getByText('Student dashboard')).toBeInTheDocument();
  });
});
