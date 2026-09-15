import { Loader2, Trash2 } from 'lucide-react';
import { useRef, useState } from 'react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogDescription, DialogTitle } from '@/components/ui/dialog';
import { adminDeleteReport } from '@/lib/reports';

export interface ReportToDelete {
  table: 'question_reports' | 'theorem_reports';
  id: string;
  title: string;
  course: string | null;
  category: string;
  status: string;
  description: string | null;
}

export function DeleteReportDialog({
  report,
  onClose,
  onDeleted,
  onReturnFocus,
}: {
  report: ReportToDelete | null;
  onClose: () => void;
  onDeleted: (report: ReportToDelete) => void;
  onReturnFocus: () => void;
}) {
  const [deleting, setDeleting] = useState(false);
  const [error, setError] = useState('');
  const inFlight = useRef(false);
  const cancelRef = useRef<HTMLButtonElement>(null);

  const handleDelete = async () => {
    if (!report || inFlight.current) return;
    inFlight.current = true;
    setDeleting(true);
    setError('');
    try {
      await adminDeleteReport(report.table, report.id);
      onDeleted(report);
      onClose();
    } catch (err) {
      setError(
        err instanceof Error ? err.message : 'Could not delete this report. Please try again.',
      );
    } finally {
      inFlight.current = false;
      setDeleting(false);
    }
  };

  return (
    <Dialog
      open={Boolean(report)}
      onOpenChange={(open) => {
        if (!open && !inFlight.current) {
          setError('');
          onClose();
        }
      }}
    >
      <DialogContent
        onOpenAutoFocus={(event) => {
          event.preventDefault();
          cancelRef.current?.focus();
        }}
        onCloseAutoFocus={(event) => {
          event.preventDefault();
          onReturnFocus();
        }}
      >
        <div className="overflow-y-auto p-6">
          <div className="mb-4 grid size-11 place-items-center rounded-full bg-red-50 text-red-600 dark:bg-red-950/50 dark:text-red-400">
            <Trash2 className="size-5" />
          </div>
          <DialogTitle className="pr-6 text-xl font-semibold text-stone-900 dark:text-stone-50">
            Delete report?
          </DialogTitle>
          <DialogDescription className="mt-2 text-sm text-stone-500 dark:text-stone-400">
            Permanently remove this report from the inbox. This cannot be undone. The reported
            question or theorem will remain available.
          </DialogDescription>
          {report && (
            <div className="mt-5 space-y-2 rounded-xl border border-stone-200 bg-stone-50 p-4 dark:border-stone-700 dark:bg-stone-800/50">
              <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
                <span className="font-semibold">{report.course ?? 'Unknown course'}</span>
                <Badge variant={report.status === 'open' ? 'warning' : 'success'}>
                  {report.status}
                </Badge>
                <span>{report.category}</span>
              </div>
              <div className="break-words text-sm font-medium text-stone-900 dark:text-stone-100">
                <MathRenderer inline>{report.title}</MathRenderer>
              </div>
              {report.description && (
                <p className="max-h-32 overflow-y-auto whitespace-pre-wrap break-words text-sm text-stone-600 dark:text-stone-300">
                  {report.description}
                </p>
              )}
            </div>
          )}
          {error && (
            <p
              role="alert"
              className="mt-4 rounded-lg bg-red-50 p-3 text-sm text-red-700 dark:bg-red-950/50 dark:text-red-300"
            >
              {error}
            </p>
          )}
        </div>
        <div className="flex flex-col-reverse gap-2 border-t border-stone-200 px-6 py-4 sm:flex-row sm:justify-end dark:border-stone-800">
          <Button ref={cancelRef} variant="outline" disabled={deleting} onClick={onClose}>
            Keep report
          </Button>
          <Button variant="destructive" disabled={deleting} onClick={() => void handleDelete()}>
            {deleting ? <Loader2 className="animate-spin" /> : <Trash2 />}
            {deleting ? 'Deleting…' : 'Delete report'}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
