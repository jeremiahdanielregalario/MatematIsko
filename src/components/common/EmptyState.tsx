import { cn } from '@/lib/cn';

interface EmptyStateProps {
  icon?: React.ReactNode;
  title: string;
  description?: string;
  action?: React.ReactNode;
  className?: string;
}

export function EmptyState({ icon, title, description, action, className }: EmptyStateProps) {
  return (
    <div
      className={cn(
        'flex flex-col items-center justify-center gap-3 rounded-xl border border-dashed border-stone-300 bg-stone-50 px-6 py-16 text-center dark:border-stone-700 dark:bg-stone-900',
        className,
      )}
    >
      {icon ? <div className="text-stone-400 dark:text-stone-500">{icon}</div> : null}
      <h3 className="font-semibold text-stone-900 dark:text-stone-100">{title}</h3>
      {description ? (
        <p className="max-w-md text-sm text-stone-500 dark:text-stone-400">{description}</p>
      ) : null}
      {action ? <div className="mt-2">{action}</div> : null}
    </div>
  );
}
