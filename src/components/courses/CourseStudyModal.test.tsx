import { act, fireEvent, render, screen, waitFor } from '@testing-library/react';
import type { AuthChangeEvent, Session, User } from '@supabase/supabase-js';
import { MemoryRouter } from 'react-router-dom';
import { afterEach, beforeEach, describe, expect, it, vi } from 'vitest';
import { CourseStudyModal } from './CourseStudyModal';
import { AuthProvider } from '@/hooks/useAuth';
import { STUDY_PROMPT_IDLE_MS } from '@/lib/constants';
import { clearStudyActivity } from '@/lib/studyPrompt';

const authListeners = new Set<(event: AuthChangeEvent, session: Session | null) => void>();

const sampleUser = {
  id: 'student-1',
  email: 'student@up.edu.ph',
  user_metadata: { full_name: 'Isko' },
} as unknown as User;

const sampleSession = {
  user: sampleUser,
} as unknown as Session;

vi.mock('@/lib/supabase', () => ({
  isSupabaseConfigured: true,
  supabase: {
    auth: {
      onAuthStateChange: (cb: (event: AuthChangeEvent, session: Session | null) => void) => {
        authListeners.add(cb);
        return {
          data: {
            subscription: {
              unsubscribe: () => authListeners.delete(cb),
            },
          },
        };
      },
      getSession: vi.fn(() => Promise.resolve({ data: { session: null } })),
      signOut: vi.fn(() => Promise.resolve({ error: null })),
    },
  },
}));

vi.mock('@/lib/admin', () => ({
  adminIsAdmin: vi.fn(() => Promise.resolve(false)),
}));

vi.mock('@/lib/db', () => ({
  getProfile: vi.fn(() =>
    Promise.resolve({
      id: 'student-1',
      email: 'student@up.edu.ph',
      full_name: 'Isko',
      avatar_url: null,
      degree_program: 'BS Mathematics',
      year_level: '3rd Year',
      upmmc_member: false,
      upmmc_verified: false,
      created_at: '2026-01-01T00:00:00Z',
    }),
  ),
  ensureProfile: vi.fn(),
  getUserCourses: vi.fn(() =>
    Promise.resolve([
      {
        id: 'c0000000-0000-4000-8000-000000000004',
        code: 'MATH 126',
        name: 'Real Analysis',
        description: null,
        created_at: '2026-01-01T00:00:00Z',
      },
    ]),
  ),
}));

function emitAuth(event: AuthChangeEvent, session: Session | null) {
  for (const cb of authListeners) {
    cb(event, session);
  }
}

describe('CourseStudyModal tab-switch and idle behavior', () => {
  beforeEach(() => {
    localStorage.clear();
    clearStudyActivity();
    authListeners.clear();
  });

  afterEach(() => {
    vi.restoreAllMocks();
  });

  it('opens on fresh sign-in, stays closed across routine tab switches, and re-opens only after a long idle period', async () => {
    let now = 1_700_000_000_000;
    vi.spyOn(Date, 'now').mockImplementation(() => now);

    render(
      <MemoryRouter>
        <AuthProvider>
          <CourseStudyModal />
        </AuthProvider>
      </MemoryRouter>,
    );

    // 1. Fresh sign-in opens the study modal
    act(() => {
      emitAuth('SIGNED_IN', sampleSession);
    });

    expect(await screen.findByText('What would you like to study today?')).toBeInTheDocument();

    // Dismiss the modal
    fireEvent.click(screen.getByRole('button', { name: 'Not now' }));
    await waitFor(() => {
      expect(screen.queryByText('What would you like to study today?')).not.toBeInTheDocument();
    });

    // 2. Simulate switching away from the tab and returning 15 minutes later
    //    (including Supabase's automatic SIGNED_IN emission on tab visibility recovery)
    now += 15 * 60 * 1000;
    act(() => {
      Object.defineProperty(document, 'visibilityState', {
        configurable: true,
        value: 'hidden',
      });
      document.dispatchEvent(new Event('visibilitychange'));

      Object.defineProperty(document, 'visibilityState', {
        configurable: true,
        value: 'visible',
      });
      document.dispatchEvent(new Event('visibilitychange'));
      window.dispatchEvent(new Event('focus'));
      emitAuth('SIGNED_IN', sampleSession);
    });

    expect(screen.queryByText('What would you like to study today?')).not.toBeInTheDocument();

    // 3. Simulate returning after STUDY_PROMPT_IDLE_MS (4+ hours unused)
    now += STUDY_PROMPT_IDLE_MS + 60_000;
    act(() => {
      document.dispatchEvent(new Event('visibilitychange'));
      window.dispatchEvent(new Event('focus'));
    });

    expect(await screen.findByText('What would you like to study today?')).toBeInTheDocument();
  });
});
