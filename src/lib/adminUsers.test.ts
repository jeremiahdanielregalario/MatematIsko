import { beforeEach, describe, expect, it, vi } from 'vitest';
const { rpc } = vi.hoisted(() => ({ rpc: vi.fn() }));
vi.mock('./supabase', () => ({ supabase: { rpc }, isSupabaseConfigured: true }));
import { adminListProfiles, adminUpdateProfile, profileDraft } from './adminUsers';
import type { Profile } from '@/types';
const original = {
  id: 'u',
  email: 'student@example.test',
  full_name: 'Student',
  degree_program: 'BS Mathematics',
  year_level: '1st Year',
  upmmc_member: false,
} as Profile;
beforeEach(() => rpc.mockReset());
describe('admin profile requests', () => {
  it('uses bounded server pagination and trimmed search', async () => {
    rpc.mockResolvedValue({ data: { users: [original], total: 60 }, error: null });
    expect(await adminListProfiles(' Student ', 2)).toEqual({ users: [original], total: 60 });
    expect(rpc).toHaveBeenCalledWith('admin_list_profiles', {
      p_search: 'Student',
      p_offset: 50,
      p_limit: 25,
    });
  });
  it('sends only editable fields and the original snapshot', async () => {
    rpc.mockResolvedValue({ data: original, error: null });
    await adminUpdateProfile(original, {
      ...profileDraft(original),
      full_name: ' Updated ',
      degree_program: ' ',
    });
    expect(rpc).toHaveBeenCalledWith('admin_update_profile', {
      p_id: 'u',
      p_full_name: 'Updated',
      p_degree_program: null,
      p_year_level: '1st Year',
      p_upmmc_member: false,
      p_expected: profileDraft(original),
    });
  });
  it('propagates authorization and conflict failures', async () => {
    rpc.mockResolvedValue({ data: null, error: { message: 'Only administrators can view users' } });
    await expect(adminListProfiles('', 0)).rejects.toThrow('Only administrators');
    rpc.mockResolvedValue({ data: null, error: { message: 'This profile changed' } });
    await expect(adminUpdateProfile(original, profileDraft(original))).rejects.toThrow(
      'profile changed',
    );
  });
  it('rejects malformed directory and missing update results', async () => {
    rpc.mockResolvedValue({ data: null, error: null });
    await expect(adminListProfiles('', 0)).rejects.toThrow('directory');
    await expect(adminUpdateProfile(original, profileDraft(original))).rejects.toThrow(
      'No updated profile',
    );
  });
});
