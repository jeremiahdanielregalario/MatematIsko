import { Play } from 'lucide-react';
import { useMemo, useState } from 'react';
import type { Course, Difficulty, QuestionFilter, QuestionWithMeta, Topic } from '@/types';
import { Button } from '@/components/ui/button';
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from '@/components/ui/card';
import { Label } from '@/components/ui/label';
import { Select, SelectContent, SelectItem, SelectTrigger, SelectValue } from '@/components/ui/select';
import { DIFFICULTY_LABELS } from '@/lib/constants';
import { shuffleQuestions } from '@/lib/practice';
import { applyFilterAndSort } from '@/lib/questionFilter';

const COUNT_OPTIONS = [5, 10, 15, 25];

interface PracticeSetupProps {
  courses: Course[];
  questions: QuestionWithMeta[];
  initial: QuestionFilter;
  onStart: (ids: string[]) => void;
}

export function PracticeSetup({ courses, questions, initial, onStart }: PracticeSetupProps) {
  const [courseId, setCourseId] = useState<string | undefined>(initial.courseId);
  const [topicId, setTopicId] = useState<string | undefined>(initial.topicId);
  const [difficulty, setDifficulty] = useState<Difficulty | undefined>(initial.difficulty);
  const [count, setCount] = useState(COUNT_OPTIONS[1]);

  const topics = useMemo(() => {
    const filteredByCourse = courseId
      ? questions.filter((q) => q.course_id === courseId)
      : questions;
    const map = new Map<string, Topic>();
    for (const q of filteredByCourse) {
      if (q.topic) map.set(q.topic.id, { id: q.topic.id, course_id: q.topic.course_id, name: q.topic.name });
    }
    return [...map.values()].sort((a, b) => a.name.localeCompare(b.name));
  }, [questions, courseId]);

  const candidates = useMemo(
    () =>
      applyFilterAndSort(questions, {
        courseId,
        topicId,
        difficulty,
        sort: 'random',
      }),
    [questions, courseId, topicId, difficulty],
  );

  const handleStart = () => {
    const picked = shuffleQuestions(candidates).slice(0, count);
    if (picked.length === 0) return;
    onStart(picked.map((q) => q.id));
  };

  return (
    <Card className="mx-auto max-w-2xl">
      <CardHeader>
        <CardTitle className="font-serif text-2xl">Set up a practice session</CardTitle>
        <CardDescription>
          We will randomly pick questions from your selection. You can reveal hints, answers, and
          solutions, then mark each problem as correct, incorrect, or not sure.
        </CardDescription>
      </CardHeader>
      <CardContent className="space-y-5">
        <div className="grid gap-4 sm:grid-cols-2">
          <div className="flex flex-col gap-1.5">
            <Label htmlFor="practice-course">Course</Label>
            <Select
              value={courseId ?? 'all'}
              onValueChange={(value) => {
                setCourseId(value === 'all' ? undefined : value);
                setTopicId(undefined);
              }}
            >
              <SelectTrigger id="practice-course">
                <SelectValue placeholder="All courses" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">All courses</SelectItem>
                {courses.map((course: Course) => (
                  <SelectItem key={course.id} value={course.id}>
                    {course.code} — {course.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="flex flex-col gap-1.5">
            <Label htmlFor="practice-topic">Topic</Label>
            <Select
              value={topicId ?? 'all'}
              onValueChange={(value) => setTopicId(value === 'all' ? undefined : value)}
            >
              <SelectTrigger id="practice-topic">
                <SelectValue placeholder="All topics" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">All topics</SelectItem>
                {topics.map((topic) => (
                  <SelectItem key={topic.id} value={topic.id}>
                    {topic.name}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="flex flex-col gap-1.5">
            <Label htmlFor="practice-difficulty">Difficulty</Label>
            <Select
              value={difficulty ?? 'all'}
              onValueChange={(value) =>
                setDifficulty(value === 'all' ? undefined : (value as Difficulty))
              }
            >
              <SelectTrigger id="practice-difficulty">
                <SelectValue placeholder="Any difficulty" />
              </SelectTrigger>
              <SelectContent>
                <SelectItem value="all">Any difficulty</SelectItem>
                {(Object.keys(DIFFICULTY_LABELS) as Difficulty[]).map((d) => (
                  <SelectItem key={d} value={d}>
                    {DIFFICULTY_LABELS[d]}
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>

          <div className="flex flex-col gap-1.5">
            <Label htmlFor="practice-count">Number of questions</Label>
            <Select value={String(count)} onValueChange={(value) => setCount(Number(value))}>
              <SelectTrigger id="practice-count">
                <SelectValue />
              </SelectTrigger>
              <SelectContent>
                {COUNT_OPTIONS.map((option) => (
                  <SelectItem key={option} value={String(option)}>
                    {option} questions
                  </SelectItem>
                ))}
              </SelectContent>
            </Select>
          </div>
        </div>

        <p className="text-sm text-stone-500 dark:text-stone-400">
          {candidates.length} question{candidates.length === 1 ? '' : 's'} match your selection.
        </p>

        <Button className="w-full" size="lg" disabled={candidates.length === 0} onClick={handleStart}>
          <Play className="size-4" />
          Start practice
        </Button>
      </CardContent>
    </Card>
  );
}
