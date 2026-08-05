import { Bookmark } from 'lucide-react';
import { Button, type ButtonProps } from '@/components/ui/button';
import { cn } from '@/lib/cn';

interface BookmarkButtonProps extends Omit<ButtonProps, 'onClick'> {
  bookmarked: boolean;
  onToggleBookmark: (bookmarked: boolean) => void;
}

export function BookmarkButton({
  bookmarked,
  onToggleBookmark,
  className,
  ...props
}: BookmarkButtonProps) {
  return (
    <Button
      type="button"
      variant="ghost"
      size="icon-sm"
      className={cn('shrink-0', className)}
      aria-pressed={bookmarked}
      aria-label={bookmarked ? 'Remove bookmark' : 'Bookmark question'}
      title={bookmarked ? 'Remove bookmark' : 'Bookmark for later'}
      onClick={(event) => {
        event.preventDefault();
        event.stopPropagation();
        onToggleBookmark(!bookmarked);
      }}
      {...props}
    >
      <Bookmark
        className={cn(
          'size-4',
          bookmarked && 'fill-brand-600 text-brand-600 dark:fill-brand-400 dark:text-brand-400',
        )}
      />
    </Button>
  );
}
