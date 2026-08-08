import { ChevronUp, Sparkles } from 'lucide-react';
import { useMemo, useState } from 'react';
import { Button } from '@/components/ui/button';
import type { Course } from '@/types';

const DEFAULT_COURSE_CODES = [
  'MATH 20',
  'MATH 21',
  'MATH 22',
  'MATH 23',
  'MATH 40',
  'STAT 101',
  'MATH 122',
  'MATH 162',
];

function courseNumber(code: string): number {
  return parseFloat(code.replace('MATH', '').trim()) || 0;
}

function sortByCourseNumber(courses: Course[]): Course[] {
  return [...courses].sort((a, b) => courseNumber(a.code) - courseNumber(b.code));
}

function CourseCheckbox({
  course,
  checked,
  onToggle,
}: {
  course: Course;
  checked: boolean;
  onToggle: () => void;
}) {
  return (
    <label className="flex cursor-pointer items-center gap-3 rounded-lg border border-stone-200 px-3 py-2.5 text-sm transition-colors has-[:checked]:border-brand-700 has-[:checked]:bg-brand-50 dark:border-stone-800 dark:has-[:checked]:border-brand-500 dark:has-[:checked]:bg-brand-950/40">
      <input
        type="checkbox"
        checked={checked}
        onChange={onToggle}
        className="size-4 shrink-0 accent-brand-800 dark:accent-brand-400"
      />
      <span className="font-medium text-stone-900 dark:text-stone-100">{course.code}</span>
      <span className="text-stone-500 dark:text-stone-400">{course.name}</span>
    </label>
  );
}

interface CoursePickerProps {
  courses: Course[];
  value: string[];
  onChange: (ids: string[]) => void;
}

export function CoursePicker({ courses, value, onChange }: CoursePickerProps) {
  const [showHigher, setShowHigher] = useState(false);

  const defaultCourses = useMemo(() => {
    const byCode = new Map((courses ?? []).map((course) => [course.code, course]));
    return DEFAULT_COURSE_CODES.map((code) => byCode.get(code)).filter(
      (course): course is Course => Boolean(course),
    );
  }, [courses]);

  const higherCourses = useMemo(() => {
    const defaultIds = new Set(defaultCourses.map((course) => course.id));
    return sortByCourseNumber((courses ?? []).filter((course) => !defaultIds.has(course.id)));
  }, [courses, defaultCourses]);

  const toggleCourse = (courseId: string) => {
    onChange(
      value.includes(courseId) ? value.filter((id) => id !== courseId) : [...value, courseId],
    );
  };

  return (
    <>
      <div className="grid max-h-72 gap-2 overflow-y-auto pr-1">
        {defaultCourses.map((course) => (
          <CourseCheckbox
            key={course.id}
            course={course}
            checked={value.includes(course.id)}
            onToggle={() => toggleCourse(course.id)}
          />
        ))}
      </div>
      {higherCourses.length > 0 ? (
        showHigher ? (
          <>
            <div className="grid max-h-72 gap-2 overflow-y-auto pr-1">
              {higherCourses.map((course) => (
                <CourseCheckbox
                  key={course.id}
                  course={course}
                  checked={value.includes(course.id)}
                  onToggle={() => toggleCourse(course.id)}
                />
              ))}
            </div>
            <Button
              type="button"
              variant="ghost"
              size="sm"
              className="w-full"
              onClick={() => setShowHigher(false)}
            >
              <ChevronUp className="size-4" />
              Hide higher maths
            </Button>
          </>
        ) : (
          <Button
            type="button"
            variant="outline"
            className="w-full"
            onClick={() => setShowHigher(true)}
          >
            <Sparkles className="size-4" />
            Higher Maths
          </Button>
        )
      ) : null}
    </>
  );
}
