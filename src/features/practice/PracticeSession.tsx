import { X } from 'lucide-react';
import { useState } from 'react';
import type { PracticeAnswer, AnswerResult } from '@/lib/practice';
import type { QuestionWithMeta } from '@/types';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { MathRenderer } from '@/components/math/MathRenderer';
import { DifficultyBadge } from '@/components/questions/DifficultyBadge';
import { RevealSection } from '@/components/questions/RevealSection';
import { useReveal } from '@/hooks/useReveal';
import { useRevealKeyboard } from '@/hooks/useRevealKeyboard';
import { cn } from '@/lib/cn';

interface PracticeSessionProps {
  questions: QuestionWithMeta[];
  onAnswer: (questionId: string, correct: boolean) => void;
  onComplete: (answers: PracticeAnswer[]) => void;
  onQuit: () => void;
}

export function PracticeSession({ questions, onAnswer, onComplete, onQuit }: PracticeSessionProps) {
  const [index, setIndex] = useState(0);
  const [answers, setAnswers] = useState<PracticeAnswer[]>([]);
  const reveal = useReveal();
  useRevealKeyboard(reveal.reveal);

  const question = questions[index];
  if (!question) return null;

  const progress = Math.round((index / questions.length) * 100);

  const handleAnswer = (result: AnswerResult) => {
    onAnswer(question.id, result === 'correct');
    const nextAnswers = [...answers, { questionId: question.id, result }];
    setAnswers(nextAnswers);
    if (index + 1 >= questions.length) {
      onComplete(nextAnswers);
      return;
    }
    setIndex(index + 1);
    reveal.reset();
  };

  const answerButtonClass = (variant: AnswerResult) =>
    cn(
      'h-11 flex-1',
      variant === 'correct' &&
        'bg-emerald-600 text-white hover:bg-emerald-500 dark:bg-emerald-600 dark:hover:bg-emerald-500',
      variant === 'incorrect' && 'bg-red-600 text-white hover:bg-red-500 dark:bg-red-700 dark:hover:bg-red-600',
      variant === 'unsure' && 'bg-amber-500 text-white hover:bg-amber-400 dark:bg-amber-600 dark:hover:bg-amber-500',
    );

  return (
    <div className="mx-auto max-w-3xl space-y-4">
      <div className="flex items-center justify-between">
        <p className="text-sm font-medium text-stone-600 dark:text-stone-300">
          Question {index + 1} of {questions.length}
        </p>
        <Button variant="ghost" size="sm" onClick={onQuit}>
          <X className="size-4" />
          Quit practice
        </Button>
      </div>

      <div
        className="h-1.5 overflow-hidden rounded-full bg-stone-200 dark:bg-stone-800"
        role="progressbar"
        aria-valuemin={0}
        aria-valuemax={100}
        aria-valuenow={progress}
        aria-label="Practice progress"
      >
        <div
          className="h-full rounded-full bg-brand-700 transition-all duration-300 dark:bg-brand-400"
          style={{ width: `${progress}%` }}
        />
      </div>

      <Card>
        <CardContent className="space-y-5 p-6">
          <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
            <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
              {question.course?.code ?? '—'}
            </span>
            <span>{question.topic?.name}</span>
            <DifficultyBadge difficulty={question.difficulty} />
            <span>
              {question.year} · {question.exam_name}
            </span>
          </div>

          <div>
            <h2 className="mb-2 font-serif text-xl font-semibold leading-snug text-stone-900 dark:text-stone-50">
              {question.title}
            </h2>
            <MathRenderer className="font-serif text-lg leading-relaxed">
              {question.question_text}
            </MathRenderer>
          </div>

          <RevealSection
            level={reveal.level}
            onReveal={reveal.reveal}
            onReset={reveal.reset}
            hint={question.hint}
            answer={question.answer}
            solution={question.solution}
          />
        </CardContent>
      </Card>

      <div className="flex flex-col gap-2 sm:flex-row">
        <button
          type="button"
          className={answerButtonClass('correct')}
          onClick={() => handleAnswer('correct')}
        >
          Correct
        </button>
        <button
          type="button"
          className={answerButtonClass('incorrect')}
          onClick={() => handleAnswer('incorrect')}
        >
          Incorrect
        </button>
        <button
          type="button"
          className={answerButtonClass('unsure')}
          onClick={() => handleAnswer('unsure')}
        >
          Not sure
        </button>
      </div>
    </div>
  );
}
