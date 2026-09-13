import { useState } from 'react';
import type { Course, QuestionWithMeta } from '@/types';
import { Button } from '@/components/ui/button';
import { ExamSetup } from './ExamSetup';
import { ExamPaper } from './ExamPaper';
import { createExam, parseExam, type ExamSession } from './exam';

export function ExamWorkspace({
  questions,
  courses,
  storageKey,
}: {
  questions: QuestionWithMeta[];
  courses: Course[];
  storageKey: string;
}) {
  const [initial] = useState(() => {
    try {
      return { session: parseExam(sessionStorage.getItem(storageKey)), storageAvailable: true };
    } catch {
      return { session: null, storageAvailable: false };
    }
  });
  const [session, setSession] = useState(initial.session);
  const [storageAvailable, setStorageAvailable] = useState(initial.storageAvailable);
  const save = (next: ExamSession | null) => {
    setSession(next);
    try {
      if (next) sessionStorage.setItem(storageKey, JSON.stringify(next));
      else sessionStorage.removeItem(storageKey);
      setStorageAvailable(true);
    } catch {
      setStorageAvailable(false);
    }
  };
  const byId = new Map(questions.map((q) => [q.id, q]));
  const paper =
    session?.ids.map((id) => byId.get(id)).filter((q): q is QuestionWithMeta => !!q) ?? [];
  return (
    <div className="space-y-6 text-stone-900 dark:text-stone-100">
      {!storageAvailable && (
        <p role="alert" className="rounded-lg border border-amber-400 p-3 text-sm">
          This browser could not save your paper. Keep this page open; refreshing or leaving may
          lose your work.
        </p>
      )}
      {session && paper.length !== session.ids.length ? (
        <div className="space-y-3">
          <p>
            Some questions in your saved paper are no longer available in your course selection.
            Your saved paper has not been shortened or replaced.
          </p>
          <Button onClick={() => save(null)}>Discard unavailable paper & start again</Button>
        </div>
      ) : session ? (
        <ExamPaper
          key={session.startedAt}
          session={session}
          questions={paper}
          bank={questions}
          onChange={save}
          onNew={() => save(null)}
          onRetry={(ids) => save(createExam(ids, (session.deadline - session.startedAt) / 60_000))}
        />
      ) : (
        <ExamSetup questions={questions} courses={courses} onStart={save} />
      )}
    </div>
  );
}
