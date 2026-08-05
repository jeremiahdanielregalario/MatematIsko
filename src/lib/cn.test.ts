import { describe, expect, it } from 'vitest';
import { cn } from './cn';

describe('cn', () => {
  it('joins truthy class names and drops falsy ones', () => {
    expect(cn('a', 'b', null, undefined, false, 'c')).toBe('a b c');
  });

  it('merges conflicting tailwind classes keeping the last one', () => {
    expect(cn('px-2 py-4', 'px-6')).toBe('py-4 px-6');
    expect(cn('text-sm', 'text-lg')).toBe('text-lg');
  });

  it('returns empty string for no classes', () => {
    expect(cn()).toBe('');
  });
});
