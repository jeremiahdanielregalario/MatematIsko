import { useState } from 'react';
import {
  Bookmark,
  BookMarked,
  BookOpenText,
  GraduationCap,
  LayoutDashboard,
  Sparkles,
  Target,
  ArrowRight,
} from 'lucide-react';
import { useSearchParams } from 'react-router-dom';
import { Dialog, DialogContent, DialogDescription, DialogTitle } from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { setWelcomePending, welcomePending } from '@/lib/welcomeGuide';

const steps = [
  {
    icon: Sparkles,
    tab: 'Welcome aboard',
    title: 'Your next math session starts here',
    body: 'Welcome to MatematIsko! Build understanding one problem at a time. This quick tour shows you where to read, practice, and return to ideas that need another try.',
    tip: 'The main tabs are at the top on larger screens and along the bottom on your phone.',
  },
  {
    icon: LayoutDashboard,
    tab: 'Dashboard',
    title: 'Know what to work on next',
    body: 'Suggested helps you pick a starting point. Needs review gathers problems marked Learning. Unseen gives you fresh problems, and Saved brings back your bookmarks.',
    tip: 'Learning and Mastered are your own assessments. Use the progress view to see where to focus.',
  },
  {
    icon: GraduationCap,
    tab: 'Courses',
    title: 'Keep your study materials together',
    body: 'Open a course to browse its topics, questions, and notes. Read at your own pace, use the section list, and look for highlighted definitions, theorems, and proofs.',
    tip: 'A linked theorem in the notes can take you straight to its flashcard.',
  },
  {
    icon: BookMarked,
    tab: 'Theorems',
    title: 'Recall before you reveal',
    body: 'Browse theorem statements or start a flashcard session. Try recalling the statement from its name, flip the card, then mark whether you know it or are still learning.',
    tip: 'Small, repeated recall sessions are a useful way to revisit the ideas behind the problems.',
  },
  {
    icon: Target,
    tab: 'Practice',
    title: 'Choose your pace',
    body: 'Practice lets you attempt problems and reveal support when you need it. Quiz / exam mode creates a timed paper with answers hidden until you finish and choose to review.',
    tip: 'In an active exam, Replace question swaps in another from the same topic when available. The timer keeps running. Complete-solution access depends on your course and verified membership.',
  },
  {
    icon: Bookmark,
    tab: 'Bookmarks',
    title: 'Save the problems worth revisiting',
    body: 'Tap the bookmark icon on a question to keep it here. Save a tricky problem, a useful method, or something you want to discuss later.',
    tip: 'Bookmarking and mastery are separate: a mastered problem can still be worth saving.',
  },
  {
    icon: BookOpenText,
    tab: 'Blogs & your account',
    title: 'You’re ready to explore',
    body: 'Blogs contains community posts. Your account menu opens your profile and this Welcome guide whenever you need a refresher. Use Report on a question or theorem if you spot an issue.',
    tip: 'Start with one suggested problem on your dashboard. Try it first, then reveal only the help you need.',
  },
];

export function WelcomeGuide({ userId, onDismiss }: { userId: string; onDismiss?: () => void }) {
  const [params, setParams] = useSearchParams();
  const requested = params.get('guide') === '1';
  const [automatic, setAutomatic] = useState(() => welcomePending(userId));
  const [step, setStep] = useState(0);
  const current = steps[step];
  const Icon = current.icon;
  const close = () => {
    onDismiss?.();
    setWelcomePending(userId, false);
    setAutomatic(false);
    setStep(0);
    if (requested) {
      const next = new URLSearchParams(params);
      next.delete('guide');
      setParams(next, { replace: true });
    }
  };
  return (
    <Dialog
      open={automatic || requested}
      onOpenChange={(open) => {
        if (!open) close();
      }}
    >
      <DialogContent className="max-w-xl">
        <div className="min-h-0 overflow-y-auto p-6 sm:p-8">
          <div className="mb-6 flex items-center gap-3 pr-7">
            <span className="flex size-12 shrink-0 items-center justify-center rounded-2xl bg-brand-100 text-brand-800 dark:bg-brand-950 dark:text-brand-200">
              <Icon className="size-6" aria-hidden="true" />
            </span>
            <div>
              <p className="text-xs font-semibold uppercase tracking-widest text-brand-800 dark:text-brand-300">
                {current.tab}
              </p>
              <p role="status" className="mt-1 text-xs text-stone-500">
                Step {step + 1} of {steps.length} · Quick tour
              </p>
            </div>
          </div>
          <DialogTitle className="font-serif text-2xl font-semibold text-stone-900 dark:text-stone-50">
            {current.title}
          </DialogTitle>
          <DialogDescription className="mt-4 text-base leading-relaxed text-stone-600 dark:text-stone-300">
            {current.body}
          </DialogDescription>
          <p className="mt-5 rounded-xl border border-stone-200 bg-stone-50 p-4 text-sm leading-relaxed text-stone-600 dark:border-stone-700 dark:bg-stone-800 dark:text-stone-300">
            {current.tip}
          </p>
          <div className="mt-6 flex gap-1.5" aria-hidden="true">
            {steps.map((_, index) => (
              <span
                key={index}
                className={`h-1 flex-1 rounded-full ${index <= step ? 'bg-brand-700 dark:bg-brand-300' : 'bg-stone-200 dark:bg-stone-700'}`}
              />
            ))}
          </div>
          <div className="mt-6 flex flex-wrap items-center justify-between gap-3">
            <Button variant="ghost" onClick={close}>
              Skip tour
            </Button>
            <div className="flex gap-2">
              {step > 0 && (
                <Button variant="outline" onClick={() => setStep(step - 1)}>
                  Back
                </Button>
              )}
              <Button onClick={() => (step === steps.length - 1 ? close() : setStep(step + 1))}>
                {step === steps.length - 1 ? 'Start exploring' : 'Next'}
                <ArrowRight className="size-4" aria-hidden="true" />
              </Button>
            </div>
          </div>
        </div>
      </DialogContent>
    </Dialog>
  );
}
