import { memo, useEffect, useState } from 'react';
import { Clock, Flag, LockKeyhole } from 'lucide-react';
import type { QuestionWithMeta } from '@/types';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { Textarea } from '@/components/ui/textarea';
import { Dialog, DialogContent, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { MathRenderer } from '@/components/math/MathRenderer';
import { cn } from '@/lib/cn';
import { examEnded, formatExamTime, type ExamSession } from './exam';

interface Props {
  session: ExamSession;
  questions: QuestionWithMeta[];
  onChange: (session: ExamSession) => void;
  onNew: () => void;
  onRetry: (ids: string[]) => void;
}

export function ExamPaper({ session, questions, onChange, onNew, onRetry }: Props) {
  const [now, setNow] = useState(Date.now);
  const [confirmFinish, setConfirmFinish] = useState(false);
  const [confirmNew, setConfirmNew] = useState(false);
  const ended = examEnded(session, now);
  const revealed = ended && session.revealed;
  useEffect(() => {
    if (ended) return;
    const tick = () => setNow(Date.now());
    const interval = window.setInterval(tick, 1000);
    window.addEventListener('focus', tick);
    document.addEventListener('visibilitychange', tick);
    return () => {
      window.clearInterval(interval);
      window.removeEventListener('focus', tick);
      document.removeEventListener('visibilitychange', tick);
    };
  }, [ended]);

  const checked = Object.keys(session.ratings).length;
  const correct = Object.values(session.ratings).filter((value) => value === 'correct').length;
  const retryIds = session.ids.filter(
    (id) => session.ratings[id] === 'incorrect' || session.ratings[id] === 'unsure',
  );
  const elapsed = (session.finishedAt ?? Math.min(now, session.deadline)) - session.startedAt;
  const jumpTo = (id: string) => {
    const heading = document.getElementById(`exam-question-${id}`);
    heading?.focus();
    heading?.scrollIntoView({ block: 'start' });
  };

  return (
    <div className="mx-auto max-w-5xl space-y-6">
      <section
        className="sticky top-16 z-30 rounded-xl border border-stone-200 bg-white/95 p-4 shadow-sm backdrop-blur dark:border-stone-700 dark:bg-stone-900/95"
        aria-label="Exam status"
      >
        <div className="flex flex-wrap items-center justify-between gap-3">
          <div>
            <p className="text-sm font-semibold">{ended ? 'Paper complete' : 'Exam in progress'}</p>
            <p className="text-xs text-stone-500">
              {session.attempted.length} / {questions.length} marked attempted ·{' '}
              {session.flagged.length} flagged
            </p>
          </div>
          <div className="flex items-center gap-3">
            <span
              role="timer"
              aria-label={ended ? 'Time used' : 'Time remaining'}
              className={cn(
                'flex items-center gap-2 font-mono text-xl tabular-nums',
                !ended && session.deadline - now <= 300_000 && 'text-red-600 dark:text-red-400',
              )}
            >
              <Clock className="size-4" />
              {formatExamTime(ended ? elapsed : session.deadline - now)}
            </span>
            {!ended && <Button onClick={() => setConfirmFinish(true)}>I'm done</Button>}
          </div>
        </div>
        <nav
          aria-label="Questions in this paper"
          className="mt-3 flex max-h-24 flex-wrap gap-1.5 overflow-y-auto"
        >
          {questions.map((q, index) => (
            <button
              key={q.id}
              onClick={() => jumpTo(q.id)}
              className={cn(
                'flex size-9 items-center justify-center rounded border text-xs focus-visible:outline-2 focus-visible:outline-brand-600',
                session.attempted.includes(q.id)
                  ? 'border-brand-900 bg-brand-900 text-white'
                  : 'border-stone-300 dark:border-stone-600',
              )}
              aria-label={`Question ${index + 1}${session.attempted.includes(q.id) ? ', attempted' : ''}${session.flagged.includes(q.id) ? ', flagged' : ''}`}
            >
              {index + 1}
              {session.flagged.includes(q.id) && <Flag className="ml-0.5 size-3" />}
            </button>
          ))}
        </nav>
      </section>
      {!ended && (
        <p className="flex items-center gap-2 text-sm text-stone-500 dark:text-stone-400">
          <LockKeyhole className="size-4 shrink-0" />
          Work through the paper in any order. Answers unlock only after you finish.
        </p>
      )}
      {ended && (
        <Card>
          <CardContent className="space-y-4 p-5">
            <h2 className="font-serif text-2xl font-semibold" role="status">
              {session.finishedAt === null
                ? "Time's up — your paper is complete."
                : 'Ready to check your work?'}
            </h2>
            <p className="text-sm text-stone-500 dark:text-stone-400">
              Your responses are now locked.{' '}
              {revealed
                ? 'Compare your work with the solutions, then rate each question honestly. These self-checks stay with this paper and do not change your mastery records.'
                : 'Take a moment to reflect, then reveal the answers when you are ready.'}
            </p>
            {!revealed ? (
              <Button
                onClick={() => {
                  if (examEnded(session, Date.now())) onChange({ ...session, revealed: true });
                }}
              >
                Reveal answers & solutions
              </Button>
            ) : (
              <>
                <p className="font-medium">
                  {checked} / {questions.length} self-checked · {correct} correct
                  {checked > 0
                    ? ` · ${Math.round((correct / checked) * 100)}% of checked questions`
                    : ''}
                </p>
                <p className="text-sm text-stone-500">
                  {questions.length - checked} unreviewed. A self-check is not an automatically
                  graded score.
                </p>
                {checked === questions.length && (
                  <p className="text-sm">
                    {retryIds.length
                      ? 'Try the missed and unsure questions again without solutions. Explain the step you missed before moving on.'
                      : 'Try a fresh mixed paper next to check whether you can apply these ideas to different problems.'}
                  </p>
                )}
                <div className="flex flex-wrap gap-2">
                  <Button
                    disabled={checked !== questions.length || retryIds.length === 0}
                    onClick={() => onRetry(retryIds)}
                  >
                    Retry missed & unsure ({retryIds.length})
                  </Button>
                  <Button variant="outline" onClick={() => setConfirmNew(true)}>
                    Create another paper
                  </Button>
                </div>
              </>
            )}
          </CardContent>
        </Card>
      )}
      <ExamQuestions
        session={session}
        questions={questions}
        onChange={onChange}
        ended={ended}
        revealed={revealed}
      />
      {!ended && (
        <Button className="w-full" size="lg" onClick={() => setConfirmFinish(true)}>
          Finish paper
        </Button>
      )}
      <Dialog open={confirmFinish && !ended} onOpenChange={setConfirmFinish}>
        <DialogContent>
          <DialogTitle className="font-serif text-xl font-semibold">Finish this paper?</DialogTitle>
          <DialogDescription className="mt-2 text-sm text-stone-500">
            You marked {session.attempted.length} of {questions.length} questions attempted, with{' '}
            {session.flagged.length} flagged. Finishing locks your responses and stops the timer.
            Answers will remain hidden until you choose to reveal them.
          </DialogDescription>
          <div className="mt-5 flex flex-wrap justify-end gap-2">
            <Button variant="outline" onClick={() => setConfirmFinish(false)}>
              Keep working
            </Button>
            <Button
              onClick={() => {
                onChange({ ...session, finishedAt: Math.min(Date.now(), session.deadline) });
                setConfirmFinish(false);
              }}
            >
              Finish & lock responses
            </Button>
          </div>
        </DialogContent>
      </Dialog>
      <Dialog open={confirmNew} onOpenChange={setConfirmNew}>
        <DialogContent>
          <DialogTitle className="font-serif text-xl font-semibold">Start a new paper?</DialogTitle>
          <DialogDescription className="mt-2 text-sm text-stone-500">
            This replaces the paper and its notes saved in this tab. Copy any notes you want to keep
            first.
          </DialogDescription>
          <div className="mt-5 flex gap-2">
            <Button variant="outline" onClick={() => setConfirmNew(false)}>
              Keep this paper
            </Button>
            <Button onClick={onNew}>New paper</Button>
          </div>
        </DialogContent>
      </Dialog>
    </div>
  );
}

// The ticking clock must not rerender every Markdown/KaTeX question each second.
const ExamQuestions = memo(function ExamQuestions({
  session,
  questions,
  onChange,
  ended,
  revealed,
}: Pick<Props, 'session' | 'questions' | 'onChange'> & { ended: boolean; revealed: boolean }) {
  const edit = (patch: Partial<ExamSession>) => {
    if (!examEnded(session, Date.now())) onChange({ ...session, ...patch });
  };
  const toggle = (list: string[], id: string) =>
    list.includes(id) ? list.filter((value) => value !== id) : [...list, id];

  return (
    <>
      {questions.map((question, index) => (
        <Card key={question.id}>
          <CardContent className="space-y-5 p-5 sm:p-7">
            <div className="flex flex-wrap items-center justify-between gap-2">
              <p className="text-xs font-medium text-stone-500 dark:text-stone-400">
                {question.course?.code} · {question.topic?.name} · {question.year}{' '}
                {question.exam_name}
              </p>
              <span className="text-xs text-stone-500">
                Question {index + 1} of {questions.length}
              </span>
            </div>
            <h2
              id={`exam-question-${question.id}`}
              tabIndex={-1}
              className="scroll-mt-64 font-serif text-xl font-semibold focus-visible:outline-2 focus-visible:outline-brand-600"
            >
              <MathRenderer inline>{question.title}</MathRenderer>
            </h2>
            <MathRenderer className="font-serif text-lg">{question.question_text}</MathRenderer>
            <div>
              <label htmlFor={`response-${question.id}`} className="mb-2 block text-sm font-medium">
                Your answer or working notes{' '}
                <span className="font-normal text-stone-500">(optional if working on paper)</span>
              </label>
              <Textarea
                id={`response-${question.id}`}
                value={session.notes[question.id] ?? ''}
                maxLength={10000}
                readOnly={ended}
                rows={3}
                placeholder="Record your answer, approach, or where you got stuck…"
                onChange={(event) =>
                  edit({ notes: { ...session.notes, [question.id]: event.target.value } })
                }
              />
            </div>
            <div className="flex flex-wrap gap-4 text-sm">
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  className="size-4 accent-brand-900"
                  checked={session.attempted.includes(question.id)}
                  disabled={ended}
                  onChange={() => edit({ attempted: toggle(session.attempted, question.id) })}
                />
                Marked attempted
              </label>
              <label className="flex items-center gap-2">
                <input
                  type="checkbox"
                  className="size-4 accent-brand-900"
                  checked={session.flagged.includes(question.id)}
                  disabled={ended}
                  onChange={() => edit({ flagged: toggle(session.flagged, question.id) })}
                />
                <Flag className="size-4" />
                Return to this question
              </label>
            </div>
            {revealed && (
              <section
                className="space-y-4 border-t border-stone-200 pt-5 dark:border-stone-700"
                aria-label={`Review question ${index + 1}`}
              >
                <div>
                  <h3 className="mb-2 font-semibold">Answer</h3>
                  <MathRenderer>{question.answer || 'No answer is available yet.'}</MathRenderer>
                </div>
                <details>
                  <summary className="cursor-pointer text-sm font-semibold text-brand-900 dark:text-brand-300">
                    Worked solution
                  </summary>
                  <div className="mt-3">
                    <MathRenderer>
                      {question.solution || 'No worked solution is available yet.'}
                    </MathRenderer>
                  </div>
                </details>
                <fieldset>
                  <legend className="mb-2 text-sm font-medium">How did you do?</legend>
                  <div className="flex flex-wrap gap-2">
                    {(
                      [
                        { value: 'correct', label: 'Correct' },
                        { value: 'incorrect', label: 'Incorrect' },
                        { value: 'unsure', label: 'Not sure' },
                      ] as const
                    ).map((rating) => (
                      <Button
                        key={rating.value}
                        size="sm"
                        variant={
                          session.ratings[question.id] === rating.value ? 'default' : 'outline'
                        }
                        aria-pressed={session.ratings[question.id] === rating.value}
                        onClick={() =>
                          onChange({
                            ...session,
                            ratings: { ...session.ratings, [question.id]: rating.value },
                          })
                        }
                      >
                        {rating.label}
                      </Button>
                    ))}
                  </div>
                </fieldset>
              </section>
            )}
          </CardContent>
        </Card>
      ))}
    </>
  );
});
