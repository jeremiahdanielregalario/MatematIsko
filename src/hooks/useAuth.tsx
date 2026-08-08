import type { User } from '@supabase/supabase-js';
import { createContext, useCallback, useContext, useEffect, useMemo, useState } from 'react';
import { UP_ACCESS_MESSAGE, isApprovedUpEmail } from '@/lib/auth';
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

export function AuthProvider({ children }: { children: React.ReactNode }) {
  const [rawUser, setRawUser] = useState<User | null>(null);
  const [profile, setProfile] = useState<Profile | null>(null);
  const [loading, setLoading] = useState(true);
  const [authError, setAuthError] = useState<string | null>(null);

  // Session + domain gate. A `user` is only ever exposed to the rest of the
  // app after their email is confirmed to end in @up.edu.ph.
  useEffect(() => {
    if (!supabase) {
      setLoading(false);
      return;
    }
    let cancelled = false;
    const client = supabase;

    const { data } = client.auth.onAuthStateChange((_event, session) => {
      const nextUser = session?.user ?? null;
      if (!nextUser) {
        setRawUser(null);
        setProfile(null);
        setLoading(false);
        return;
      }
      if (!isApprovedUpEmail(nextUser.email)) {
        setRawUser(null);
        setProfile(null);
        setAuthError(UP_ACCESS_MESSAGE);
        void client.auth.signOut();
        setLoading(false);
        return;
      }
      setAuthError(null);
      setRawUser(nextUser);
      setLoading(false);
    });

    void client.auth
      .getSession()
      .then(({ data: sessionData }) => {
        if (cancelled) return;
        const user = sessionData.session?.user ?? null;
        if (user) {
          if (!isApprovedUpEmail(user.email)) {
            setRawUser(null);
            setProfile(null);
            setAuthError(UP_ACCESS_MESSAGE);
            void client.auth.signOut();
          } else {
            setRawUser(user);
            setAuthError(null);
          }
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
