import { Navigate } from 'react-router-dom';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';
import { isAdminEmail } from '@/lib/auth';

/**
 * Route guard for the admin area. Client-side email check; the database RPCs
 * enforce the same rule server-side, so this is just UI gating.
 */
export function RequireAdmin({ children }: { children: React.ReactNode }) {
  const { user, loading } = useAuth();

  if (loading) {
    return <LoadingState label="Checking access" />;
  }

  if (!user || !isAdminEmail(user.email)) {
    return <Navigate to="/dashboard" replace />;
  }

  return <>{children}</>;
}
