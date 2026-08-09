import { useEffect, useState } from 'react';
import { cn } from '@/lib/cn';

interface ProgressBarProps {
  /** Percent value from 0-100. */
  value: number;
  /** Class applied to the track element. */
  className?: string;
  /** Class applied to the fill element. */
  barClassName?: string;
  /** Accessible label for the progress bar. */
  label?: string;
}

/**
 * A progress bar that animates from 0 to `value` when it mounts. Respects
 * `prefers-reduced-motion` by jumping straight to the final value.
 */
export function ProgressBar({ value, className, barClassName, label }: ProgressBarProps) {
  const [width, setWidth] = useState(0);

  useEffect(() => {
    const prefersReduced =
      typeof window.matchMedia === 'function' &&
      window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    if (prefersReduced) {
      setWidth(value);
      return;
    }

    const frame = requestAnimationFrame(() => setWidth(value));
    return () => cancelAnimationFrame(frame);
  }, [value]);

  const clamped = Math.max(0, Math.min(100, width));

  return (
    <div
      className={cn('h-1.5 w-full overflow-hidden rounded-full bg-stone-200 dark:bg-stone-800', className)}
      role="progressbar"
      aria-valuemin={0}
      aria-valuemax={100}
      aria-valuenow={value}
      aria-label={label}
    >
      <div
        className={cn(
          'h-full rounded-full bg-brand-700 transition-[width] duration-700 ease-out dark:bg-brand-400',
          barClassName,
        )}
        style={{ width: `${clamped}%` }}
      />
    </div>
  );
}
