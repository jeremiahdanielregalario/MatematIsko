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
        Review the preview and save your changes. The editor will close after saving; mark the
        report resolved separately.
      </p>
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
          onSaved={onClose}
          onCancel={onClose}
        />
      ) : data.theorem ? (
        <TheoremForm
          initial={data.theorem}
          courses={data.courses}
          topics={data.topics}
          onSaved={onClose}
          onCancel={onClose}
        />
      ) : null}
    </div>
  );
}
