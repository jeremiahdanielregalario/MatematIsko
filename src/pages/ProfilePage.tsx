import { BookOpenText, GraduationCap, LogOut, ShieldCheck, UserRound } from 'lucide-react';
import { useCallback } from 'react';
import { useNavigate } from 'react-router-dom';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { useAuth } from '@/hooks/useAuth';
import { useAsync } from '@/hooks/useAsync';
import { getUserCourses } from '@/lib/db';

function InfoRow({
  label,
  value,
  icon,
}: {
  label: string;
  value: string;
  icon?: React.ReactNode;
}) {
  return (
    <div className="flex items-center justify-between gap-4 py-2.5">
      <span className="flex items-center gap-2 text-sm text-stone-500 dark:text-stone-400">
        {icon}
        {label}
      </span>
      <span className="text-sm font-medium text-stone-900 dark:text-stone-100">{value}</span>
    </div>
  );
}

export function ProfilePage() {
  const { user, profile, signOut } = useAuth();
  const navigate = useNavigate();
  const fetchCourses = useCallback(() => (user ? getUserCourses(user.id) : Promise.resolve([])), [user]);
  const { data: courses, loading: coursesLoading } = useAsync(fetchCourses);

  if (!user) return null;

  const displayName = profile?.full_name ?? user.user_metadata?.full_name ?? user.email ?? 'Student';
  const avatarUrl = profile?.avatar_url ?? user.user_metadata?.avatar_url;
  const firstName = displayName.split(/\s+/)[0] ?? 'Student';

  const handleSignOut = async () => {
    await signOut();
    navigate('/');
  };

  const infoRows = [
    { label: 'Degree program', value: profile?.degree_program ?? 'Not set', icon: <GraduationCap className="size-4" /> },
    { label: 'Year level', value: profile?.year_level ?? 'Not set', icon: <UserRound className="size-4" /> },
    {
      label: 'UPMMC member',
      value: profile?.upmmc_member ? 'Yes' : 'No',
      icon: <ShieldCheck className="size-4" />,
    },
  ];

  return (
    <div className="mx-auto max-w-2xl space-y-6">
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

      <Card>
        <CardHeader>
          <CardTitle className="text-xl">Your track</CardTitle>
          <CardDescription>
            Information you shared when you first signed in, {firstName}.
          </CardDescription>
        </CardHeader>
        <CardContent className="divide-y divide-stone-100 dark:divide-stone-800">
          {infoRows.map((row) => (
            <InfoRow key={row.label} label={row.label} value={row.value} icon={row.icon} />
          ))}
        </CardContent>
      </Card>

      <Card>
        <CardHeader className="flex-row items-center justify-between gap-4">
          <div>
            <CardTitle className="text-xl">Courses you're studying</CardTitle>
            <CardDescription>The math courses you picked to focus on.</CardDescription>
          </div>
          <BookOpenText className="size-5 text-stone-400" />
        </CardHeader>
        <CardContent>
          {coursesLoading ? (
            <p className="py-2 text-sm text-stone-400 dark:text-stone-500">Loading courses&hellip;</p>
          ) : courses && courses.length > 0 ? (
            <ul className="space-y-2">
              {courses.map((course) => (
                <li key={course.id} className="flex items-center justify-between gap-3">
                  <span className="font-medium text-stone-900 dark:text-stone-100">{course.code}</span>
                  <span className="text-sm text-stone-500 dark:text-stone-400">{course.name}</span>
                </li>
              ))}
            </ul>
          ) : (
            <p className="py-2 text-sm text-stone-400 dark:text-stone-500">
              No courses selected yet.
            </p>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
