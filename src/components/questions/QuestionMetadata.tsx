import { CalendarDays, Hash, Layers } from 'lucide-react';
import type { QuestionWithRelations } from '@/types';
import { cn } from '@/lib/cn';
import { DifficultyBadge } from './DifficultyBadge';

interface QuestionMetadataProps {
  question: QuestionWithRelations;
  className?: string;
  showExam?: boolean;
}

/**
 * Compact metadata row: course, topic, difficulty, year, exam, number.
 * Color is never the only signal — difficulty is also labeled with text.
 */
export function QuestionMetadata({ question, className, showExam = true }: QuestionMetadataProps) {
  return (
    <div className={cn('flex flex-wrap items-center gap-x-3 gap-y-1.5 text-xs text-stone-500 dark:text-stone-400', className)}>
      <span className="font-mono font-semibold text-stone-700 dark:text-stone-300">
        {question.course?.code ?? '—'}
      </span>
      <span className="inline-flex items-center gap-1">
        <Layers className="size-3.5" />
        {question.topic?.name ?? 'Uncategorized'}
      </span>
      <DifficultyBadge difficulty={question.difficulty} />
      <span className="inline-flex items-center gap-1">
        <CalendarDays className="size-3.5" />
        {question.year}
      </span>
      {showExam ? (
        <span className="inline-flex items-center gap-1">
          {question.exam_name}
          <span className="inline-flex items-center gap-0.5">
            <Hash className="size-3" />
            {question.question_number}
          </span>
        </span>
      ) : null}
    </div>
  );
}
