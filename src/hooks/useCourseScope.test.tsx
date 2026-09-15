import { act, fireEvent, render, screen, waitFor } from '@testing-library/react';
import { beforeEach, describe, expect, it, vi } from 'vitest';
const { auth, courses, save } = vi.hoisted(() => ({
  auth: { user: { id: 'student' }, isAdmin: false, adminLoading: false },
  courses: vi.fn(),
  save: vi.fn(),
}));
vi.mock('@/hooks/useAuth', () => ({ useAuth: () => auth }));
vi.mock('@/lib/db', () => ({ getUserCourses: courses, setUserCourses: save }));
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
  save.mockReset();
  save.mockResolvedValue(undefined);
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
    courses.mockResolvedValue([]);
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

function SaveConsumer() {
  const { courseIds, saveCourses, refresh } = useCourseScope();
  return (
    <>
      <output>{courseIds === null ? 'all' : courseIds.join(',')}</output>
      <button onClick={() => void saveCourses(['two']).catch(() => {})}>Save</button>
      <button onClick={refresh}>Refresh</button>
    </>
  );
}

describe('saved course selection', () => {
  it('publishes a successful save without a second read and ignores an older refresh', async () => {
    courses.mockResolvedValueOnce([{ id: 'one' }]);
    render(
      <CourseScopeProvider>
        <SaveConsumer />
      </CourseScopeProvider>,
    );
    await screen.findByText('one');
    let finish!: (value: { id: string }[]) => void;
    courses.mockImplementationOnce(
      () =>
        new Promise((resolve) => {
          finish = resolve;
        }),
    );
    fireEvent.click(screen.getByText('Refresh'));
    fireEvent.click(screen.getByText('Save'));
    await screen.findByText('two');
    expect(save).toHaveBeenCalledWith('student', ['two']);
    expect(courses).toHaveBeenCalledTimes(2);
    await act(async () => finish([{ id: 'one' }]));
    expect(screen.getByText('two')).toBeInTheDocument();
  });

  it('uses saved selections for administrators too', async () => {
    auth.isAdmin = true;
    courses.mockResolvedValue([{ id: 'one' }]);
    render(
      <CourseScopeProvider>
        <SaveConsumer />
      </CourseScopeProvider>,
    );
    await screen.findByText('one');
    fireEvent.click(screen.getByText('Save'));
    await screen.findByText('two');
  });

  it('retains the current scope when saving fails', async () => {
    courses.mockResolvedValue([{ id: 'one' }]);
    save.mockRejectedValue(new Error('Save failed'));
    render(
      <CourseScopeProvider>
        <SaveConsumer />
      </CourseScopeProvider>,
    );
    await screen.findByText('one');
    await act(async () => fireEvent.click(screen.getByText('Save')));
    expect(screen.getByText('one')).toBeInTheDocument();
  });
});
