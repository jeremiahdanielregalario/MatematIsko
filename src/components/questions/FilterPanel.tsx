import { memo } from 'react';
import { FilterX } from 'lucide-react';
import type { Course, Difficulty, QuestionFilter, Topic } from '@/types';
import { cn } from '@/lib/cn';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { DIFFICULTY_LABELS } from '@/lib/constants';

interface FilterFieldProps {
  label: string;
  value: string;
  onValueChange: (value: string) => void;
  placeholder?: string;
  children: React.ReactNode;
  className?: string;
}

function FilterField({ label, value, onValueChange, placeholder, children, className }: FilterFieldProps) {
  return (
    <div className={cn('flex flex-col gap-1.5', className)}>
      <Label className="text-xs text-stone-500 dark:text-stone-400">{label}</Label>
      <Select value={value} onValueChange={onValueChange}>
        <SelectTrigger className="h-10 text-sm">
          <SelectValue placeholder={placeholder} />
        </SelectTrigger>
        <SelectContent position="item-aligned">
          <SelectItem value="all">{placeholder ?? 'All'}</SelectItem>
          {children}
        </SelectContent>
      </Select>
    </div>
  );
}

interface FilterPanelProps {
  courses: Course[];
  topics: Topic[];
  years: number[];
  filter: QuestionFilter;
  onChange: (filter: QuestionFilter) => void;
  className?: string;
}

export const FilterPanel = memo(function FilterPanel({ courses, topics, years, filter, onChange, className }: FilterPanelProps) {
  const set = <K extends keyof QuestionFilter>(key: K, value: QuestionFilter[K] | undefined) => {
    const next = { ...filter, [key]: value };
    if (key === 'courseId') {
      next.topicId = undefined;
    }
    onChange(next);
  };

  const hasActiveFilters =
    Boolean(filter.courseId) ||
    Boolean(filter.topicId) ||
    Boolean(filter.difficulty) ||
    Boolean(filter.year) ||
    Boolean(filter.status);

  return (
    <div
      className={cn(
        'grid grid-cols-2 gap-3 rounded-xl border border-stone-200 bg-white p-4 sm:grid-cols-3 lg:grid-cols-6 max-[360px]:grid-cols-1 dark:border-stone-800 dark:bg-stone-900',
        className,
      )}
    >
      <FilterField
        label="Course"
        value={filter.courseId ?? 'all'}
        placeholder="All courses"
        onValueChange={(v) => set('courseId', v === 'all' ? undefined : v)}
      >
        {courses.map((course) => (
          <SelectItem key={course.id} value={course.id}>
            {course.code} — {course.name}
          </SelectItem>
        ))}
      </FilterField>

      <FilterField
        label="Topic"
        value={filter.topicId ?? 'all'}
        placeholder="All topics"
        onValueChange={(v) => set('topicId', v === 'all' ? undefined : v)}
      >
        {topics
          .filter((t) => !filter.courseId || t.course_id === filter.courseId)
          .map((topic) => (
            <SelectItem key={topic.id} value={topic.id}>
              {topic.name}
            </SelectItem>
          ))}
      </FilterField>

      <FilterField
        label="Difficulty"
        value={filter.difficulty ?? 'all'}
        placeholder="Any difficulty"
        onValueChange={(v) => set('difficulty', v === 'all' ? undefined : (v as Difficulty))}
      >
        {(Object.keys(DIFFICULTY_LABELS) as Difficulty[]).map((d) => (
          <SelectItem key={d} value={d}>
            {DIFFICULTY_LABELS[d]}
          </SelectItem>
        ))}
      </FilterField>

      <FilterField
        label="Year"
        value={filter.year !== undefined ? String(filter.year) : 'all'}
        placeholder="Any year"
        onValueChange={(v) => set('year', v === 'all' ? undefined : Number(v))}
      >
        {years.map((year) => (
          <SelectItem key={year} value={String(year)}>
            {year}
          </SelectItem>
        ))}
      </FilterField>

      <FilterField
        label="Status"
        value={filter.status ?? 'all'}
        placeholder="All questions"
        onValueChange={(v) =>
          set('status', v === 'all' ? undefined : (v as QuestionFilter['status']))
        }
      >
        <SelectItem value="unseen">Unseen</SelectItem>
        <SelectItem value="learning">Learning</SelectItem>
        <SelectItem value="mastered">Mastered</SelectItem>
        <SelectItem value="bookmarked">Bookmarked</SelectItem>
      </FilterField>

      <div className="col-span-2 flex items-end sm:col-span-3 lg:col-span-1">
        <Button
          variant="outline"
          size="sm"
          className="h-9 w-full"
          disabled={!hasActiveFilters}
          onClick={() =>
            onChange({
              ...filter,
              courseId: undefined,
              topicId: undefined,
              difficulty: undefined,
              year: undefined,
              status: undefined,
            })
          }
        >
          <FilterX className="size-4" />
          Clear
        </Button>
      </div>
    </div>
  );
});
