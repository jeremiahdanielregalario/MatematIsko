import { Navigate } from 'react-router-dom';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';

/**
 * Route guard for the admin area. Uses the database admin check; privileged operations also enforce access server-side.
 */
export function RequireAdmin({ children }: { children: React.ReactNode }) {
  const { user, loading, isAdmin, adminLoading } = useAuth();

  if (loading || adminLoading) {
    return <LoadingState label="Checking access" />;
  }

  if (!user || !isAdmin) {
    return <Navigate to="/dashboard" replace />;
  }

  return <>{children}</>;
}
