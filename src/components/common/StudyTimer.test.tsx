import { act, fireEvent, render, screen } from '@testing-library/react';
import { afterEach, describe, expect, it, vi } from 'vitest';
import { StudyTimer } from './StudyTimer';

describe('StudyTimer', () => {
  afterEach(() => {
    vi.useRealTimers();
    sessionStorage.clear();
  });

  it('switches presets, counts down, and records completed focus blocks', () => {
    vi.useFakeTimers();
    render(<StudyTimer />);

    const trigger = screen.getByRole('button', { name: 'Study focus timer' });
    expect(trigger).toHaveTextContent('25:00');
    fireEvent.click(trigger);

    fireEvent.click(screen.getByRole('button', { name: '5m Short Break' }));
    expect(screen.getByLabelText('Timer display')).toHaveTextContent('05:00');

    fireEvent.click(screen.getByRole('button', { name: '25m Focus' }));
    fireEvent.click(screen.getByRole('button', { name: 'Start timer' }));

    act(() => {
      vi.advanceTimersByTime(60_000);
    });
    expect(screen.getByLabelText('Timer display')).toHaveTextContent('24:00');

    fireEvent.click(screen.getByRole('button', { name: 'Pause timer' }));
    fireEvent.click(screen.getByRole('button', { name: 'Reset' }));
    expect(screen.getByLabelText('Timer display')).toHaveTextContent('25:00');
  });
});
