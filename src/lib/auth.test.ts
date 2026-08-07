import { describe, expect, it } from 'vitest';
import { isAdminEmail, isApprovedUpEmail } from './auth';

describe('isApprovedUpEmail', () => {
  it('accepts @up.edu.ph addresses', () => {
    expect(isApprovedUpEmail('student@up.edu.ph')).toBe(true);
    expect(isApprovedUpEmail('first.last@up.edu.ph')).toBe(true);
    expect(isApprovedUpEmail('  admin@up.edu.ph  ')).toBe(true);
  });

  it('is case-insensitive on the domain', () => {
    expect(isApprovedUpEmail('Student@UP.EDU.PH')).toBe(true);
  });

  it('rejects non-UP addresses', () => {
    expect(isApprovedUpEmail('student@gmail.com')).toBe(false);
    expect(isApprovedUpEmail('student@up.edu.ph.evil.com')).toBe(false);
    expect(isApprovedUpEmail('up.edu.ph@example.com')).toBe(false);
  });

  it('rejects missing emails', () => {
    expect(isApprovedUpEmail(null)).toBe(false);
    expect(isApprovedUpEmail(undefined)).toBe(false);
    expect(isApprovedUpEmail('')).toBe(false);
  });
});

describe('isAdminEmail', () => {
  it('recognizes the hardcoded admin email case-insensitively', () => {
    expect(isAdminEmail('jeremiah.regalario@gmail.com')).toBe(true);
    expect(isAdminEmail('JEREMIAH.REGALARIO@GMAIL.COM')).toBe(true);
  });

  it('rejects everyone else', () => {
    expect(isAdminEmail('student@up.edu.ph')).toBe(false);
    expect(isAdminEmail('student@gmail.com')).toBe(false);
  });

  it('rejects missing emails', () => {
    expect(isAdminEmail(null)).toBe(false);
    expect(isAdminEmail(undefined)).toBe(false);
    expect(isAdminEmail('')).toBe(false);
  });
});
