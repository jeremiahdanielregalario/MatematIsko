import { useCallback } from 'react';
import { getTopics } from '@/lib/db';
import { useAsync } from './useAsync';

export function useTopics() {
  const fn = useCallback(() => getTopics(), []);
  return useAsync(fn);
}
