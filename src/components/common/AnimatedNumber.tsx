import { useEffect, useRef, useState } from 'react';

interface AnimatedNumberProps {
  value: number;
  /** Animation duration in milliseconds. */
  duration?: number;
  /** Optional formatter for the rendered value (e.g. to add a '%'). */
  format?: (value: number) => string;
  className?: string;
}

function easeOutCubic(t: number): number {
  return 1 - Math.pow(1 - t, 3);
}

/**
 * Counts up to `value` on mount using requestAnimationFrame. Respects
 * `prefers-reduced-motion` by snapping straight to the final value.
 */
export function AnimatedNumber({
  value,
  duration = 700,
  format = (v) => v.toLocaleString(),
  className,
}: AnimatedNumberProps) {
  const [display, setDisplay] = useState(0);
  const frameRef = useRef<number>(0);

  useEffect(() => {
    const prefersReduced =
      typeof window.matchMedia === 'function' &&
      window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    if (prefersReduced) {
      setDisplay(value);
      return;
    }

    const start = performance.now();
    const from = 0;

    const tick = (now: number) => {
      const elapsed = Math.min(1, (now - start) / duration);
      const next = from + (value - from) * easeOutCubic(elapsed);
      setDisplay(Math.round(next));
      if (elapsed < 1) {
        frameRef.current = requestAnimationFrame(tick);
      }
    };

    frameRef.current = requestAnimationFrame(tick);
    return () => cancelAnimationFrame(frameRef.current);
  }, [value, duration]);

  return <span className={className}>{format(display)}</span>;
}
