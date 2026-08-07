import { LogOut, Shield, UserRound } from 'lucide-react';
import { Link, useNavigate } from 'react-router-dom';
import { useAuth } from '@/hooks/useAuth';
import { isAdminEmail } from '@/lib/auth';
import { cn } from '@/lib/cn';
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuLabel,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from '@/components/ui/dropdown-menu';

function initials(name: string | null | undefined): string {
  if (!name) return '?';
  return name
    .split(/\s+/)
    .filter(Boolean)
    .slice(0, 2)
    .map((part) => part[0])
    .join('')
    .toUpperCase();
}

export function UserMenu() {
  const { user, profile, signOut } = useAuth();
  const navigate = useNavigate();

  if (!user) return null;

  const displayName = profile?.full_name ?? user.user_metadata?.full_name ?? user.email ?? 'Student';
  const avatarUrl = profile?.avatar_url ?? user.user_metadata?.avatar_url;

  const handleSignOut = async () => {
    await signOut();
    navigate('/');
  };

  return (
    <DropdownMenu>
      <DropdownMenuTrigger
        className={cn(
          'flex size-9 items-center justify-center overflow-hidden rounded-full bg-brand-900 text-sm font-semibold text-brand-50',
          'transition-opacity hover:opacity-90 focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
          'dark:bg-brand-800 dark:text-brand-50',
        )}
        aria-label="Account menu"
      >
        {avatarUrl ? (
          <img src={avatarUrl} alt="" className="size-full object-cover" />
        ) : (
          <span>{initials(displayName)}</span>
        )}
      </DropdownMenuTrigger>
      <DropdownMenuContent align="end">
        <DropdownMenuLabel>
          <span className="block max-w-[200px] truncate">{displayName}</span>
          <span className="block truncate text-xs font-normal text-stone-500 dark:text-stone-400">
            {user.email}
          </span>
        </DropdownMenuLabel>
        <DropdownMenuSeparator />
        <DropdownMenuItem asChild>
          <Link to="/profile">
            <UserRound className="size-4" />
            Profile
          </Link>
        </DropdownMenuItem>
        {isAdminEmail(user.email) ? (
          <DropdownMenuItem asChild>
            <Link to="/admin">
              <Shield className="size-4" />
              Admin
            </Link>
          </DropdownMenuItem>
        ) : null}
        <DropdownMenuItem
          className="text-red-700 focus:text-red-800 dark:text-red-400 dark:focus:text-red-300"
          onSelect={() => void handleSignOut()}
        >
          <LogOut className="size-4" />
          Sign out
        </DropdownMenuItem>
      </DropdownMenuContent>
    </DropdownMenu>
  );
}
