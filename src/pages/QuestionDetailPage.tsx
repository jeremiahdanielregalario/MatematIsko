import { QuestionWatermark } from '@/components/common/QuestionWatermark';
import { ArrowLeft, Columns2, Maximize2, Shuffle, Target } from 'lucide-react';
import { useState } from 'react';
import { Link, useNavigate, useParams, useSearchParams } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { BookmarkButton } from '@/components/questions/BookmarkButton';
import { DifficultyBadge } from '@/components/questions/DifficultyBadge';
import { MasteryButton } from '@/components/questions/MasteryButton';
import { RevealSection } from '@/components/questions/RevealSection';
import { Scratchpad } from '@/components/questions/Scratchpad';
import { ReportButton } from '@/components/common/ReportButton';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { MathRenderer } from '@/components/math/MathRenderer';
import { useQuestion } from '@/hooks/useQuestion';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { useReveal } from '@/hooks/useReveal';
import { useRevealKeyboard } from '@/hooks/useRevealKeyboard';
import { cn } from '@/lib/cn';
import { mergeMutations } from '@/lib/mutations';
import { pickRandom, pickRandomProblem } from '@/lib/questionFilter';
import { submitQuestionReport } from '@/lib/reports';

export function QuestionDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const [searchParams] = useSearchParams();
  const [splitLayout, setSplitLayout] = useState(false);
  const { data: question, loading, error, reload } = useQuestion(id);

  const { data: loadedQuestions = null } = useQuestions();
  const allQuestions = loadedQuestions ?? [];
  const getQuestion = (qid: string) =>
    question?.id === qid ? question : allQuestions.find((q) => q.id === qid);
  const mutations = useQuestionMutations(getQuestion);

  const reveal = useReveal();
  useRevealKeyboard(reveal.reveal, !loading);

  if (loading) return <LoadingState label="Loading question" />;

  if (error || !question) {
    return (
      <ErrorState
        title="Could not load this question"
        message={error?.message ?? 'The question may have been removed.'}
        onRetry={reload}
      />
    );
  }

  const merged = mergeMutations(question, mutations);
  const attempts = merged.progress?.attempts ?? 0;

  // Carry the study context (course/topic/filters) through detail navigation so
  // the "next question" button stays within what the student is focusing on.
  const randomMode = searchParams.get('mode') === 'random';
  const contextCourse = randomMode ? undefined : (searchParams.get('course') ?? question.course_id);
  const contextTopic = randomMode ? undefined : (searchParams.get('topic') ?? undefined);

  // "Next" carries the context so the study session stays within the same
  // course/topic, or preserves cross-course random mode. The fallback keeps focus even
  // when the student arrived via a deep link.
  const contextPath = (nextId: string) => {
    const params = new URLSearchParams(searchParams);
    if (contextCourse) params.set('course', contextCourse);
    else params.delete('course');
    if (randomMode) params.delete('topic');
    if (contextTopic) params.set('topic', contextTopic);
    return `/questions/${nextId}?${params.toString()}`;
  };

  const nextPool = allQuestions.filter(
    (q) =>
      q.id !== question.id &&
      (!contextCourse || q.course_id === contextCourse) &&
      (!contextTopic || q.topic_id === contextTopic),
  );
  const nextInContext = () => {
    const random = randomMode
      ? pickRandomProblem(nextPool.map((q) => mergeMutations(q, mutations)))
      : pickRandom(nextPool);
    if (random) {
      reveal.reset();
      navigate(contextPath(random.id));
    }
  };
  // "Back" returns to the course page, which is the study home for the topic.
  const backPath = randomMode ? '/dashboard' : `/courses/${contextCourse}`;

  const inTopic = Boolean(contextTopic);
  const inCourse = Boolean(contextCourse) && !inTopic;

  return (
    <div
      className={cn(
        'mx-auto space-y-6 transition-all duration-200',
        splitLayout ? 'max-w-6xl' : 'max-w-3xl',
      )}
    >
      <div className="flex flex-wrap items-center justify-between gap-3">
        <Link
          to={backPath}
          className="inline-flex items-center gap-1.5 text-sm font-medium text-stone-500 hover:text-stone-900 dark:text-stone-400 dark:hover:text-stone-100"
        >
          <ArrowLeft className="size-4" />
          {randomMode ? 'Back to dashboard' : 'Back to course'}
        </Link>
        <Button
          type="button"
          variant="ghost"
          size="sm"
          aria-pressed={splitLayout}
          onClick={() => setSplitLayout((s) => !s)}
          className="hidden lg:inline-flex"
        >
          {splitLayout ? <Maximize2 className="size-3.5" /> : <Columns2 className="size-3.5" />}
          {splitLayout ? 'Single-column view' : 'Split workbench view'}
        </Button>
      </div>

      <Card className="overflow-hidden">
        <div className="border-b border-stone-100 bg-stone-50/50 p-6 dark:border-stone-800 dark:bg-stone-900/40">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
              <span className="rounded bg-brand-100/80 px-2 py-0.5 font-mono font-semibold text-brand-900 dark:bg-brand-950 dark:text-brand-300">
                {merged.course?.code ?? '—'}
              </span>
              <span className="font-medium text-stone-700 dark:text-stone-300">
                {merged.topic?.name}
              </span>
              <DifficultyBadge difficulty={merged.difficulty} />
              <span>{merged.year}</span>
              <span>
                {merged.exam_name} · No. {merged.question_number}
              </span>
              {attempts > 0 && (
                <span className="rounded bg-stone-200/70 px-1.5 py-0.5 font-mono text-[11px] tabular-nums text-stone-700 dark:bg-stone-800 dark:text-stone-300">
                  Attempted {attempts} {attempts === 1 ? 'time' : 'times'}
                </span>
              )}
            </div>
            <div className="flex items-center gap-1">
              <ReportButton
                kind="question"
                onSubmit={(category, description) =>
                  submitQuestionReport(merged.id, category as never, description)
                }
              />
              <BookmarkButton
                bookmarked={merged.bookmarked}
                onToggleBookmark={(next) => mutations.toggleBookmark(merged.id, next)}
              />
            </div>
          </div>
          <h1 className="mt-3 font-serif text-2xl font-bold leading-tight tracking-tight text-stone-900 dark:text-stone-50">
            <MathRenderer inline>{merged.title}</MathRenderer>
          </h1>
        </div>

        <div
          className={cn(
            'p-6',
            splitLayout ? 'grid gap-8 lg:grid-cols-[1.1fr_1fr] lg:items-start' : 'space-y-6',
          )}
        >
          <div className="rounded-xl border border-stone-200/80 bg-stone-50/40 p-5 dark:border-stone-800 dark:bg-stone-950/40">
            <h2 className="mb-3 text-xs font-semibold uppercase tracking-widest text-brand-800 dark:text-brand-300">
              Problem
            </h2>
            <QuestionWatermark>
              <MathRenderer className="font-serif text-lg leading-relaxed">
                {merged.question_text}
              </MathRenderer>
            </QuestionWatermark>
          </div>

          <div className="space-y-6">
            <div>
              <div className="mb-2 flex flex-wrap items-center justify-between gap-2">
                <h2 className="text-xs font-semibold uppercase tracking-widest text-stone-400 dark:text-stone-500">
                  Your workspace
                </h2>
                <span className="font-mono text-[11px] text-stone-400 dark:text-stone-500">
                  Shortcuts: H Hint · A Answer · S Solution
                </span>
              </div>
              <p className="mb-4 text-sm text-stone-500 dark:text-stone-400">
                Try the problem on your own before revealing anything. When you are ready, work
                through the hints, answer, and full solution one step at a time.
              </p>
              <div className="mb-4">
                <Scratchpad questionId={merged.id} />
              </div>
              <RevealSection
                level={reveal.level}
                onReveal={reveal.reveal}
                onReset={reveal.reset}
                hint={merged.hint}
                answer={merged.answer}
                solution={merged.solution}
              />
            </div>

            <div className="flex flex-wrap items-center justify-between gap-4 border-t border-stone-100 pt-5 dark:border-stone-800">
              <div>
                <p className="mb-2 text-sm font-medium text-stone-700 dark:text-stone-200">
                  How well do you know this one?
                </p>
                <MasteryButton
                  status={merged.progress?.status ?? 'unseen'}
                  onChange={(next) => mutations.setStatus(merged.id, next)}
                />
              </div>
              <div className="flex flex-wrap items-center gap-2">
                <Button variant="ghost" size="sm" asChild>
                  <Link
                    to={`/practice?courseId=${merged.course_id}&topicId=${merged.topic_id}`}
                  >
                    <Target className="size-4" />
                    Practice topic
                  </Link>
                </Button>
                <Button
                  variant="outline"
                  size="sm"
                  onClick={nextInContext}
                  disabled={nextPool.length === 0}
                >
                  <Shuffle className="size-4" />
                  {inTopic
                    ? `Next in ${merged.topic?.name ?? 'topic'}`
                    : inCourse
                      ? `Next in ${merged.course?.code ?? 'course'}`
                      : 'Next random problem'}
                </Button>
              </div>
            </div>
          </div>
        </div>
      </Card>
    </div>
  );
}
