import { BookOpenText, Flag, GraduationCap, Landmark } from 'lucide-react';
import { useEffect, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
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

const VALID_TABS = new Set<AdminTab>(['courses', 'questions', 'theorems', 'reports']);

function parseTab(value: string | null): AdminTab {
  return value !== null && VALID_TABS.has(value as AdminTab) ? (value as AdminTab) : 'questions';
}

export function AdminPage() {
  const [searchParams, setSearchParams] = useSearchParams();
  const [tab, setTab] = useState<AdminTab>(() => parseTab(searchParams.get('tab')));
  const [editId, setEditId] = useState<string | null>(() => searchParams.get('edit'));

  useEffect(() => {
    const nextTab = parseTab(searchParams.get('tab'));
    const nextEdit = searchParams.get('edit');
    setTab(nextTab);
    setEditId(nextEdit);
  }, [searchParams]);

  const selectTab = (value: AdminTab) => {
    const params = new URLSearchParams(searchParams);
    params.set('tab', value);
    params.delete('edit');
    setSearchParams(params, { replace: true });
    setTab(value);
    setEditId(null);
  };

  const clearEdit = () => {
    if (editId === null) return;
    const params = new URLSearchParams(searchParams);
    params.delete('edit');
    setSearchParams(params, { replace: true });
    setEditId(null);
  };

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
            onClick={() => selectTab(value)}
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
      {tab === 'questions' && (
        <QuestionAdminSection editId={editId} onEditHandled={clearEdit} />
      )}
      {tab === 'theorems' && (
        <TheoremAdminSection editId={editId} onEditHandled={clearEdit} />
      )}
      {tab === 'reports' && <ReportsAdminSection />}
    </div>
  );
}
