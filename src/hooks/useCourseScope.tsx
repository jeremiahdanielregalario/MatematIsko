import { createContext, useCallback, useContext, useEffect, useState } from 'react';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';
import { getUserCourses } from '@/lib/db';
import { isAdminEmail } from '@/lib/auth';

interface CourseScopeValue {
  /** Course IDs the signed-in user can access, or null when unrestricted (admin). */
  courseIds: string[] | null;
  loading: boolean;
  /** Re-fetch the user's courses and update the access scope. */
  refresh: () => void;
}

const CourseScopeContext = createContext<CourseScopeValue | null>(null);

/**
 * Resolves the set of courses a student preselected during onboarding.
 * Admins are unrestricted (courseIds = null). While the scope is loading for a
 * signed-in user the provider renders a loading state so that no out-of-scope
 * data is ever fetched or flashed to the client.
 */
export function CourseScopeProvider({ children }: { children: React.ReactNode }) {
  const { user } = useAuth();
  const [courseIds, setCourseIds] = useState<string[] | null>(null);
  const [loading, setLoading] = useState(false);

  const fetchCourses = useCallback(async () => {
    if (!user || isAdminEmail(user.email)) return;
    const courses = await getUserCourses(user.id);
    setCourseIds(courses.map((c) => c.id));
  }, [user]);

  useEffect(() => {
    if (!user || isAdminEmail(user.email)) {
      setCourseIds(null);
      setLoading(false);
      return;
    }
    let cancelled = false;
    setLoading(true);
    void fetchCourses()
      .catch(() => {
        if (!cancelled) setCourseIds([]);
      })
      .finally(() => {
        if (!cancelled) setLoading(false);
      });
    return () => {
      cancelled = true;
    };
  }, [user, fetchCourses]);

  const refresh = useCallback(() => {
    if (!user) return;
    setLoading(true);
    void fetchCourses()
      .catch(() => setCourseIds([]))
      .finally(() => setLoading(false));
  }, [user, fetchCourses]);

  if (user && loading && courseIds === null) {
    return <LoadingState label="Loading your courses" />;
  }

  return (
    <CourseScopeContext.Provider value={{ courseIds, loading, refresh }}>
      {children}
    </CourseScopeContext.Provider>
  );
}

export function useCourseScope(): CourseScopeValue {
  const ctx = useContext(CourseScopeContext);
  if (!ctx) throw new Error('useCourseScope must be used within a CourseScopeProvider');
  return ctx;
}
