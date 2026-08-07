import { Plus, SearchX } from 'lucide-react';
import { useMemo, useState } from 'react';
import { AdminQuestionList } from '@/components/admin/AdminQuestionList';
import { QuestionForm } from '@/components/admin/QuestionForm';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { useCourses } from '@/hooks/useCourses';
import { useQuestions } from '@/hooks/useQuestions';
import { useTopics } from '@/hooks/useTopics';
import { adminDeleteQuestion } from '@/lib/admin';
import type { QuestionWithMeta } from '@/types';

const ALL_COURSES = '__all';
const EMPTY_QUESTIONS: QuestionWithMeta[] = [];

export function AdminPage() {
  const { data: loaded, loading, error, reload } = useQuestions();
  const { data: coursesData } = useCourses();
  const { data: topicsData } = useTopics();

  const courses = coursesData ?? [];
  const topics = topicsData ?? [];
  const questions = loaded ?? EMPTY_QUESTIONS;

  const [selected, setSelected] = useState<QuestionWithMeta | null>(null);
  const [courseFilter, setCourseFilter] = useState('');
  const [search, setSearch] = useState('');
  const [deleting, setDeleting] = useState(false);
  const [deleteError, setDeleteError] = useState<string | null>(null);

  const filtered = useMemo(() => {
    const term = search.trim().toLowerCase();
    return questions.filter((question) => {
      if (courseFilter !== '' && question.course_id !== courseFilter) return false;
      if (term === '') return true;
      return (
        question.title.toLowerCase().includes(term) ||
        question.question_text.toLowerCase().includes(term) ||
        (question.course?.code ?? '').toLowerCase().includes(term) ||
        (question.topic?.name ?? '').toLowerCase().includes(term)
      );
    });
  }, [questions, courseFilter, search]);

  if (loading) return <LoadingState label="Loading the question bank" />;
  if (error) {
    return (
      <ErrorState title="Could not load questions" message={error.message} onRetry={reload} />
    );
  }

  const handleDelete = (question: QuestionWithMeta) => {
    if (!window.confirm(`Delete "${question.title}"? Student progress and bookmarks for it will be removed too.`)) {
      return;
    }
    setDeleting(true);
    setDeleteError(null);
    void adminDeleteQuestion(question.id)
      .then(() => {
        if (selected?.id === question.id) setSelected(null);
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
            Question Bank Admin
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            {questions.length} questions · changes apply to the live site immediately
          </p>
        </div>
        <Button variant="outline" onClick={() => setSelected(null)}>
          <Plus className="size-4" />
          New question
        </Button>
      </section>

      {deleteError ? (
        <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-400">
          {deleteError}
        </p>
      ) : null}

      <div className="grid gap-6 lg:grid-cols-[minmax(0,360px)_1fr]">
        <div className="space-y-3">
          <div className="space-y-1.5">
            <Label htmlFor="admin-course-filter">Filter by course</Label>
            <Select
              value={courseFilter === '' ? ALL_COURSES : courseFilter}
              onValueChange={(value) => setCourseFilter(value === ALL_COURSES ? '' : value)}
            >
              <SelectTrigger id="admin-course-filter">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value={ALL_COURSES}>All courses</SelectItem>
                {courses.map((course) => (
                  <SelectItem key={course.id} value={course.id}>
                    {course.code} — {course.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
          <Input
            value={search}
            onChange={(event) => setSearch(event.target.value)}
            placeholder="Search questions…"
          />
          {filtered.length === 0 ? (
            <EmptyState
              icon={<SearchX className="size-8" />}
              title="No questions match"
              description="Adjust the course filter or search terms."
            />
          ) : (
            <AdminQuestionList
              questions={filtered}
              selectedId={selected?.id ?? null}
              deleting={deleting}
              onSelect={setSelected}
              onDelete={handleDelete}
            />
          )}
        </div>

        <QuestionForm
          initial={selected}
          courses={courses}
          topics={topics}
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
