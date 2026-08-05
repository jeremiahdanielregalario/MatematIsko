export const UP_EMAIL_DOMAIN = 'up.edu.ph';

export const UP_ACCESS_MESSAGE =
  'MatematIsko is currently available only to UP email accounts ending in @up.edu.ph.';

/** Hardcoded admin emails that bypass the @up.edu.ph domain check. */
const ADMIN_EMAILS: readonly string[] = ['jeremiah.regalario@gmail.com'];

function isAdminEmail(email: string): boolean {
  return ADMIN_EMAILS.includes(email.toLowerCase());
}

/**
 * Returns true if the address is an allowed @up.edu.ph address or a
 * hardcoded admin account. This is the single source of truth used by the
 * auth provider. (The database additionally enforces this for non-admin
 * accounts; see supabase/schema.sql.)
 */
export function isApprovedUpEmail(email: string | null | undefined): boolean {
  if (!email) return false;
  const lower = email.trim().toLowerCase();
  if (isAdminEmail(lower)) return true;
  const atIndex = lower.lastIndexOf('@');
  if (atIndex <= 0 || atIndex === lower.length - 1) return false;
  const domain = lower.slice(atIndex + 1);
  return domain === UP_EMAIL_DOMAIN;
}
