import { Pause, Play, RotateCcw, Timer } from 'lucide-react';
import { useEffect, useState } from 'react';
import { Button } from '@/components/ui/button';
import {
  Dialog,
  DialogContent,
  DialogDescription,
  DialogTitle,
} from '@/components/ui/dialog';
import { cn } from '@/lib/cn';

const STORAGE_KEY = 'matematisko-study-timer-v1';

interface TimerState {
  modeLabel: string;
  durationSec: number;
  remainingSec: number;
  running: boolean;
  targetTimestamp: number | null;
  completedBlocks: number;
}

const PRESETS = [
  { label: '25m Focus', minutes: 25 },
  { label: '50m Deep Study', minutes: 50 },
  { label: '5m Short Break', minutes: 5 },
  { label: '15m Long Break', minutes: 15 },
] as const;

const DEFAULT_STATE: TimerState = {
  modeLabel: '25m Focus',
  durationSec: 25 * 60,
  remainingSec: 25 * 60,
  running: false,
  targetTimestamp: null,
  completedBlocks: 0,
};

function loadTimerState(): TimerState {
  try {
    const raw = sessionStorage.getItem(STORAGE_KEY);
    if (!raw) return DEFAULT_STATE;
    const parsed = JSON.parse(raw) as Partial<TimerState>;
    if (
      typeof parsed.durationSec !== 'number' ||
      typeof parsed.remainingSec !== 'number' ||
      typeof parsed.modeLabel !== 'string'
    ) {
      return DEFAULT_STATE;
    }
    if (parsed.running && typeof parsed.targetTimestamp === 'number') {
      const diff = Math.max(0, Math.ceil((parsed.targetTimestamp - Date.now()) / 1000));
      return {
        modeLabel: parsed.modeLabel,
        durationSec: parsed.durationSec,
        remainingSec: diff,
        running: diff > 0,
        targetTimestamp: diff > 0 ? parsed.targetTimestamp : null,
        completedBlocks: parsed.completedBlocks ?? 0,
      };
    }
    return {
      modeLabel: parsed.modeLabel,
      durationSec: parsed.durationSec,
      remainingSec: parsed.remainingSec,
      running: false,
      targetTimestamp: null,
      completedBlocks: parsed.completedBlocks ?? 0,
    };
  } catch {
    return DEFAULT_STATE;
  }
}

function saveTimerState(state: TimerState): void {
  try {
    sessionStorage.setItem(STORAGE_KEY, JSON.stringify(state));
  } catch {
    // Ignore sessionStorage failures.
  }
}

function formatClock(totalSeconds: number): string {
  const clamped = Math.max(0, Math.floor(totalSeconds));
  const mins = Math.floor(clamped / 60);
  const secs = clamped % 60;
  return `${String(mins).padStart(2, '0')}:${String(secs).padStart(2, '0')}`;
}

