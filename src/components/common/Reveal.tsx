import { useEffect, useRef, useState, type ElementType, type ReactNode } from 'react';
import { cn } from '@/lib/cn';

interface RevealProps {
  children: ReactNode;
  /** Extra class applied to the wrapper element. */
  className?: string;
  /** Delay before the reveal starts, in milliseconds. */
  delay?: number;
  /** Direction the element travels from. */
  from?: 'up' | 'down' | 'left' | 'right' | 'none';
  /** Render as a different element (e.g. 'li', 'section'). */
  as?: ElementType;
}

const HIDDEN_TRANSFORM: Record<NonNullable<RevealProps['from']>, string> = {
  up: 'translateY(20px)',
  down: 'translateY(-20px)',
  left: 'translateX(20px)',
  right: 'translateX(-20px)',
  none: 'none',
};

/**
 * Fades and slides its children into view the first time they scroll into
 * the viewport. Respects `prefers-reduced-motion` (renders visible instantly).
 */
export function Reveal({
  children,
  className,
  delay = 0,
  from = 'up',
  as: Tag = 'div',
}: RevealProps) {
  const ref = useRef<HTMLElement | null>(null);
  const [visible, setVisible] = useState(false);

  useEffect(() => {
    const node = ref.current;
    if (!node) return;

    const prefersReduced =
      typeof window.matchMedia === 'function' &&
      window.matchMedia('(prefers-reduced-motion: reduce)').matches;

    if (prefersReduced || typeof IntersectionObserver === 'undefined') {
      setVisible(true);
      return;
    }

    const observer = new IntersectionObserver(
      (entries) => {
        for (const entry of entries) {
          if (entry.isIntersecting) {
            setVisible(true);
            observer.disconnect();
          }
        }
      },
      { threshold: 0.1, rootMargin: '0px 0px -40px 0px' },
    );
    observer.observe(node);
    return () => observer.disconnect();
  }, []);

  return (
    <Tag
      ref={ref as React.Ref<HTMLElement>}
      className={cn(
        'transition-[opacity,transform] duration-500 ease-out',
        visible && 'opacity-100',
        !visible && 'opacity-0',
        className,
      )}
      style={{
        transform: visible ? 'none' : HIDDEN_TRANSFORM[from],
        transitionDelay: `${delay}ms`,
        willChange: visible ? undefined : 'opacity, transform',
      }}
    >
      {children}
    </Tag>
  );
}
