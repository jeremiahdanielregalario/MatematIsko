import {
  Bookmark,
  Infinity as InfinityIcon,
  Layers,
  PenLine,
  ShieldCheck,
  Target,
  TriangleAlert,
  Wrench,
} from 'lucide-react';
import { Link, Navigate, useLocation } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Reveal } from '@/components/common/Reveal';
import { Logo } from '@/components/Logo';
import { MathRenderer } from '@/components/math/MathRenderer';
import { RevealSection } from '@/components/questions/RevealSection';
import { ThemeToggle } from '@/components/layout/ThemeToggle';
import { EmailAuthForm } from '@/features/auth/EmailAuthForm';
import { GoogleSignInButton } from '@/features/auth/GoogleSignInButton';
import { useAuth } from '@/hooks/useAuth';
import { useReveal } from '@/hooks/useReveal';
import { useRevealKeyboard } from '@/hooks/useRevealKeyboard';

const FEATURES = [
  {
    icon: Layers,
    title: 'Study by course and topic',
    description: 'Real past exam questions organized by course and topic, so you can focus on what you are currently learning.',
  },
  {
    icon: Target,
    title: 'Attempt before you look',
    description: 'Work the problem yourself, then progressively reveal hints, answers, and solutions.',
  },
  {
    icon: Bookmark,
    title: 'Bookmark & track mastery',
    description: 'Save tricky problems and mark what you have mastered to study what matters.',
  },
  {
    icon: ShieldCheck,
    title: 'Made for UP students',
    description: 'Sign in with your @up.edu.ph Google account and pick up where you left off.',
  },
];

const SAMPLE_QUESTION = {
  question: 'Compute $$\\lim_{x \\to 2}\\frac{x^2 - 4}{x - 2},$$ if it exists.',
  hint: 'Factor the numerator and cancel the common factor before taking the limit.',
  answer: '$$4$$',
  solution:
    'For $x \\neq 2$, $\\dfrac{x^2 - 4}{x - 2} = \\dfrac{(x - 2)(x + 2)}{x - 2} = x + 2$. A limit looks at values *near* $x = 2$, not at it, so\n\n$$\\lim_{x \\to 2}\\frac{x^2 - 4}{x - 2} = \\lim_{x \\to 2}(x + 2) = 4.$$',
};

