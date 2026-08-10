import { ArrowLeft, ArrowRight, BookOpenText } from 'lucide-react';
import { Link, Navigate, useParams } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { EmptyState } from '@/components/common/EmptyState';
import { LoadingState } from '@/components/common/LoadingState';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { ProgressBar } from '@/components/common/ProgressBar';
import { useCourses } from '@/hooks/useCourses';
import { useCourseScope } from '@/hooks/useCourseScope';
import { useQuestions } from '@/hooks/useQuestions';
import type { TopicWithStats } from '@/types';

export function CoursePage() {
  const { courseId } = useParams<{ courseId: string }>();
  const { data: coursesData } = useCourses();
  const { courseIds } = useCourseScope();
  const courses = coursesData ?? [];
  const { data: loaded, loading, error, reload } = useQuestions();

  if (loading) return <LoadingState label="Loading course" />;

  const questions = loaded ?? [];
  const course = courses.find((c) => c.id === courseId) ?? questions.find((q) => q.course_id === courseId)?.course;

  if (courseIds !== null && courseId && !courseIds.includes(courseId)) {
    return <Navigate to="/dashboard" replace />;
  }

  if (error) {
    return (
      <ErrorState
        title="Could not load this course"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  if (!course) {
    return (
      <EmptyState
        icon={<BookOpenText className="size-8" />}
        title="Course not found"
        description="This course does not exist or has no questions yet."
        action={
          <Button asChild>
            <Link to="/questions">Browse the question bank</Link>
          </Button>
        }
      />
    );
  }

  const courseQuestions = questions.filter((q) => q.course_id === course.id);

  const topicMap = new Map<string, TopicWithStats>();
  for (const q of courseQuestions) {
    if (!q.topic) continue;
    const entry = topicMap.get(q.topic.id) ?? {
      ...q.topic,
      question_count: 0,
      mastered_count: 0,
      mastery_percent: 0,
    };
    entry.question_count += 1;
    if (q.progress?.status === 'mastered') entry.mastered_count += 1;
    topicMap.set(q.topic.id, entry);
  }
  const topics: TopicWithStats[] = [...topicMap.values()]
    .map((t) => ({
      ...t,
      mastery_percent: t.question_count === 0 ? 0 : Math.round((t.mastered_count / t.question_count) * 100),
    }))
    .sort((a, b) => a.name.localeCompare(b.name));

  const mastered = courseQuestions.filter((q) => q.progress?.status === 'mastered').length;
  const masteryPercent = courseQuestions.length === 0 ? 0 : Math.round((mastered / courseQuestions.length) * 100);

  const recent = [...courseQuestions]
    .filter((q) => q.progress?.last_attempted_at)
    .sort((a, b) => (b.progress?.last_attempted_at ?? '').localeCompare(a.progress?.last_attempted_at ?? ''))
    .slice(0, 5);

  return (
    <div className="space-y-8">
      <Link
        to="/questions"
        className="inline-flex items-center gap-1.5 text-sm font-medium text-stone-500 hover:text-stone-900 dark:text-stone-400 dark:hover:text-stone-100"
      >
        <ArrowLeft className="size-4" />
        Question bank
      </Link>

      <section className="flex flex-col gap-4 sm:flex-row sm:items-end sm:justify-between">
        <div>
          <p className="font-mono text-sm font-semibold text-brand-900 dark:text-brand-300">
            {course.code}
          </p>
          <h1 className="mt-1 font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {course.name}
          </h1>
          <p className="mt-2 max-w-2xl text-stone-600 dark:text-stone-400">{course.description}</p>
        </div>
        <Button asChild>
          <Link to={`/questions?course=${course.id}`}>
            All {course.code} questions
            <ArrowRight className="size-4" />
          </Link>
        </Button>
      </section>

      <section className="grid gap-4 sm:grid-cols-3">
        <Card className="p-5">
          <p className="text-sm font-medium text-stone-500 dark:text-stone-400">Questions</p>
          <p className="mt-1 text-3xl font-bold text-stone-900 dark:text-stone-100">
            {courseQuestions.length}
          </p>
        </Card>
        <Card className="p-5">
          <p className="text-sm font-medium text-stone-500 dark:text-stone-400">Mastered</p>
          <p className="mt-1 text-3xl font-bold text-stone-900 dark:text-stone-100">{mastered}</p>
        </Card>
        <Card className="p-5">
          <p className="text-sm font-medium text-stone-500 dark:text-stone-400">Mastery</p>
          <div className="mt-2 flex items-center gap-2">
            <p className="text-3xl font-bold text-stone-900 dark:text-stone-100">{masteryPercent}%</p>
            <ProgressBar
              value={masteryPercent}
              label={`${course.name} mastery`}
              className="h-2 flex-1 bg-stone-100 dark:bg-stone-800"
              barClassName="bg-gradient-to-r from-brand-700 to-brand-500 dark:from-brand-500 dark:to-brand-300"
            />
          </div>
        </Card>
      </section>

      <section>
        <h2 className="mb-3 font-serif text-xl font-semibold text-stone-900 dark:text-stone-100">
          Topics
        </h2>
        {topics.length === 0 ? (
          <EmptyState
            title="No topics yet"
            description="There are no questions for this course yet."
          />
        ) : (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {topics.map((topic) => (
              <Link
                key={topic.id}
                to={`/questions?course=${course.id}&topic=${topic.id}`}
                className="group rounded-xl border border-stone-200 bg-white p-5 shadow-sm transition-all duration-200 hover:-translate-y-1 hover:shadow-md dark:border-stone-800 dark:bg-stone-900"
              >
                <h3 className="font-semibold text-stone-900 group-hover:text-brand-800 dark:text-stone-100 dark:group-hover:text-brand-300">
                  {topic.name}
                </h3>
                <p className="mt-1 text-sm text-stone-500 dark:text-stone-400">
                  {topic.question_count} question{topic.question_count === 1 ? '' : 's'} ·{' '}
                  {topic.mastery_percent}% mastered
                </p>
                <ProgressBar
                  value={topic.mastery_percent}
                  label={`${topic.name} mastery`}
                  className="mt-3 h-1.5 bg-stone-100 dark:bg-stone-800"
                />
              </Link>
            ))}
          </div>
        )}
      </section>

      {recent.length > 0 ? (
        <section>
          <h2 className="mb-3 font-serif text-xl font-semibold text-stone-900 dark:text-stone-100">
            Recently attempted
          </h2>
          <Card>
            <ul className="divide-y divide-stone-100 dark:divide-stone-800">
              {recent.map((q) => (
                <li key={q.id}>
                  <Link
                    to={`/questions/${q.id}?course=${course.id}`}
                    className="flex items-center justify-between gap-3 px-5 py-3 text-sm transition-colors hover:bg-stone-50 dark:hover:bg-stone-800/50"
                  >
                    <span className="min-w-0 truncate font-medium text-stone-800 dark:text-stone-100">
                      {q.title}
                    </span>
                    <span className="shrink-0 text-xs text-stone-400 dark:text-stone-500">
                      {q.topic?.name}
                    </span>
                  </Link>
                </li>
              ))}
            </ul>
          </Card>
        </section>
      ) : null}
    </div>
  );
}
