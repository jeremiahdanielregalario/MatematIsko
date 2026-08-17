import { ArrowLeft, ArrowRight, BookOpenText, FileText } from 'lucide-react';
import { Link, Navigate, useSearchParams, useParams } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { CourseNotesView } from '@/components/courses/CourseNotesView';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { useCourses } from '@/hooks/useCourses';
import { useCourseNotes } from '@/hooks/useCourseNotes';
import { useCourseScope } from '@/hooks/useCourseScope';
import { useQuestions } from '@/hooks/useQuestions';
import { cn } from '@/lib/cn';
import { pickRandom } from '@/lib/questionFilter';
import type { TopicWithStats } from '@/types';

type CourseTab = 'questions' | 'notes';

export function CoursePage() {
  const { courseId } = useParams<{ courseId: string }>();
  const [searchParams, setSearchParams] = useSearchParams();
  const { data: coursesData } = useCourses();
  const { courseIds } = useCourseScope();
  const courses = coursesData ?? [];
  const { data: loaded, loading, error, reload } = useQuestions();

  const activeTab = (searchParams.get('tab') as CourseTab) || 'questions';
  const setActiveTab = (tab: CourseTab) => setSearchParams({ tab });

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
        description="This course does not exist or you do not have access."
        action={
          <Button asChild>
            <Link to="/courses">Back to courses</Link>
          </Button>
        }
      />
    );
  }

  return (
    <div className="space-y-6">
      <header className="flex flex-col gap-3 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <Link
            to="/courses"
            className="mb-1 inline-flex items-center gap-1 text-sm text-stone-500 transition-colors hover:text-stone-800 dark:text-stone-400 dark:hover:text-stone-200"
          >
            <ArrowLeft className="size-3.5" />
            All courses
          </Link>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            {course.code}
          </h1>
          {course.name && (
            <p className="text-stone-500 dark:text-stone-400">{course.name}</p>
          )}
        </div>
        <Button variant="outline" asChild>
          <Link to={`/practice?courseId=${courseId}`}>
            Practice this course
            <ArrowRight className="size-4" />
          </Link>
        </Button>
      </header>

      {/* Tab bar */}
      <div className="flex items-center gap-1 rounded-lg border border-stone-200 bg-stone-50 p-1 dark:border-stone-800 dark:bg-stone-900">
        <TabButton
          active={activeTab === 'questions'}
          onClick={() => setActiveTab('questions')}
        >
          <BookOpenText className="size-4" />
          Questions
        </TabButton>
        <TabButton
          active={activeTab === 'notes'}
          onClick={() => setActiveTab('notes')}
        >
          <FileText className="size-4" />
          Notes
        </TabButton>
      </div>

      {activeTab === 'questions' ? (
        <QuestionsTab courseId={courseId} questions={questions} />
      ) : (
        <NotesTab courseId={courseId} />
      )}
    </div>
  );
}

function TabButton({
  active,
  onClick,
  children,
}: {
  active: boolean;
  onClick: () => void;
  children: React.ReactNode;
}) {
  return (
    <button
      type="button"
      onClick={onClick}
      className={cn(
        'inline-flex items-center gap-1.5 rounded-md px-4 py-2 text-sm font-medium transition-colors',
        active
          ? 'bg-white text-stone-900 shadow-sm dark:bg-stone-800 dark:text-stone-50'
          : 'text-stone-500 hover:text-stone-700 dark:text-stone-400 dark:hover:text-stone-200',
      )}
    >
      {children}
    </button>
  );
}

// ---------------------------------------------------------------------------
// Questions tab
// ---------------------------------------------------------------------------

function QuestionsTab({
  courseId,
  questions,
}: {
  courseId: string | undefined;
  questions: { id: string; course_id: string; topic?: { id: string; name: string } | null }[];
}) {
  const [, navigate] = useSearchParams();

  const byTopic = new Map<string, TopicWithStats>();

  for (const q of questions) {
    if (q.course_id !== courseId) continue;
    const topic = q.topic;
    if (!topic) continue;
    const existing = byTopic.get(topic.id);
    if (existing) {
      existing.question_count += 1;
    } else {
      byTopic.set(topic.id, {
        id: topic.id,
        course_id: courseId!,
        name: topic.name,
        question_count: 1,
        mastered_count: 0,
        mastery_percent: 0,
      });
    }
  }

  const topics = [...byTopic.values()].sort((a, b) => a.name.localeCompare(b.name));
  const hasTopics = topics.length > 0;

  const startRandom = () => {
    const pool = questions.filter((q) => q.course_id === courseId);
    const pick = pickRandom(pool);
    if (pick) navigate(`/questions/${pick.id}`);
  };

  const startTopic = (topicId: string) => {
    const pool = questions.filter((q) => q.course_id === courseId && q.topic?.id === topicId);
    const pick = pickRandom(pool);
    if (pick) {
      navigate(`/questions/${pick.id}?course=${courseId}&topic=${topicId}`);
    }
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <h2 className="font-serif text-2xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
          Topics
        </h2>
        <Button variant="outline" onClick={startRandom} disabled={!hasTopics}>
          Random problem
        </Button>
      </div>

      {!hasTopics ? (
        <EmptyState
          icon={<BookOpenText className="size-8" />}
          title="No topics yet"
          description="No questions have been added to this course yet."
        />
      ) : (
        <ul className="space-y-4">
          {topics.map((topic) => (
            <li key={topic.id}>
              <button
                type="button"
                onClick={() => startTopic(topic.id)}
                className="group block w-full text-left"
              >
                <Card className="transition-colors group-hover:border-brand-300 group-hover:bg-brand-50/40 dark:group-hover:border-brand-700 dark:group-hover:bg-brand-950/40">
                  <CardContent className="flex items-center justify-between gap-4 px-5 py-4">
                    <div className="min-w-0">
                      <h3 className="truncate font-semibold text-stone-800 group-hover:text-brand-700 dark:text-stone-100 dark:group-hover:text-brand-300">
                        {topic.name}
                      </h3>
                      <p className="mt-0.5 text-xs text-stone-500 dark:text-stone-400">
                        {topic.mastered_count} / {topic.question_count} mastered
                      </p>
                    </div>
                    <ArrowRight className="size-4 shrink-0 text-stone-400 transition-transform group-hover:translate-x-1 group-hover:text-brand-600 dark:text-stone-500 dark:group-hover:text-brand-400" />
                  </CardContent>
                </Card>
              </button>
            </li>
          ))}
        </ul>
      )}
    </div>
  );
}

// ---------------------------------------------------------------------------
// Notes tab
// ---------------------------------------------------------------------------

function NotesTab({ courseId }: { courseId: string | undefined }) {
  const { data: notes, loading, error, reload } = useCourseNotes(courseId);

  if (loading) return <LoadingState label="Loading notes" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load notes"
        message={error}
        onRetry={reload}
      />
    );
  }

  if (!notes || notes.length === 0) {
    return (
      <EmptyState
        icon={<FileText className="size-8" />}
        title="No notes yet"
        description="Course notes will appear here once they are added."
      />
    );
  }

  return <CourseNotesView notes={notes} />;
}