export function LandingPage() {
  const { user, loading, authError, configured, signOut } = useAuth();
  const location = useLocation();
  const reveal = useReveal();
  useRevealKeyboard(reveal.reveal);

  if (user && !loading) {
    return <Navigate to="/dashboard" replace />;
  }

  const redirectNote = (location.state as { from?: string } | null)?.from;

  return (
    <div className="flex min-h-dvh flex-col">
      <header className="border-b border-stone-200 dark:border-stone-800">
        <div className="mx-auto flex h-16 w-full max-w-8xl items-center justify-between px-4 sm:px-6">
          <Logo size="sm" />
          <div className="flex items-center gap-3">
            <Link
              to="/blogs"
              className="inline-flex items-center gap-1.5 text-sm font-medium text-stone-600 transition-colors hover:text-stone-900 dark:text-stone-300 dark:hover:text-stone-50"
            >
              <PenLine className="size-3.5" />
              Blogs
            </Link>
            <ThemeToggle />
            {user ? (
              <Button variant="outline" size="sm" onClick={() => void signOut()}>
                Sign out
              </Button>
            ) : null}
          </div>
        </div>
      </header>

      <main className="mx-auto w-full max-w-5xl flex-1 px-4 py-12 sm:px-6 sm:py-20">
        <section className="grid items-center gap-12 lg:grid-cols-[1.15fr_1fr]">
          <div className="animate-slide-up text-center lg:text-left">
            <div className="mb-6 flex justify-center lg:justify-start">
              <Logo size="lg" />
            </div>
            <h1 className="font-serif text-4xl font-bold leading-tight tracking-tight text-stone-900 sm:text-5xl dark:text-stone-50">
              Review smarter. Solve better.
            </h1>
            <p className="mt-4 max-w-xl text-lg leading-relaxed text-stone-600 dark:text-stone-300">
              MatematIsko is the interactive mathematics exam-review platform for UP students.
              Browse exam questions, attempt them yourself, then reveal hints, answers, and full
              solutions — all rendered beautifully with real math notation.
            </p>

            <div className="mt-8 max-w-md">
              <div className="rounded-xl border border-stone-200 bg-white p-6 shadow-sm dark:border-stone-800 dark:bg-stone-900">
                <h2 className="mb-1 font-semibold text-stone-900 dark:text-stone-100">
                  Sign in to start studying
                </h2>
                <p className="mb-4 text-sm text-stone-500 dark:text-stone-400">
                  Only UP Google accounts ending in <strong>@up.edu.ph</strong> are allowed.
                </p>

                {authError ? (
                  <div
                    role="alert"
                    className="mb-4 flex gap-2 rounded-lg border border-amber-300 bg-amber-50 p-3 text-sm text-amber-900 dark:border-amber-800 dark:bg-amber-950/40 dark:text-amber-200"
                  >
                    <TriangleAlert className="mt-0.5 size-4 shrink-0" />
                    <span>{authError}</span>
                  </div>
                ) : null}

                {redirectNote ? (
                  <p className="mb-4 text-sm text-stone-500 dark:text-stone-400">
                    Please sign in to continue. Your progress syncs to your UP account.
                  </p>
                ) : null}

                {configured ? (
                  <>
                    <GoogleSignInButton
                      onError={(message) => {
                        reveal.reset();
                        window.alert(message);
                      }}
                    />
                    <div className="relative my-4">
                      <div className="absolute inset-0 flex items-center">
                        <div className="w-full border-t border-stone-200 dark:border-stone-700" />
                      </div>
                      <div className="relative flex justify-center text-xs">
                        <span className="bg-white px-2 text-stone-400 dark:bg-stone-900 dark:text-stone-500">
                          or
                        </span>
                      </div>
                    </div>
                    <EmailAuthForm />
                  </>
                ) : (
                  <div className="flex gap-2 rounded-lg border border-stone-200 bg-stone-50 p-3 text-sm text-stone-600 dark:border-stone-800 dark:bg-stone-900 dark:text-stone-300">
                    <Wrench className="mt-0.5 size-4 shrink-0" />
                    <p>
                      Supabase is not configured yet. Copy <code>.env.example</code> to{' '}
                      <code>.env</code> and add your <code>VITE_SUPABASE_URL</code> and{' '}
                      <code>VITE_SUPABASE_ANON_KEY</code>.
                    </p>
                  </div>
                )}
              </div>
            </div>
          </div>

          <div className="animate-slide-up [animation-delay:100ms]">
            <Card className="overflow-hidden">
              <CardHeader className="border-b border-stone-100 bg-stone-50/60 dark:border-stone-800 dark:bg-stone-950/40">
                <div className="flex items-center gap-2 text-xs font-medium uppercase tracking-widest text-stone-500 dark:text-stone-400">
                  <InfinityIcon className="size-4 text-brand-700 dark:text-brand-400" />
                  Try it now
                </div>
                <CardTitle className="font-serif text-lg">Sample problem</CardTitle>
                <CardDescription>Work it out, then reveal the solution.</CardDescription>
              </CardHeader>
              <CardContent className="space-y-5">
                <MathRenderer>{SAMPLE_QUESTION.question}</MathRenderer>
                <RevealSection
                  level={reveal.level}
                  onReveal={reveal.reveal}
                  onReset={reveal.reset}
                  hint={SAMPLE_QUESTION.hint}
                  answer={SAMPLE_QUESTION.answer}
                  solution={SAMPLE_QUESTION.solution}
                />
                <p className="text-xs text-stone-400 dark:text-stone-500">
                  Keyboard shortcuts: H = hint, A = answer, S = solution.
                </p>
              </CardContent>
            </Card>
          </div>
        </section>

        <section className="mt-20" aria-label="Features">
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            {FEATURES.map((feature, index) => (
              <Reveal key={feature.title} delay={index * 80} className="h-full">
                <Card className="h-full p-5 transition-all duration-200 hover:-translate-y-1 hover:shadow-md">
                  <feature.icon className="mb-3 size-6 text-brand-700 dark:text-brand-400" />
                  <h3 className="mb-1 font-semibold text-stone-900 dark:text-stone-100">
                    {feature.title}
                  </h3>
                  <p className="text-sm leading-relaxed text-stone-600 dark:text-stone-400">
                    {feature.description}
                  </p>
                </Card>
              </Reveal>
            ))}
          </div>
        </section>
      </main>

      <footer className="border-t border-stone-200 py-6 dark:border-stone-800">
        <div className="mx-auto flex w-full max-w-8xl items-center justify-between px-4 text-xs text-stone-500 sm:px-6 dark:text-stone-400">
          <span>MatematIsko — review smarter, solve better.</span>
          <span>For UP Diliman and UP students.</span>
        </div>
      </footer>
    </div>
  );
}
