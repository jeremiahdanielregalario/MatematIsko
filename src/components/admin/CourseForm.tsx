import { useEffect, useState } from 'react';
import { Save, X } from 'lucide-react';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { adminUpsertCourse, type CourseDraft } from '@/lib/admin';
import type { Course } from '@/types';

interface CourseFormProps {
  initial: Course | null;
  onSaved: (course: Course) => void;
  onCancel: () => void;
}

function emptyDraft(): CourseDraft {
  return { code: '', name: '', description: null };
}

function toDraft(course: Course): CourseDraft {
  return { id: course.id, code: course.code, name: course.name, description: course.description };
}

export function CourseForm({ initial, onSaved, onCancel }: CourseFormProps) {
  const [draft, setDraft] = useState<CourseDraft>(() => (initial ? toDraft(initial) : emptyDraft()));
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    setDraft(initial ? toDraft(initial) : emptyDraft());
    setError(null);
  }, [initial]);

  const requiredFilled = draft.code.trim() !== '' && draft.name.trim() !== '';

  const set = <K extends keyof CourseDraft>(key: K, value: CourseDraft[K]) =>
    setDraft((current) => ({ ...current, [key]: value }));

  const handleSave = async () => {
    if (!requiredFilled) return;
    setError(null);
    setSaving(true);
    try {
      const saved = await adminUpsertCourse(draft);
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
            {initial ? 'Edit course' : 'New course'}
          </h2>
          <p className="text-sm text-stone-500 dark:text-stone-400">
            Manage the course catalog used across the app.
          </p>
        </div>
        <Button type="button" variant="ghost" size="sm" onClick={onCancel}>
          <X className="size-4" />
        </Button>
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="admin-course-code">Course code</Label>
        <Input
          id="admin-course-code"
          value={draft.code}
          onChange={(event) => set('code', event.target.value)}
          placeholder="e.g. MATH 158"
        />
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="admin-course-name">Course name</Label>
        <Input
          id="admin-course-name"
          value={draft.name}
          onChange={(event) => set('name', event.target.value)}
          placeholder="e.g. Introduction to Discrete Mathematics"
        />
      </div>

      <div className="space-y-1.5">
        <Label htmlFor="admin-course-desc">Description</Label>
        <Textarea
          id="admin-course-desc"
          className="min-h-20 text-sm"
          value={draft.description ?? ''}
          onChange={(event) => set('description', event.target.value.trim() === '' ? null : event.target.value)}
          placeholder="Brief description of the course content."
        />
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
          {saving ? 'Saving…' : initial ? 'Save changes' : 'Create course'}
        </Button>
      </div>
    </Card>
  );
}
