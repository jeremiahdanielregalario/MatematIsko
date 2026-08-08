import type { User } from '@supabase/supabase-js';
import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react';
import { UP_ACCESS_MESSAGE, isApprovedUpEmail } from '@/lib/auth';
import { SESSION_EXPIRED_MESSAGE, SESSION_LIFETIME_MS, SESSION_START_KEY } from '@/lib/constants';
import { ensureProfile, getProfile } from '@/lib/db';
import { isSupabaseConfigured, supabase } from '@/lib/supabase';
import type { Profile } from '@/types';

interface AuthContextValue {
  user: User | null;
  profile: Profile | null;
  loading: boolean;
  /** Non-null when the signed-in email is not allowed to use the app. */
  authError: string | null;
  configured: boolean;
  signInWithGoogle: () => Promise<void>;
  signInWithEmail: (email: string, password: string) => Promise<void>;
  signOut: () => Promise<void>;
  /** Re-fetch the current user's profile row and update context state. */
  refreshProfile: () => Promise<void>;
}

const AuthContext = createContext<AuthContextValue | null>(null);

function getSessionStart(): number {
  const raw = localStorage.getItem(SESSION_START_KEY);
  const parsed = raw ? Number(raw) : NaN;
  return Number.isFinite(parsed) ? parsed : Date.now();
}

function ensureSessionStart(): void {
  if (!localStorage.getItem(SESSION_START_KEY)) {
    localStorage.setItem(SESSION_START_KEY, String(Date.now()));
  }
}

function clearSessionStart(): void {
  localStorage.removeItem(SESSION_START_KEY);
}

function isSessionExpired(): boolean {
  return Date.now() - getSessionStart() >= SESSION_LIFETIME_MS;
}

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [rawUser, setRawUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);
  const [authError, setAuthError] = useState<string | null>(null);

  // Session + domain gate. A `user` is only ever exposed to the rest of the
  // app after their email is confirmed to end in @up.edu.ph. Sessions are also
  // time-boxed: after SESSION_LIFETIME_MS the user must sign in again.
  useEffect(() => {
    if (!supabase) {
      setLoading(false);
      return;
    }
    let cancelled = false;
    const client = supabase;

    const acceptUser = (user: User) => {
      if (!isApprovedUpEmail(user.email)) {
        setRawUser(null);
        setProfile(null);
        setAuthError(UP_ACCESS_MESSAGE);
        clearSessionStart();
        void client.auth.signOut();
        return;
      }
      if (isSessionExpired()) {
        setRawUser(null);
        setProfile(null);
        setAuthError(SESSION_EXPIRED_MESSAGE);
        clearSessionStart();
        void client.auth.signOut();
        return;
      }
      setAuthError(null);
      setRawUser(user);
    };

    const { data } = client.auth.onAuthStateChange((event, session) => {
      const nextUser = session?.user ?? null;
      if (!nextUser) {
        clearSessionStart();
        setRawUser(null);
        setProfile(null);
        setLoading(false);
        return;
      }
      if (event === 'SIGNED_IN' || event === 'INITIAL_SESSION') {
        ensureSessionStart();
      }
      acceptUser(nextUser);
      setLoading(false);
    });

    void client.auth
      .getSession()
      .then(({ data: sessionData }) => {
        if (cancelled) return;
        const user = sessionData.session?.user ?? null;
        if (user) {
          ensureSessionStart();
          acceptUser(user);
        }
        setLoading(false);
      })
      .catch(() => {
        if (!cancelled) setLoading(false);
      });

    return () => {
      cancelled = true;
      data.subscription.unsubscribe();
    };
  }, []);

  // Force sign-out while the tab stays open once the session window elapses.
  useEffect(() => {
    if (!rawUser || !supabase) return;
    const client = supabase;
    const remaining = getSessionStart() + SESSION_LIFETIME_MS - Date.now();
    if (remaining <= 0) {
      void client.auth.signOut();
      return;
    }
    const timerId = window.setTimeout(() => {
      void client.auth.signOut();
    }, remaining);
    return () => window.clearTimeout(timerId);
  }, [rawUser]);

  // Load (and lazily create) the profile row for an approved user.
  useEffect(() => {
    if (!rawUser || !supabase) {
      setProfile(null);
      return;
    }
    let cancelled = false;
    void (async () => {
      const existing = await getProfile(rawUser.id);
      if (cancelled) return;
      if (existing) {
        setProfile(existing);
        return;
      }
      const created = await ensureProfile(
        rawUser.id,
        rawUser.email ?? '',
        rawUser.user_metadata?.full_name ?? null,
        rawUser.user_metadata?.avatar_url ?? null,
      );
      if (!cancelled) setProfile(created);
    })().catch(() => {
      if (!cancelled) setProfile(null);
    });
    return () => {
      cancelled = true;
    };
  }, [rawUser]);

  const signInWithGoogle = useCallback(async () => {
    if (!supabase) return;
    const { error } = await supabase.auth.signInWithOAuth({
      provider: 'google',
      options: { redirectTo: `${window.location.origin}/auth/callback` },
    });
    if (error) throw error;
  }, []);

  const signInWithEmail = useCallback(async (email: string, password: string) => {
    if (!supabase) return;
    const { error } = await supabase.auth.signInWithPassword({ email, password });
    if (error) throw error;
  }, []);

  const signOut = useCallback(async () => {
    if (!supabase) return;
    await supabase.auth.signOut();
    clearSessionStart();
    setRawUser(null);
    setProfile(null);
    setAuthError(null);
  }, []);

  const refreshProfile = useCallback(async () => {
    if (!rawUser || !supabase) return;
    const next = await getProfile(rawUser.id);
    if (next) setProfile(next);
  }, [rawUser]);

  const value = useMemo<AuthContextValue>(
    () => ({
      user: rawUser,
      profile,
      loading,
      authError,
      configured: isSupabaseConfigured,
      signInWithGoogle,
      signInWithEmail,
      signOut,
      refreshProfile,
    }),
    [rawUser, profile, loading, authError, signInWithGoogle, signInWithEmail, signOut, refreshProfile],
  );

  return <AuthContext.Provider value={value}>{children}</AuthContext.Provider>;
}

export function useAuth(): AuthContextValue {
  const ctx = useContext(AuthContext);
  if (!ctx) throw new Error('useAuth must be used within an AuthProvider');
  return ctx;
}
