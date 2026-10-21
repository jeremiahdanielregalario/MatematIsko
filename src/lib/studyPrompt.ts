import { STUDY_PROMPT_IDLE_MS, STUDY_PROMPT_LAST_ACTIVE_KEY_PREFIX } from './constants';

const memoryLastActive = new Map<string, number>();

const storageKey = (userId: string) => `${STUDY_PROMPT_LAST_ACTIVE_KEY_PREFIX}${userId}`;

export function getLastStudyActivity(userId: string): number | null {
  try {
    const raw = localStorage.getItem(storageKey(userId));
    if (raw !== null) {
      const parsed = Number(raw);
      if (Number.isFinite(parsed) && parsed > 0) {
        memoryLastActive.set(userId, parsed);
        return parsed;
      }
    }
  } catch {
    /* Fall back to in-memory timestamp when localStorage is unavailable. */
  }
  return memoryLastActive.get(userId) ?? null;
}

export function recordStudyActivity(userId: string, now = Date.now()): void {
  memoryLastActive.set(userId, now);
  try {
    localStorage.setItem(storageKey(userId), String(now));
  } catch {
    /* Non-blocking when browser storage is restricted. */
  }
}

export function clearStudyActivity(userId?: string): void {
  if (userId) {
    memoryLastActive.delete(userId);
    try {
      localStorage.removeItem(storageKey(userId));
    } catch {
      /* Ignore storage errors on sign-out. */
    }
    return;
  }
  const ids = Array.from(memoryLastActive.keys());
  memoryLastActive.clear();
  for (const id of ids) {
    try {
      localStorage.removeItem(storageKey(id));
    } catch {
      /* Ignore storage errors on sign-out. */
    }
  }
}

export function shouldPromptStudyAfterIdle(userId: string, now = Date.now()): boolean {
  const last = getLastStudyActivity(userId);
  if (last === null) return true;
  return now - last >= STUDY_PROMPT_IDLE_MS;
}

/**
 * Checks whether the user should be shown the "What would you like to study today?"
 * prompt (either on a fresh sign-in when `promptIfUnset` is true, or after at least
 * `STUDY_PROMPT_IDLE_MS` of inactivity), and records `now` as the latest activity time.
 */
export function touchStudyActivity(
  userId: string,
  options: { promptIfUnset?: boolean; now?: number } = {},
): boolean {
  const now = options.now ?? Date.now();
  const last = getLastStudyActivity(userId);
  recordStudyActivity(userId, now);
  if (last === null) {
    return Boolean(options.promptIfUnset);
  }
  return now - last >= STUDY_PROMPT_IDLE_MS;
}
