import { act, fireEvent, render, screen } from '@testing-library/react';
import { afterEach, describe, expect, it, vi } from 'vitest';
import { StudyPrivacy } from './StudyPrivacy';

afterEach(() => {
  vi.restoreAllMocks();
  vi.useRealTimers();
});

describe('StudyPrivacy', () => {
  it('covers on blur and hidden tabs, and restores only a visible focused window', () => {
    const focus = vi.spyOn(document, 'hasFocus').mockReturnValue(true);
    const hidden = vi.spyOn(document, 'hidden', 'get').mockReturnValue(false);
    render(<StudyPrivacy userId="account-one" watermark />);
    expect(screen.queryByRole('status')).not.toBeInTheDocument();
    fireEvent(window, new Event('blur'));
    expect(screen.getByRole('status')).toHaveTextContent('Study view hidden');
    hidden.mockReturnValue(true);
    fireEvent(window, new Event('focus'));
    expect(screen.getByRole('status')).toBeInTheDocument();
    hidden.mockReturnValue(false);
    focus.mockReturnValue(false);
    fireEvent(document, new Event('visibilitychange'));
    expect(screen.getByRole('status')).toBeInTheDocument();
    focus.mockReturnValue(true);
    fireEvent(window, new Event('focus'));
    expect(screen.queryByRole('status')).not.toBeInTheDocument();
  });

  it('updates the account and time without exposing email, and removes overlays on unmount', () => {
    vi.useFakeTimers();
    vi.setSystemTime(new Date('2026-09-16T08:00:00Z'));
    vi.spyOn(document, 'hasFocus').mockReturnValue(true);
    const { rerender, unmount } = render(<StudyPrivacy userId="account-one" watermark />);
    const image = () =>
      decodeURIComponent(screen.getByTestId('study-watermark').style.backgroundImage);
    expect(image()).toContain('account-one');
    expect(image()).toContain('08:00 UTC');
    act(() => vi.advanceTimersByTime(60_000));
    expect(image()).toContain('08:01 UTC');
    rerender(<StudyPrivacy userId="account-two" watermark />);
    expect(image()).toContain('account-two');
    expect(image()).not.toContain('account-one');
    rerender(<StudyPrivacy userId="account-two" watermark={false} />);
    expect(screen.queryByTestId('study-watermark')).not.toBeInTheDocument();
    fireEvent(window, new Event('blur'));
    unmount();
    expect(screen.queryByRole('status')).not.toBeInTheDocument();
    expect(vi.getTimerCount()).toBe(0);
  });
});
