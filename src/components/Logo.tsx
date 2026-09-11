import { useId } from 'react';
import { cn } from '@/lib/cn';

interface LogoProps {
  size?: 'sm' | 'md' | 'lg';
  showWordmark?: boolean;
  className?: string;
}

const SIZES = {
  sm: { tile: 'size-8', text: 'text-lg' },
  md: { tile: 'size-10', text: 'text-2xl' },
  lg: { tile: 'size-14', text: 'text-3xl' },
} as const;

/**
 * Text/icon logo: an SVG tile with a font-independent contour integral plus the wordmark.
 * "Matemat" is set in stone, "Isko" in the UP-maroon brand color.
 */
export function Logo({ size = 'md', showWordmark = true, className }: LogoProps) {
  const s = SIZES[size];
  const gradientId = useId();

  return (
    <span className={cn('inline-flex items-center gap-2.5', className)}>
      <svg
        viewBox="0 0 40 40"
        role={showWordmark ? undefined : 'img'}
        aria-hidden={showWordmark || undefined}
        aria-label={showWordmark ? undefined : 'MatematIsko'}
        focusable="false"
        className={cn('shrink-0', s.tile)}
      >
        <defs>
          <linearGradient id={gradientId} x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#a02c2c" />
            <stop offset="100%" stopColor="#450b0c" />
          </linearGradient>
        </defs>
        <rect x="1" y="1" width="38" height="38" rx="10" fill={`url(#${gradientId})`} />
        <rect
          x="1.5"
          y="1.5"
          width="37"
          height="37"
          rx="9.5"
          fill="none"
          stroke="rgba(255,255,255,0.25)"
          strokeWidth="1"
        />
        <g fill="none" stroke="#fff" strokeLinecap="round">
          <circle cx="20" cy="20" r="5.25" strokeWidth="1.65" />
          <path d="M25 9C21 6 21 11 20 20S19 34 15 31" strokeWidth="2.5" />
        </g>
      </svg>
      {showWordmark ? (
        <span className={cn('font-serif font-bold leading-none tracking-tight', s.text)}>
          <span className="text-stone-900 dark:text-stone-100">Matemat</span>
          <span className="text-brand-800 dark:text-brand-400">Isko</span>
        </span>
      ) : null}
    </span>
  );
}
