import { supabase, isSupabaseConfigured } from './supabase';
import type { Profile } from '@/types';

export type AdminProfileDraft = Pick<
  Profile,
  'full_name' | 'degree_program' | 'year_level' | 'upmmc_member'
>;
export type AdminUser = Profile & { is_admin?: boolean; is_super_admin?: boolean };
export interface AdminUsersPage {
  users: AdminUser[];
  total: number;
  can_revoke_admin?: boolean;
}
export const ADMIN_USERS_PAGE_SIZE = 25;
export const PROFILE_YEAR_LEVELS = [
  '1st Year',
  '2nd Year',
  '3rd Year',
  '4th Year',
  '5th Year or more',
];

export function profileDraft(profile: AdminProfileDraft): AdminProfileDraft {
  return {
    full_name: profile.full_name,
    degree_program: profile.degree_program,
    year_level: profile.year_level,
    upmmc_member: profile.upmmc_member,
  };
}

export async function adminListProfiles(search: string, page: number): Promise<AdminUsersPage> {
  if (!isSupabaseConfigured || !supabase) throw new Error('Supabase is not configured.');
  const { data, error } = await supabase.rpc('admin_list_profiles', {
    p_search: search.trim(),
    p_offset: page * ADMIN_USERS_PAGE_SIZE,
    p_limit: ADMIN_USERS_PAGE_SIZE,
  });
  if (error) throw new Error(error.message);
  if (!data || !Array.isArray(data.users) || typeof data.total !== 'number')
    throw new Error('Could not read the user directory.');
  return data as AdminUsersPage;
}

export async function adminUpdateProfile(
  original: Profile,
  draft: AdminProfileDraft,
): Promise<Profile> {
  if (!isSupabaseConfigured || !supabase) throw new Error('Supabase is not configured.');
  const { data, error } = await supabase.rpc('admin_update_profile', {
    p_id: original.id,
    p_full_name: draft.full_name?.trim() || null,
    p_degree_program: draft.degree_program?.trim() || null,
    p_year_level: draft.year_level || null,
    p_upmmc_member: draft.upmmc_member,
    p_expected: profileDraft(original),
  });
  if (error) throw new Error(error.message);
  if (!data) throw new Error('No updated profile was returned. Please refresh the directory.');
  return data as Profile;
}

export async function adminGrantAccess(userId: string): Promise<void> {
  if (!isSupabaseConfigured || !supabase) throw new Error('Supabase is not configured.');
  const { error } = await supabase.rpc('admin_grant_access', { p_user_id: userId });
  if (error) throw new Error(error.message);
}

export async function adminRevokeAccess(userId: string): Promise<void> {
  if (!isSupabaseConfigured || !supabase) throw new Error('Supabase is not configured.');
  const { error } = await supabase.rpc('admin_revoke_access', { p_user_id: userId });
  if (error) throw new Error(error.message);
}
