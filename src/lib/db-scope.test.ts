import { describe, expect, it, vi } from 'vitest';
const { from } = vi.hoisted(() => ({ from: vi.fn() }));
vi.mock('./supabase', () => ({ isSupabaseConfigured: true, supabase: { from } }));
import { getQuestionsWithRelations, getQuestionById, getTheorems, getTheoremById } from './db';

describe('empty selected course scope', () => {
  it('returns no questions or theorems without issuing unrestricted queries', async () => {
    expect(await getQuestionsWithRelations([])).toEqual([]);
    expect(await getTheorems([])).toEqual([]);
    expect(await getQuestionById('question', [])).toBeNull();
    expect(await getTheoremById('theorem', [])).toBeNull();
    expect(from).not.toHaveBeenCalled();
  });
});
