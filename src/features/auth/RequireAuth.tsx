import { Navigate, Outlet, useLocation } from 'react-router-dom';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';

/**
 * Route guard: blocks access for unauthenticated users and for users whose
 * email is not allowed (authError is set by the AuthProvider in that case).
 */
export function RequireAuth() {
  const { user, loading, authError } = useAuth();
  const location = useLocation();

  if (loading) {
    return <LoadingState label="Checking your session" />;
  }

  if (!user || authError) {
    return <Navigate to="/" replace state={{ from: location.pathname }} />;
  }

  return <Outlet />;
}
