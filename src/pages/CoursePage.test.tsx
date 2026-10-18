import { fireEvent, render, screen } from '@testing-library/react';
import { MemoryRouter, Route, Routes } from 'react-router-dom';
import { describe, expect, it, vi } from 'vitest';
import { CoursePage } from './CoursePage';

vi.mock('@/hooks/useAuth', () => ({
  useAuth: () => ({ user: { id: 'student-1', email: 'student@up.edu.ph' } }),
}));

vi.mock('@/hooks/useCourseScope', () => ({
  useCourseScope: () => ({ courseIds: ['c1'] }),
}));

vi.mock('@/hooks/useCourses', () => ({
  useCourses: () => ({
    data: [{ id: 'c1', code: 'MATH 21', name: 'Elementary Analysis I', description: null }],
    loading: false,
    error: null,
    reload: vi.fn(),
  }),
}));

vi.mock('@/hooks/useCourseNotes', () => ({
  useCourseNotes: () => ({ data: [], loading: false, error: null, reload: vi.fn() }),
}));

vi.mock('@/hooks/useQuestions', () => ({
  useQuestions: () => ({
    data: [
      {
        id: 'q1',
        course_id: 'c1',
        topic_id: 't1',
        title: 'Squeeze Theorem Limit',
        question_text: 'Evaluate $\\lim_{x \\to 0} x^2 \\sin(1/x)$.',
        difficulty: 'easy',
        year: 2024,
        exam_name: 'LE1',
        question_number: 1,
        answer: '0',
        solution: 'By squeeze theorem.',
        hint: null,
        created_at: '2024-01-01',
        updated_at: '2024-01-01',
        course: { id: 'c1', code: 'MATH 21', name: 'Elementary Analysis I' },
        topic: { id: 't1', course_id: 'c1', name: 'Limits and Continuity' },
        bookmarked: false,
        progress: {
          user_id: 'student-1',
          question_id: 'q1',
          status: 'mastered',
          attempts: 1,
          last_attempted_at: '2024-02-01',
          mastered_at: '2024-02-01',
        },
      },
      {
        id: 'q2',
        course_id: 'c1',
        topic_id: 't1',
        title: 'Chain Rule Derivative',
        question_text: 'Differentiate $\\sin(x^2)$.',
        difficulty: 'hard',
        year: 2024,
        exam_name: 'LE2',
        question_number: 2,
        answer: '2x cos(x^2)',
        solution: 'Use chain rule.',
        hint: null,
        created_at: '2024-01-02',
        updated_at: '2024-01-02',
        course: { id: 'c1', code: 'MATH 21', name: 'Elementary Analysis I' },
        topic: { id: 't1', course_id: 'c1', name: 'Limits and Continuity' },
        bookmarked: true,
        progress: null,
      },
    ],
    loading: false,
    error: null,
    reload: vi.fn(),
  }),
}));

vi.mock('@/hooks/useTheorems', () => ({
  useTheorems: () => ({
    data: [
      {
        id: 'th1',
        course_id: 'c1',
        topic_id: 't1',
        name: 'Intermediate Value Theorem',
        reference: 'Theorem 1.4',
        statement: 'If $f$ is continuous on $[a,b]$...',
        formal_notation: null,
        created_at: '2024-01-01',
        updated_at: '2024-01-01',
        course: { id: 'c1', code: 'MATH 21', name: 'Elementary Analysis I' },
        topic: { id: 't1', course_id: 'c1', name: 'Limits and Continuity' },
        progress: null,
      },
    ],
    loading: false,
    error: null,
    reload: vi.fn(),
  }),
}));

vi.mock('@/lib/db', () => ({
  setBookmark: vi.fn().mockResolvedValue(undefined),
  upsertProgress: vi.fn().mockResolvedValue(undefined),
  upsertTheoremProgress: vi.fn().mockResolvedValue(undefined),
}));

describe('CoursePage', () => {
  it('computes accurate topic mastery stats and filters course problems', () => {
    render(
      <MemoryRouter initialEntries={['/courses/c1']}>
        <Routes>
          <Route path="/courses/:courseId" element={<CoursePage />} />
        </Routes>
      </MemoryRouter>,
    );

    expect(screen.getByText('1 / 2 mastered (50%)')).toBeInTheDocument();
    expect(screen.getByText('Squeeze Theorem Limit')).toBeInTheDocument();
    expect(screen.getByText('Chain Rule Derivative')).toBeInTheDocument();

    fireEvent.change(screen.getByLabelText('Difficulty'), { target: { value: 'hard' } });
    expect(screen.getByText('Chain Rule Derivative')).toBeInTheDocument();
    expect(screen.queryByText('Squeeze Theorem Limit')).not.toBeInTheDocument();
  });

  it('displays course theorems in the Theorems tab', () => {
    render(
      <MemoryRouter initialEntries={['/courses/c1']}>
        <Routes>
          <Route path="/courses/:courseId" element={<CoursePage />} />
        </Routes>
      </MemoryRouter>,
    );

    fireEvent.click(screen.getByRole('button', { name: 'Theorems' }));
    expect(screen.getByText('Intermediate Value Theorem')).toBeInTheDocument();
    expect(screen.getByRole('link', { name: 'Practice course flashcards' })).toHaveAttribute(
      'href',
      '/theorems/flashcards?course=c1',
    );
  });
});
