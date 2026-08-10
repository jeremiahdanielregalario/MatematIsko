import { Flag } from 'lucide-react';
import { useState } from 'react';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogClose,
  DialogContent,
  DialogDescription,
  DialogTitle,
} from '@/components/ui/dialog';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { Textarea } from '@/components/ui/textarea';
import { cn } from '@/lib/cn';

// ---------------------------------------------------------------------------
// Shared types
// ---------------------------------------------------------------------------

interface ReportDialogProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  /** "question" or "theorem" — controls category labels */
  kind: 'question' | 'theorem';
  onSubmit: (category: string, description: string) => Promise<unknown>;
}

// ---------------------------------------------------------------------------
// Category options
// ---------------------------------------------------------------------------

const QUESTION_CATEGORIES = [
  { value: 'rendering', label: 'Rendering / display issue' },
  { value: 'question', label: 'Problem statement incorrect' },
  { value: 'hint', label: 'Hint is incorrect or misleading' },
  { value: 'answer', label: 'Answer is incorrect' },
  { value: 'solution', label: 'Solution is incorrect or incomplete' },
  { value: 'other', label: 'Other' },
];

const THEOREM_CATEGORIES = [
  { value: 'rendering', label: 'Rendering / display issue' },
  { value: 'statement', label: 'Statement is incorrect' },
  { value: 'formal_notation', label: 'Formal notation is incorrect' },
  { value: 'name', label: 'Name is incorrect' },
  { value: 'other', label: 'Other' },
];

// ---------------------------------------------------------------------------
// ReportDialog
// ---------------------------------------------------------------------------

export function ReportDialog({
  open,
  onOpenChange,
  kind,
  onSubmit,
}: ReportDialogProps) {
  const categories = kind === 'question' ? QUESTION_CATEGORIES : THEOREM_CATEGORIES;
  const [category, setCategory] = useState(categories[0].value);
  const [description, setDescription] = useState('');
  const [submitting, setSubmitting] = useState(false);
  const [submitted, setSubmitted] = useState(false);
  const [error, setError] = useState<string | null>(null);

  const handleSubmit = async () => {
    setSubmitting(true);
    setError(null);
    try {
      await onSubmit(category, description);
      setSubmitted(true);
    } catch (err) {
      setError(err instanceof Error ? err.message : String(err));
    } finally {
      setSubmitting(false);
    }
  };

  const handleClose = (nextOpen: boolean) => {
    if (!nextOpen) {
      // Reset state when closing
      setCategory(categories[0].value);
      setDescription('');
      setSubmitted(false);
      setError(null);
    }
    onOpenChange(nextOpen);
  };

  return (
    <Dialog open={open} onOpenChange={handleClose}>
      <DialogContent>
        <DialogTitle className="font-serif text-lg font-semibold text-stone-900 dark:text-stone-100">
          Report an Issue
        </DialogTitle>
        <DialogDescription className="text-sm text-stone-500 dark:text-stone-400">
          {submitted
            ? 'Thank you for your feedback! The admin will review it.'
            : `Help us improve by reporting a problem with this ${kind === 'question' ? 'question' : 'theorem'}.`}
        </DialogDescription>

        {submitted ? (
          <div className="flex items-center justify-end gap-2 pt-2">
            <DialogClose asChild>
              <Button>Close</Button>
            </DialogClose>
          </div>
        ) : (
          <div className="space-y-4 pt-2">
            <div className="space-y-1.5">
              <Label>What is the issue?</Label>
              <Select value={category} onValueChange={setCategory}>
                <SelectTrigger>
                  <SelectValue />
                </SelectTrigger>
                <SelectContent>
                  {categories.map((cat) => (
                    <SelectItem key={cat.value} value={cat.value}>
                      {cat.label}
                    </SelectItem>
                  ))}
                </SelectContent>
              </Select>
            </div>

            <div className="space-y-1.5">
              <Label htmlFor="report-description">Additional details (optional)</Label>
              <Textarea
                id="report-description"
                value={description}
                onChange={(event) => setDescription(event.target.value)}
                placeholder="Describe the issue you found…"
                className="min-h-20 text-sm"
              />
            </div>

            {error ? (
              <p className="rounded-md bg-red-50 px-3 py-2 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-400">
                {error}
              </p>
            ) : null}

            <div className="flex items-center justify-end gap-2">
              <DialogClose asChild>
                <Button variant="ghost">Cancel</Button>
              </DialogClose>
              <Button onClick={handleSubmit} disabled={submitting}>
                {submitting ? 'Submitting…' : 'Submit Report'}
              </Button>
            </div>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
}

// ---------------------------------------------------------------------------
// ReportButton (standalone trigger + dialog)
// ---------------------------------------------------------------------------

interface ReportButtonProps {
  kind: 'question' | 'theorem';
  onSubmit: (category: string, description: string) => Promise<unknown>;
  className?: string;
}

export function ReportButton({ kind, onSubmit, className }: ReportButtonProps) {
  const [open, setOpen] = useState(false);

  return (
    <>
      <Button
        variant="ghost"
        size="sm"
        className={cn('text-stone-400 hover:text-stone-600 dark:text-stone-500 dark:hover:text-stone-300', className)}
        onClick={() => setOpen(true)}
      >
        <Flag className="size-3.5" />
        Report
      </Button>
      <ReportDialog open={open} onOpenChange={setOpen} kind={kind} onSubmit={onSubmit} />
    </>
  );
}
