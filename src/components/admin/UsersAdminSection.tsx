import { useCallback, useRef, useState } from 'react';
import { Pencil, Search, Users } from 'lucide-react';
import type { Profile } from '@/types';
import { useAsync } from '@/hooks/useAsync';
import { useAuth } from '@/hooks/useAuth';
import {
  adminGrantAccess,
  adminRevokeAccess,
  adminListProfiles,
  adminUpdateProfile,
  ADMIN_USERS_PAGE_SIZE,
  PROFILE_YEAR_LEVELS,
  profileDraft,
} from '@/lib/adminUsers';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Card, CardContent } from '@/components/ui/card';
import { Dialog, DialogContent, DialogTitle, DialogDescription } from '@/components/ui/dialog';
import { LoadingState } from '@/components/common/LoadingState';
import { ErrorState } from '@/components/common/ErrorState';
import { UserProgressDialog } from './UserProgressDialog';

export function UsersAdminSection() {
  const { user, refreshProfile } = useAuth();
  const [search, setSearch] = useState('');
  const [query, setQuery] = useState({ search: '', page: 0 });
  const [selected, setSelected] = useState<Profile | null>(null);
  const [progressTarget, setProgressTarget] = useState<Profile | null>(null);
  const [message, setMessage] = useState('');
  const [revokeTarget, setRevokeTarget] = useState<Profile | null>(null);
  const [grantTarget, setGrantTarget] = useState<Profile | null>(null);
  const fetchUsers = useCallback(() => adminListProfiles(query.search, query.page), [query]);
  const { data, loading, error, reload } = useAsync(fetchUsers);
  const saved = (profile: Profile) => {
    setSelected(null);
    setMessage('Profile updated.');
    reload();
    if (profile.id === user?.id)
      void refreshProfile().catch(() =>
        setMessage('Profile updated. Refresh the page to reload your own profile.'),
      );
  };
  return (
    <section className="space-y-5">
      <header>
        <h2 className="flex items-center gap-2 font-serif text-2xl font-semibold text-stone-900 dark:text-stone-50">
          <Users className="size-6" />
          App users
        </h2>
        <p className="mt-1 text-sm text-stone-500 dark:text-stone-400">
          Manage profiles, monitor selected courses and study progress, or reset progress.
        </p>
      </header>
      <form
        className="flex flex-wrap gap-2"
        onSubmit={(event) => {
          event.preventDefault();
          setQuery({ search: search.trim(), page: 0 });
          setMessage('');
        }}
      >
        <Input
          aria-label="Search users by name or email"
          placeholder="Search by name or email…"
          maxLength={200}
          value={search}
          onChange={(event) => setSearch(event.target.value)}
          className="min-w-0 flex-1"
        />
        <Button type="submit">
          <Search className="size-4" />
          Search
        </Button>
        <Button type="button" variant="outline" onClick={reload} disabled={loading}>
          Refresh
        </Button>
      </form>
      {message && (
        <p role="status" className="text-sm text-emerald-700 dark:text-emerald-300">
          {message}
        </p>
      )}
      {loading ? (
        <LoadingState label="Loading users" />
      ) : error ? (
        <ErrorState title="Could not load users" message={error.message} onRetry={reload} />
      ) : (
        <>
          <p className="text-sm text-stone-500 dark:text-stone-400">
            {data?.total ?? 0} matching users
            {data?.users.length
              ? ` · Showing ${query.page * ADMIN_USERS_PAGE_SIZE + 1}–${query.page * ADMIN_USERS_PAGE_SIZE + data.users.length}`
              : ''}
          </p>
          {!data?.users.length ? (
            <Card>
              <CardContent className="p-6 text-sm text-stone-500">
                No users found. Try a different name or email
                {query.page > 0 ? ', or return to the previous page' : ''}.
              </CardContent>
            </Card>
          ) : (
            <div className="grid gap-3 lg:grid-cols-2">
              {data.users.map((profile) => (
                <Card key={profile.id}>
                  <CardContent className="space-y-3 p-4">
                    <div className="flex items-start justify-between gap-3">
                      <div className="min-w-0">
                        <h3 className="break-words font-semibold text-stone-900 dark:text-stone-100">
                          {profile.full_name || 'Name not set'}
                        </h3>
                        <p className="break-all text-sm text-stone-500 dark:text-stone-400">
                          {profile.email}
                        </p>
                      </div>
                      <Button
                        variant="outline"
                        size="sm"
                        onClick={() => {
                          setSelected(profile);
                          setMessage('');
                        }}
                        aria-label={`Edit ${profile.full_name || profile.email}`}
                      >
                        <Pencil className="size-4" />
                        Edit
                      </Button>
                    </div>
                    <div className="flex flex-wrap items-center justify-between gap-2 border-t border-stone-200 pt-3 dark:border-stone-800">
                      <span className="text-sm font-medium">
                        {profile.is_super_admin
                          ? 'Super admin · protected'
                          : profile.is_admin
                            ? 'Administrator'
                            : 'Student'}
                      </span>
                      {data?.can_revoke_admin &&
                        profile.is_admin &&
                        !profile.is_super_admin &&
                        profile.id !== user?.id && (
                          <Button
                            variant="outline"
                            size="sm"
                            onClick={() => setRevokeTarget(profile)}
                          >
                            Remove admin access
                          </Button>
                        )}
                      {!profile.is_admin && profile.id !== user?.id && (
                        <Button variant="outline" size="sm" onClick={() => setGrantTarget(profile)}>
                          Grant admin access
                        </Button>
                      )}
                    </div>
                    <Button variant="outline" size="sm" onClick={() => setProgressTarget(profile)}>
                      View courses and progress
                    </Button>
                    <dl className="grid grid-cols-2 gap-x-4 gap-y-2 text-sm">
                      <div>
                        <dt className="text-stone-500">Degree program</dt>
                        <dd className="break-words text-stone-900 dark:text-stone-100">
                          {profile.degree_program || 'Not set'}
                        </dd>
                      </div>
                      <div>
                        <dt className="text-stone-500">Year level</dt>
                        <dd className="text-stone-900 dark:text-stone-100">
                          {profile.year_level || 'Not set'}
                        </dd>
                      </div>
                      <div>
                        <dt className="text-stone-500">UPMMC member</dt>
                        <dd className="text-stone-900 dark:text-stone-100">
                          {profile.upmmc_member ? 'Yes' : 'No'}
                          {profile.upmmc_verified ? ' · Verified' : ' · Not verified'}
                        </dd>
                      </div>
                      <div>
                        <dt className="text-stone-500">Joined</dt>
                        <dd className="text-stone-900 dark:text-stone-100">
                          {new Date(profile.created_at).toLocaleDateString()}
                        </dd>
                      </div>
                    </dl>
                  </CardContent>
                </Card>
              ))}
            </div>
          )}
          <nav
            aria-label="User directory pages"
            className="flex items-center justify-between gap-3"
          >
            <Button
              variant="outline"
              disabled={query.page === 0}
              onClick={() => setQuery({ ...query, page: query.page - 1 })}
            >
              Previous
            </Button>
            <span className="text-sm text-stone-500">Page {query.page + 1}</span>
            <Button
              variant="outline"
              disabled={(query.page + 1) * ADMIN_USERS_PAGE_SIZE >= (data?.total ?? 0)}
              onClick={() => setQuery({ ...query, page: query.page + 1 })}
            >
              Next
            </Button>
          </nav>
        </>
      )}
      {progressTarget && (
        <UserProgressDialog
          key={progressTarget.id}
          profile={progressTarget}
          onClose={() => setProgressTarget(null)}
        />
      )}
      {revokeTarget && (
        <GrantAdminDialog
          revoke
          profile={revokeTarget}
          onClose={() => setRevokeTarget(null)}
          onGranted={() => {
            setRevokeTarget(null);
            setMessage('Admin access removed. This user retains their student account.');
            reload();
          }}
        />
      )}
      {grantTarget && (
        <GrantAdminDialog
          profile={grantTarget}
          onClose={() => setGrantTarget(null)}
          onGranted={() => {
            setGrantTarget(null);
            setMessage(
              'Admin access granted. The user can refresh the app to access administration.',
            );
            reload();
          }}
        />
      )}
      {selected && (
        <ProfileEditor
          key={selected.id}
          profile={selected}
          onClose={() => setSelected(null)}
          onSaved={saved}
        />
      )}
    </section>
  );
}

