import { beforeEach, describe, expect, it, vi } from 'vitest';
import { STUDY_PROMPT_IDLE_MS } from './constants';
import {
  clearStudyActivity,
  getLastStudyActivity,
  recordStudyActivity,
  shouldPromptStudyAfterIdle,
  touchStudyActivity,
} from './studyPrompt';

describe('studyPrompt', () => {
  beforeEach(() => {
    localStorage.clear();
    clearStudyActivity();
  });

  it('prompts on a fresh sign-in when no prior activity exists and suppresses subsequent tab switches', () => {
    const t0 = 1_700_000_000_000;
    expect(touchStudyActivity('user-1', { promptIfUnset: true, now: t0 })).toBe(true);
    expect(getLastStudyActivity('user-1')).toBe(t0);

    // Tab switch 5 minutes later should NOT re-prompt
    const fiveMinLater = t0 + 5 * 60 * 1000;
    expect(touchStudyActivity('user-1', { promptIfUnset: false, now: fiveMinLater })).toBe(false);
    expect(shouldPromptStudyAfterIdle('user-1', fiveMinLater + 10_000)).toBe(false);
  });

  it('prompts again only after STUDY_PROMPT_IDLE_MS of inactivity', () => {
    const t0 = 1_700_000_000_000;
    recordStudyActivity('user-1', t0);

    // Just before the idle threshold: do not prompt
    const beforeIdle = t0 + STUDY_PROMPT_IDLE_MS - 1_000;
    expect(shouldPromptStudyAfterIdle('user-1', beforeIdle)).toBe(false);

    // At or after the idle threshold: prompt and update activity timestamp
    const afterIdle = t0 + STUDY_PROMPT_IDLE_MS;
    expect(shouldPromptStudyAfterIdle('user-1', afterIdle)).toBe(true);
    expect(touchStudyActivity('user-1', { promptIfUnset: false, now: afterIdle })).toBe(true);
    expect(getLastStudyActivity('user-1')).toBe(afterIdle);
    expect(shouldPromptStudyAfterIdle('user-1', afterIdle + 5_000)).toBe(false);
  });

  it('clears state on sign-out and falls back to memory when localStorage throws', () => {
    const t0 = 1_700_000_000_000;
    recordStudyActivity('user-1', t0);
    clearStudyActivity('user-1');
    expect(getLastStudyActivity('user-1')).toBeNull();
    expect(shouldPromptStudyAfterIdle('user-1', t0 + 1_000)).toBe(true);

    const setSpy = vi.spyOn(Storage.prototype, 'setItem').mockImplementation(() => {
      throw new Error('QuotaExceeded');
    });
    const getSpy = vi.spyOn(Storage.prototype, 'getItem').mockImplementation(() => {
      throw new Error('SecurityError');
    });

    expect(touchStudyActivity('offline-user', { promptIfUnset: true, now: t0 })).toBe(true);
    expect(touchStudyActivity('offline-user', { promptIfUnset: false, now: t0 + 10_000 })).toBe(
      false,
    );

    setSpy.mockRestore();
    getSpy.mockRestore();
  });
});
