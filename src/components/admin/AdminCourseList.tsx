import { Edit, Loader2, Trash2 } from 'lucide-react';
import type { Course } from '@/types';

interface AdminCourseListProps {
  courses: Course[];
  selectedId: string | null;
  deleting: boolean;
  onSelect: (course: Course) => void;
  onDelete: (course: Course) => void;
}

export function AdminCourseList({
  courses,
  selectedId,
  deleting,
  onSelect,
  onDelete,
}: AdminCourseListProps) {
  return (
    <ul className="space-y-1">
      {courses.map((course) => {
        const active = course.id === selectedId;
        return (
          <li
            key={course.id}
            className="flex items-center justify-between gap-2 rounded-lg border border-stone-200 px-3 py-2 text-sm transition-colors dark:border-stone-800"
          >
            <button
              type="button"
              onClick={() => onSelect(course)}
              className={`min-w-0 flex-1 truncate text-left transition-colors ${
                active
                  ? 'font-semibold text-brand-800 dark:text-brand-300'
                  : 'text-stone-700 hover:text-stone-900 dark:text-stone-300 dark:hover:text-stone-100'
              }`}
            >
              <span className="font-mono text-xs font-semibold">{course.code}</span>
              <span className="ml-2">{course.name}</span>
            </button>
            <div className="flex shrink-0 items-center gap-1">
              <button
                type="button"
                onClick={() => onSelect(course)}
                className="rounded-md p-1 text-stone-400 transition-colors hover:bg-stone-100 hover:text-stone-700 dark:hover:bg-stone-800 dark:hover:text-stone-200"
                aria-label={`Edit ${course.code}`}
              >
                <Edit className="size-4" />
              </button>
              <button
                type="button"
                onClick={() => onDelete(course)}
                disabled={deleting}
                className="rounded-md p-1 text-stone-400 transition-colors hover:bg-red-50 hover:text-red-600 disabled:opacity-40 dark:hover:bg-red-950/50 dark:hover:text-red-400"
                aria-label={`Delete ${course.code}`}
              >
                {deleting ? <Loader2 className="size-4 animate-spin" /> : <Trash2 className="size-4" />}
              </button>
            </div>
          </li>
        );
      })}
    </ul>
  );
}
