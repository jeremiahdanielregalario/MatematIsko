import { cn } from '@/lib/cn';

interface LogoProps {
  size?: 'sm' | 'md' | 'lg';
  showWordmark?: boolean;
  className?: string;
}

const SIZES = {
  sm: { tile: 'size-8', glyph: 15, text: 'text-lg' },
  md: { tile: 'size-10', glyph: 19, text: 'text-2xl' },
  lg: { tile: 'size-14', glyph: 27, text: 'text-3xl' },
} as const;

/**
 * Text/icon logo: an SVG tile with an integral glyph plus the wordmark.
 * "Matemat" is set in stone, "Isko" in the UP-maroon brand color.
 */
export function Logo({ size = 'md', showWordmark = true, className }: LogoProps) {
  const s = SIZES[size];

  return (
    <span className={cn('inline-flex items-center gap-2.5', className)}>
      <svg
        width={s.tile}
        height={s.tile}
        viewBox="0 0 40 40"
        role="img"
        aria-label="MatematIsko"
        className={cn('shrink-0', s.tile)}
      >
        <defs>
          <linearGradient id="logo-grad" x1="0" y1="0" x2="1" y2="1">
            <stop offset="0%" stopColor="#a02c2c" />
            <stop offset="100%" stopColor="#450b0c" />
          </linearGradient>
        </defs>
        <rect x="1" y="1" width="38" height="38" rx="10" fill="url(#logo-grad)" />
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
        <text
          x="20"
          y="27.5"
          textAnchor="middle"
          fontFamily="'Source Serif 4', Georgia, serif"
          fontWeight="600"
          fontSize={s.glyph}
          fill="#ffffff"
        >
          ∮
        </text>
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
