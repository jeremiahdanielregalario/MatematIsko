import { createContext, useCallback, useContext, useEffect, useRef, useState } from 'react';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';
import { getUserCourses } from '@/lib/db';

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
  const { user, isAdmin, adminLoading } = useAuth();
  const [courseIds, setCourseIds] = useState<string[] | null>(null);
  const [loading, setLoading] = useState(false);
  const request = useRef(0);

  const fetchCourses = useCallback(async () => {
    if (!user || isAdmin) return null;
    const courses = await getUserCourses(user.id);
    return courses.map((c) => c.id);
  }, [user, isAdmin]);

  useEffect(() => {
    const version = ++request.current;
    if (adminLoading) return;
    if (!user || isAdmin) {
      setCourseIds(null);
      setLoading(false);
      return;
    }

    setLoading(true);
    void fetchCourses()
      .then((ids) => {
        if (version === request.current) setCourseIds(ids);
      })
      .catch(() => {
        if (version === request.current) setCourseIds([]);
      })
      .finally(() => {
        if (version === request.current) setLoading(false);
      });
    return () => {
      // Invalidate every in-flight request, including manual refreshes, on identity/role changes.
      // eslint-disable-next-line react-hooks/exhaustive-deps
      request.current++;
    };
  }, [user, isAdmin, adminLoading, fetchCourses]);

  const refresh = useCallback(() => {
    if (!user || adminLoading) return;
    const version = ++request.current;
    setLoading(true);
    void fetchCourses()
      .then((ids) => {
        if (version === request.current) setCourseIds(ids);
      })
      .catch(() => {
        if (version === request.current) setCourseIds([]);
      })
      .finally(() => {
        if (version === request.current) setLoading(false);
      });
  }, [user, adminLoading, fetchCourses]);

  if (adminLoading || (user && loading && courseIds === null)) {
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
