import { Compass } from 'lucide-react';
import { Link } from 'react-router-dom';
import { Button } from '@/components/ui/button';

export function NotFoundPage() {
  return (
    <div className="flex min-h-dvh flex-col items-center justify-center gap-4 px-4 text-center">
      <div className="grid size-16 place-items-center rounded-full bg-brand-900 text-brand-50 dark:bg-brand-800">
        <Compass className="size-8" />
      </div>
      <h1 className="font-serif text-3xl font-bold text-stone-900 dark:text-stone-50">
        Page not found
      </h1>
      <p className="max-w-md text-sm text-stone-500 dark:text-stone-400">
        This page drifted out of the domain. Head back to the landing page or your courses.
      </p>
      <Button asChild>
        <Link to="/">Go home</Link>
      </Button>
    </div>
  );
}
