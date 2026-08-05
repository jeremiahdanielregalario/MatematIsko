import { useEffect } from 'react';
import { Navigate } from 'react-router-dom';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';

/**
 * OAuth redirect target. Supabase drops the session in the URL hash here;
 * the AuthProvider picks it up (detectSessionInUrl) and we redirect onward.
 */
export function AuthCallbackPage() {
  const { user, loading, authError } = useAuth();

  useEffect(() => {
    if (!loading && !user) {
      // No session recovered — back to the landing page.
    }
  }, [loading, user]);

  if (!loading && user) return <Navigate to="/dashboard" replace />;
  if (!loading && !user) return <Navigate to="/" replace state={{ from: '/dashboard' }} />;
  if (authError) return <Navigate to="/" replace />;

  return <LoadingState label="Finishing your sign-in" />;
}
