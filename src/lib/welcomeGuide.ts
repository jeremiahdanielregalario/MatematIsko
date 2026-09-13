// Only completed first-time setup queues the guide. Existing users are not interrupted.
// Per-account browser persistence; memory fallback keeps storage failures non-blocking.
const states = new Map<string, boolean>();
const key = (userId: string) => `matematisko-welcome-v1:${userId}`;

export function welcomePending(userId: string) {
  if (states.has(userId)) return states.get(userId)!;
  try {
    return localStorage.getItem(key(userId)) === 'pending';
  } catch {
    return false;
  }
}

export function setWelcomePending(userId: string, pending: boolean) {
  states.set(userId, pending);
  try {
    localStorage.setItem(key(userId), pending ? 'pending' : 'dismissed');
  } catch {
    /* The walkthrough never blocks studying when storage is unavailable. */
  }
}
