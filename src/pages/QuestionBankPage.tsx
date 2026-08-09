import { ChevronLeft, ChevronRight, SearchX, Shuffle } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { EmptyState } from '@/components/common/EmptyState';
import { LoadingState } from '@/components/common/LoadingState';
import { Reveal } from '@/components/common/Reveal';
import { FilterPanel } from '@/components/questions/FilterPanel';
import { QuestionCard } from '@/components/questions/QuestionCard';
import { SearchBar } from '@/components/questions/SearchBar';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { useCourses } from '@/hooks/useCourses';
import { useCourseScope } from '@/hooks/useCourseScope';
import { useDebounce } from '@/hooks/useDebounce';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { mergeMutations } from '@/lib/mutations';
import { applyFilterAndSort, pickRandom } from '@/lib/questionFilter';
import type { Difficulty, QuestionFilter, QuestionWithMeta } from '@/types';

const EMPTY_QUESTIONS: QuestionWithMeta[] = [];
const PAGE_SIZE = 12;

const SORT_OPTIONS: { value: NonNullable<QuestionFilter['sort']>; label: string }[] = [
  { value: 'newest', label: 'Newest first' },
  { value: 'oldest', label: 'Oldest first' },
  { value: 'difficulty', label: 'Difficulty (easy → hard)' },
  { value: 'recent', label: 'Recently attempted' },
  { value: 'random', label: 'Random' },
];

