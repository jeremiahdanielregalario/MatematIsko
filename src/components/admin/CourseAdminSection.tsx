import { Plus, SearchX } from 'lucide-react';
import { useMemo, useState } from 'react';
import { AdminCourseList } from '@/components/admin/AdminCourseList';
import { CourseForm } from '@/components/admin/CourseForm';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { useCourses } from '@/hooks/useCourses';
import { adminDeleteCourse } from '@/lib/admin';
import type { Course } from '@/types';

export function CourseAdminSection() {
  const { data: loaded, loading, error, reload } = useCourses();
  const courses = useMemo(() => loaded ?? [], [loaded]);

  const [selected, setSelected] = useState<Course | null>(null);
  const [search, setSearch] = useState('');
  const [deleting, setDeleting] = useState(false);
  const [deleteError, setDeleteError] = useState<string | null>(null);

  const filtered = useMemo(() => {
    const term = search.trim().toLowerCase();
    if (term === '') return courses;
    return courses.filter(
      (course) =>
        course.code.toLowerCase().includes(term) ||
        course.name.toLowerCase().includes(term) ||
        (course.description ?? '').toLowerCase().includes(term),
    );
  }, [courses, search]);

  if (loading) return <LoadingState label="Loading courses" />;
  if (error) {
    return (
      <ErrorState title="Could not load courses" message={error.message} onRetry={reload} />
    );
  }

  const handleDelete = (course: Course) => {
    if (
      !window.confirm(
        `Delete "${course.code} — ${course.name}"? This will fail if it still has topics or questions.`,
      )
    ) {
      return;
    }
    setDeleting(true);
    setDeleteError(null);
    void adminDeleteCourse(course.id)
      .then(() => {
        if (selected?.id === course.id) setSelected(null);
        reload();
      })
      .catch((err: unknown) => {
        setDeleteError(err instanceof Error ? err.message : String(err));
      })
      .finally(() => {
        setDeleting(false);
      });
  };

  return (
    <div className="space-y-6">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Course Catalog
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            {courses.length} courses · changes apply to the live site immediately
          </p>
        </div>
        <Button variant="outline" onClick={() => setSelected(null)}>
          <Plus className="size-4" />
          New course
        </Button>
      </section>

      {deleteError ? (
        <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-400">
          {deleteError}
        </p>
      ) : null}

      <div className="grid gap-6 lg:grid-cols-[minmax(0,360px)_1fr]">
        <div className="space-y-3">
          <Input
            value={search}
            onChange={(event) => setSearch(event.target.value)}
            placeholder="Search courses…"
          />
          {filtered.length === 0 ? (
            <EmptyState
              icon={<SearchX className="size-8" />}
              title="No courses match"
              description="Adjust the search terms."
            />
          ) : (
            <AdminCourseList
              courses={filtered}
              selectedId={selected?.id ?? null}
              deleting={deleting}
              onSelect={setSelected}
              onDelete={handleDelete}
            />
          )}
        </div>

        <CourseForm
          initial={selected}
          onSaved={() => {
            reload();
            setSelected(null);
          }}
          onCancel={() => setSelected(null)}
        />
      </div>
    </div>
  );
}
