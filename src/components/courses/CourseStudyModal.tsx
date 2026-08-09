import { ArrowRight, GraduationCap, Loader2 } from 'lucide-react';
import { useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogTitle,
} from '@/components/ui/dialog';
import { useAuth } from '@/hooks/useAuth';
import { useAsync } from '@/hooks/useAsync';
import { getUserCourses } from '@/lib/db';
import { isAdminEmail } from '@/lib/auth';

/**
 * Shown right after a returning student signs in. Asks what they want to
 * study today and jumps straight to the chosen course.
 */
export function CourseStudyModal() {
  const { user, profile, justSignedIn, acknowledgeSignIn } = useAuth();
  const navigate = useNavigate();

  const userId = user?.id ?? null;
  const fetchCourses = useCallback(
    () => (userId ? getUserCourses(userId) : Promise.resolve([])),
    [userId],
  );
  const { data: courses, loading } = useAsync(fetchCourses);

  if (!justSignedIn || !user || !profile?.degree_program || isAdminEmail(user.email)) {
    return null;
  }

  const pickCourse = (courseId: string) => {
    acknowledgeSignIn();
    navigate(`/courses/${courseId}`);
  };

  const dismiss = () => {
    acknowledgeSignIn();
  };

  return (
    <Dialog open onOpenChange={(open) => !open && dismiss()}>
      <DialogContent className="max-w-md p-6">
        <DialogTitle className="flex items-center gap-2 text-xl">
          <GraduationCap className="size-5 text-brand-700 dark:text-brand-300" />
          What would you like to study today?
        </DialogTitle>
        <DialogDescription>
          Pick a course to jump right in. You can switch anytime from the dashboard.
        </DialogDescription>
        <div className="mt-2 min-h-0 flex-1 space-y-2 overflow-y-auto pr-1">
          {loading ? (
            <div className="flex items-center justify-center gap-2 py-6 text-sm text-stone-400 dark:text-stone-500">
              <Loader2 className="size-4 animate-spin" />
              Loading your courses
            </div>
          ) : courses && courses.length > 0 ? (
            courses.map((course) => (
              <button
                key={course.id}
                type="button"
                onClick={() => pickCourse(course.id)}
                className="group flex w-full items-center justify-between gap-3 rounded-lg border border-stone-200 px-3 py-2.5 text-left transition-colors hover:border-brand-700 hover:bg-brand-50 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600 dark:border-stone-800 dark:hover:border-brand-500 dark:hover:bg-brand-950/40"
              >
                <span className="flex min-w-0 flex-col">
                  <span className="font-medium text-stone-900 dark:text-stone-100">{course.code}</span>
                  <span className="truncate text-sm text-stone-500 dark:text-stone-400">
                    {course.name}
                  </span>
                </span>
                <ArrowRight className="size-4 shrink-0 text-stone-400 transition-transform group-hover:translate-x-0.5 group-hover:text-brand-700 dark:group-hover:text-brand-300" />
              </button>
            ))
          ) : (
            <p className="py-4 text-center text-sm text-stone-500 dark:text-stone-400">
              No courses selected yet. Head to your profile to choose some.
            </p>
          )}
        </div>
        <div className="mt-4 flex justify-end">
          <Button variant="ghost" size="sm" onClick={dismiss}>
            Not now
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
