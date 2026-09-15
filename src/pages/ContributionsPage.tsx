import { useCallback, useState } from 'react';
import { useSearchParams } from 'react-router-dom';
import { ContributionCard } from '@/components/contributions/ContributionCard';
import { ContributionForm } from '@/components/contributions/ContributionForm';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Button } from '@/components/ui/button';
import { useAuth } from '@/hooks/useAuth';
import { useAsync } from '@/hooks/useAsync';
import { getCourses, getTopics } from '@/lib/db';
import {
  CONTRIBUTIONS_PAGE_SIZE,
  listContributions,
  type Contribution,
  type ContributionDraft,
} from '@/lib/contributions';

export function ContributionsPage({ admin = false }: { admin?: boolean }) {
  const { user } = useAuth();
  const [params] = useSearchParams();
  const [page, setPage] = useState(0);
  const [status, setStatus] = useState<Contribution['status'] | ''>(admin ? 'pending' : '');
  const [form, setForm] = useState<{ initial?: ContributionDraft } | null>(null);
  const [notice, setNotice] = useState('');
  const catalog = useAsync(
    useCallback(async () => {
      const [courses, topics] = await Promise.all([getCourses(), getTopics()]);
      return { courses, topics };
    }, []),
  );
  const userId = user?.id;
  const submissions = useAsync(
    useCallback(
      () =>
        userId
          ? listContributions({
              authorId: admin ? undefined : userId,
              status: status || undefined,
              page,
            })
          : Promise.resolve([]),
      [userId, admin, status, page],
    ),
  );
  const courses = catalog.data?.courses ?? [];
  const topics = catalog.data?.topics ?? [];
  const rows = submissions.data ?? [];
  return (
    <div className="space-y-6">
      <header className="flex flex-wrap items-start justify-between gap-4">
        <div>
          <h1 className="font-serif text-3xl font-bold">
            {admin ? 'Review contributions' : 'Your contributions'}
          </h1>
          <p className="mt-2 max-w-2xl text-stone-500 dark:text-stone-400">
            {admin
              ? 'Review community questions and course notes before they enter the study library.'
              : 'Help other students study. Share questions or course notes and follow their admin review here.'}
          </p>
        </div>
        {!admin && !form && (
          <Button
            onClick={() => {
              setNotice('');
              setForm({});
            }}
          >
            New contribution
          </Button>
        )}
      </header>
      {notice && (
        <p
          role="status"
          className="rounded-lg bg-emerald-50 p-3 text-sm text-emerald-800 dark:bg-emerald-950/50 dark:text-emerald-200"
        >
          {notice}
        </p>
      )}
      {catalog.error ? (
        <ErrorState
          title="Could not load courses and topics"
          message={catalog.error.message}
          onRetry={catalog.reload}
        />
      ) : catalog.loading ? (
        <LoadingState label="Loading courses and topics" />
      ) : (
        form && (
          <ContributionForm
            courses={courses}
            topics={topics}
            initial={form.initial}
            initialCourseId={
              courses.some((course) => course.id === params.get('courseId'))
                ? params.get('courseId')!
                : undefined
            }
            onCancel={() => setForm(null)}
            onSubmitted={() => {
              setForm(null);
              setPage(0);
              setStatus('');
              setNotice('Submitted for review. You can track the decision below.');
              submissions.reload();
              window.scrollTo({ top: 0, behavior: 'instant' });
            }}
          />
        )
      )}
      <div className="flex flex-wrap gap-2" role="group" aria-label="Submission status">
        {(['', 'pending', 'approved', 'rejected'] as const).map((value) => (
          <Button
            key={value}
            size="sm"
            variant={status === value ? 'default' : 'outline'}
            aria-pressed={status === value}
            onClick={() => {
              setStatus(value);
              setPage(0);
            }}
          >
            {value ? value.charAt(0).toUpperCase() + value.slice(1) : 'All submissions'}
          </Button>
        ))}
      </div>
      {submissions.loading ? (
        <LoadingState label="Loading submissions" />
      ) : submissions.error ? (
        <ErrorState
          title="Could not load submissions"
          message={submissions.error.message}
          onRetry={submissions.reload}
        />
      ) : rows.length ? (
        <div className="space-y-4">
          {rows.slice(0, CONTRIBUTIONS_PAGE_SIZE).map((item) => (
            <ContributionCard
              key={item.id}
              item={item}
              admin={admin}
              courseName={courses.find((course) => course.id === item.course_id)?.code ?? 'Course'}
              topicName={
                item.kind === 'question'
                  ? topics.find((topic) => topic.id === item.payload.topic_id)?.name
                  : undefined
              }
              onReviewed={() => {
                setNotice('Review saved.');
                submissions.reload();
              }}
              onRevise={
                !admin && !form
                  ? () => {
                      setForm({ initial: item });
                      window.scrollTo({ top: 0, behavior: 'instant' });
                    }
                  : undefined
              }
            />
          ))}
        </div>
      ) : (
        <p className="rounded-xl border border-dashed border-stone-300 p-8 text-center text-stone-500 dark:border-stone-700">
          {page
            ? 'No more submissions on this page.'
            : status
              ? `No ${status} submissions.`
              : 'No submissions yet. Start with a question or a set of course notes.'}
        </p>
      )}
      <div className="flex items-center justify-end gap-3">
        <Button
          variant="outline"
          disabled={page === 0 || submissions.loading}
          onClick={() => setPage(page - 1)}
        >
          Previous
        </Button>
        <span className="text-sm">Page {page + 1}</span>
        <Button
          variant="outline"
          disabled={rows.length <= CONTRIBUTIONS_PAGE_SIZE || submissions.loading}
          onClick={() => setPage(page + 1)}
        >
          Next
        </Button>
      </div>
    </div>
  );
}
