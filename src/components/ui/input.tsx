import { forwardRef } from 'react';
import { cn } from '@/lib/cn';

export type InputProps = React.InputHTMLAttributes<HTMLInputElement>;

const Input = forwardRef<HTMLInputElement, InputProps>(({ className, type, ...props }, ref) => (
  <input
    type={type}
    ref={ref}
    className={cn(
      'flex h-10 w-full rounded-lg border border-stone-300 bg-white px-3 py-2 text-sm text-stone-900 shadow-sm transition-colors',
      'placeholder:text-stone-400',
      'focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
      'disabled:cursor-not-allowed disabled:opacity-50',
      'dark:border-stone-700 dark:bg-stone-950 dark:text-stone-100 dark:placeholder:text-stone-500',
      className,
    )}
    {...props}
  />
));
Input.displayName = 'Input';

export { Input };
