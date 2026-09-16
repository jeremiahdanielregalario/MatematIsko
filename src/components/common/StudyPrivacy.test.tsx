import { fireEvent, render, screen } from '@testing-library/react';
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
    render(<StudyPrivacy />);
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

  it('removes the privacy cover on unmount', () => {
    vi.spyOn(document, 'hasFocus').mockReturnValue(false);
    const { unmount } = render(<StudyPrivacy />);
    expect(screen.getByRole('status')).toBeInTheDocument();
    unmount();
    expect(screen.queryByRole('status')).not.toBeInTheDocument();
  });
});
