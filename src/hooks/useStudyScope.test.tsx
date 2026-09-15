import { render, waitFor } from '@testing-library/react';
import { describe, expect, it, vi } from 'vitest';
const mocks = vi.hoisted(() => ({
  auth: { user: { id: 'student' }, isAdmin: false },
  questions: vi.fn(async () => []),
  theorems: vi.fn(async () => []),
  ids: ['selected'],
}));
vi.mock('@/hooks/useAuth', () => ({ useAuth: () => mocks.auth }));
vi.mock('@/hooks/useCourseScope', () => ({ useCourseScope: () => ({ courseIds: mocks.ids }) }));
vi.mock('@/lib/db', () => ({
  getQuestionsWithRelations: mocks.questions,
  getTheorems: mocks.theorems,
  getProgressForUser: async () => [],
  getBookmarksForUser: async () => [],
  getTheoremProgressForUser: async () => [],
}));
import { useQuestions } from './useQuestions';
import { useTheorems } from './useTheorems';
function Consumer({ allCourses }: { allCourses: boolean }) {
  useQuestions({ allCourses });
  useTheorems({ allCourses });
  return null;
}
describe('study preferences and admin content management', () => {
  it.each([
    { admin: false, allCourses: false, expected: ['selected'] },
    { admin: true, allCourses: false, expected: ['selected'] },
    { admin: true, allCourses: true, expected: undefined },
    { admin: false, allCourses: true, expected: ['selected'] },
  ])('admin=$admin, allCourses=$allCourses', async ({ admin, allCourses, expected }) => {
    mocks.auth.isAdmin = admin;
    mocks.questions.mockClear();
    mocks.theorems.mockClear();
    render(<Consumer allCourses={allCourses} />);
    await waitFor(() => {
      expect(mocks.questions).toHaveBeenCalledWith(expected);
      expect(mocks.theorems).toHaveBeenCalledWith(expected);
    });
  });
});
