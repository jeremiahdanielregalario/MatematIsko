import { Loader2 } from 'lucide-react';

interface LoadingStateProps {
  label?: string;
}

export function LoadingState({ label = 'Loading' }: LoadingStateProps) {
  return (
    <div
      role="status"
      aria-live="polite"
      className="flex flex-col items-center justify-center gap-3 py-20 text-stone-500 dark:text-stone-400"
    >
      <Loader2 className="size-8 animate-spin text-brand-700 dark:text-brand-400" />
      <p className="text-sm">{label}&hellip;</p>
    </div>
  );
}

export function SkeletonState({ label }: LoadingStateProps) {
  return (
    <div className="py-20">
      <LoadingState label={label} />
    </div>
  );
}
