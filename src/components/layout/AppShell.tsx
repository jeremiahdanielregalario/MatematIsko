import {
  Bookmark,
  BookMarked,
  BookOpenText,
  Home,
  LayoutDashboard,
  LineChart,
  Target,
} from 'lucide-react';
import { Link, NavLink, Outlet, useLocation } from 'react-router-dom';
import { useAuth } from '@/hooks/useAuth';
import { cn } from '@/lib/cn';
import { Logo } from '@/components/Logo';
import { ThemeToggle } from './ThemeToggle';
import { UserMenu } from './UserMenu';

const NAV_ITEMS = [
  { to: '/dashboard', label: 'Dashboard', icon: LayoutDashboard },
  { to: '/questions', label: 'Questions', icon: BookOpenText },
  { to: '/theorems', label: 'Theorems', icon: BookMarked },
  { to: '/practice', label: 'Practice', icon: Target },
  { to: '/bookmarks', label: 'Bookmarks', icon: Bookmark },
  { to: '/progress', label: 'Progress', icon: LineChart },
];

function navLinkClass({ isActive }: { isActive: boolean }) {
  return cn(
    'rounded-lg px-3 py-1.5 text-sm font-medium transition-colors',
    'focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
    isActive
      ? 'bg-brand-900 text-brand-50 dark:bg-brand-800 dark:text-brand-50'
      : 'text-stone-600 hover:bg-stone-100 hover:text-stone-900 dark:text-stone-300 dark:hover:bg-stone-800 dark:hover:text-stone-100',
  );
}

export function AppShell() {
  const { user, loading } = useAuth();
  const location = useLocation();

  return (
    <div className="flex min-h-dvh flex-col">
      <header className="sticky top-0 z-40 border-b border-stone-200 bg-white/80 backdrop-blur dark:border-stone-800 dark:bg-stone-950/80">
        <div className="mx-auto flex h-16 w-full max-w-8xl items-center justify-between gap-3 px-4 sm:px-6">
          <Link to={user ? '/dashboard' : '/'} aria-label="MatematIsko home" className="rounded">
            <Logo size="sm" />
          </Link>

          {user ? (
            <nav aria-label="Primary" className="hidden items-center gap-1 md:flex">
              {NAV_ITEMS.map(({ to, label, icon: Icon }) => (
                <NavLink key={to} to={to} className={navLinkClass}>
                  <span className="inline-flex items-center gap-1.5">
                    <Icon className="size-4" />
                    {label}
                  </span>
                </NavLink>
              ))}
            </nav>
          ) : null}

          <div className="flex items-center gap-1.5">
            <ThemeToggle />
            {user ? <UserMenu /> : <Link to="/" className="sr-only md:hidden" />}
          </div>
        </div>
      </header>

      <main className="mx-auto w-full max-w-8xl flex-1 px-4 pb-24 pt-8 sm:px-6 md:pb-12">
        {loading ? (
          <div className="flex h-64 items-center justify-center text-sm text-stone-400">
            Loading&hellip;
          </div>
        ) : (
          <Outlet />
        )}
      </main>

      <footer className="border-t border-stone-200 py-6 dark:border-stone-800">
        <div className="mx-auto flex w-full max-w-8xl flex-col items-center gap-1 px-4 text-center text-xs text-stone-500 dark:text-stone-400 sm:px-6">
          <span className="inline-flex items-center gap-1.5 font-medium">
            <Home className="size-3.5" />
            MatematIsko
          </span>
          <p>Review smarter. Solve better.</p>
        </div>
      </footer>

      {user ? (
        <nav
          aria-label="Mobile"
          className="fixed inset-x-0 bottom-0 z-40 border-t border-stone-200 bg-white/95 pb-[env(safe-area-inset-bottom)] backdrop-blur dark:border-stone-800 dark:bg-stone-950/95 md:hidden"
        >
          <div className="mx-auto flex h-16 max-w-lg items-stretch justify-around">
            {NAV_ITEMS.map(({ to, label, icon: Icon }) => {
              const active = location.pathname === to;
              return (
                <NavLink
                  key={to}
                  to={to}
                  aria-label={label}
                  aria-current={active ? 'page' : undefined}
                  className={cn(
                    'flex flex-1 flex-col items-center justify-center gap-0.5 text-[10px] font-medium',
                    'focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
                    active
                      ? 'text-brand-900 dark:text-brand-300'
                      : 'text-stone-500 dark:text-stone-400',
                  )}
                >
                  <Icon className="size-5" />
                  {label}
                </NavLink>
              );
            })}
          </div>
        </nav>
      ) : null}
    </div>
  );
}
