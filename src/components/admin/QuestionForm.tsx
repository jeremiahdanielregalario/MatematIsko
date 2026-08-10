import { Eye, Save, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';
import { adminUpsertQuestion, adminUpsertTopic, type QuestionDraft } from '@/lib/admin';
import type { Course, Difficulty, Question, Topic } from '@/types';

interface QuestionFormProps {
  initial: Question | null;
  courses: Course[];
  topics: Topic[];
  onSaved: (question: Question) => void;
  onCancel: () => void;
}

const DIFFICULTIES: Difficulty[] = ['easy', 'medium', 'hard'];

function emptyDraft(): QuestionDraft {
  return {
    course_id: '',
    topic_id: '',
    title: '',
    question_text: '',
    difficulty: 'medium',
    year: new Date().getFullYear(),
    exam_name: '',
    question_number: 1,
    answer: '',
    solution: '',
    hint: null,
  };
}

function toDraft(question: Question): QuestionDraft {
  return {
    id: question.id,
    course_id: question.course_id,
    topic_id: question.topic_id,
    title: question.title,
    question_text: question.question_text,
    difficulty: question.difficulty,
    year: question.year,
    exam_name: question.exam_name,
    question_number: question.question_number,
    answer: question.answer,
    solution: question.solution,
    hint: question.hint,
  };
}

export function QuestionForm({ initial, courses, topics, onSaved, onCancel }: QuestionFormProps) {
  const [draft, setDraft] = useState<QuestionDraft>(() => (initial ? toDraft(initial) : emptyDraft()));
  const [newTopicName, setNewTopicName] = useState('');
  const [showPreview, setShowPreview] = useState(true);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setDraft(initial ? toDraft(initial) : emptyDraft());
    setNewTopicName('');
    setError(null);
  }, [initial]);

  const courseTopics = useMemo(
    () => topics.filter((topic) => topic.course_id === draft.course_id),
    [topics, draft.course_id],
  );

  const requiredFilled =
    draft.course_id !== '' &&
    (draft.topic_id !== '' || newTopicName.trim() !== '') &&
    draft.title.trim() !== '' &&
    draft.question_text.trim() !== '' &&
    draft.exam_name.trim() !== '' &&
    draft.answer.trim() !== '' &&
    draft.solution.trim() !== '';

  const set = <K extends keyof QuestionDraft>(key: K, value: QuestionDraft[K]) =>
    setDraft((current) => ({ ...current, [key]: value }));

  const handleCourseChange = (courseId: string) => {
    set('course_id', courseId);
    set('topic_id', '');
    setNewTopicName('');
  };

  const handleSave = async () => {
    if (!requiredFilled) return;
    setError(null);
    setSaving(true);
    try {
      let topicId = draft.topic_id;
      if (newTopicName.trim() !== '') {
        const topic = await adminUpsertTopic(draft.course_id, newTopicName.trim());
        topicId = topic.id;
      }
      const saved = await adminUpsertQuestion({ ...draft, topic_id: topicId });
      onSaved(saved);
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setSaving(false);
    }
  };

  return (
    <Card className="space-y-5 p-5">
      <div className="flex items-center justify-between">
        <div>
          <h2 className="font-serif text-lg font-semibold text-stone-900 dark:text-stone-100">
            {initial ? 'Edit question' : 'New question'}
          </h2>
          <p className="text-sm text-stone-500 dark:text-stone-400">
            Markdown + LaTeX — inline `$...$`, display `$$...$$`
          </p>
        </div>
        <div className="flex items-center gap-2">
          <Button
            type="button"
            variant="outline"
            size="sm"
            onClick={() => setShowPreview((current) => !current)}
          >
            <Eye className="size-4" />
            {showPreview ? 'Hide previews' : 'Show previews'}
          </Button>
          <Button type="button" variant="ghost" size="sm" onClick={onCancel}>
            <X className="size-4" />
          </Button>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="admin-course">Course</Label>
          <Select value={draft.course_id || undefined} onValueChange={handleCourseChange}>
            <SelectTrigger id="admin-course">
              <SelectValue placeholder="Select a course" />
            </SelectTrigger>
            <SelectContent>
              {courses.map((course) => (
                <SelectItem key={course.id} value={course.id}>
                  {course.code} — {course.name}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>

        <div className="space-y-1.5">
          <Label htmlFor="admin-difficulty">Difficulty</Label>
          <Select value={draft.difficulty} onValueChange={(value) => set('difficulty', value as Difficulty)}>
            <SelectTrigger id="admin-difficulty">
              <SelectValue />
            </SelectTrigger>
            <SelectContent>
              {DIFFICULTIES.map((level) => (
                <SelectItem key={level} value={level}>
                  {level.charAt(0).toUpperCase() + level.slice(1)}
                </SelectItem>
              ))}
            </SelectContent>
          </Select>
        </div>
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="admin-topic">Topic</Label>
        <Select
          value={draft.topic_id || undefined}
          onValueChange={(value) => {
            set('topic_id', value);
            setNewTopicName('');
          }}
        >
          <SelectTrigger id="admin-topic">
            <SelectValue placeholder="Select an existing topic" />
          </SelectTrigger>
          <SelectContent>
            {courseTopics.length === 0 ? (
              <div className="px-3 py-2 text-sm text-stone-400">No topics yet for this course</div>
            ) : (
              courseTopics.map((topic) => (
                <SelectItem key={topic.id} value={topic.id}>
                  {topic.name}
                </SelectItem>
              ))
            )}
          </SelectContent>
        </Select>
        <Input
          value={newTopicName}
          onChange={(event) => setNewTopicName(event.target.value)}
          placeholder="…or type a new topic name to create it"
        />
      </div>

      <div className="grid gap-4 sm:grid-cols-3">
        <div className="space-y-1.5">
          <Label htmlFor="admin-year">Year</Label>
          <Input
            id="admin-year"
            type="number"
            value={Number.isInteger(draft.year) ? String(draft.year) : ''}
            onChange={(event) => set('year', Number(event.target.value))}
          />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="admin-exam">Exam name</Label>
          <Input
            id="admin-exam"
            value={draft.exam_name}
            onChange={(event) => set('exam_name', event.target.value)}
            placeholder="e.g. LE 1, Long Exam 2"
          />
        </div>
        <div className="space-y-1.5">
          <Label htmlFor="admin-number">Question number</Label>
          <Input
            id="admin-number"
            type="number"
            min={1}
            value={String(draft.question_number)}
            onChange={(event) => set('question_number', Number(event.target.value))}
          />
        </div>
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="admin-title">Title</Label>
        <Input
          id="admin-title"
          value={draft.title}
          onChange={(event) => set('title', event.target.value)}
          placeholder="e.g. Limits of rational functions"
        />
        <PreviewBox value={draft.title} emptyLabel="Nothing to preview" />
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="admin-question-text">Question text</Label>
        <Textarea
          id="admin-question-text"
          className="min-h-32 font-mono text-xs"
          value={draft.question_text}
          onChange={(event) => set('question_text', event.target.value)}
          placeholder={'Find $\\lim_{x \\to 2} \\frac{x^2 - 4}{x - 2}$.'}
        />
        <PreviewBox value={draft.question_text} emptyLabel="Nothing to preview" />
      </div>

      <div className="grid gap-4 lg:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="admin-hint">Hint (optional)</Label>
          <Textarea
            id="admin-hint"
            className="min-h-24 font-mono text-xs"
            value={draft.hint ?? ''}
            onChange={(event) => set('hint', event.target.value.trim() === '' ? null : event.target.value)}
            placeholder="A small nudge before revealing the answer."
          />
        </div>
        <div className="space-y-1.5">
          <Label className="text-stone-400 dark:text-stone-500">Hint — preview</Label>
          <PreviewBox value={draft.hint ?? ''} emptyLabel="No hint yet" />
        </div>

        <div className="space-y-1.5">
          <Label htmlFor="admin-answer">Answer</Label>
          <Textarea
            id="admin-answer"
            className="min-h-24 font-mono text-xs"
            value={draft.answer}
            onChange={(event) => set('answer', event.target.value)}
          />
        </div>
        <div className="space-y-1.5">
          <Label className="text-stone-400 dark:text-stone-500">Answer — preview</Label>
          <PreviewBox value={draft.answer} emptyLabel="No answer yet" />
        </div>

        <div className="space-y-1.5">
          <Label htmlFor="admin-solution">Solution</Label>
          <Textarea
            id="admin-solution"
            className="min-h-24 font-mono text-xs"
            value={draft.solution}
            onChange={(event) => set('solution', event.target.value)}
          />
        </div>
        <div className="space-y-1.5">
          <Label className="text-stone-400 dark:text-stone-500">Solution — preview</Label>
          <PreviewBox value={draft.solution} emptyLabel="No solution yet" />
        </div>
      </div>

      {error ? (
        <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-400">
          {error}
        </p>
      ) : null}

      <div className="flex items-center justify-end gap-2">
        <Button type="button" variant="ghost" onClick={onCancel}>
          Cancel
        </Button>
        <Button type="button" onClick={() => void handleSave()} disabled={!requiredFilled || saving}>
          <Save className="size-4" />
          {saving ? 'Saving…' : initial ? 'Save changes' : 'Create question'}
        </Button>
      </div>
    </Card>
  );
}

interface PreviewBoxProps {
  value: string;
  emptyLabel?: string;
}

function PreviewBox({ value, emptyLabel = 'Nothing to preview' }: PreviewBoxProps) {
  return (
    <div className="mt-2 rounded-md border border-dashed border-stone-200 bg-white px-3 py-2 dark:border-stone-700 dark:bg-stone-950">
      {value.trim() !== '' ? (
        <MathRenderer>{value}</MathRenderer>
      ) : (
        <p className="text-xs italic text-stone-400 dark:text-stone-600">{emptyLabel}</p>
      )}
    </div>
  );
}
