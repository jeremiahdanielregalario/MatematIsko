import { useEffect } from 'react';
import type { RevealLevel } from './useReveal';

function isEditableTarget(target: EventTarget | null): boolean {
  if (!(target instanceof HTMLElement)) return true;
  if (target.isContentEditable) return true;
  const tag = target.tagName;
  return tag === 'INPUT' || tag === 'TEXTAREA' || tag === 'SELECT';
}

/**
 * H → hint, A → answer, S → solution.
 * Never fires while the user is typing in an input/textarea.
 */
export function useRevealKeyboard(
  reveal: (level: RevealLevel) => void,
  enabled = true,
): void {
  useEffect(() => {
    if (!enabled) return;

    const onKeyDown = (event: KeyboardEvent) => {
      if (isEditableTarget(event.target)) return;
      if (event.metaKey || event.ctrlKey || event.altKey) return;

      let level: RevealLevel | null = null;
      switch (event.key.toLowerCase()) {
        case 'h':
          level = 'hint';
          break;
        case 'a':
          level = 'answer';
          break;
        case 's':
          level = 'solution';
          break;
        default:
          return;
      }
      event.preventDefault();
      reveal(level);
    };

    window.addEventListener('keydown', onKeyDown);
    return () => window.removeEventListener('keydown', onKeyDown);
  }, [reveal, enabled]);
}
