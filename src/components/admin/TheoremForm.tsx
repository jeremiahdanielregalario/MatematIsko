import { Eye, Save, X } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
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
import { MathEditor } from './MathEditor';
import { adminUpsertTheorem, adminUpsertTopic, type TheoremDraft } from '@/lib/admin';
import type { Course, Theorem, Topic } from '@/types';

interface TheoremFormProps {
  initial: Theorem | null;
  courses: Course[];
  topics: Topic[];
  onSaved: (theorem: Theorem) => void;
  onCancel: () => void;
}

function emptyDraft(): TheoremDraft {
  return {
    course_id: '',
    topic_id: '',
    name: '',
    reference: null,
    statement: '',
    formal_notation: null,
  };
}

function toDraft(theorem: Theorem): TheoremDraft {
  return {
    id: theorem.id,
    course_id: theorem.course_id,
    topic_id: theorem.topic_id,
    name: theorem.name,
    reference: theorem.reference,
    statement: theorem.statement,
    formal_notation: theorem.formal_notation,
  };
}

export function TheoremForm({ initial, courses, topics, onSaved, onCancel }: TheoremFormProps) {
  const [draft, setDraft] = useState<TheoremDraft>(() =>
    initial ? toDraft(initial) : emptyDraft(),
  );
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
    draft.name.trim() !== '' &&
    draft.statement.trim() !== '';

  const set = <K extends keyof TheoremDraft>(key: K, value: TheoremDraft[K]) =>
    setDraft((current) => ({ ...current, [key]: value }));

  const handleCourseChange = (courseId: string) => {
    set('course_id', courseId);
    set('topic_id', '');
    setNewTopicName('');
  };

  const handleSave = async () => {
    if (!requiredFilled || saving) return;
    setError(null);
    setSaving(true);
    try {
      let topicId = draft.topic_id;
      if (newTopicName.trim() !== '') {
        const topic = await adminUpsertTopic(draft.course_id, newTopicName.trim());
        topicId = topic.id;
      }
      const saved = await adminUpsertTheorem({ ...draft, topic_id: topicId });
      onSaved(saved);
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setSaving(false);
    }
  };

  return (
    <Card className="min-w-0 space-y-5 p-3 sm:p-5">
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div>
          <h2 className="font-serif text-lg font-semibold text-stone-900 dark:text-stone-100">
            {initial ? 'Edit theorem' : 'New theorem'}
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
            {showPreview ? 'Hide preview' : 'Preview'}
          </Button>
          <Button
            type="button"
            variant="ghost"
            size="sm"
            aria-label="Close editor"
            disabled={saving}
            onClick={onCancel}
          >
            <X className="size-4" />
          </Button>
        </div>
      </div>

      <div className="grid gap-4 sm:grid-cols-2">
        <div className="space-y-1.5">
          <Label htmlFor="theorem-course">Course</Label>
          <Select value={draft.course_id || undefined} onValueChange={handleCourseChange}>
            <SelectTrigger id="theorem-course">
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
          <Label htmlFor="theorem-reference">Reference (optional)</Label>
          <Input
            id="theorem-reference"
            value={draft.reference ?? ''}
            onChange={(event) =>
              set('reference', event.target.value.trim() === '' ? null : event.target.value)
            }
            placeholder="e.g. Theorem 1.1"
          />
        </div>
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="theorem-topic">Topic</Label>
        <Select
          value={draft.topic_id || undefined}
          onValueChange={(value) => {
            set('topic_id', value);
            setNewTopicName('');
          }}
        >
          <SelectTrigger id="theorem-topic">
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

      <MathEditor
        label="Theorem name"
        value={draft.name}
        onChange={(value) => set('name', value)}
        showPreview={showPreview}
      />
      <MathEditor
        label="Statement"
        value={draft.statement}
        onChange={(value) => set('statement', value)}
        showPreview={showPreview}
      />
      <MathEditor
        label="Formal notation (optional)"
        value={draft.formal_notation ?? ''}
        onChange={(value) => set('formal_notation', value || null)}
        showPreview={showPreview}
      />

      {error ? (
        <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-400">
          {error}
        </p>
      ) : null}

      <div className="flex items-center justify-end gap-2">
        <Button type="button" variant="ghost" disabled={saving} onClick={onCancel}>
          Cancel
        </Button>
        <Button
          type="button"
          onClick={() => void handleSave()}
          disabled={!requiredFilled || saving}
        >
          <Save className="size-4" />
          {saving ? 'Saving…' : initial ? 'Save changes' : 'Create theorem'}
        </Button>
      </div>
    </Card>
  );
}
