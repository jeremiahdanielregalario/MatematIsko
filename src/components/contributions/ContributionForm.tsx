import { useRef, useState } from 'react';
import { Send } from 'lucide-react';
import { MathEditor } from '@/components/admin/MathEditor';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  submitContribution,
  type ContributionDraft,
  type QuestionContributionContent,
} from '@/lib/contributions';
import type { Course, Topic } from '@/types';

const selectClass =
  'h-10 w-full rounded-lg border border-stone-300 bg-white px-3 text-sm text-stone-900 dark:border-stone-700 dark:bg-stone-950 dark:text-stone-100';
export function ContributionForm({
  courses,
  topics,
  initial,
  initialCourseId,
  onSubmitted,
  onCancel,
}: {
  courses: Course[];
  topics: Topic[];
  initial?: ContributionDraft;
  initialCourseId?: string;
  onSubmitted: () => void;
  onCancel: () => void;
}) {
  const [kind, setKind] = useState<'question' | 'note'>(initial?.kind ?? 'question');
  const [courseId, setCourseId] = useState(initial?.course_id ?? initialCourseId ?? '');
  const [title, setTitle] = useState(initial?.title ?? '');
  const [content, setContent] = useState(initial?.kind === 'note' ? initial.payload.content : '');
  const [question, setQuestion] = useState<QuestionContributionContent>(
    initial?.kind === 'question'
      ? initial.payload
      : {
          topic_id: '',
          question_text: '',
          answer: '',
          solution: '',
          hint: null,
          difficulty: 'medium',
          year: new Date().getFullYear(),
          exam_name: '',
          question_number: 1,
        },
  );
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');
  const request = useRef<{ signature: string; id: string } | null>(null);
  const inFlight = useRef(false);
  const set = <K extends keyof QuestionContributionContent>(
    key: K,
    value: QuestionContributionContent[K],
  ) => setQuestion((q) => ({ ...q, [key]: value }));
  const courseTopics = topics.filter((topic) => topic.course_id === courseId);

  const submit = async () => {
    if (inFlight.current) return;
    const draft: ContributionDraft =
      kind === 'question'
        ? { kind, course_id: courseId, title, payload: question }
        : { kind, course_id: courseId, title, payload: { content } };
    const signature = JSON.stringify(draft);
    if (request.current?.signature !== signature)
      request.current = { signature, id: crypto.randomUUID() };
    inFlight.current = true;
    setSaving(true);
    setError('');
    try {
      await submitContribution(request.current.id, draft);
      onSubmitted();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Could not submit. Please try again.');
    } finally {
      inFlight.current = false;
      setSaving(false);
    }
  };
  return (
    <form
      onSubmit={(event) => {
        event.preventDefault();
        void submit();
      }}
      className="space-y-5 rounded-xl border border-stone-200 bg-white p-4 dark:border-stone-800 dark:bg-stone-900 sm:p-6"
    >
      <h2 className="font-serif text-xl font-semibold">
        {initial ? 'Revise and resubmit' : 'New contribution'}
      </h2>
      <p className="text-sm text-stone-500 dark:text-stone-400">
        Submit material you wrote or have permission to share. Admins review accuracy and formatting
        before publishing. Your submission stays private to you and administrators until approved.
      </p>
      <fieldset disabled={saving} className="min-w-0 space-y-5">
        <div className="grid gap-4 sm:grid-cols-2">
          <div className="space-y-1.5">
            <Label htmlFor="contribution-kind">Contribution type</Label>
            <select
              id="contribution-kind"
              className={selectClass}
              value={kind}
              onChange={(e) => setKind(e.target.value as typeof kind)}
            >
              <option value="question">Question</option>
              <option value="note">Course notes</option>
            </select>
          </div>
          <div className="space-y-1.5">
            <Label htmlFor="contribution-course">Course</Label>
            <select
              id="contribution-course"
              required
              className={selectClass}
              value={courseId}
              onChange={(e) => {
                setCourseId(e.target.value);
                set('topic_id', '');
              }}
            >
              <option value="">Select a course</option>
              {courses.map((course) => (
                <option key={course.id} value={course.id}>
                  {course.code} — {course.name}
                </option>
              ))}
            </select>
          </div>
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="contribution-title">Title</Label>
          <Input
            id="contribution-title"
            required
            maxLength={300}
            value={title}
            onChange={(e) => setTitle(e.target.value)}
          />
          <p className="text-xs text-stone-500">
            Use inline math in titles. Put display equations in the body.
          </p>
        </div>
        {kind === 'question' ? (
          <>
            <div className="grid gap-4 sm:grid-cols-2">
              <div className="space-y-1.5">
                <Label htmlFor="contribution-topic">Topic</Label>
                <select
                  id="contribution-topic"
                  className={selectClass}
                  required
                  value={question.topic_id}
                  onChange={(e) => set('topic_id', e.target.value)}
                >
                  <option value="">Select a topic</option>
                  {courseTopics.map((topic) => (
                    <option key={topic.id} value={topic.id}>
                      {topic.name}
                    </option>
                  ))}
                </select>
                {courseId && !courseTopics.length && (
                  <p className="text-sm text-amber-700 dark:text-amber-300">
                    This course needs an administrator to add topics before questions can be
                    submitted.
                  </p>
                )}
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="contribution-difficulty">Difficulty</Label>
                <select
                  id="contribution-difficulty"
                  className={selectClass}
                  value={question.difficulty}
                  onChange={(e) => set('difficulty', e.target.value as typeof question.difficulty)}
                >
                  {['easy', 'medium', 'hard'].map((level) => (
                    <option key={level}>{level}</option>
                  ))}
                </select>
              </div>
              <div className="space-y-1.5">
                <Label htmlFor="contribution-source">Source / exam name</Label>
                <Input
                  id="contribution-source"
                  required
                  value={question.exam_name}
                  onChange={(e) => set('exam_name', e.target.value)}
                  placeholder="e.g. Original practice or LE 1"
                />
              </div>
              <div className="grid grid-cols-2 gap-3">
                <div className="space-y-1.5">
                  <Label htmlFor="contribution-year">Year</Label>
                  <Input
                    id="contribution-year"
                    type="number"
                    required
                    min={1900}
                    max={2200}
                    value={question.year || ''}
                    onChange={(e) => set('year', Number(e.target.value))}
                  />
                </div>
                <div className="space-y-1.5">
                  <Label htmlFor="contribution-number">Question number</Label>
                  <Input
                    id="contribution-number"
                    type="number"
                    required
                    min={1}
                    max={10000}
                    value={question.question_number || ''}
                    onChange={(e) => set('question_number', Number(e.target.value))}
                  />
                </div>
              </div>
            </div>
            <MathEditor
              label="Question text"
              value={question.question_text}
              onChange={(v) => set('question_text', v)}
            />
            <MathEditor
              label="Hint (optional)"
              value={question.hint ?? ''}
              onChange={(v) => set('hint', v || null)}
            />
            <MathEditor label="Answer" value={question.answer} onChange={(v) => set('answer', v)} />
            <MathEditor
              label="Solution"
              value={question.solution}
              onChange={(v) => set('solution', v)}
            />
          </>
        ) : (
          <MathEditor
            label="Notes content"
            value={content}
            onChange={setContent}
            noteEnvironments={{}}
          />
        )}
        {error && (
          <p
            role="alert"
            className="rounded-lg bg-red-50 p-3 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-300"
          >
            {error}
          </p>
        )}
        <div className="flex flex-wrap justify-end gap-2">
          <Button type="button" variant="outline" onClick={onCancel}>
            Cancel
          </Button>
          <Button type="submit">
            <Send className="size-4" />
            {saving ? 'Submitting…' : 'Submit for review'}
          </Button>
        </div>
      </fieldset>
    </form>
  );
}