export function ProfileEditor({
  profile,
  onClose,
  onSaved,
}: {
  profile: Profile;
  onClose: () => void;
  onSaved: (profile: Profile) => void;
}) {
  const [draft, setDraft] = useState(() => profileDraft(profile));
  const [saving, setSaving] = useState(false);
  const savingRef = useRef(false);
  const [error, setError] = useState<string | null>(null);
  const save = async (event: React.FormEvent) => {
    event.preventDefault();
    if (savingRef.current) return;
    savingRef.current = true;
    setSaving(true);
    setError(null);
    try {
      const updated = await adminUpdateProfile(profile, draft);
      onSaved(updated);
    } catch (failure) {
      setError(
        failure instanceof Error ? failure.message : 'Could not save the profile. Try again.',
      );
    } finally {
      savingRef.current = false;
      setSaving(false);
    }
  };
  return (
    <Dialog
      open
      onOpenChange={(open) => {
        if (!open && !savingRef.current) onClose();
      }}
    >
      <DialogContent className="p-6">
        <DialogTitle className="font-serif pr-8 text-xl font-semibold">
          Edit user profile
        </DialogTitle>
        <DialogDescription className="mt-1 break-all text-sm text-stone-500">
          {profile.email}
        </DialogDescription>
        <form
          onSubmit={(event) => void save(event)}
          className="mt-4 min-h-0 space-y-4 overflow-y-auto pr-1"
        >
          <fieldset disabled={saving} className="space-y-4">
            <label className="block text-sm font-medium">
              Full name
              <Input
                className="mt-1"
                maxLength={200}
                value={draft.full_name ?? ''}
                onChange={(event) => setDraft({ ...draft, full_name: event.target.value })}
              />
            </label>
            <label className="block text-sm font-medium">
              Degree program
              <Input
                className="mt-1"
                maxLength={200}
                value={draft.degree_program ?? ''}
                onChange={(event) => setDraft({ ...draft, degree_program: event.target.value })}
              />
            </label>
            <label className="block text-sm font-medium">
              Year level
              <select
                className="mt-1 block w-full rounded-lg border border-stone-300 bg-white p-2 text-stone-900 dark:border-stone-700 dark:bg-stone-950 dark:text-stone-100"
                value={draft.year_level ?? ''}
                onChange={(event) => setDraft({ ...draft, year_level: event.target.value || null })}
              >
                <option value="">Not set</option>
                {draft.year_level && !PROFILE_YEAR_LEVELS.includes(draft.year_level) && (
                  <option value={draft.year_level}>
                    {draft.year_level} (choose a supported year)
                  </option>
                )}
                {PROFILE_YEAR_LEVELS.map((year) => (
                  <option key={year}>{year}</option>
                ))}
              </select>
            </label>
            <label className="flex items-center gap-2 text-sm">
              <input
                type="checkbox"
                className="size-4 accent-brand-900"
                checked={draft.upmmc_member}
                onChange={(event) => setDraft({ ...draft, upmmc_member: event.target.checked })}
              />
              UPMMC member
            </label>
            <label className="flex items-center gap-2 text-sm">
              <input
                type="checkbox"
                className="size-4 accent-brand-900"
                checked={draft.upmmc_verified ?? false}
                onChange={(event) => setDraft({ ...draft, upmmc_verified: event.target.checked })}
              />
              Verified UPMMC member — allow complete solutions
            </label>
            <p className="text-xs text-stone-500 dark:text-stone-400">
              Verify only after confirming membership. Clearing verification removes access to
              restricted solutions. Math 20, 21, 22, 23 and STAT 101 remain available to all students.
            </p>
          </fieldset>
          <p className="text-xs text-stone-500 dark:text-stone-400">
            These changes update the app profile. Sign-in email and administrator access are managed
            separately.
          </p>
          {(!draft.degree_program?.trim() || !draft.year_level) && (
            <p className="text-sm text-amber-700 dark:text-amber-300">
              A missing degree program or year level will ask this user to complete onboarding again
              when their profile reloads.
            </p>
          )}
          {error && (
            <p role="alert" className="text-sm text-red-600 dark:text-red-400">
              {error}
            </p>
          )}
          <div className="flex justify-end gap-2">
            <Button type="button" variant="outline" disabled={saving} onClick={onClose}>
              Cancel
            </Button>
            <Button type="submit" disabled={saving}>
              {saving ? 'Saving…' : 'Save profile'}
            </Button>
          </div>
        </form>
      </DialogContent>
    </Dialog>
  );
}

