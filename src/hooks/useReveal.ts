import { useCallback, useState } from 'react';

export type RevealLevel = 'hidden' | 'hint' | 'answer' | 'solution';

const LEVELS: RevealLevel[] = ['hidden', 'hint', 'answer', 'solution'];

export function useReveal() {
  const [level, setLevel] = useState<RevealLevel>('hidden');

  const reveal = useCallback((target: RevealLevel) => {
    setLevel((current) => {
      const currentIndex = LEVELS.indexOf(current);
      const targetIndex = LEVELS.indexOf(target);
      return targetIndex >= currentIndex ? target : current;
    });
  }, []);

  const reset = useCallback(() => setLevel('hidden'), []);

  return { level, reveal, reset };
}
