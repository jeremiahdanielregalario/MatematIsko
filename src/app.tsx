import { BrowserRouter, Route, Routes } from 'react-router-dom';
import { AppShell } from '@/components/layout/AppShell';
import { RequireAuth } from '@/features/auth/RequireAuth';
import { AuthProvider } from '@/hooks/useAuth';
import { ThemeProvider } from '@/hooks/useTheme';
import { RequireAdmin } from '@/features/auth/RequireAdmin';
import { RequireOnboarding } from '@/features/auth/RequireOnboarding';
import { AdminPage } from '@/pages/AdminPage';
import { AuthCallbackPage } from '@/pages/AuthCallbackPage';
import { BookmarksPage } from '@/pages/BookmarksPage';
import { CoursePage } from '@/pages/CoursePage';
import { DashboardPage } from '@/pages/DashboardPage';
import { LandingPage } from '@/pages/LandingPage';
import { NotFoundPage } from '@/pages/NotFoundPage';
import { OnboardingPage } from '@/pages/OnboardingPage';
import { PracticePage } from '@/pages/PracticePage';
import { ProfilePage } from '@/pages/ProfilePage';
import { ProgressPage } from '@/pages/ProgressPage';
import { QuestionBankPage } from '@/pages/QuestionBankPage';
import { QuestionDetailPage } from '@/pages/QuestionDetailPage';
import { TheoremsPage } from '@/pages/TheoremsPage';
import { TheoremDetailPage } from '@/pages/TheoremDetailPage';
import { FlashcardSessionPage } from '@/pages/FlashcardSessionPage';

export function App() {
  return (
    <ThemeProvider>
      <BrowserRouter>
        <AuthProvider>
          <Routes>
            <Route path="/" element={<LandingPage />} />
            <Route path="/auth/callback" element={<AuthCallbackPage />} />

            <Route element={<RequireAuth />}>
              <Route path="/onboarding" element={<OnboardingPage />} />
              <Route element={<RequireOnboarding />}>
                <Route element={<AppShell />}>
                  <Route path="/dashboard" element={<DashboardPage />} />
                  <Route path="/questions" element={<QuestionBankPage />} />
                  <Route path="/questions/:id" element={<QuestionDetailPage />} />
                  <Route path="/theorems" element={<TheoremsPage />} />
                  <Route path="/theorems/flashcards" element={<FlashcardSessionPage />} />
                  <Route path="/theorems/:id" element={<TheoremDetailPage />} />
                  <Route path="/practice" element={<PracticePage />} />
                  <Route path="/bookmarks" element={<BookmarksPage />} />
                  <Route path="/progress" element={<ProgressPage />} />
                  <Route path="/courses/:courseId" element={<CoursePage />} />
                  <Route path="/profile" element={<ProfilePage />} />
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
        </AuthProvider>
      </BrowserRouter>
    </ThemeProvider>
  );
}
