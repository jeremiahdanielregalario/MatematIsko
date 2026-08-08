import { ArrowRight, CheckCircle2, Layers } from 'lucide-react';
import { Card } from '@/components/ui/card';
import { cn } from '@/lib/cn';
import type { Course } from '@/types';

export interface CourseStats {
  total: number;
  mastered: number;
  learning: number;
}

interface CourseCardProps {
  course: Course;
  stats: CourseStats;
  className?: string;
}

export function CourseCard({ course, stats, className }: CourseCardProps) {
  const mastery = stats.total === 0 ? 0 : Math.round((stats.mastered / stats.total) * 100);

  return (
    <Card
      className={cn(
        'group relative flex flex-col gap-3 p-5 transition-shadow hover:shadow-md',
        'focus-within:outline-2 focus-within:outline-offset-2 focus-within:outline-brand-600',
        className,
      )}
    >
      <div className="flex items-start justify-between gap-2">
        <span className="font-mono text-sm font-semibold text-brand-900 dark:text-brand-300">
          {course.code}
        </span>
        <ArrowRight className="size-4 shrink-0 text-stone-400 transition-transform group-hover:translate-x-0.5 group-hover:text-brand-700 dark:group-hover:text-brand-300" />
      </div>

      <h3 className="font-semibold leading-snug text-stone-900 dark:text-stone-100">
        {course.name}
      </h3>

      {course.description ? (
        <p className="line-clamp-2 text-sm text-stone-500 dark:text-stone-400">
          {course.description}
        </p>
      ) : null}

      <div className="mt-auto flex items-center gap-4 pt-2 text-xs text-stone-500 dark:text-stone-400">
        <span className="inline-flex items-center gap-1">
          <Layers className="size-3.5" />
          {stats.total} question{stats.total === 1 ? '' : 's'}
        </span>
        <span className="inline-flex items-center gap-1">
          <CheckCircle2 className="size-3.5" />
          {stats.mastered} mastered
        </span>
      </div>

      <div className="h-1.5 w-full overflow-hidden rounded-full bg-stone-200 dark:bg-stone-800">
        <div
          className="h-full rounded-full bg-brand-700 transition-all dark:bg-brand-400"
          style={{ width: `${mastery}%` }}
        />
      </div>
      <span className="text-xs font-medium text-stone-500 dark:text-stone-400">
        {mastery}% mastered
      </span>
    </Card>
  );
}
