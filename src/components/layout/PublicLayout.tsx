import { Link, Outlet } from 'react-router-dom';
import { Logo } from '@/components/Logo';
import { ThemeToggle } from './ThemeToggle';

export function PublicLayout() {
  return (
    <div className="flex min-h-dvh flex-col">
      <header className="sticky top-0 z-40 border-b border-stone-200 bg-white/80 backdrop-blur dark:border-stone-800 dark:bg-stone-950/80">
        <div className="mx-auto flex h-16 w-full max-w-8xl items-center justify-between px-4 sm:px-6">
          <Link to="/" aria-label="MatematIsko home" className="rounded">
            <Logo size="sm" />
          </Link>
          <div className="flex items-center gap-1.5">
            <ThemeToggle />
          </div>
        </div>
      </header>

      <main className="mx-auto w-full max-w-5xl flex-1 px-4 py-8 sm:px-6 sm:py-12">
        <div className="animate-page-in">
          <Outlet />
        </div>
      </main>

      <footer className="hidden border-t border-stone-200 py-6 dark:border-stone-800 md:block">
        <div className="mx-auto flex w-full max-w-8xl flex-col items-center gap-1 px-4 text-center text-xs text-stone-500 dark:text-stone-400 sm:px-6">
          <span className="inline-flex items-center gap-1.5 font-medium">
            MatematIsko
          </span>
          <p>Review smarter. Solve better.</p>
        </div>
      </footer>
    </div>
  );
}