export function QuestionBankPage() {
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();

  const courseId = searchParams.get('course') ?? undefined;
  const topicId = searchParams.get('topic') ?? undefined;
  const difficulty = (searchParams.get('difficulty') as Difficulty | null) ?? undefined;
  const status = (searchParams.get('status') as QuestionFilter['status'] | null) ?? undefined;

  const [searchInput, setSearchInput] = useState('');
  const search = useDebounce(searchInput, 250);
  const [sort, setSort] = useState<NonNullable<QuestionFilter['sort']>>('newest');
  const [page, setPage] = useState(1);

  const { data: loaded, loading, error, reload } = useQuestions();
  const { data: coursesData } = useCourses();
  const { courseIds } = useCourseScope();
  const courses = useMemo(
    () => (coursesData ?? []).filter((course) => courseIds === null || courseIds.includes(course.id)),
    [coursesData, courseIds],
  );

  const baseQuestions = loaded ?? EMPTY_QUESTIONS;

  const getQuestion = (id: string) => baseQuestions.find((q) => q.id === id);
  const mutations = useQuestionMutations(getQuestion);

  const filter: QuestionFilter = useMemo(
    () => ({ search, courseId, topicId, difficulty, status, sort }),
    [search, courseId, topicId, difficulty, status, sort],
  );

  const questions = useMemo<QuestionWithMeta[]>(() => {
    const merged = baseQuestions.map((q) => mergeMutations(q, mutations));
    return applyFilterAndSort(merged, filter);
  }, [baseQuestions, mutations, filter]);

  // Reset to first page whenever filters or sort change.
  useEffect(() => {
    setPage(1);
  }, [filter]);

  const totalPages = Math.max(1, Math.ceil(questions.length / PAGE_SIZE));
  const safePage = Math.min(page, totalPages);
  const pagedQuestions = useMemo(
    () => questions.slice((safePage - 1) * PAGE_SIZE, safePage * PAGE_SIZE),
    [questions, safePage],
  );

  const years = useMemo(
    () => [...new Set(baseQuestions.map((q) => q.year))].sort((a, b) => b - a),
    [baseQuestions],
  );

  const topics = useMemo(() => {
    const map = new Map<string, { id: string; course_id: string; name: string }>();
    for (const q of baseQuestions) {
      if (q.topic) map.set(q.topic.id, q.topic);
    }
    return [...map.values()];
  }, [baseQuestions]);

  if (loading) return <LoadingState label="Loading the question bank" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load questions"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  const updateParams = (changes: Record<string, string | undefined>) => {
    const next = new URLSearchParams(searchParams);
    for (const [key, value] of Object.entries(changes)) {
      if (value === undefined || value === '') {
        next.delete(key);
      } else {
        next.set(key, value);
      }
    }
    setSearchParams(next, { replace: true });
  };

  const handleFilterChange = (next: QuestionFilter) => {
    const nextCourse = next.courseId;
    const changes: Record<string, string | undefined> = {
      course: nextCourse,
      difficulty: next.difficulty,
      status: next.status,
      year: next.year !== undefined ? String(next.year) : undefined,
      topic: nextCourse !== courseId ? undefined : next.topicId,
    };
    updateParams(changes);
  };

  const openRandom = () => {
    const random = pickRandom(questions.length > 0 ? questions : baseQuestions);
    if (random) navigate(`/questions/${random.id}`);
  };

  const hasSearchOrFilter =
    search.trim().length > 0 ||
    Boolean(courseId) ||
    Boolean(topicId) ||
    Boolean(difficulty) ||
    Boolean(status) ||
    searchParams.get('year') !== null;

  return (
    <div className="space-y-6">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Question Bank
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            {questions.length} of {baseQuestions.length} questions
          </p>
        </div>
        <Button variant="outline" onClick={openRandom}>
          <Shuffle className="size-4" />
          Give me a random problem
        </Button>
      </section>

      <div className="space-y-3">
        <SearchBar
          value={searchInput}
          onChange={setSearchInput}
          placeholder="Search by text, title, topic, course, or exam…"
        />
        <FilterPanel
          courses={courses}
          topics={topics}
          years={years}
          filter={filter}
          onChange={handleFilterChange}
        />
        <div className="flex items-center justify-end gap-2">
          <Label className="text-xs text-stone-500 dark:text-stone-400">Sort by</Label>
          <Select value={sort} onValueChange={(value) => setSort(value as NonNullable<QuestionFilter['sort']>)}>
            <SelectTrigger className="h-10 w-full text-sm sm:w-56">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {SORT_OPTIONS.map((option) => (
                <SelectItem key={option.value} value={option.value}>
                  {option.label}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      {questions.length === 0 ? (
        <EmptyState
          icon={<SearchX className="size-8" />}
          title={baseQuestions.length === 0 ? 'No questions yet' : 'No matching questions'}
          description={
            baseQuestions.length === 0
              ? 'The question bank is empty. Run the seed data to populate it.'
              : 'Try changing your search terms or clearing the filters.'
          }
          action={
            hasSearchOrFilter ? (
              <Button
                variant="outline"
                size="sm"
                onClick={() => {
                  setSearchInput('');
                  setSearchParams({}, { replace: true });
                }}
              >
                Clear search and filters
              </Button>
            ) : undefined
          }
        />
      ) : (
        <>
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {pagedQuestions.map((question, index) => (
              <Reveal key={question.id} delay={(index % PAGE_SIZE) * 45} className="h-full">
                <QuestionCard
                  question={question}
                  className="h-full"
                  onToggleBookmark={mutations.toggleBookmark}
                  onSetStatus={mutations.setStatus}
                />
              </Reveal>
            ))}
          </div>
          {totalPages > 1 ? (
            <div className="flex items-center justify-center gap-3 pt-2">
              <Button
                variant="outline"
                size="sm"
                disabled={safePage <= 1}
                onClick={() => setPage((p) => p - 1)}
              >
                <ChevronLeft className="size-4" />
                Previous
              </Button>
              <span className="text-sm text-stone-500 dark:text-stone-400">
                Page {safePage} of {totalPages}
              </span>
              <Button
                variant="outline"
                size="sm"
                disabled={safePage >= totalPages}
                onClick={() => setPage((p) => p + 1)}
              >
                Next
                <ChevronRight className="size-4" />
              </Button>
            </div>
          ) : null}
        </>
      )}
    </div>
  );
}
