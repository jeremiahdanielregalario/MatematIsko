import { LogOut, ShieldCheck } from 'lucide-react';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/hooks/useAuth';

export function ProfilePage() {
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
    <div className="mx-auto max-w-xl space-y-6">
      <h1 className="font-serif text-3xl font-bold tracking-tight text-stone-900 dark:text-stone-50">
        Profile
      </h1>

      <Card>
        <CardHeader className="flex-row items-center gap-4">
          <div className="grid size-16 shrink-0 place-items-center overflow-hidden rounded-full bg-brand-900 text-lg font-bold text-brand-50 dark:bg-brand-800">
            {avatarUrl ? (
              <img src={avatarUrl} alt="" className="size-full object-cover" />
            ) : (
              displayName.charAt(0).toUpperCase()
            )}
          </div>
          <div>
            <CardTitle className="text-xl">{displayName}</CardTitle>
            <CardDescription>{user.email}</CardDescription>
          </div>
        </CardHeader>
        <CardContent className="space-y-4">
          <div className="flex items-start gap-2 rounded-lg border border-emerald-200 bg-emerald-50 p-3 text-sm text-emerald-900 dark:border-emerald-900/60 dark:bg-emerald-950/30 dark:text-emerald-200">
            <ShieldCheck className="mt-0.5 size-4 shrink-0" />
            <p>
              You are signed in with a verified <strong>@up.edu.ph</strong> account, so your
              bookmarks and progress sync to this profile.
            </p>
          </div>
          <Button variant="outline" className="w-full" onClick={() => void handleSignOut()}>
            <LogOut className="size-4" />
            Sign out
          </Button>
        </CardContent>
      </Card>
    </div>
  );
}
