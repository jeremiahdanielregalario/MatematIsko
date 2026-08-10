import { Clock, Eye, EyeOff, ExternalLink, SearchX } from 'lucide-react';
import { useEffect, useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { cn } from '@/lib/cn';
import { formatRelativeTime } from '@/lib/format';
import {
  adminListQuestionReports,
  adminListTheoremReports,
  adminResolveReport,
  adminReopenReport,
} from '@/lib/reports';
import type { QuestionReportRow, TheoremReportRow } from '@/types';

const ALL_STATUS = '__all';

interface QuestionReportItemProps {
  report: QuestionReportRow;
  onToggle: (id: string) => void;
}

function QuestionReportItem({ report, onToggle }: QuestionReportItemProps) {
  const navigate = useNavigate();
  return (
    <div className="rounded-lg border border-stone-200 bg-white p-4 dark:border-stone-800 dark:bg-stone-900">
      <div className="flex flex-wrap items-start justify-between gap-2">
        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
            <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
              {report.course_code ?? '—'}
            </span>
            <Badge variant={report.status === 'open' ? 'warning' : 'success'}>
              {report.status}
            </Badge>
            <span>{report.category}</span>
          </div>
          <button
            type="button"
            onClick={() => navigate(`/questions/${report.question_id}`)}
            className="mt-1 text-left text-sm font-medium text-stone-900 hover:text-brand-700 hover:underline dark:text-stone-100 dark:hover:text-brand-400"
          >
            {report.question_title ?? 'Unknown question'}
          </button>
          <p className="mt-0.5 text-xs text-stone-400 dark:text-stone-500">
            Reported by {report.user_email ?? 'unknown'}
          </p>
          {report.description ? (
            <p className="mt-2 rounded-md bg-stone-50 px-3 py-2 text-sm text-stone-700 dark:bg-stone-800 dark:text-stone-300">
              {report.description}
            </p>
          ) : null}
          <p className="mt-2 flex items-center gap-1 text-xs text-stone-400 dark:text-stone-500">
            <Clock className="size-3" />
            {formatRelativeTime(report.created_at)}
          </p>
        </div>
      </div>
      <div className="mt-3 flex items-center justify-end gap-2">
        <Button
          variant="ghost"
          size="sm"
          onClick={() => navigate(`/questions/${report.question_id}`)}
          className="text-stone-500 dark:text-stone-400"
        >
          <ExternalLink className="size-4" />
          View
        </Button>
        {report.status === 'open' ? (
          <Button
            variant="outline"
            size="sm"
            onClick={() => onToggle(report.id)}
          >
            <Eye className="size-4" />
            Mark resolved
          </Button>
        ) : (
          <Button
            variant="ghost"
            size="sm"
            onClick={() => onToggle(report.id)}
          >
            <EyeOff className="size-4" />
            Reopen
          </Button>
        )}
      </div>
    </div>
  );
}

interface TheoremReportItemProps {
  report: TheoremReportRow;
  onToggle: (id: string) => void;
}

function TheoremReportItem({ report, onToggle }: TheoremReportItemProps) {
  const navigate = useNavigate();
  return (
    <div className="rounded-lg border border-stone-200 bg-white p-4 dark:border-stone-800 dark:bg-stone-900">
      <div className="flex flex-wrap items-start justify-between gap-2">
        <div className="min-w-0 flex-1">
          <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
            <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
              {report.course_code ?? '—'}
            </span>
            <Badge variant={report.status === 'open' ? 'warning' : 'success'}>
              {report.status}
            </Badge>
            <span>{report.category}</span>
          </div>
          <button
            type="button"
            onClick={() => navigate(`/theorems/${report.theorem_id}`)}
            className="mt-1 text-left text-sm font-medium text-stone-900 hover:text-brand-700 hover:underline dark:text-stone-100 dark:hover:text-brand-400"
          >
            {report.theorem_name ?? 'Unknown theorem'}
          </button>
          <p className="mt-0.5 text-xs text-stone-400 dark:text-stone-500">
            Reported by {report.user_email ?? 'unknown'}
          </p>
          {report.description ? (
            <p className="mt-2 rounded-md bg-stone-50 px-3 py-2 text-sm text-stone-700 dark:bg-stone-800 dark:text-stone-300">
              {report.description}
            </p>
          ) : null}
          <p className="mt-2 flex items-center gap-1 text-xs text-stone-400 dark:text-stone-500">
            <Clock className="size-3" />
            {formatRelativeTime(report.created_at)}
          </p>
        </div>
      </div>
      <div className="mt-3 flex items-center justify-end gap-2">
        <Button
          variant="ghost"
          size="sm"
          onClick={() => navigate(`/theorems/${report.theorem_id}`)}
          className="text-stone-500 dark:text-stone-400"
        >
          <ExternalLink className="size-4" />
          View
        </Button>
        {report.status === 'open' ? (
          <Button
            variant="outline"
            size="sm"
            onClick={() => onToggle(report.id)}
          >
            <Eye className="size-4" />
            Mark resolved
          </Button>
        ) : (
          <Button
            variant="ghost"
            size="sm"
            onClick={() => onToggle(report.id)}
          >
            <EyeOff className="size-4" />
            Reopen
          </Button>
        )}
      </div>
    </div>
  );
}

type ReportTab = 'questions' | 'theorems';

export function ReportsAdminSection() {
  const [activeTab, setActiveTab] = useState<ReportTab>('questions');
  const [statusFilter, setStatusFilter] = useState(ALL_STATUS);

  const [questionReports, setQuestionReports] = useState<QuestionReportRow[]>([]);
  const [theoremReports, setTheoremReports] = useState<TheoremReportRow[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchReports = (status?: string) => {
    const statusArg = status === ALL_STATUS ? undefined : status;
    setLoading(true);
    setError(null);
    Promise.all([
      adminListQuestionReports(statusArg),
      adminListTheoremReports(statusArg),
    ])
      .then(([qReports, tReports]) => {
        setQuestionReports(qReports);
        setTheoremReports(tReports);
      })
      .catch((err: unknown) => {
        setError(err instanceof Error ? err.message : String(err));
      })
      .finally(() => {
        setLoading(false);
      });
  };

  useEffect(() => {
    fetchReports(statusFilter);
  }, [statusFilter]);

  const handleToggle = async (table: 'question_reports' | 'theorem_reports', id: string) => {
    const currentList = table === 'question_reports' ? questionReports : theoremReports;
    const current = currentList.find((r) => r.id === id);
    if (!current) return;
    try {
      if (current.status === 'open') {
        await adminResolveReport(table, id);
      } else {
        await adminReopenReport(table, id);
      }
      fetchReports(statusFilter);
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    }
  };

  const openQuestionCount = questionReports.filter((r) => r.status === 'open').length;
  const openTheoremCount = theoremReports.filter((r) => r.status === 'open').length;
  const totalOpen = openQuestionCount + openTheoremCount;

  if (loading && questionReports.length === 0 && theoremReports.length === 0) {
    return <LoadingState label="Loading reports" />;
  }
  if (error && questionReports.length === 0 && theoremReports.length === 0) {
    return (
      <ErrorState title="Could not load reports" message={error} onRetry={() => fetchReports(statusFilter)} />
    );
  }

  return (
    <div className="space-y-6">
      <section className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <div>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Reports
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            {totalOpen} open · {questionReports.length + theoremReports.length - totalOpen} resolved
          </p>
        </div>
        <div className="flex items-center gap-3">
          <Select value={statusFilter} onValueChange={setStatusFilter}>
            <SelectTrigger className="w-40">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              <SelectItem value={ALL_STATUS}>All statuses</SelectItem>
              <SelectItem value="open">Open only</SelectItem>
              <SelectItem value="resolved">Resolved only</SelectItem>
            </SelectContent>
          </Select>
        </div>
      </section>

      {error ? (
        <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-400">
          {error}
        </p>
      ) : null}

      {/* Report type tabs */}
      <div className="flex items-center gap-1 rounded-lg border border-stone-200 bg-stone-50 p-1 dark:border-stone-800 dark:bg-stone-900">
        {([
          { key: 'questions' as const, label: 'Questions', count: questionReports.length },
          { key: 'theorems' as const, label: 'Theorems', count: theoremReports.length },
        ]).map(({ key, label, count }) => (
          <button
            key={key}
            type="button"
            onClick={() => setActiveTab(key)}
            className={cn(
              'inline-flex items-center gap-2 rounded-md px-4 py-2 text-sm font-medium transition-colors',
              activeTab === key
                ? 'bg-white text-stone-900 shadow-sm dark:bg-stone-800 dark:text-stone-50'
                : 'text-stone-500 hover:text-stone-700 dark:text-stone-400 dark:hover:text-stone-200',
            )}
          >
            {label}
            <Badge variant="secondary" className="font-mono text-xs">
              {count}
            </Badge>
          </button>
        ))}
      </div>

      {activeTab === 'questions' ? (
        questionReports.length === 0 ? (
          <EmptyState
            icon={<SearchX className="size-8" />}
            title="No question reports"
            description="Students have not reported any issues with questions yet."
          />
        ) : (
          <div className="space-y-3">
            {questionReports.map((report) => (
              <QuestionReportItem
                key={report.id}
                report={report}
                onToggle={(id) => handleToggle('question_reports', id)}
              />
            ))}
          </div>
        )
      ) : theoremReports.length === 0 ? (
        <EmptyState
          icon={<SearchX className="size-8" />}
          title="No theorem reports"
          description="Students have not reported any issues with theorems yet."
        />
      ) : (
        <div className="space-y-3">
          {theoremReports.map((report) => (
            <TheoremReportItem
              key={report.id}
              report={report}
              onToggle={(id) => handleToggle('theorem_reports', id)}
            />
          ))}
        </div>
      )}
    </div>
  );
}


