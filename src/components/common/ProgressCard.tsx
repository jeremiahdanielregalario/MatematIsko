import { cn } from '@/lib/cn';
import { Card } from '@/components/ui/card';
import { AnimatedNumber } from './AnimatedNumber';

interface ProgressCardProps {
  label: string;
  value: number | string;
  icon?: React.ReactNode;
  hint?: string;
  className?: string;
}

export function ProgressCard({ label, value, icon, hint, className }: ProgressCardProps) {
  return (
    <Card className={cn('flex flex-col gap-2 p-5 transition-all duration-200 hover:-translate-y-0.5 hover:shadow-md', className)}>
      <div className="flex items-center gap-2 text-sm font-medium text-stone-500 dark:text-stone-400">
        {icon}
        <span>{label}</span>
      </div>
      <div className="text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-100">
        {typeof value === 'number' ? <AnimatedNumber value={value} /> : value}
      </div>
      {hint ? <p className="text-xs text-stone-500 dark:text-stone-400">{hint}</p> : null}
    </Card>
  );
}
