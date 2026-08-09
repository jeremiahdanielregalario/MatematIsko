import {
  BookOpenText,
  Bookmark,
  CheckCircle2,
  Layers,
  Shuffle,
  Target,
} from 'lucide-react';
import { useMemo } from 'react';
import { Link, useNavigate } from 'react-router-dom';
import { CourseCard, type CourseStats } from '@/components/courses/CourseCard';
import { ErrorState } from '@/components/common/ErrorState';
import { EmptyState } from '@/components/common/EmptyState';
import { LoadingState } from '@/components/common/LoadingState';
import { ProgressCard } from '@/components/common/ProgressCard';
import { Reveal } from '@/components/common/Reveal';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/hooks/useAuth';
import { useCourseScope } from '@/hooks/useCourseScope';
import { useCourses } from '@/hooks/useCourses';
import { useQuestions } from '@/hooks/useQuestions';
import { computeStats } from '@/lib/stats';
import { pickRandom } from '@/lib/questionFilter';

function greeting(): string {
  const hour = new Date().getHours();
  if (hour < 12) return 'Good morning';
  if (hour < 18) return 'Good afternoon';
  return 'Good evening';
}

export function DashboardPage() {
  const { profile } = useAuth();
  const navigate = useNavigate();
  const { data, loading, error, reload } = useQuestions();
  const { data: coursesData } = useCourses();
  const { courseIds } = useCourseScope();

  const courses = useMemo(
    () => (coursesData ?? []).filter((course) => courseIds === null || courseIds.includes(course.id)),
    [coursesData, courseIds],
  );

  const questions = useMemo(() => data ?? [], [data]);

  const stats = useMemo(() => computeStats(questions), [questions]);

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

  if (loading) return <LoadingState label="Loading your dashboard" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load your dashboard"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  const firstName = profile?.full_name?.split(/\s+/)[0] ?? 'student';

  const startRandom = () => {
    const random = pickRandom(questions);
    if (random) navigate(`/questions/${random.id}`);
  };

  return (
    <div className="space-y-8">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <h1 className="animate-fade-in-down font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {greeting()}, {firstName}.
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            Pick a course to review, or dive into a random problem.
          </p>
        </div>
        <div className="flex flex-wrap gap-2">
          <Button onClick={startRandom}>
            <Shuffle className="size-4" />
            Give me a random problem
          </Button>
          <Button variant="outline" asChild>
            <Link to="/practice">
              <Target className="size-4" />
              Start Practice
            </Link>
          </Button>
        </div>
      </section>

      <section className="grid grid-cols-2 gap-4 lg:grid-cols-4">
        <Reveal delay={0} className="h-full">
          <ProgressCard
            label="Questions available"
            value={stats.total}
            icon={<Layers className="size-4" />}
            className="h-full"
          />
        </Reveal>
        <Reveal delay={75} className="h-full">
          <ProgressCard
            label="Mastered"
            value={stats.mastered}
            icon={<CheckCircle2 className="size-4" />}
            hint={
              stats.masteryRate === null
                ? 'Answer questions to start tracking.'
                : `${stats.masteryRate}% of attempted questions mastered`
            }
            className="h-full"
          />
        </Reveal>
        <Reveal delay={150} className="h-full">
          <ProgressCard
            label="Learning"
            value={stats.learning}
            icon={<BookOpenText className="size-4" />}
            className="h-full"
          />
        </Reveal>
        <Reveal delay={225} className="h-full">
          <ProgressCard
            label="Bookmarked"
            value={stats.bookmarked}
            icon={<Bookmark className="size-4" />}
            className="h-full"
          />
        </Reveal>
      </section>

      <section className="space-y-4">
        <h2 className="font-serif text-2xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
          What are you studying?
        </h2>
        {courses.length > 0 ? (
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {courses.map((course, index) => (
              <Reveal key={course.id} delay={index * 60} className="h-full">
                <Link
                  to={`/courses/${course.id}`}
                  className="block h-full rounded-xl focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600"
                >
                  <CourseCard course={course} stats={statsByCourse.get(course.id) ?? { total: 0, mastered: 0, learning: 0 }} className="h-full" />
                </Link>
              </Reveal>
            ))}
          </div>
        ) : (
          <EmptyState
            icon={<Layers className="size-8" />}
            title="No courses selected yet"
            description="Choose the math courses you want to study so they show up here."
            action={
              <Button asChild>
                <Link to="/profile">Choose courses</Link>
              </Button>
            }
          />
        )}
      </section>
    </div>
  );
}
