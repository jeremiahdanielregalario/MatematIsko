import { act, fireEvent, render, screen, waitFor } from '@testing-library/react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
const { auth, courses } = vi.hoisted(() => ({
  auth: { user: { id: 'student' }, isAdmin: false, adminLoading: false },
  courses: vi.fn(),
}));
vi.mock('@/hooks/useAuth', () => ({ useAuth: () => auth }));
vi.mock('@/lib/db', () => ({ getUserCourses: courses }));
import { CourseScopeProvider, useCourseScope } from './useCourseScope';
function Consumer() {
  const { courseIds, refresh } = useCourseScope();
  return (
    <button onClick={refresh}>{courseIds === null ? 'unrestricted' : courseIds.join(',')}</button>
  );
}
beforeEach(() => {
  auth.isAdmin = false;
  auth.adminLoading = false;
  courses.mockReset();
});
describe('role-aware course scope', () => {
  it('refreshes student course selection', async () => {
    courses.mockResolvedValue([{ id: 'one' }]);
    render(
      <CourseScopeProvider>
        <Consumer />
      </CourseScopeProvider>,
    );
    fireEvent.click(await screen.findByText('one'));
    courses.mockResolvedValue([{ id: 'two' }]);
    await act(async () => {});
    fireEvent.click(screen.getByRole('button'));
    await screen.findByText('two');
  });
  it('ignores an old course request after promotion', async () => {
    let finish!: (value: { id: string }[]) => void;
    courses.mockReturnValue(
      new Promise((resolve) => {
        finish = resolve;
      }),
    );
    const view = render(
      <CourseScopeProvider>
        <Consumer />
      </CourseScopeProvider>,
    );
    await waitFor(() => expect(courses).toHaveBeenCalled());
    auth.isAdmin = true;
    view.rerender(
      <CourseScopeProvider>
        <Consumer />
      </CourseScopeProvider>,
    );
    await screen.findByText('unrestricted');
    await act(async () => finish([{ id: 'old' }]));
    expect(screen.getByText('unrestricted')).toBeInTheDocument();
  });
});
