import { Check, HelpCircle, X } from 'lucide-react';
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

  const answerButtons: { variant: AnswerResult; icon: typeof Check; label: string; activeClass: string }[] = [
    {
      variant: 'correct',
      icon: Check,
      label: 'Correct',
      activeClass:
        'border-emerald-600 bg-emerald-600 text-white hover:border-emerald-500 hover:bg-emerald-500 dark:border-emerald-500 dark:bg-emerald-600 dark:hover:bg-emerald-500',
    },
    {
      variant: 'incorrect',
      icon: X,
      label: 'Incorrect',
      activeClass:
        'border-red-600 bg-red-600 text-white hover:border-red-500 hover:bg-red-500 dark:border-red-500 dark:bg-red-600 dark:hover:bg-red-500',
    },
    {
      variant: 'unsure',
      icon: HelpCircle,
      label: 'Not sure',
      activeClass:
        'border-amber-500 bg-amber-500 text-white hover:border-amber-400 hover:bg-amber-400 dark:border-amber-500 dark:bg-amber-500 dark:hover:bg-amber-400',
    },
  ];

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
          className="h-full rounded-full bg-brand-700 transition-all duration-300 ease-out dark:bg-brand-400"
          style={{ width: `${progress}%` }}
        />
      </div>

      <Card key={question.id} className="animate-slide-up">
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
              <MathRenderer inline>{question.title}</MathRenderer>
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
        {answerButtons.map(({ variant, icon: Icon, label, activeClass }) => (
          <button
            key={variant}
            type="button"
            className={cn(
              'flex h-11 flex-1 items-center justify-center gap-2 rounded-lg border text-sm font-semibold transition-all duration-150 active:scale-[0.97] focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
              activeClass,
            )}
            onClick={() => handleAnswer(variant)}
          >
            <Icon className="size-4" aria-hidden="true" />
            {label}
          </button>
        ))}
      </div>
    </div>
  );
}
