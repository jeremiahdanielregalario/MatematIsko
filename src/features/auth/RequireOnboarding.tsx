import { Navigate, Outlet } from 'react-router-dom';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';

/**
 * Route guard: redirects signed-in users who have not finished first-login
 * onboarding (degree program + year level are required) to /onboarding.
 */
export function RequireOnboarding() {
  const { user, profile, loading } = useAuth();

  if (loading) {
    return <LoadingState label="Checking your profile" />;
  }

  if (!user) {
    return <Navigate to="/" replace />;
  }

  const onboardingComplete = Boolean(profile?.degree_program && profile?.year_level);

  if (!onboardingComplete) {
    return <Navigate to="/onboarding" replace />;
  }

  return <Outlet />;
}
