import { BookOpen, Lightbulb, Sparkles } from 'lucide-react';
import { cn } from '@/lib/cn';
import { MathRenderer } from '@/components/math/MathRenderer';

type Tone = 'hint' | 'answer' | 'solution';

const TONES: Record<Tone, string> = {
  hint: 'border-amber-200 bg-amber-50 text-amber-950 dark:border-amber-900/60 dark:bg-amber-950/30 dark:text-amber-100',
  answer: 'border-emerald-200 bg-emerald-50 text-emerald-950 dark:border-emerald-900/60 dark:bg-emerald-950/30 dark:text-emerald-100',
  solution:
    'border-sky-200 bg-sky-50 text-sky-950 dark:border-sky-900/60 dark:bg-sky-950/30 dark:text-sky-100',
};

function RevealPanelBase({
  icon,
  title,
  tone,
  children,
}: {
  icon: React.ReactNode;
  title: string;
  tone: Tone;
  children: string;
}) {
  return (
    <section
      data-testid={`reveal-${tone}`}
      className={cn('animate-slide-up rounded-xl border p-5', TONES[tone])}
    >
      <h4 className="flex items-center gap-2 text-xs font-semibold uppercase tracking-widest">
        <span className="grid size-6 place-items-center rounded-full bg-white/70 dark:bg-black/20">
          {icon}
        </span>
        {title}
      </h4>
      <div className="mt-3">
        <MathRenderer className="prose-sm">{children}</MathRenderer>
      </div>
    </section>
  );
}

export function HintPanel({ hint }: { hint: string }) {
  return (
    <RevealPanelBase icon={<Lightbulb className="size-3.5" />} title="Hint" tone="hint">
      {hint}
    </RevealPanelBase>
  );
}

export function AnswerPanel({ answer }: { answer: string }) {
  return (
    <RevealPanelBase icon={<Sparkles className="size-3.5" />} title="Answer" tone="answer">
      {answer}
    </RevealPanelBase>
  );
}

export function SolutionPanel({ solution }: { solution: string }) {
  return (
    <RevealPanelBase icon={<BookOpen className="size-3.5" />} title="Complete solution" tone="solution">
      {solution}
    </RevealPanelBase>
  );
}
