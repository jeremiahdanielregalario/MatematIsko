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
  const [showPreview, setShowPreview] = useState(false);
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
    if (!requiredFilled) return;
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
    <Card className="space-y-5 p-5">
      <div className="flex items-center justify-between">
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
          <Button type="button" variant="ghost" size="sm" onClick={onCancel}>
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

      <div className="space-y-1.5">
        <Label htmlFor="theorem-name">Theorem name</Label>
        <Input
          id="theorem-name"
          value={draft.name}
          onChange={(event) => set('name', event.target.value)}
          placeholder="e.g. The Division Algorithm in $\mathbb{Z}$"
        />
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="theorem-statement">Statement</Label>
        <Textarea
          id="theorem-statement"
          className="min-h-32 font-mono text-xs"
          value={draft.statement}
          onChange={(event) => set('statement', event.target.value)}
          placeholder={'Let $n \\in \\mathbb{N}$ and $m \\in \\mathbb{Z}$. Then…'}
        />
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="theorem-formal">Formal notation (optional)</Label>
        <Textarea
          id="theorem-formal"
          className="min-h-16 font-mono text-xs"
          value={draft.formal_notation ?? ''}
          onChange={(event) =>
            set('formal_notation', event.target.value.trim() === '' ? null : event.target.value)
          }
          placeholder={'$(\\forall n \\in \\mathbb{N})(\\forall m \\in \\mathbb{Z})(\\exists! q, r \\in \\mathbb{Z} \\mid m = nq + r \\text{ and } 0 \\le r < n)$'}
        />
      </div>

      {showPreview ? (
        <div className="space-y-4 rounded-lg border border-stone-200 bg-stone-50 p-4 dark:border-stone-800 dark:bg-stone-900/60">
          <p className="text-sm font-semibold text-stone-700 dark:text-stone-300">Live preview</p>
          {draft.name.trim() !== '' ? (
            <div>
              <p className="mb-1 text-xs font-medium uppercase tracking-wide text-stone-400">
                Name
              </p>
              <div className="rounded-md bg-white px-3 py-2 dark:bg-stone-950">
                <MathRenderer>{draft.name}</MathRenderer>
              </div>
            </div>
          ) : null}
          {draft.statement.trim() !== '' ? (
            <div>
              <p className="mb-1 text-xs font-medium uppercase tracking-wide text-stone-400">
                Statement
              </p>
              <div className="rounded-md bg-white px-3 py-2 dark:bg-stone-950">
                <MathRenderer>{draft.statement}</MathRenderer>
              </div>
            </div>
          ) : null}
          {draft.formal_notation?.trim() ? (
            <div>
              <p className="mb-1 text-xs font-medium uppercase tracking-wide text-stone-400">
                Formal notation
              </p>
              <div className="rounded-md bg-white px-3 py-2 dark:bg-stone-950">
                <MathRenderer>{draft.formal_notation}</MathRenderer>
              </div>
            </div>
          ) : null}
        </div>
      ) : null}

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
          {saving ? 'Saving…' : initial ? 'Save changes' : 'Create theorem'}
        </Button>
      </div>
    </Card>
  );
}
