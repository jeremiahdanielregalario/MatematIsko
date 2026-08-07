import { createContext, useContext, useEffect, useState } from 'react';
import { LoadingState } from '@/components/common/LoadingState';
import { useAuth } from '@/hooks/useAuth';
import { getUserCourses } from '@/lib/db';
import { isAdminEmail } from '@/lib/auth';

interface CourseScopeValue {
  /** Course IDs the signed-in user can access, or null when unrestricted (admin). */
  courseIds: string[] | null;
  loading: boolean;
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

  useEffect(() => {
    if (!user) {
      setCourseIds(null);
      setLoading(false);
      return;
    }
    if (isAdminEmail(user.email)) {
      setCourseIds(null);
      setLoading(false);
      return;
    }
    let cancelled = false;
    setLoading(true);
    void getUserCourses(user.id)
      .then((courses) => {
        if (cancelled) return;
        setCourseIds(courses.map((c) => c.id));
        setLoading(false);
      })
      .catch(() => {
        if (cancelled) return;
        setCourseIds([]);
        setLoading(false);
      });
    return () => {
      cancelled = true;
    };
  }, [user]);

  if (user && loading) {
    return <LoadingState label="Loading your courses" />;
  }

  return (
    <CourseScopeContext.Provider value={{ courseIds, loading }}>
      {children}
    </CourseScopeContext.Provider>
  );
}

export function useCourseScope(): CourseScopeValue {
  const ctx = useContext(CourseScopeContext);
  if (!ctx) throw new Error('useCourseScope must be used within a CourseScopeProvider');
  return ctx;
}
