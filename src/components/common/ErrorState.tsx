import { AlertTriangle, RefreshCw } from 'lucide-react';
import { Button } from '@/components/ui/button';

interface ErrorStateProps {
  title?: string;
  message?: string;
  onRetry?: () => void;
}

export function ErrorState({
  title = 'Something went wrong',
  message = 'We could not load this content. Please try again.',
  onRetry,
}: ErrorStateProps) {
  return (
    <div
      role="alert"
      className="flex flex-col items-center justify-center gap-3 rounded-xl border border-dashed border-stone-300 bg-stone-50 px-6 py-16 text-center dark:border-stone-700 dark:bg-stone-900"
    >
      <AlertTriangle className="size-8 text-amber-600 dark:text-amber-400" />
      <h3 className="font-semibold text-stone-900 dark:text-stone-100">{title}</h3>
      <p className="max-w-md text-sm text-stone-500 dark:text-stone-400">{message}</p>
      {onRetry ? (
        <Button variant="outline" size="sm" onClick={onRetry}>
          <RefreshCw className="size-4" />
          Try again
        </Button>
      ) : null}
    </div>
  );
}
