import { GraduationCap, Loader2, Save } from 'lucide-react';
import { useState } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { CoursePicker } from '@/components/courses/CoursePicker';
import { Logo } from '@/components/Logo';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { useAuth } from '@/hooks/useAuth';
import { useCourses } from '@/hooks/useCourses';
import { ensureProfile, setUserCourses, updateProfileOnboarding } from '@/lib/db';

const YEAR_LEVELS = ['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year or more'];

const DEGREE_PROGRAMS = [
  'BS Mathematics',
  'BA Anthropology',
  'BS Applied Physics',
  'BA Applied Psychology',
  'BS Architecture',
  'B Fine Arts',
  'BA Art Studies',
  'BS Biology',
  'BA Broadcast Communication',
  'BS Business Administration',
  'BS Business Administration and Accountancy',
  'BS Business Economics',
  'BA Business Economics',
  'BS Business Management',
  'BS Chemical Engineering',
  'BS Chemistry',
  'BS Civil Engineering',
  'BS Clothing Technology',
  'BS Community Development',
  'BA Communication Research',
  'BS Community Nutrition',
  'BA Comparative Literature',
  'BS Computer Engineering',
  'BS Computer Science',
  'BA Creative Writing',
  'BS Economics',
  'BS Electrical Engineering',
  'BS Electronics Engineering',
  'B Elementary Education',
  'BA English Studies: Language',
  'BA English Studies: Literature',
  'BA European Languages',
  'BS Family Life and Child Development',
  'BA Filipino',
  'BA Film',
  'BS Food Technology',
  'BS Geodetic Engineering',
  'BS Geography',
  'BS Geology',
  'BA History',
  'BS Home Economics',
  'BS Hotel, Restaurant and Institution Management',
  'BS Industrial Engineering',
  'BS Interior Design',
  'BA Journalism',
  'B Landscape Architecture',
  'B Library and Information Science',
  'BA Linguistics',
  'BA Malikhaing Pagsulat',
  'BS Materials Engineering',
  'BS Mechanical Engineering',
  'BS Metallurgical Engineering',
  'BS Mining Engineering',
  'BS Molecular Biology and Biotechnology',
  'B Music',
  'BA Philippine Studies',
  'BA Philosophy',
  'B Physical Education',
  'BS Physics',
  'BA Political Science',
  'B Public Administration',
  'BA Psychology',
  'BFA Sculpture',
  'B Secondary Education',
  'BS Social Work',
  'BA Sociology',
  'BA Speech Communication',
  'B Sport Science',
  'AA Sports Studies',
  'BS Statistics',
  'BA Theatre Arts',
  'BS Tourism',
];

