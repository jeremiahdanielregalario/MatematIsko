import { useCallback, useRef, useState } from 'react';
import type { Profile } from '@/types';
import { useAsync } from '@/hooks/useAsync';
import { adminUserProgress, adminResetUserProgress } from '@/lib/adminProgress';
import { Button } from '@/components/ui/button';
import { Dialog, DialogContent, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { LoadingState } from '@/components/common/LoadingState';
import { ErrorState } from '@/components/common/ErrorState';

export function UserProgressDialog({
  profile,
  onClose,
}: {
  profile: Profile;
  onClose: () => void;
}) {
  const fetchProgress = useCallback(() => adminUserProgress(profile.id), [profile.id]);
  const { data, loading, error, reload } = useAsync(fetchProgress);
  const [target, setTarget] = useState<{ id: string | null; label: string } | null>(null);
  const [saving, setSaving] = useState(false);
  const busy = useRef(false);
  const [failure, setFailure] = useState('');
  const [message, setMessage] = useState('');
  const reset = async () => {
    if (!target || busy.current) return;
    busy.current = true;
    setSaving(true);
    setFailure('');
    try {
      await adminResetUserProgress(profile.id, target.id);
      setTarget(null);
      setMessage(`Progress reset for ${target.label}.`);
      reload();
    } catch (err) {
      setFailure(err instanceof Error ? err.message : 'Could not reset progress. Try again.');
    } finally {
      busy.current = false;
      setSaving(false);
    }
  };
  return (
    <Dialog
      open
      onOpenChange={(open) => {
        if (!open && !busy.current) onClose();
      }}
    >
      <DialogContent className="max-w-2xl p-6">
        <DialogTitle className="pr-8 font-serif text-xl font-semibold">
          Courses and progress
        </DialogTitle>
        <DialogDescription className="mt-1 break-words text-sm text-stone-500">
          {profile.full_name || profile.email} · {profile.email}
        </DialogDescription>
        <div className="mt-4 min-h-0 space-y-4 overflow-y-auto pr-1">
          <p className="text-sm text-stone-500">
            Mastery is self-assessed. Selected courses reflect the user's course choices. Exam
            papers and self-checks saved only in their browser are not included.
          </p>
          {message && (
            <p role="status" className="text-sm text-emerald-700 dark:text-emerald-300">
              {message}
            </p>
          )}
          {target ? (
            <div className="space-y-3 rounded-xl border border-red-300 p-4">
              <h3 className="font-semibold">Reset progress for {target.label}?</h3>
              <p className="text-sm">
                This permanently clears {profile.full_name || profile.email}'s question and theorem
                mastery, attempts, and review timestamps in this scope. Bookmarks and selected
                courses remain. Active study pages should be refreshed; later study actions can
                record new progress.
              </p>
              {failure && (
                <p role="alert" className="text-sm text-red-600 dark:text-red-400">
                  {failure}
                </p>
              )}
              <div className="flex flex-wrap gap-2">
                <Button variant="outline" disabled={saving} onClick={() => setTarget(null)}>
                  Cancel reset
                </Button>
                <Button disabled={saving} onClick={() => void reset()}>
                  {saving ? 'Resetting…' : 'Confirm reset'}
                </Button>
              </div>
            </div>
          ) : loading ? (
            <LoadingState label="Loading progress" />
          ) : error ? (
            <ErrorState title="Could not load progress" message={error.message} onRetry={reload} />
          ) : (
            <>
              <div className="flex flex-wrap gap-2">
                <Button variant="outline" onClick={reload}>
                  Refresh progress
                </Button>
                <Button
                  variant="outline"
                  disabled={!data?.some((c) => c.question_records + c.theorem_records > 0)}
                  onClick={() => {
                    setMessage('');
                    setFailure('');
                    setTarget({ id: null, label: 'all courses' });
                  }}
                >
                  Reset all progress
                </Button>
              </div>
              {!data?.length && (
                <p className="text-sm text-stone-500">
                  No selected courses or saved study progress.
                </p>
              )}
              {data?.map((course) => (
                <article
                  key={course.id}
                  className="space-y-3 rounded-xl border border-stone-200 p-4 dark:border-stone-700"
                >
                  <h3 className="font-semibold">
                    {course.code} · {course.name}
                  </h3>
                  <p className="text-sm text-stone-500">
                    {course.selected
                      ? 'Selected course'
                      : 'Previously studied · not currently selected'}
                  </p>
                  <p className="text-sm">
                    Questions: {course.questions_mastered}/{course.questions_total} mastered ·{' '}
                    {course.questions_learning} learning ·{' '}
                    {course.questions_total - course.questions_mastered - course.questions_learning}{' '}
                    unseen
                  </p>
                  <p className="text-sm">
                    Theorems: {course.theorems_mastered}/{course.theorems_total} mastered ·{' '}
                    {course.theorems_learning} learning ·{' '}
                    {course.theorems_total - course.theorems_mastered - course.theorems_learning}{' '}
                    unseen
                  </p>
                  <p className="text-sm text-stone-500">
                    {course.attempts} question attempts · Last recorded activity:{' '}
                    {course.last_activity
                      ? new Date(course.last_activity).toLocaleString()
                      : 'None'}
                  </p>
                  <Button
                    variant="outline"
                    size="sm"
                    disabled={course.question_records + course.theorem_records === 0}
                    onClick={() => {
                      setMessage('');
                      setFailure('');
                      setTarget({ id: course.id, label: course.code });
                    }}
                  >
                    Reset {course.code} progress
                  </Button>
                </article>
              ))}
            </>
          )}
        </div>
      </DialogContent>
    </Dialog>
  );
}
