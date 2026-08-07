import { GraduationCap, Loader2, Save } from 'lucide-react';
import { useState } from 'react';
import { Navigate, useNavigate } from 'react-router-dom';
import { ErrorState } from '@/components/common/ErrorState';
import { LoadingState } from '@/components/common/LoadingState';
import { Logo } from '@/components/Logo';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Input } from '@/components/ui/input';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { useAuth } from '@/hooks/useAuth';
import { useCourses } from '@/hooks/useCourses';
import { setUserCourses, updateProfileOnboarding } from '@/lib/db';
import { cn } from '@/lib/cn';
import type { Course } from '@/types';

const YEAR_LEVELS = ['1st Year', '2nd Year', '3rd Year', '4th Year', '5th Year or more'];

function CourseCheckbox({
  course,
  checked,
  onToggle,
}: {
  course: Course;
  checked: boolean;
  onToggle: () => void;
}) {
  return (
    <label className="flex cursor-pointer items-center gap-3 rounded-lg border border-stone-200 px-3 py-2.5 text-sm transition-colors has-[:checked]:border-brand-700 has-[:checked]:bg-brand-50 dark:border-stone-800 dark:has-[:checked]:border-brand-500 dark:has-[:checked]:bg-brand-950/40">
      <input
        type="checkbox"
        checked={checked}
        onChange={onToggle}
        className="size-4 shrink-0 accent-brand-800 dark:accent-brand-400"
      />
      <span className="font-medium text-stone-900 dark:text-stone-100">{course.code}</span>
      <span className="text-stone-500 dark:text-stone-400">{course.name}</span>
    </label>
  );
}

export function OnboardingPage() {
  const { user, profile, loading } = useAuth();
  const navigate = useNavigate();
  const { data: courses, loading: coursesLoading, error: coursesError, reload } = useCourses();

  const [degreeProgram, setDegreeProgram] = useState('');
  const [yearLevel, setYearLevel] = useState<string | undefined>();
  const [upmmcMember, setUpmmcMember] = useState(false);
  const [selectedCourseIds, setSelectedCourseIds] = useState<string[]>([]);
  const [submitting, setSubmitting] = useState(false);
  const [error, setError] = useState<string | null>(null);

  if (loading) return <LoadingState label="Preparing your setup" />;

  if (!user) return <Navigate to="/" replace />;

  const onboardingComplete = Boolean(profile?.degree_program && profile?.year_level);
  if (onboardingComplete) {
    return <Navigate to="/dashboard" replace />;
  }

  const toggleCourse = (courseId: string) => {
    setSelectedCourseIds((prev) =>
      prev.includes(courseId) ? prev.filter((id) => id !== courseId) : [...prev, courseId],
    );
  };

  const handleSubmit = async () => {
    setError(null);
    if (!degreeProgram.trim()) {
      setError('Please enter your degree program.');
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
      await updateProfileOnboarding(user.id, {
        degree_program: degreeProgram.trim(),
        year_level: yearLevel,
        upmmc_member: upmmcMember,
      });
      await setUserCourses(user.id, selectedCourseIds);
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
                <Input
                  id="degree-program"
                  value={degreeProgram}
                  onChange={(e) => setDegreeProgram(e.target.value)}
                  placeholder="e.g. BS Mathematics"
                  autoComplete="off"
                />
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
                  <div className="grid max-h-72 gap-2 overflow-y-auto pr-1">
                    {(courses ?? []).map((course) => (
                      <CourseCheckbox
                        key={course.id}
                        course={course}
                        checked={selectedCourseIds.includes(course.id)}
                        onToggle={() => toggleCourse(course.id)}
                      />
                    ))}
                  </div>
                )}
              </div>

              <div className="flex flex-col gap-1.5">
                <Label>Are you a member of UPMMC?</Label>
                <div className="grid grid-cols-2 gap-2">
                  {[
                    { value: true, label: 'Yes' },
                    { value: false, label: 'No' },
                  ].map(({ value, label }) => (
                    <label
                      key={label}
                      className={cn(
                        'flex h-10 cursor-pointer items-center justify-center gap-2 rounded-lg border border-stone-300 text-sm font-medium transition-colors',
                        'focus-within:outline-2 focus-within:outline-offset-2 focus-within:outline-brand-600',
                        upmmcMember === value
                          ? 'border-brand-900 bg-brand-900 text-white dark:border-brand-800 dark:bg-brand-800'
                          : 'bg-white text-stone-700 hover:bg-stone-50 dark:bg-stone-950 dark:text-stone-300 dark:hover:bg-stone-800',
                      )}
                    >
                      <input
                        type="radio"
                        name="upmmc-member"
                        checked={upmmcMember === value}
                        onChange={() => setUpmmcMember(value)}
                        className="sr-only"
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
