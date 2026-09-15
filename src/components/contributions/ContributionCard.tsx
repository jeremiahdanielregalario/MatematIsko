import { useRef, useState } from 'react';
import { Link } from 'react-router-dom';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Badge } from '@/components/ui/badge';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';
import { reviewContribution, type Contribution } from '@/lib/contributions';

export function ContributionCard({
  item,
  courseName,
  topicName,
  admin = false,
  onReviewed,
  onRevise,
}: {
  item: Contribution;
  courseName: string;
  topicName?: string;
  admin?: boolean;
  onReviewed: () => void;
  onRevise?: () => void;
}) {
  const [expanded, setExpanded] = useState(false);
  const [note, setNote] = useState('');
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState('');
  const inFlight = useRef(false);
  const review = async (decision: 'approved' | 'rejected') => {
    if (inFlight.current) return;
    if (decision === 'rejected' && !note.trim()) {
      setError('Add feedback so the contributor knows what to improve.');
      return;
    }
    inFlight.current = true;
    setSaving(true);
    setError('');
    try {
      await reviewContribution(item.id, decision, note);
      onReviewed();
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Could not save the review.');
    } finally {
      inFlight.current = false;
      setSaving(false);
    }
  };
  return (
    <article className="min-w-0 space-y-4 rounded-xl border border-stone-200 bg-white p-4 dark:border-stone-800 dark:bg-stone-900 sm:p-5">
      <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
        <span className="font-semibold">{courseName}</span>
        <span>{item.kind === 'question' ? 'Question' : 'Course notes'}</span>
        <Badge
          variant={
            item.status === 'approved'
              ? 'success'
              : item.status === 'pending'
                ? 'warning'
                : 'secondary'
          }
        >
          {item.status}
        </Badge>
        <span>{new Date(item.created_at).toLocaleDateString()}</span>
      </div>
      <h3 className="break-words font-semibold">
        <MathRenderer inline>{item.title}</MathRenderer>
      </h3>
      {admin && <p className="text-sm text-stone-500">Submitted by {item.author_name}</p>}
      {item.review_note && (
        <div className="rounded-lg bg-stone-50 p-3 text-sm dark:bg-stone-800">
          <p className="font-semibold">Admin feedback</p>
          <p className="whitespace-pre-wrap break-words">{item.review_note}</p>
        </div>
      )}
      <div className="flex flex-wrap gap-2">
        <Button
          variant="outline"
          size="sm"
          disabled={saving}
          aria-expanded={expanded}
          onClick={() => setExpanded(!expanded)}
        >
          {expanded
            ? 'Hide submission'
            : admin && item.status === 'pending'
              ? 'Review submission'
              : 'View submission'}
        </Button>
        {item.status === 'rejected' && onRevise && (
          <Button variant="outline" size="sm" onClick={onRevise}>
            Revise and resubmit
          </Button>
        )}
        {item.status === 'approved' && item.published_id && (
          <Button variant="outline" size="sm" asChild>
            <Link
              to={
                item.kind === 'question'
                  ? `/questions/${item.published_id}`
                  : `/courses/${item.course_id}/notes/${item.published_id}`
              }
            >
              View published {item.kind === 'question' ? 'question' : 'notes'}
            </Link>
          </Button>
        )}
      </div>
      {expanded && (
        <div className="space-y-5 border-t border-stone-200 pt-4 dark:border-stone-800">
          {item.kind === 'note' ? (
            <MathRenderer noteEnvironments={{}}>{item.payload.content}</MathRenderer>
          ) : (
            <>
              <p className="text-sm text-stone-500">
                {topicName ?? 'Topic no longer available'} · {item.payload.difficulty} ·{' '}
                {item.payload.exam_name} · {item.payload.year} · Question{' '}
                {item.payload.question_number}
              </p>
              {(
                [
                  ['Question', item.payload.question_text],
                  ['Hint', item.payload.hint],
                  ['Answer', item.payload.answer],
                  ['Solution', item.payload.solution],
                ] as const
              ).map(
                ([label, body]) =>
                  body && (
                    <section key={label} className="space-y-2">
                      <h4 className="font-semibold">{label}</h4>
                      <MathRenderer>{body}</MathRenderer>
                    </section>
                  ),
              )}
            </>
          )}
          {admin && item.status === 'pending' && (
            <div className="space-y-3 rounded-lg bg-stone-50 p-4 dark:bg-stone-800/50">
              <p className="text-sm text-stone-600 dark:text-stone-300">
                Approval adds this submission to the course library. Check accuracy, source, and
                math formatting first. Reject with feedback if changes are needed.
              </p>
              <Label htmlFor={`review-${item.id}`}>Feedback (required when rejecting)</Label>
              <Textarea
                id={`review-${item.id}`}
                maxLength={2000}
                disabled={saving}
                value={note}
                onChange={(e) => setNote(e.target.value)}
              />
              {error && (
                <p role="alert" className="text-sm text-red-700 dark:text-red-300">
                  {error}
                </p>
              )}
              <div className="flex flex-wrap justify-end gap-2">
                <Button variant="outline" disabled={saving} onClick={() => void review('rejected')}>
                  Reject submission
                </Button>
                <Button disabled={saving} onClick={() => void review('approved')}>
                  {saving ? 'Saving review…' : 'Approve and publish'}
                </Button>
              </div>
            </div>
          )}
        </div>
      )}
    </article>
  );
}