export function StudyTimer() {
  const [open, setOpen] = useState(false);
  const [state, setState] = useState<TimerState>(loadTimerState);

  useEffect(() => {
    saveTimerState(state);
  }, [state]);

  useEffect(() => {
    if (!state.running || state.targetTimestamp === null) return;
    const interval = window.setInterval(() => {
      setState((prev) => {
        if (!prev.running || prev.targetTimestamp === null) return prev;
        const left = Math.max(0, Math.ceil((prev.targetTimestamp - Date.now()) / 1000));
        if (left === 0) {
          const isFocus = prev.modeLabel.includes('Focus') || prev.modeLabel.includes('Study');
          return {
            ...prev,
            remainingSec: 0,
            running: false,
            targetTimestamp: null,
            completedBlocks: isFocus ? prev.completedBlocks + 1 : prev.completedBlocks,
          };
        }
        return { ...prev, remainingSec: left };
      });
    }, 1000);
    return () => window.clearInterval(interval);
  }, [state.running, state.targetTimestamp]);

  const toggleRun = () => {
    setState((prev) => {
      if (prev.running) {
        const left = prev.targetTimestamp
          ? Math.max(0, Math.ceil((prev.targetTimestamp - Date.now()) / 1000))
          : prev.remainingSec;
        return {
          ...prev,
          running: false,
          remainingSec: left,
          targetTimestamp: null,
        };
      }
      const baseSec = prev.remainingSec > 0 ? prev.remainingSec : prev.durationSec;
      return {
        ...prev,
        remainingSec: baseSec,
        running: true,
        targetTimestamp: Date.now() + baseSec * 1000,
      };
    });
  };

  const resetTimer = () => {
    setState((prev) => ({
      ...prev,
      remainingSec: prev.durationSec,
      running: false,
      targetTimestamp: null,
    }));
  };

  const selectPreset = (label: string, minutes: number) => {
    const secs = minutes * 60;
    setState((prev) => ({
      ...prev,
      modeLabel: label,
      durationSec: secs,
      remainingSec: secs,
      running: false,
      targetTimestamp: null,
    }));
  };

  const progressPercent =
    state.durationSec > 0
      ? Math.round(((state.durationSec - state.remainingSec) / state.durationSec) * 100)
      : 0;

  return (
    <>
      <button
        type="button"
        onClick={() => setOpen(true)}
        aria-label="Study focus timer"
        className={cn(
          'inline-flex h-9 items-center gap-1.5 rounded-lg border px-2.5 font-mono text-xs font-medium tabular-nums transition-colors focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600',
          state.running
            ? 'border-brand-300 bg-brand-50 text-brand-900 dark:border-brand-700 dark:bg-brand-950/70 dark:text-brand-200'
            : 'border-stone-200 bg-stone-50 text-stone-600 hover:bg-stone-100 hover:text-stone-900 dark:border-stone-800 dark:bg-stone-900 dark:text-stone-300 dark:hover:bg-stone-800',
        )}
      >
        <Timer className={cn('size-3.5', state.running && 'text-brand-700 dark:text-brand-300')} />
        <span>{formatClock(state.remainingSec)}</span>
      </button>

      <Dialog open={open} onOpenChange={setOpen}>
        <DialogContent className="max-w-md p-6">
          <DialogTitle className="font-serif text-xl font-bold text-stone-900 dark:text-stone-50">
            Study Focus Timer
          </DialogTitle>
          <DialogDescription className="mt-1 text-xs text-stone-500 dark:text-stone-400">
            Pace your problem-solving sessions. This timer stays active across pages in this tab.
          </DialogDescription>

          <div className="mt-4 grid grid-cols-2 gap-2" aria-label="Timer presets">
            {PRESETS.map((preset) => {
              const active = state.modeLabel === preset.label;
              return (
                <button
                  key={preset.label}
                  type="button"
                  aria-pressed={active}
                  onClick={() => selectPreset(preset.label, preset.minutes)}
                  className={cn(
                    'rounded-lg border px-3 py-2 text-xs font-medium transition-colors',
                    active
                      ? 'border-brand-800 bg-brand-50 font-semibold text-brand-900 dark:border-brand-400 dark:bg-brand-950 dark:text-brand-200'
                      : 'border-stone-200 text-stone-600 hover:bg-stone-50 dark:border-stone-700 dark:text-stone-300 dark:hover:bg-stone-800',
                  )}
                >
                  {preset.label}
                </button>
              );
            })}
          </div>

          <div className="my-5 rounded-2xl border border-stone-200 bg-stone-50/80 p-6 text-center dark:border-stone-800 dark:bg-stone-950/60">
            <p className="text-xs font-semibold uppercase tracking-widest text-brand-800 dark:text-brand-300">
              {state.modeLabel}
            </p>
            <p
              aria-label="Timer display"
              className="mt-2 font-mono text-5xl font-bold tracking-tight tabular-nums text-stone-900 dark:text-stone-50"
            >
              {formatClock(state.remainingSec)}
            </p>
            <div className="mx-auto mt-4 h-1.5 w-full overflow-hidden rounded-full bg-stone-200 dark:bg-stone-800">
              <div
                className="h-full rounded-full bg-brand-800 transition-all duration-300 dark:bg-brand-400"
                style={{ width: `${progressPercent}%` }}
              />
            </div>
          </div>

          <div className="flex items-center justify-between gap-2">
            <Button onClick={toggleRun} className="flex-1">
              {state.running ? <Pause className="size-4" /> : <Play className="size-4" />}
              {state.running ? 'Pause timer' : 'Start timer'}
            </Button>
            <Button variant="outline" onClick={resetTimer}>
              <RotateCcw className="size-4" />
              Reset
            </Button>
          </div>

          <p className="mt-4 text-center text-xs text-stone-500 dark:text-stone-400">
            Completed focus blocks this session:{' '}
            <strong className="font-mono text-stone-800 dark:text-stone-200">
              {state.completedBlocks}
            </strong>
          </p>
        </DialogContent>
      </Dialog>
    </>
  );
}
