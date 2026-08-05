import { act, renderHook } from '@testing-library/react';
import { describe, expect, it } from 'vitest';
import { useReveal } from './useReveal';

describe('useReveal', () => {
  it('starts hidden', () => {
    const { result } = renderHook(() => useReveal());
    expect(result.current.level).toBe('hidden');
  });

  it('reveals levels progressively', () => {
    const { result } = renderHook(() => useReveal());
    act(() => result.current.reveal('hint'));
    expect(result.current.level).toBe('hint');
    act(() => result.current.reveal('answer'));
    expect(result.current.level).toBe('answer');
  });

  it('never moves backwards', () => {
    const { result } = renderHook(() => useReveal());
    act(() => result.current.reveal('solution'));
    act(() => result.current.reveal('hint'));
    expect(result.current.level).toBe('solution');
  });

  it('resets to hidden', () => {
    const { result } = renderHook(() => useReveal());
    act(() => result.current.reveal('answer'));
    act(() => result.current.reset());
    expect(result.current.level).toBe('hidden');
  });
});
