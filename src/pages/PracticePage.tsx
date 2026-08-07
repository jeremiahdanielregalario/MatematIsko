import { useState } from 'react';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { useCourses } from '@/hooks/useCourses';
import { useCourseScope } from '@/hooks/useCourseScope';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { mergeMutations } from '@/lib/mutations';
import { computePracticeResults, toMetaQuestions, type PracticeAnswer } from '@/lib/practice';
import type { QuestionFilter, QuestionWithMeta } from '@/types';
import { PracticeResults } from '@/features/practice/PracticeResults';
import { PracticeSession } from '@/features/practice/PracticeSession';
import { PracticeSetup } from '@/features/practice/PracticeSetup';

type Phase =
  | { kind: 'setup'; filter: QuestionFilter }
  | { kind: 'session'; ids: string[]; filter: QuestionFilter }
  | { kind: 'results'; summary: ReturnType<typeof computePracticeResults>; filter: QuestionFilter };

export function PracticePage() {
  const { data: loaded, loading, error, reload } = useQuestions();
  const { data: coursesData } = useCourses();
  const { courseIds } = useCourseScope();
  const courses = (coursesData ?? []).filter(
    (course) => courseIds === null || courseIds.includes(course.id),
  );
  const [phase, setPhase] = useState<Phase>({ kind: 'setup', filter: {} });

  const baseQuestions = loaded ?? [];
  const getQuestion = (id: string) => baseQuestions.find((q) => q.id === id);
  const mutations = useQuestionMutations(getQuestion);

  if (loading) return <LoadingState label="Setting up practice" />;
  if (error) {
    return (
      <ErrorState
        title="Could not load questions for practice"
        message={error.message}
        onRetry={reload}
      />
    );
  }

  const withMutations = (ids: string[]): QuestionWithMeta[] =>
    toMetaQuestions(ids, baseQuestions).map((q) => mergeMutations(q, mutations));

  const handleComplete = (answers: PracticeAnswer[], ids: string[]) => {
    const summary = computePracticeResults(answers, ids.length);
    const filter = phase.kind === 'session' ? phase.filter : {};
    setPhase({ kind: 'results', summary, filter });
  };

  if (phase.kind === 'setup') {
    return (
      <div className="space-y-6">
        <header>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Practice Mode
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            Pick your focus, work through randomly selected problems, and track how you do.
          </p>
        </header>
        <PracticeSetup
          courses={courses}
          questions={baseQuestions}
          initial={phase.filter}
          onStart={(ids) => setPhase({ kind: 'session', ids, filter: phase.filter })}
        />
      </div>
    );
  }

  if (phase.kind === 'results') {
    return (
      <div className="space-y-6">
        <PracticeResults
          summary={phase.summary}
          onPracticeAgain={() => setPhase({ kind: 'setup', filter: phase.filter })}
          onReviewMistakes={() =>
            setPhase({ kind: 'session', ids: phase.summary.reviewIds, filter: phase.filter })
          }
        />
      </div>
    );
  }

  const sessionQuestions = withMutations(phase.ids);
  if (sessionQuestions.length === 0) {
    return (
      <div className="space-y-6">
        <header>
          <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
            Practice Mode
          </h1>
          <p className="mt-1 text-stone-500 dark:text-stone-400">
            Nothing to review here — start a new practice session.
          </p>
        </header>
        <PracticeSetup
          courses={courses}
          questions={baseQuestions}
          initial={phase.filter}
          onStart={(ids) => setPhase({ kind: 'session', ids, filter: phase.filter })}
        />
      </div>
    );
  }

  return (
    <PracticeSession
      questions={sessionQuestions}
      onAnswer={(questionId, correct) => mutations.recordAttempt(questionId, correct)}
      onComplete={(answers) => handleComplete(answers, phase.ids)}
      onQuit={() => setPhase({ kind: 'setup', filter: phase.filter })}
    />
  );
}
