import { render, renderHook, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';
import { describe, expect, it, vi } from 'vitest';
import { useRevealKeyboard } from './useRevealKeyboard';

describe('useRevealKeyboard', () => {
  it('reveals the answer on the A key', async () => {
    const user = userEvent.setup();
    const reveal = vi.fn();
    renderHook(() => useRevealKeyboard(reveal, true));
    await user.keyboard('{a}');
    expect(reveal).toHaveBeenCalledWith('answer');
  });

  it('reveals hints and solutions on H and S', async () => {
    const user = userEvent.setup();
    const reveal = vi.fn();
    renderHook(() => useRevealKeyboard(reveal, true));
    await user.keyboard('{h}');
    await user.keyboard('{s}');
    expect(reveal).toHaveBeenNthCalledWith(1, 'hint');
    expect(reveal).toHaveBeenNthCalledWith(2, 'solution');
  });

  it('does nothing when disabled', async () => {
    const user = userEvent.setup();
    const reveal = vi.fn();
    renderHook(() => useRevealKeyboard(reveal, false));
    await user.keyboard('{a}');
    expect(reveal).not.toHaveBeenCalled();
  });

  it('ignores keys typed into inputs', async () => {
    const user = userEvent.setup();
    const reveal = vi.fn();
    render(<input aria-label="search" />);
    renderHook(() => useRevealKeyboard(reveal, true));

    const input = screen.getByLabelText('search');
    input.focus();
    await user.keyboard('{h}');
    expect(reveal).not.toHaveBeenCalled();
  });

  it('ignores modified shortcuts (ctrl/meta)', async () => {
    const user = userEvent.setup();
    const reveal = vi.fn();
    renderHook(() => useRevealKeyboard(reveal, true));
    await user.keyboard('{Control>}a{/Control}');
    expect(reveal).not.toHaveBeenCalled();
  });
});
