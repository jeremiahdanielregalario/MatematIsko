import { Link } from 'react-router-dom';
import { useAuth } from '@/hooks/useAuth';
import { useQuestions } from '@/hooks/useQuestions';
import { useCourses } from '@/hooks/useCourses';
import { useCourseScope } from '@/hooks/useCourseScope';
import { LoadingState } from '@/components/common/LoadingState';
import { ErrorState } from '@/components/common/ErrorState';
import { ExamWorkspace } from '@/features/exam/ExamWorkspace';

export function ExamPage() {
  const { user } = useAuth();
  const { courseIds } = useCourseScope();
  const { data: questions, loading, error, reload } = useQuestions();
  const {
    data: courses,
    loading: coursesLoading,
    error: coursesError,
    reload: reloadCourses,
  } = useCourses();
  if (loading || coursesLoading) return <LoadingState label="Preparing your exam builder" />;
  if (error || coursesError)
    return (
      <ErrorState
        title="Could not load your exam questions"
        message={(error ?? coursesError)!.message}
        onRetry={() => {
          reload();
          reloadCourses();
        }}
      />
    );
  if (!user) return null;
  const scopedCourses = (courses ?? []).filter(
    (course) => courseIds === null || courseIds.includes(course.id),
  );
  const scopedQuestions = (questions ?? []).filter(
    (question) => courseIds === null || courseIds.includes(question.course_id),
  );
  const storageKey = `matematisko-exam-v1:${user.id}`;
  return (
    <div className="space-y-6">
      <header className="mx-auto max-w-5xl">
        <Link to="/practice" className="text-sm text-brand-900 hover:underline dark:text-brand-300">
          ← Practice
        </Link>
        <h1 className="mt-3 font-serif text-3xl font-bold text-stone-900 dark:text-stone-50">
          Quiz & exam
        </h1>
        <p className="mt-2 text-stone-500 dark:text-stone-400">
          A full paper. Time to think. Review when you’re done.
        </p>
      </header>
      <ExamWorkspace
        key={`${storageKey}:${courseIds?.join(',') ?? 'all'}`}
        storageKey={storageKey}
        questions={scopedQuestions}
        courses={scopedCourses}
      />
    </div>
  );
}
