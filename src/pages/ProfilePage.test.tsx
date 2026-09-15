import { fireEvent, render, screen, waitFor } from '@testing-library/react';
import { describe, expect, it, vi } from 'vitest';
import { Link, MemoryRouter, Route, Routes } from 'react-router-dom';

const db = vi.hoisted(() => {
  const catalog = [
    { id: 'one', code: 'MATH 21', name: 'Calculus I' },
    { id: 'two', code: 'MATH 22', name: 'Calculus II' },
  ];
  return { catalog, selected: ['one'], questions: vi.fn(), save: vi.fn() };
});
vi.mock('@/hooks/useAuth', () => {
  const auth = {
    user: { id: 'student', email: 'student@up.edu.ph', user_metadata: {} },
    profile: null,
    isAdmin: true,
    adminLoading: false,
  };
  return { useAuth: () => auth };
});
vi.mock('@/lib/db', () => ({
  getCourses: async () => db.catalog,
  getUserCourses: async () => db.catalog.filter((course) => db.selected.includes(course.id)),
  setUserCourses: async (userId: string, ids: string[]) => {
    db.save(userId, ids);
    db.selected = ids;
  },
  getQuestionsWithRelations: db.questions,
  getProgressForUser: async () => [],
  getBookmarksForUser: async () => [],
}));
import { CourseScopeProvider } from '@/hooks/useCourseScope';
import { ProfilePage } from './ProfilePage';
import { CoursesPage } from './CoursesPage';

describe('profile course selection', () => {
  it('updates Courses and the shared dashboard question query after saving as an admin', async () => {
    db.selected = ['one'];
    db.questions.mockResolvedValue([]);
    render(
      <MemoryRouter initialEntries={['/profile']}>
        <CourseScopeProvider>
          <Link to="/courses">Open courses</Link>
          <Routes>
            <Route path="/profile" element={<ProfilePage />} />
            <Route path="/courses" element={<CoursesPage />} />
          </Routes>
        </CourseScopeProvider>
      </MemoryRouter>,
    );
    await screen.findByText('MATH 21');
    fireEvent.click(screen.getByRole('button', { name: 'Edit' }));
    fireEvent.click(screen.getByRole('checkbox', { name: /MATH 21/ }));
    fireEvent.click(screen.getByRole('checkbox', { name: /MATH 22/ }));
    fireEvent.click(screen.getByRole('button', { name: 'Save courses' }));
    await waitFor(() =>
      expect(screen.queryByRole('button', { name: 'Save courses' })).not.toBeInTheDocument(),
    );
    expect(db.save).toHaveBeenCalledWith('student', ['two']);
    fireEvent.click(screen.getByText('Open courses'));
    await screen.findByText('MATH 22');
    expect(screen.queryByText('MATH 21')).not.toBeInTheDocument();
    await waitFor(() => expect(db.questions).toHaveBeenLastCalledWith(['two']));
  });
});
