import { useCallback } from 'react';
import { getCourses } from '@/lib/db';
import { useAsync } from './useAsync';

export function useCourses() {
  const fn = useCallback(() => getCourses(), []);
  return useAsync(fn);
}
