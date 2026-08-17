import { FileText, Plus, Trash2 } from 'lucide-react';
import { useEffect, useMemo, useState } from 'react';
import { EmptyState } from '@/components/common/EmptyState';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import {
  Select,
  SelectContent,
  SelectItem,
  SelectTrigger,
  SelectValue,
} from '@/components/ui/select';
import { useCourses } from '@/hooks/useCourses';
import { useCourseNotes } from '@/hooks/useCourseNotes';
import { adminUpsertCourseNote, adminDeleteCourseNote } from '@/lib/db';
import type { CourseNote } from '@/types';

interface NotesAdminSectionProps {
  editId?: string | null;
  onEditHandled?: () => void;
}

export function NotesAdminSection({ editId, onEditHandled }: NotesAdminSectionProps) {
  const { data: coursesData } = useCourses();
  const courses = coursesData ?? [];
  const [selectedCourse, setSelectedCourse] = useState<string>(() => {
    return courses.length > 0 ? courses[0].id : '';
  });

  const { data: notes, loading, error, reload } = useCourseNotes(selectedCourse || undefined);

  const [selected, setSelected] = useState<CourseNote | null>(null);
  const [title, setTitle] = useState('');
  const [content, setContent] = useState('');
  const [sortOrder, setSortOrder] = useState(0);
  const [saving, setSaving] = useState(false);
  const [saveError, setSaveError] = useState<string | null>(null);
  const [search, setSearch] = useState('');

  // Auto-select course from editId
  useEffect(() => {
    if (!editId || !notes) return;
    const target = notes.find((n) => n.id === editId);
    if (target) {
      setSelectedCourse(target.course_id);
      setSelected(target);
      setTitle(target.title);
      setContent(target.content);
      setSortOrder(target.sort_order);
      onEditHandled?.();
    }
  }, [editId, notes, onEditHandled]);

  const filtered = useMemo(() => {
    if (!notes) return [];
    const term = search.trim().toLowerCase();
    if (term === '') return notes;
    return notes.filter(
      (n) => n.title.toLowerCase().includes(term) || n.content.toLowerCase().includes(term),
    );
  }, [notes, search]);

  const resetForm = () => {
    setSelected(null);
    setTitle('');
    setContent('');
    setSortOrder(0);
    setSaveError(null);
  };

  const handleNew = () => {
    resetForm();
  };

  const handleEdit = (note: CourseNote) => {
    setSelected(note);
    setTitle(note.title);
    setContent(note.content);
    setSortOrder(note.sort_order);
    setSaveError(null);
  };

  const handleSave = async () => {
    if (!selectedCourse) return;
    if (!title.trim()) {
      setSaveError('Title is required');
      return;
    }
    setSaving(true);
    setSaveError(null);
    try {
      await adminUpsertCourseNote(selectedCourse, title, content, sortOrder, selected?.id ?? null);
      resetForm();
      reload();
    } catch (err) {
      setSaveError(err instanceof Error ? err.message : String(err));
    } finally {
      setSaving(false);
    }
  };

  const handleDelete = (note: CourseNote) => {
    if (!window.confirm(`Delete "${note.title}"?`)) return;
    adminDeleteCourseNote(note.id)
      .then(() => {
        if (selected?.id === note.id) resetForm();
        reload();
      })
      .catch(() => {});
  };

  return (
    <div className="space-y-6">
      <div className="flex flex-col gap-4 sm:flex-row sm:items-center sm:justify-between">
        <h2 className="font-serif text-2xl font-bold text-stone-900 dark:text-stone-50">
          Course Notes
        </h2>
        <Button onClick={handleNew} size="sm">
          <Plus className="size-4" />
          New note
        </Button>
      </div>

      {/* Course selector */}
      <div className="flex flex-wrap items-center gap-3">
        <Label className="shrink-0">Course</Label>
        <Select value={selectedCourse} onValueChange={setSelectedCourse}>
          <SelectTrigger className="w-64">
            <SelectValue placeholder="Select a course" />
          </SelectTrigger>
          <SelectContent>
            {courses.map((c) => (
              <SelectItem key={c.id} value={c.id}>
                {c.code} — {c.name}
              </SelectItem>
            ))}
          </SelectContent>
        </Select>
      </div>

      {/* Editor */}
      <Card className="space-y-4 p-5">
        <h3 className="text-sm font-semibold text-stone-700 dark:text-stone-200">
          {selected ? `Editing: ${selected.title}` : 'New Note'}
        </h3>
        <div className="grid gap-4 sm:grid-cols-[1fr_120px]">
          <div>
            <Label htmlFor="note-title">Title</Label>
            <Input
              id="note-title"
              value={title}
              onChange={(e) => setTitle(e.target.value)}
              placeholder="e.g. Unit II: Group Actions"
              className="mt-1"
            />
          </div>
          <div>
            <Label htmlFor="note-sort">Sort order</Label>
            <Input
              id="note-sort"
              type="number"
              value={sortOrder}
              onChange={(e) => setSortOrder(Number(e.target.value))}
              className="mt-1"
            />
          </div>
        </div>
        <div>
          <Label htmlFor="note-content">Content (Markdown + LaTeX)</Label>
          <Textarea
            id="note-content"
            value={content}
            onChange={(e) => setContent(e.target.value)}
            placeholder="# Section Title&#10;&#10;Your content here with $math$ and **bold**."
            className="mt-1 min-h-[200px] font-mono text-sm"
          />
        </div>
        {saveError && (
          <p className="text-sm text-red-600 dark:text-red-400">{saveError}</p>
        )}
        <div className="flex items-center gap-2">
          <Button onClick={handleSave} disabled={saving}>
            {saving ? 'Saving...' : selected ? 'Update' : 'Create'}
          </Button>
          {selected && (
            <Button variant="ghost" onClick={resetForm}>
              Cancel
            </Button>
          )}
        </div>
        {/* Preview */}
        {content && (
          <div className="rounded-lg border border-stone-200 bg-stone-50 p-4 dark:border-stone-700 dark:bg-stone-800">
            <p className="mb-2 text-xs font-medium text-stone-500 dark:text-stone-400">Preview</p>
            <div className="max-h-64 overflow-y-auto">
              <MathRenderer>{content}</MathRenderer>
            </div>
          </div>
        )}
      </Card>

      {/* Search */}
      <div>
        <Input
          placeholder="Search notes..."
          value={search}
          onChange={(e) => setSearch(e.target.value)}
        />
      </div>

      {/* List */}
      {loading ? (
        <LoadingState label="Loading notes" />
      ) : error ? (
        <ErrorState title="Could not load notes" message={error} onRetry={reload} />
      ) : filtered.length === 0 ? (
        <EmptyState
          icon={<FileText className="size-8" />}
          title="No notes"
          description={search ? 'No notes match your search.' : 'Create your first note above.'}
        />
      ) : (
        <div className="space-y-2">
          {filtered.map((note) => (
            <div
              key={note.id}
              className="flex items-center justify-between gap-3 rounded-lg border border-stone-200 bg-white px-4 py-3 transition-colors hover:bg-stone-50 dark:border-stone-700 dark:bg-stone-900 dark:hover:bg-stone-800"
            >
              <div className="min-w-0 flex-1">
                <p className="truncate text-sm font-medium text-stone-800 dark:text-stone-100">
                  {note.title}
                </p>
                <p className="mt-0.5 text-xs text-stone-400 dark:text-stone-500">
                  Order: {note.sort_order} · {note.content.length} chars
                </p>
              </div>
              <div className="flex shrink-0 gap-1">
                <Button variant="ghost" size="sm" onClick={() => handleEdit(note)}>
                  Edit
                </Button>
                <Button
                  variant="ghost"
                  size="sm"
                  onClick={() => handleDelete(note)}
                  className="text-red-500 hover:text-red-700 hover:bg-red-50 dark:text-red-400 dark:hover:text-red-300 dark:hover:bg-red-950"
                >
                  <Trash2 className="size-4" />
                </Button>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
}
