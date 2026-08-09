import { Bookmark, SearchX } from 'lucide-react';
import { useMemo, useState } from 'react';
import { Link } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Reveal } from '@/components/common/Reveal';
import { QuestionCard } from '@/components/questions/QuestionCard';
import { SearchBar } from '@/components/questions/SearchBar';
import { Button } from '@/components/ui/button';
import { useDebounce } from '@/hooks/useDebounce';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { mergeMutations } from '@/lib/mutations';
import { applyFilterAndSort } from '@/lib/questionFilter';
import type { QuestionFilter, QuestionWithMeta } from '@/types';

const EMPTY_QUESTIONS: QuestionWithMeta[] = [];

export function BookmarksPage() {
  const { data: loaded, loading, error, reload } = useQuestions();
  const [searchInput, setSearchInput] = useState('');
  const search = useDebounce(searchInput, 250);
  const [courseId, setCourseId] = useState<string | undefined>(undefined);

  const baseQuestions = loaded ?? EMPTY_QUESTIONS;
  const getQuestion = (id: string) => baseQuestions.find((q) => q.id === id);
  const mutations = useQuestionMutations(getQuestion);

  const bookmarks = useMemo(() => {
    const filter: QuestionFilter = { search, courseId, status: 'bookmarked' };
    return applyFilterAndSort(
      baseQuestions.map((q) => mergeMutations(q, mutations)),
      filter,
    );
  }, [baseQuestions, mutations, search, courseId]);

  const courses = useMemo(
    () => [...new Map(baseQuestions.map((q) => [q.course?.id, q.course])).values()],
    [baseQuestions],
  );

  if (loading) return <LoadingState label="Loading your bookmarks" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load your bookmarks"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  return (
    <div className="space-y-6">
      <header>
        <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
          Bookmarks
        </h1>
        <p className="mt-1 text-stone-500 dark:text-stone-400">
          {bookmarks.length} bookmarked question{bookmarks.length === 1 ? '' : 's'}
        </p>
      </header>

      <SearchBar
        value={searchInput}
        onChange={setSearchInput}
        placeholder="Search your bookmarks…"
      />

      {courses.length > 1 ? (
        <div className="flex flex-wrap gap-2">
          <Button
            variant={courseId === undefined ? 'secondary' : 'outline'}
            size="sm"
            onClick={() => setCourseId(undefined)}
          >
            All courses
          </Button>
          {courses.map(
            (course) =>
              course && (
                <Button
                  key={course.id}
                  variant={courseId === course.id ? 'secondary' : 'outline'}
                  size="sm"
                  onClick={() => setCourseId(course.id)}
                >
                  {course.code}
                </Button>
              ),
          )}
        </div>
      ) : null}

      {bookmarks.length === 0 ? (
        <EmptyState
          icon={<Bookmark className="size-8" />}
          title={search || courseId ? 'No bookmarks match your filters' : 'No bookmarked problems yet'}
          description={
            search || courseId
              ? 'Try a different search or course.'
              : 'When you find a question worth revisiting, bookmark it here.'
          }
          action={
            search || courseId ? (
              <Button
                variant="outline"
                size="sm"
                onClick={() => {
                  setSearchInput('');
                  setCourseId(undefined);
                }}
              >
                Clear filters
              </Button>
            ) : (
              <Button asChild>
                <Link to="/questions">Browse the question bank</Link>
              </Button>
            )
          }
        />
      ) : (
        <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
          {bookmarks.map((question, index) => (
            <Reveal key={question.id} delay={index * 45} className="h-full">
              <QuestionCard
                question={question}
                className="h-full"
                onToggleBookmark={mutations.toggleBookmark}
                onSetStatus={mutations.setStatus}
              />
            </Reveal>
          ))}
        </div>
      )}

      {bookmarks.length > 0 ? (
        <p className="flex items-center gap-1.5 text-xs text-stone-400 dark:text-stone-500">
          <SearchX className="size-3.5" />
          Tip: use the bookmark button on any card to save or remove questions.
        </p>
      ) : null}
    </div>
  );
}
