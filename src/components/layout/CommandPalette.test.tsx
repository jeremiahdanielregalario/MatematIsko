import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { MemoryRouter, Route, Routes, useLocation } from 'react-router-dom';
import { describe, expect, it, vi } from 'vitest';
import { CommandPalette } from './CommandPalette';

vi.mock('@/hooks/useAuth', () => ({
  useAuth: () => ({ user: { id: 'u1', email: 'student@up.edu.ph' } }),
}));

vi.mock('@/hooks/useCourseScope', () => ({
  useCourseScope: () => ({ courseIds: ['c1'] }),
}));

vi.mock('@/lib/db', () => ({
  getCourses: vi.fn().mockResolvedValue([
    { id: 'c1', code: 'MATH 126', name: 'Real Analysis', description: null, created_at: '2024' },
  ]),
  getQuestionsWithRelations: vi.fn().mockResolvedValue([
    {
      id: 'q-vitali',
      course_id: 'c1',
      topic_id: 't1',
      title: 'Vitali Non-Measurable Set',
      question_text: 'Construct a non-measurable subset.',
      difficulty: 'hard',
      year: 2024,
      exam_name: 'LE1',
      question_number: 1,
      answer: 'A',
      solution: 'S',
      hint: null,
      created_at: '2024',
      updated_at: '2024',
      course: { id: 'c1', code: 'MATH 126', name: 'Real Analysis' },
      topic: { id: 't1', course_id: 'c1', name: 'Lebesgue Measure' },
    },
  ]),
  getTheorems: vi.fn().mockResolvedValue([
    {
      id: 'th-egoroff',
      course_id: 'c1',
      topic_id: 't1',
      name: "Egoroff's Theorem",
      reference: 'Theorem 1.12',
      statement: 'Pointwise convergence is nearly uniform.',
      formal_notation: null,
      created_at: '2024',
      updated_at: '2024',
      course: { id: 'c1', code: 'MATH 126', name: 'Real Analysis' },
      topic: { id: 't1', course_id: 'c1', name: 'Lebesgue Measure' },
    },
  ]),
}));

function LocationProbe() {
  const location = useLocation();
  return <div data-testid="path">{location.pathname}</div>;
}

describe('CommandPalette', () => {
  it('opens with Ctrl+K, searches courses, problems, and theorems, and navigates on Enter', async () => {
    render(
      <MemoryRouter initialEntries={['/dashboard']}>
        <CommandPalette />
        <Routes>
          <Route path="*" element={<LocationProbe />} />
        </Routes>
      </MemoryRouter>,
    );

    fireEvent.keyDown(window, { key: 'k', ctrlKey: true });
    expect(screen.getByRole('dialog')).toBeInTheDocument();

    await waitFor(() => {
      expect(screen.getByText('MATH 126 — Real Analysis')).toBeInTheDocument();
    });

    const input = screen.getByRole('textbox', {
      name: 'Search courses, problems, theorems, and study tools',
    });
    fireEvent.change(input, { target: { value: 'Egoroff' } });

    expect(screen.getByText("Egoroff's Theorem")).toBeInTheDocument();
    fireEvent.keyDown(input, { key: 'Enter' });

    expect(screen.getByTestId('path')).toHaveTextContent('/theorems/th-egoroff');
  });
});
