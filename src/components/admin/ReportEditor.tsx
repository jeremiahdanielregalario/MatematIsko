import { useEffect, useState } from 'react';
import { QuestionForm } from './QuestionForm';
import { TheoremForm } from './TheoremForm';
import { Button } from '@/components/ui/button';
import { getCourses, getTopics, getQuestionById, getTheoremById } from '@/lib/db';
import type { Course, Topic, Question, Theorem } from '@/types';

export function ReportEditor({
  kind,
  contentId,
  onClose,
}: {
  kind: 'question' | 'theorem';
  contentId: string;
  onClose: () => void;
}) {
  const [data, setData] = useState<{
    courses: Course[];
    topics: Topic[];
    question: Question | null;
    theorem: Theorem | null;
  } | null>(null);
  const [error, setError] = useState('');
  const [saved, setSaved] = useState(false);
  const [attempt, setAttempt] = useState(0);
  useEffect(() => {
    let active = true;
    Promise.all([
      getCourses(),
      getTopics(),
      kind === 'question' ? getQuestionById(contentId) : getTheoremById(contentId),
    ])
      .then(([courses, topics, content]) => {
        if (!active) return;
        if (!content) throw new Error('This content is no longer available.');
        setData({
          courses,
          topics,
          question: kind === 'question' ? (content as Question) : null,
          theorem: kind === 'theorem' ? (content as Theorem) : null,
        });
      })
      .catch((err: unknown) => {
        if (active) setError(err instanceof Error ? err.message : String(err));
      });
    return () => {
      active = false;
    };
  }, [kind, contentId, attempt]);
  return (
    <div className="mt-4 space-y-3 border-t border-stone-200 pt-4 dark:border-stone-700">
      <p className="text-sm text-stone-500">
        Correct the content below, save, then mark the report resolved after reviewing the preview.
      </p>
      {saved && (
        <p
          role="status"
          className="rounded-lg bg-emerald-50 p-3 text-sm text-emerald-800 dark:bg-emerald-950 dark:text-emerald-200"
        >
          Changes saved to the live site. Report status has not changed. Mark it resolved when your
          review is complete.
        </p>
      )}
      {error ? (
        <div role="alert">
          {error}
          <Button
            variant="outline"
            onClick={() => {
              setError('');
              setAttempt((n) => n + 1);
            }}
          >
            Retry
          </Button>
        </div>
      ) : !data ? (
        <p role="status">Loading editor…</p>
      ) : data.question ? (
        <QuestionForm
          initial={data.question}
          courses={data.courses}
          topics={data.topics}
          onSaved={(question) => {
            setData({ ...data, question });
            setSaved(true);
          }}
          onCancel={onClose}
        />
      ) : data.theorem ? (
        <TheoremForm
          initial={data.theorem}
          courses={data.courses}
          topics={data.topics}
          onSaved={(theorem) => {
            setData({ ...data, theorem });
            setSaved(true);
          }}
          onCancel={onClose}
        />
      ) : null}
    </div>
  );
}