export function GrantAdminDialog({
  revoke = false,
  profile,
  onClose,
  onGranted,
}: {
  profile: Profile;
  onClose: () => void;
  onGranted: () => void;
  revoke?: boolean;
}) {
  const [saving, setSaving] = useState(false);
  const busy = useRef(false);
  const [error, setError] = useState('');
  const grant = async () => {
    if (busy.current) return;
    busy.current = true;
    setSaving(true);
    setError('');
    try {
      if (revoke) await adminRevokeAccess(profile.id);
      else await adminGrantAccess(profile.id);
      onGranted();
    } catch (failure) {
      setError(
        failure instanceof Error ? failure.message : 'Could not change admin access. Try again.',
      );
    } finally {
      busy.current = false;
      setSaving(false);
    }
  };
  return (
    <Dialog
      open
      onOpenChange={(open) => {
        if (!open && !busy.current) onClose();
      }}
    >
      <DialogContent className="p-6">
        <DialogTitle className="pr-8 font-serif text-xl font-semibold">
          {revoke ? 'Remove admin access?' : 'Grant admin access?'}
        </DialogTitle>
        <DialogDescription className="mt-2 break-words text-sm text-stone-500">
          {profile.full_name || profile.email} ({profile.email}){' '}
          {revoke
            ? 'will lose access to administration. Their student account, bookmarks and study progress will remain.'
            : 'will be able to manage content, reports and user profiles, monitor and reset study progress, and grant admin access to others. Only the super admin can remove admin access.'}
        </DialogDescription>
        {error && (
          <p role="alert" className="mt-3 text-sm text-red-600 dark:text-red-400">
            {error}
          </p>
        )}
        <div className="mt-5 flex flex-wrap justify-end gap-2">
          <Button variant="outline" disabled={saving} onClick={onClose}>
            Cancel
          </Button>
          <Button disabled={saving} onClick={() => void grant()}>
            {saving ? 'Saving…' : revoke ? 'Confirm removal' : 'Confirm admin access'}
          </Button>
        </div>
      </DialogContent>
    </Dialog>
  );
}
