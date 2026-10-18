import { lazy, Suspense } from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { LoadingState } from '@/components/common/LoadingState';
import { AppShell } from '@/components/layout/AppShell';
import { RequireAuth } from '@/features/auth/RequireAuth';
import { AuthProvider } from '@/hooks/useAuth';
import { ThemeProvider } from '@/hooks/useTheme';
import { RequireAdmin } from '@/features/auth/RequireAdmin';
import { RequireOnboarding } from '@/features/auth/RequireOnboarding';
import { CourseScopeProvider } from '@/hooks/useCourseScope';
import { AuthCallbackPage } from '@/pages/AuthCallbackPage';
import { LandingPage } from '@/pages/LandingPage';
import { NotFoundPage } from '@/pages/NotFoundPage';

const AdminPage = lazy(() => import('@/pages/AdminPage').then((m) => ({ default: m.AdminPage })));
const BookmarksPage = lazy(() =>
  import('@/pages/BookmarksPage').then((m) => ({ default: m.BookmarksPage })),
);
const CoursePage = lazy(() =>
  import('@/pages/CoursePage').then((m) => ({ default: m.CoursePage })),
);
const CourseNoteDetailPage = lazy(() =>
  import('@/pages/CourseNoteDetailPage').then((m) => ({ default: m.CourseNoteDetailPage })),
);
const CoursesPage = lazy(() =>
  import('@/pages/CoursesPage').then((m) => ({ default: m.CoursesPage })),
);
const DashboardPage = lazy(() =>
  import('@/pages/DashboardPage').then((m) => ({ default: m.DashboardPage })),
);
const OnboardingPage = lazy(() =>
  import('@/pages/OnboardingPage').then((m) => ({ default: m.OnboardingPage })),
);
const PracticePage = lazy(() =>
  import('@/pages/PracticePage').then((m) => ({ default: m.PracticePage })),
);
const ExamPage = lazy(() => import('@/pages/ExamPage').then((m) => ({ default: m.ExamPage })));
const ContributionsPage = lazy(() =>
  import('@/pages/ContributionsPage').then((m) => ({ default: m.ContributionsPage })),
);
const ProfilePage = lazy(() =>
  import('@/pages/ProfilePage').then((m) => ({ default: m.ProfilePage })),
);
const QuestionDetailPage = lazy(() =>
  import('@/pages/QuestionDetailPage').then((m) => ({ default: m.QuestionDetailPage })),
);
const TheoremsPage = lazy(() =>
  import('@/pages/TheoremsPage').then((m) => ({ default: m.TheoremsPage })),
);
const TheoremDetailPage = lazy(() =>
  import('@/pages/TheoremDetailPage').then((m) => ({ default: m.TheoremDetailPage })),
);
const FlashcardSessionPage = lazy(() =>
  import('@/pages/FlashcardSessionPage').then((m) => ({ default: m.FlashcardSessionPage })),
);
const BlogsPage = lazy(() => import('@/pages/BlogsPage').then((m) => ({ default: m.BlogsPage })));
const BlogPostPage = lazy(() =>
  import('@/pages/BlogPostPage').then((m) => ({ default: m.BlogPostPage })),
);
const WriteBlogPage = lazy(() =>
  import('@/pages/WriteBlogPage').then((m) => ({ default: m.WriteBlogPage })),
);

export function App() {
  return (
    <ThemeProvider>
      <BrowserRouter>
        <AuthProvider>
          <CourseScopeProvider>
            <Suspense fallback={<LoadingState label="Loading page" />}>
              <Routes>
                <Route path="/" element={<LandingPage />} />
                <Route path="/auth/callback" element={<AuthCallbackPage />} />

                <Route element={<AppShell />}>
                  <Route path="/blogs" element={<BlogsPage />} />
                  <Route path="/blogs/:slug" element={<BlogPostPage />} />

                  <Route element={<RequireAuth />}>
                    <Route path="/onboarding" element={<OnboardingPage />} />
                    <Route element={<RequireOnboarding />}>
                      <Route path="/dashboard" element={<DashboardPage />} />
                      <Route path="/courses" element={<CoursesPage />} />
                      <Route path="/courses/:courseId" element={<CoursePage />} />
                      <Route
                        path="/courses/:courseId/notes/:noteId"
                        element={<CourseNoteDetailPage />}
                      />
                      <Route path="/questions/:id" element={<QuestionDetailPage />} />
                      <Route path="/theorems" element={<TheoremsPage />} />
                      <Route path="/theorems/flashcards" element={<FlashcardSessionPage />} />
                      <Route path="/theorems/:id" element={<TheoremDetailPage />} />
                      <Route path="/practice" element={<PracticePage />} />
                      <Route path="/practice/exam" element={<ExamPage />} />
                      <Route path="/bookmarks" element={<BookmarksPage />} />
                      <Route path="/blogs/new" element={<WriteBlogPage />} />
                      <Route path="/profile" element={<ProfilePage />} />
                      <Route path="/contributions" element={<ContributionsPage />} />
                      <Route
                        path="/admin"
                        element={
                          <RequireAdmin>
                            <AdminPage />
                          </RequireAdmin>
                        }
                      />
                    </Route>
                  </Route>
                </Route>

                <Route path="*" element={<NotFoundPage />} />
              </Routes>
            </Suspense>
          </CourseScopeProvider>
        </AuthProvider>
      </BrowserRouter>
    </ThemeProvider>
  );
}
