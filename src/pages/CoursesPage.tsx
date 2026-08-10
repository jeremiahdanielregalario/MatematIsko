import { BookOpenText, GraduationCap } from 'lucide-react';
import { useMemo } from 'react';
import { Link } from 'react-router-dom';
import { CourseCard, type CourseStats } from '@/components/courses/CourseCard';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Reveal } from '@/components/common/Reveal';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/hooks/useAuth';
import { useCourseScope } from '@/hooks/useCourseScope';
import { useCourses } from '@/hooks/useCourses';
import { useQuestions } from '@/hooks/useQuestions';
import { computeStats } from '@/lib/stats';

export function CoursesPage() {
  const { profile } = useAuth();
  const { data: coursesData, loading: coursesLoading, error: coursesError, reload } = useCourses();
  const { data: questionsData } = useQuestions();
  const { courseIds } = useCourseScope();

  const courses = useMemo(
    () => (coursesData ?? []).filter((course) => courseIds === null || courseIds.includes(course.id)),
    [coursesData, courseIds],
  );

  const questions = useMemo(() => questionsData ?? [], [questionsData]);

  const statsByCourse = useMemo(() => {
    const map = new Map<string, CourseStats>();
    for (const q of questions) {
      const entry = map.get(q.course_id) ?? { total: 0, mastered: 0, learning: 0 };
      entry.total += 1;
      const status = q.progress?.status ?? 'unseen';
      if (status === 'mastered') entry.mastered += 1;
      if (status === 'learning') entry.learning += 1;
      map.set(q.course_id, entry);
    }
    return map;
  }, [questions]);

  const stats = useMemo(() => computeStats(questions), [questions]);

  if (coursesLoading) return <LoadingState label="Loading courses" />;
  if (coursesError) {
    return (
      <ErrorState title="Could not load courses" message={coursesError.message} onRetry={reload} />
    );
  }

  return (
    <div className="space-y-6">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Courses
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            {profile
              ? 'Pick a course and dive into its topics to study.'
              : 'Browse the available math courses.'}
          </p>
        </div>
        <p className="text-sm text-stone-500 dark:text-stone-400">
          {stats.total} questions · {stats.mastered} mastered
        </p>
      </section>

      {courses.length > 0 ? (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {courses.map((course, index) => (
            <Reveal key={course.id} delay={index * 60} className="h-full">
              <Link
                to={`/courses/${course.id}`}
                className="block h-full rounded-xl focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600"
              >
                <CourseCard
                  course={course}
                  stats={statsByCourse.get(course.id) ?? { total: 0, mastered: 0, learning: 0 }}
                  className="h-full"
                />
              </Link>
            </Reveal>
          ))}
        </div>
      ) : (
        <EmptyState
          icon={<GraduationCap className="size-8" />}
          title="No courses available"
          description="There are no math courses available yet. Check back soon."
          action={
            <Button asChild>
              <Link to="/dashboard">
                <BookOpenText className="size-4" />
                Back to dashboard
              </Link>
            </Button>
          }
        />
      )}
    </div>
  );
}
