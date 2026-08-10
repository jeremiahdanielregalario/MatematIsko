import { ArrowLeft, Shuffle } from 'lucide-react';
import { Link, useNavigate, useParams } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { BookmarkButton } from '@/components/questions/BookmarkButton';
import { DifficultyBadge } from '@/components/questions/DifficultyBadge';
import { MasteryButton } from '@/components/questions/MasteryButton';
import { RevealSection } from '@/components/questions/RevealSection';
import { ReportButton } from '@/components/common/ReportButton';
import { Button } from '@/components/ui/button';
import { Card } from '@/components/ui/card';
import { MathRenderer } from '@/components/math/MathRenderer';
import { useQuestion } from '@/hooks/useQuestion';
import { useQuestionMutations } from '@/hooks/useQuestionMutations';
import { useQuestions } from '@/hooks/useQuestions';
import { useReveal } from '@/hooks/useReveal';
import { useRevealKeyboard } from '@/hooks/useRevealKeyboard';
import { mergeMutations } from '@/lib/mutations';
import { pickRandom } from '@/lib/questionFilter';
import { submitQuestionReport } from '@/lib/reports';

export function QuestionDetailPage() {
  const { id } = useParams<{ id: string }>();
  const navigate = useNavigate();
  const { data: question, loading, error, reload } = useQuestion(id);

  const { data: loadedQuestions = null } = useQuestions();
  const allQuestions = loadedQuestions ?? [];
  const getQuestion = (qid: string) => allQuestions.find((q) => q.id === qid);
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

  const nextRandom = () => {
    const random = pickRandom(allQuestions.filter((q) => q.id !== question.id));
    if (random) {
      reveal.reset();
      navigate(`/questions/${random.id}`);
    }
  };

  return (
    <div className="mx-auto max-w-3xl space-y-6">
      <Link
        to="/questions"
        className="inline-flex items-center gap-1.5 text-sm font-medium text-stone-500 hover:text-stone-900 dark:text-stone-400 dark:hover:text-stone-100"
      >
        <ArrowLeft className="size-4" />
        Back to question bank
      </Link>

      <Card className="overflow-hidden">
        <div className="border-b border-stone-100 p-6 dark:border-stone-800">
          <div className="flex flex-wrap items-center justify-between gap-3">
            <div className="flex flex-wrap items-center gap-2 text-xs text-stone-500 dark:text-stone-400">
              <span className="font-mono font-semibold text-brand-900 dark:text-brand-300">
                {merged.course?.code ?? '—'}
              </span>
              <span>{merged.topic?.name}</span>
              <DifficultyBadge difficulty={merged.difficulty} />
              <span>{merged.year}</span>
              <span>
                {merged.exam_name} · No. {merged.question_number}
              </span>
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

        <div className="space-y-6 p-6">
          <div>
            <h2 className="mb-3 text-xs font-semibold uppercase tracking-widest text-stone-400 dark:text-stone-500">
              Problem
            </h2>
            <MathRenderer className="font-serif text-lg leading-relaxed">
              {merged.question_text}
            </MathRenderer>
          </div>

          <div>
            <h2 className="mb-3 text-xs font-semibold uppercase tracking-widest text-stone-400 dark:text-stone-500">
              Your workspace
            </h2>
            <p className="mb-4 text-sm text-stone-500 dark:text-stone-400">
              Try the problem on your own before revealing anything. When you are ready, work
              through the hints, answer, and full solution one step at a time.
            </p>
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
            <Button variant="outline" size="sm" onClick={nextRandom}>
              <Shuffle className="size-4" />
              Next random problem
            </Button>
          </div>
        </div>
      </Card>
    </div>
  );
}
