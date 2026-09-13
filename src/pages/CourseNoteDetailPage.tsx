import { ArrowLeft } from 'lucide-react';
import { Link, useParams } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { CourseNotesView } from '@/components/courses/CourseNotesView';
import { Button } from '@/components/ui/button';
import { useTheorems } from '@/hooks/useTheorems';
import { useCourseNotes } from '@/hooks/useCourseNotes';

export function CourseNoteDetailPage() {
  const { courseId, noteId } = useParams<{ courseId: string; noteId: string }>();
  const { data: theorems } = useTheorems();
  const { data: notes, loading, error, reload } = useCourseNotes(courseId);

  if (loading) return <LoadingState label="Loading note" />;
  if (error) {
    return <ErrorState title="Could not load note" message={error} onRetry={reload} />;
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

  const noteIndex = (notes ?? []).findIndex((item) => item.id === note.id);
  const previous = notes?.[noteIndex - 1];
  const next = notes?.[noteIndex + 1];

  return (
    <div className="mx-auto max-w-6xl space-y-6">
      <Link
        to={`/courses/${courseId}?tab=notes`}
        className="inline-flex items-center gap-1 text-sm text-stone-500 transition-colors hover:text-stone-800 dark:text-stone-400 dark:hover:text-stone-200"
      >
        <ArrowLeft className="size-3.5" />
        Back to notes
      </Link>

      <CourseNotesView notes={[note]} theorems={theorems ?? []} />
      <nav aria-label="More course notes" className="grid gap-3 sm:grid-cols-2">
        {previous && (
          <Link
            className="rounded-xl border border-stone-200 bg-white p-4 dark:border-stone-800 dark:bg-stone-900"
            to={`/courses/${courseId}/notes/${previous.id}`}
          >
            <span className="block text-xs text-stone-500">Previous note</span>
            <span className="mt-1 block font-medium">{previous.title}</span>
          </Link>
        )}
        {next && (
          <Link
            className="rounded-xl border border-stone-200 bg-white p-4 dark:border-stone-800 dark:bg-stone-900 sm:col-start-2"
            to={`/courses/${courseId}/notes/${next.id}`}
          >
            <span className="block text-xs text-stone-500">Next note</span>
            <span className="mt-1 block font-medium">{next.title}</span>
          </Link>
        )}
      </nav>
    </div>
  );
}
