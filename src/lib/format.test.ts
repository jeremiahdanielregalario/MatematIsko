import { describe, expect, it } from 'vitest';
import { formatCompactNumber, formatDate, formatRelativeTime } from './format';

describe('formatDate', () => {
  it('formats an ISO date', () => {
    expect(formatDate('2025-01-15T12:00:00Z')).toBe('Jan 15, 2025');
  });

  it('returns an em dash for null', () => {
    expect(formatDate(null)).toBe('—');
  });

  it('handles invalid input gracefully', () => {
    expect(formatDate('not-a-date')).toBe('—');
  });
});

describe('formatRelativeTime', () => {
  it('returns 0m for the present moment', () => {
    expect(formatRelativeTime(new Date().toISOString())).toBe('0m');
  });

  it('shows minutes for recent times', () => {
    const past = new Date(Date.now() - 5 * 60 * 1000).toISOString();
    expect(formatRelativeTime(past)).toBe('5m');
  });

  it('shows hours when under a day', () => {
    const past = new Date(Date.now() - 3 * 60 * 60 * 1000).toISOString();
    expect(formatRelativeTime(past)).toBe('3h');
  });

  it('shows days for older times', () => {
    const past = new Date(Date.now() - 3 * 24 * 60 * 60 * 1000).toISOString();
    expect(formatRelativeTime(past)).toBe('3d');
  });

  it('handles null', () => {
    expect(formatRelativeTime(null)).toBe('—');
  });
});

describe('formatCompactNumber', () => {
  it('leaves small numbers untouched', () => {
    expect(formatCompactNumber(0)).toBe('0');
    expect(formatCompactNumber(999)).toBe('999');
  });

  it('formats thousands with one decimal', () => {
    expect(formatCompactNumber(1250)).toBe('1.3k');
  });

  it('formats millions', () => {
    expect(formatCompactNumber(2500000)).toBe('2.5M');
  });
});
