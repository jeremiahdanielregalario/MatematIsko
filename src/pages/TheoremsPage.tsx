import { GraduationCap, Layers, Layers2, SearchX } from 'lucide-react';
import { useMemo } from 'react';
import { useNavigate, useSearchParams } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { TheoremCard } from '@/components/theorems/TheoremCard';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { useCourses } from '@/hooks/useCourses';
import { useTheoremMutations } from '@/hooks/useTheoremMutations';
import { useTheorems } from '@/hooks/useTheorems';
import { useTopics } from '@/hooks/useTopics';
import { mergeTheoremMutations } from '@/lib/mutations';
import type { TheoremWithMeta } from '@/types';

const EMPTY_THEOREMS: TheoremWithMeta[] = [];

const ALL_COURSES = '__all';
const ALL_TOPICS = '__all';

export function TheoremsPage() {
  const navigate = useNavigate();
  const [searchParams, setSearchParams] = useSearchParams();

  const courseId = searchParams.get('course') ?? '';
  const topicId = searchParams.get('topic') ?? '';

  const { data: loaded, loading, error, reload } = useTheorems();
  const { data: coursesData } = useCourses();
  const { data: topicsData } = useTopics();

  const courses = coursesData ?? [];
  const theorems = loaded ?? EMPTY_THEOREMS;

  const allTopics = useMemo(() => topicsData ?? [], [topicsData]);
  const courseTopics = useMemo(
    () => allTopics.filter((topic) => topic.course_id === courseId),
    [allTopics, courseId],
  );

  const { statuses, setStatus } = useTheoremMutations(() => undefined);

  const filtered = useMemo(() => {
    const merged = theorems.map((theorem) => mergeTheoremMutations(theorem, statuses));
    return merged.filter((theorem) => {
      if (courseId !== '' && theorem.course_id !== courseId) return false;
      if (topicId !== '' && theorem.topic_id !== topicId) return false;
      return true;
    });
  }, [theorems, statuses, courseId, topicId]);

  const filteredTheorems = filtered;

  const updateParam = (key: 'course' | 'topic', value: string) => {
    const next = new URLSearchParams(searchParams);
    if (value === '') {
      next.delete(key);
    } else {
      next.set(key, value);
    }
    if (key === 'course' && value !== courseId) {
      next.delete('topic');
    }
    setSearchParams(next, { replace: true });
  };

  const startFlashcards = () => {
    const params = new URLSearchParams();
    if (courseId !== '') params.set('course', courseId);
    navigate(`/theorems/flashcards${params.toString() ? `?${params.toString()}` : ''}`);
  };

  if (loading) return <LoadingState label="Loading named theorems" />;
  if (error) {
    return <ErrorState title="Could not load theorems" message={error.message} onRetry={reload} />;
  }

  return (
    <div className="space-y-6">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Named Theorems
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            {filtered.length} theorems · memorize the statements that power every proof
          </p>
        </div>
        <Button variant="outline" onClick={startFlashcards}>
          <GraduationCap className="size-4" />
          Start Flashcards
        </Button>
      </section>

      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="theorem-course-filter">Course</Label>
          <Select
            value={courseId === '' ? ALL_COURSES : courseId}
            onValueChange={(value) => updateParam('course', value === ALL_COURSES ? '' : value)}
          >
            <SelectTrigger id="theorem-course-filter">
              <Layers className="size-4" />
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

        <div className="space-y-1.5">
          <Label htmlFor="theorem-topic-filter">Topic</Label>
          <Select
            value={topicId === '' ? ALL_TOPICS : topicId}
            onValueChange={(value) => updateParam('topic', value === ALL_TOPICS ? '' : value)}
          >
            <SelectTrigger id="theorem-topic-filter">
              <Layers2 className="size-4" />
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value={ALL_TOPICS}>All topics</SelectItem>
              {courseTopics.map((topic) => (
                <SelectItem key={topic.id} value={topic.id}>
                  {topic.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      {filteredTheorems.length === 0 ? (
        <EmptyState
          icon={<SearchX className="size-8" />}
          title="No theorems found"
          description="Adjust the course or topic filter to see more results."
        />
      ) : (
        <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
          {filteredTheorems.map((theorem) => (
            <TheoremCard
              key={theorem.id}
              theorem={theorem}
              onSetStatus={setStatus}
            />
          ))}
        </div>
      )}
    </div>
  );
}