export function OnboardingPage() {
  const { user, profile, loading, profileLoading, refreshProfile } = useAuth();
  const navigate = useNavigate();
  const { data: courses, loading: coursesLoading, error: coursesError, reload } = useCourses();

  const [degreeProgram, setDegreeProgram] = useState<string | undefined>();
  const [yearLevel, setYearLevel] = useState<string | undefined>();
  const [upmmcMember, setUpmmcMember] = useState(false);
  const [selectedCourseIds, setSelectedCourseIds] = useState<string[]>([]);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  if (loading || profileLoading) return <LoadingState label="Preparing your setup" />;

  if (!user) return <Navigate to="/" replace />;

  const onboardingComplete = Boolean(profile?.degree_program && profile?.year_level);
  if (onboardingComplete) {
    return <Navigate to="/dashboard" replace />;
  }

  const handleSubmit = async () => {
    setError(null);
    if (!degreeProgram) {
      setError('Please select your degree program.');
      return;
    }
    if (!yearLevel) {
      setError('Please select your year level.');
      return;
    }
    if (selectedCourseIds.length === 0) {
      setError('Please choose at least one math course to study.');
      return;
    }
    setSubmitting(true);
    try {
      await ensureProfile(
        user.id,
        user.email ?? '',
        user.user_metadata?.full_name ?? null,
        user.user_metadata?.avatar_url ?? null,
      );
      await updateProfileOnboarding(user.id, {
        degree_program: degreeProgram,
        year_level: yearLevel,
        upmmc_member: upmmcMember,
      });
      await setUserCourses(user.id, selectedCourseIds);
      await refreshProfile();
      navigate('/dashboard', { replace: true });
    } catch (err) {
      setError(err instanceof Error ? err.message : 'Something went wrong. Please try again.');
      setSubmitting(false);
    }
  };

  return (
    <div className="flex min-h-dvh flex-col items-center justify-center px-4 py-10">
      <div className="mb-6">
        <Logo />
      </div>

      <Card className="w-full max-w-lg">
        <CardHeader>
          <CardTitle className="font-serif text-2xl">A few questions before you start</CardTitle>
          <CardDescription>
            This helps us tailor MatematIsko to your track. You can change these answers anytime.
          </CardDescription>
        </CardHeader>
        <CardContent className="space-y-5">
          {coursesError ? (
            <ErrorState
              title="Could not load course list"
              message={coursesError.message}
              onRetry={reload}
            />
          ) : (
            <>
              <div className="flex flex-col gap-1.5">
                <Label htmlFor="degree-program">Degree program</Label>
                <Select value={degreeProgram} onValueChange={setDegreeProgram}>
                  <SelectTrigger id="degree-program">
                    <SelectValue placeholder="Select your degree program" />
                  </SelectTrigger>
                  <SelectContent>
                    {DEGREE_PROGRAMS.map((program) => (
                      <SelectItem key={program} value={program}>
                        {program}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div className="flex flex-col gap-1.5">
                <Label htmlFor="year-level">Year level</Label>
                <Select value={yearLevel} onValueChange={setYearLevel}>
                  <SelectTrigger id="year-level">
                    <SelectValue placeholder="Select your year level" />
                  </SelectTrigger>
                  <SelectContent>
                    {YEAR_LEVELS.map((level) => (
                      <SelectItem key={level} value={level}>
                        {level}
                      </SelectItem>
                    ))}
                  </SelectContent>
                </Select>
              </div>

              <div className="flex flex-col gap-2">
                <Label>Which math courses do you want to study?</Label>
                {coursesLoading ? (
                  <div className="flex items-center justify-center gap-2 py-6 text-sm text-stone-500 dark:text-stone-400">
                    <Loader2 className="size-4 animate-spin" />
                    Loading courses&hellip;
                  </div>
                ) : (
                  <CoursePicker
                    courses={courses ?? []}
                    value={selectedCourseIds}
                    onChange={setSelectedCourseIds}
                  />
                )}
              </div>

              <div className="flex flex-wrap items-center gap-x-3 gap-y-2">
                <span className="text-sm font-medium text-stone-700 dark:text-stone-300">
                  Are you a member of UPMMC?
                </span>
                <div className="flex items-center gap-3">
                  {[
                    { value: true, label: 'Yes' },
                    { value: false, label: 'No' },
                  ].map(({ value, label }) => (
                    <label
                      key={label}
                      className="flex cursor-pointer items-center gap-1.5 text-sm text-stone-900 dark:text-stone-100"
                    >
                      <input
                        type="radio"
                        name="upmmc-member"
                        checked={upmmcMember === value}
                        onChange={() => setUpmmcMember(value)}
                        className="size-4 shrink-0 accent-brand-800 dark:accent-brand-400"
                      />
                      {label}
                    </label>
                  ))}
                </div>
              </div>

              {error ? (
                <p role="alert" className="text-sm font-medium text-red-600 dark:text-red-400">
                  {error}
                </p>
              ) : null}

              <Button
                className="w-full"
                size="lg"
                onClick={() => void handleSubmit()}
                disabled={submitting || coursesLoading || Boolean(coursesError)}
              >
                {submitting ? <Loader2 className="size-4 animate-spin" /> : <Save className="size-4" />}
                {submitting ? 'Saving…' : 'Start reviewing'}
              </Button>
              <p className="flex items-center justify-center gap-1.5 text-center text-xs text-stone-400 dark:text-stone-500">
                <GraduationCap className="size-3.5" />
                Your answers are only shared with you.
              </p>
            </>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
