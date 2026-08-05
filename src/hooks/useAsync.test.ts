import { act, renderHook, waitFor } from '@testing-library/react';
import { describe, expect, it, vi } from 'vitest';
import { useAsync } from './useAsync';

describe('useAsync', () => {
  it('resolves data and stops loading', async () => {
    const fn = vi.fn(async () => ({ ok: true }));
    const { result } = renderHook(() => useAsync(fn));

    expect(result.current.loading).toBe(true);
    await waitFor(() => expect(result.current.loading).toBe(false));
    expect(result.current.data).toEqual({ ok: true });
    expect(result.current.error).toBeNull();
  });

  it('surfaces thrown errors', async () => {
    const fn = vi.fn(async () => {
      throw new Error('boom');
    });
    const { result } = renderHook(() => useAsync(fn));

    await waitFor(() => expect(result.current.loading).toBe(false));
    expect(result.current.error?.message).toBe('boom');
    expect(result.current.data).toBeNull();
  });

  it('converts non-Error throws into Error instances', async () => {
    const fn = vi.fn(async () => {
      throw 'string-error';
    });
    const { result } = renderHook(() => useAsync(fn));
    await waitFor(() => expect(result.current.loading).toBe(false));
    expect(result.current.error).toBeInstanceOf(Error);
  });

  it('reload re-runs the fetch function', async () => {
    let calls = 0;
    const fn = vi.fn(async () => {
      calls += 1;
      return { calls };
    });
    const { result } = renderHook(() => useAsync(fn));

    await waitFor(() => expect(result.current.loading).toBe(false));
    expect(calls).toBe(1);

    act(() => result.current.reload());
    await waitFor(() => expect(result.current.data).toEqual({ calls: 2 }));
  });

  it('does not fetch twice when the function identity changes between renders', async () => {
    let calls = 0;
    const makeFn = () =>
      vi.fn(async () => {
        calls += 1;
        return calls;
      });
    const { result, rerender } = renderHook(({ getFn }) => useAsync(getFn), {
      initialProps: { getFn: makeFn() },
    });
    rerender({ getFn: makeFn() });
    await waitFor(() => expect(result.current.loading).toBe(false));
    expect(calls).toBe(1);
  });
});
