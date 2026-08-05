import { renderHook, waitFor } from '@testing-library/react';
import { describe, expect, it } from 'vitest';
import { useDebounce } from './useDebounce';

describe('useDebounce', () => {
  it('returns the initial value immediately', () => {
    const { result } = renderHook(({ value }) => useDebounce(value, 50), {
      initialProps: { value: 'a' },
    });
    expect(result.current).toBe('a');
  });

  it('waits for the delay before updating', async () => {
    const { result, rerender } = renderHook(({ value }) => useDebounce(value, 100), {
      initialProps: { value: 'a' },
    });
    rerender({ value: 'b' });
    await waitFor(() => expect(result.current).toBe('b'));
  });

  it('coalesces rapid changes into a single update', async () => {
    const { result, rerender } = renderHook(({ value }) => useDebounce(value, 100), {
      initialProps: { value: 'a' },
    });
    rerender({ value: 'b' });
    rerender({ value: 'c' });
    rerender({ value: 'd' });
    await waitFor(() => expect(result.current).toBe('d'));
  });
});
