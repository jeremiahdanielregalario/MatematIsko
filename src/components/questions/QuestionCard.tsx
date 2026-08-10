import { ArrowUpRight, BookMarked } from 'lucide-react';
import { Link } from 'react-router-dom';
import type { ProgressStatus, QuestionWithMeta } from '@/types';
import { submitQuestionReport } from '@/lib/reports';
import { cn } from '@/lib/cn';
import { MathRenderer } from '@/components/math/MathRenderer';
import { ReportButton } from '@/components/common/ReportButton';
import { Badge } from '@/components/ui/badge';
import { Card } from '@/components/ui/card';
import { BookmarkButton } from './BookmarkButton';
import { DifficultyBadge } from './DifficultyBadge';
import { MasteryButton } from './MasteryButton';

interface QuestionCardProps {
  question: QuestionWithMeta;
  onToggleBookmark: (questionId: string, bookmarked: boolean) => void;
  onSetStatus?: (questionId: string, status: ProgressStatus) => void;
  className?: string;
  /** Optional link target; defaults to `/questions/:id`. Use to carry filter context. */
  to?: string;
}

export function QuestionCard({
  question,
  onToggleBookmark,
  onSetStatus,
  className,
  to,
}: QuestionCardProps) {
  const status = question.progress?.status ?? 'unseen';

  return (
    <Card
      className={cn(
        'group relative flex flex-col gap-3 p-5 transition-all duration-200 hover:-translate-y-1 hover:shadow-md',
        'focus-within:outline-2 focus-within:outline-offset-2 focus-within:outline-brand-600',
        className,
      )}
    >
      <div className="flex items-start justify-between gap-2">
        <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
          <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
            {question.course?.code ?? '—'}
          </span>
          <span>{question.topic?.name}</span>
          <DifficultyBadge difficulty={question.difficulty} />
        </div>
        <BookmarkButton
          bookmarked={question.bookmarked}
          onToggleBookmark={(bookmarked) => onToggleBookmark(question.id, bookmarked)}
        />
      </div>

      <div className="min-w-0 overflow-hidden">
        <h3 className="mb-1 font-serif text-lg font-semibold leading-snug text-stone-900 dark:text-stone-100">
          <Link
            to={to ?? `/questions/${question.id}`}
            className="rounded focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600 after:absolute after:inset-0"
          >
            <MathRenderer inline>{question.title}</MathRenderer>
          </Link>
        </h3>
        <div className="min-w-0 overflow-hidden text-sm text-stone-600 dark:text-stone-300">
          <div className="line-clamp-3">
            <MathRenderer preview>{question.question_text}</MathRenderer>
          </div>
        </div>
      </div>

      <div className="mt-auto flex flex-wrap items-center justify-between gap-2 border-t border-stone-100 pt-3 dark:border-stone-800">
        <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
          <span>
            {question.exam_name} · No. {question.question_number} · {question.year}
          </span>
          {status !== 'unseen' ? (
            <Badge variant={status === 'mastered' ? 'success' : 'warning'}>
              {status === 'mastered' ? (
                <>
                  <BookMarked className="size-3" /> Mastered
                </>
              ) : (
                'Learning'
              )}
            </Badge>
          ) : null}
        </div>
        <div className="flex items-center gap-1" onClick={(event) => event.stopPropagation()}>
          <ReportButton
            kind="question"
            onSubmit={(category, description) =>
              submitQuestionReport(question.id, category as never, description)
            }
          />
          {onSetStatus ? (
            <MasteryButton status={status} onChange={(next) => onSetStatus(question.id, next)} />
          ) : (
            <span className="inline-flex items-center gap-1 text-xs font-medium text-brand-800 opacity-0 transition-opacity group-hover:opacity-100 dark:text-brand-300">
              Open <ArrowUpRight className="size-3.5" />
            </span>
          )}
        </div>
      </div>
    </Card>
  );
}
