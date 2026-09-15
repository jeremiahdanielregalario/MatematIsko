import { createContext, useCallback, useContext, useEffect, useRef, useState } from 'react';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';
import { getUserCourses, setUserCourses } from '@/lib/db';

interface CourseScopeValue {
  /** Selected study courses; null is unrestricted for admins without a selection. */
  courseIds: string[] | null;
  loading: boolean;
  /** Re-fetch the user's courses and update the access scope. */
  refresh: () => void;
  /** Persist a selection and immediately publish it to study consumers. */
  saveCourses: (ids: string[]) => Promise<void>;
}

const CourseScopeContext = createContext<CourseScopeValue | null>(null);

/**
 * Resolves the set of courses a student preselected during onboarding.
 * Admins with no selection remain unrestricted. While the scope is loading for a
 * signed-in user the provider renders a loading state so that no out-of-scope
 * data is ever fetched or flashed to the client.
 */
export function CourseScopeProvider({ children }: { children: React.ReactNode }) {
  const { user, isAdmin, adminLoading } = useAuth();
  const [courseIds, setCourseIds] = useState<string[] | null>(null);
  const [loading, setLoading] = useState(true);
  const request = useRef(0);

  const fetchCourses = useCallback(async () => {
    if (!user) return null;
    const courses = await getUserCourses(user.id);
    return isAdmin && courses.length === 0 ? null : courses.map((c) => c.id);
  }, [user, isAdmin]);

  useEffect(() => {
    const version = ++request.current;
    if (adminLoading) return;
    if (!user) {
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

  const saveCourses = useCallback(
    async (ids: string[]) => {
      if (!user || adminLoading) throw new Error('Please wait for your account to finish loading.');
      const selected = [...ids];
      const version = ++request.current;
      await setUserCourses(user.id, selected);
      if (version !== request.current) return;
      setCourseIds(isAdmin && selected.length === 0 ? null : selected);
      setLoading(false);
    },
    [user, isAdmin, adminLoading],
  );

  if (adminLoading || (user && loading && courseIds === null)) {
    return <LoadingState label="Loading your courses" />;
  }

  return (
    <CourseScopeContext.Provider value={{ courseIds, loading, refresh, saveCourses }}>
      {children}
    </CourseScopeContext.Provider>
  );
}

export function useCourseScope(): CourseScopeValue {
  const ctx = useContext(CourseScopeContext);
  if (!ctx) throw new Error('useCourseScope must be used within a CourseScopeProvider');
  return ctx;
}
