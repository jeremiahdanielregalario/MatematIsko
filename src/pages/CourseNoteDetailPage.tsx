import { ArrowLeft } from 'lucide-react';
import { Link, useParams } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { CourseNotesView } from '@/components/courses/CourseNotesView';
import { Button } from '@/components/ui/button';
import { useCourseNotes } from '@/hooks/useCourseNotes';

export function CourseNoteDetailPage() {
  const { courseId, noteId } = useParams<{ courseId: string; noteId: string }>();
  const { data: notes, loading, error, reload } = useCourseNotes(courseId);

  if (loading) return <LoadingState label="Loading note" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load note"
        message={error}
        onRetry={reload}
      />
    );
  }

  const note = notes?.find((n) => n.id === noteId);

  if (!note) {
    return (
      <EmptyState
        icon={<ArrowLeft className="size-8" />}
        title="Note not found"
        description="This note does not exist or has been removed."
        action={
          <Button asChild>
            <Link to={`/courses/${courseId}?tab=notes`}>Back to notes</Link>
          </Button>
        }
      />
    );
  }

  return (
    <div className="space-y-6">
      <Link
        to={`/courses/${courseId}?tab=notes`}
        className="inline-flex items-center gap-1 text-sm text-stone-500 transition-colors hover:text-stone-800 dark:text-stone-400 dark:hover:text-stone-200"
      >
        <ArrowLeft className="size-3.5" />
        Back to notes
      </Link>

      <CourseNotesView notes={[note]} />
    </div>
  );
}
