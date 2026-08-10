import { BookOpenText, Flag, GraduationCap, Landmark } from 'lucide-react';
import { useState } from 'react';
import { cn } from '@/lib/cn';
import { QuestionAdminSection } from '@/components/admin/QuestionAdminSection';
import { TheoremAdminSection } from '@/components/admin/TheoremAdminSection';
import { CourseAdminSection } from '@/components/admin/CourseAdminSection';
import { ReportsAdminSection } from '@/components/admin/ReportsAdminSection';

type AdminTab = 'courses' | 'questions' | 'theorems' | 'reports';

const TABS: { value: AdminTab; label: string; icon: typeof BookOpenText }[] = [
  { value: 'courses', label: 'Courses', icon: GraduationCap },
  { value: 'questions', label: 'Questions', icon: BookOpenText },
  { value: 'theorems', label: 'Theorems', icon: Landmark },
  { value: 'reports', label: 'Reports', icon: Flag },
];

export function AdminPage() {
  const [tab, setTab] = useState<AdminTab>('questions');

  return (
    <div className="space-y-6">
      <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
        Admin
      </h1>

      <div className="flex items-center gap-1 rounded-lg border border-stone-200 bg-stone-50 p-1 dark:border-stone-800 dark:bg-stone-900">
        {TABS.map(({ value, label, icon: Icon }) => (
          <button
            key={value}
            type="button"
            onClick={() => setTab(value)}
            className={cn(
              'inline-flex items-center gap-2 rounded-md px-4 py-2 text-sm font-medium transition-colors',
              'focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
              tab === value
                ? 'bg-white text-stone-900 shadow-sm dark:bg-stone-800 dark:text-stone-50'
                : 'text-stone-500 hover:text-stone-700 dark:text-stone-400 dark:hover:text-stone-200',
            )}
          >
            <Icon className="size-4" />
            {label}
          </button>
        ))}
      </div>

      {tab === 'courses' && <CourseAdminSection />}
      {tab === 'questions' && <QuestionAdminSection />}
      {tab === 'theorems' && <TheoremAdminSection />}
      {tab === 'reports' && <ReportsAdminSection />}
    </div>
  );
}
