import { useCallback, useEffect, useState } from 'react';
import { supabase, isSupabaseConfigured } from '@/lib/supabase';
import type { CourseNote } from '@/types';

export function useCourseNotes(courseId: string | undefined) {
  const [data, setData] = useState<CourseNote[] | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const fetchNotes = useCallback(async () => {
    if (!courseId) {
      setData([]);
      setLoading(false);
      return;
    }
    if (!isSupabaseConfigured || !supabase) {
      setData([]);
      setLoading(false);
      return;
    }

    setLoading(true);
    setError(null);

    const { data: rows, error: err } = await supabase
      .from('course_notes')
      .select('*')
      .eq('course_id', courseId)
      .order('sort_order', { ascending: true });

    if (err) {
      setError(err.message);
      setData([]);
    } else {
      setData(rows as CourseNote[]);
    }
    setLoading(false);
  }, [courseId]);

  useEffect(() => {
    fetchNotes();
  }, [fetchNotes]);

  return { data, loading, error, reload: fetchNotes };
}
