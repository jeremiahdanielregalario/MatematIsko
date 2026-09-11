import { useState } from 'react';
import type { Course, QuestionWithMeta } from '@/types';
import { Button } from '@/components/ui/button';
import { Card, CardContent } from '@/components/ui/card';
import { createExam, selectExamQuestions, type ExamSession } from './exam';

const fieldClass =
  'mt-1 block w-full rounded-lg border border-stone-300 bg-white p-2 text-stone-900 dark:border-stone-700 dark:bg-stone-900 dark:text-stone-100';

export function ExamSetup({
  questions,
  courses,
  onStart,
}: {
  questions: QuestionWithMeta[];
  courses: Course[];
  onStart: (session: ExamSession) => void;
}) {
  const [courseId, setCourseId] = useState('');
  const [topics, setTopics] = useState<string[]>([]);
  const [count, setCount] = useState(10);
  const [minutes, setMinutes] = useState(45);
  const bank = questions.filter((q) => !courseId || q.course_id === courseId);
  const availableTopics = [
    ...new Map(
      bank.map((q) => [
        q.topic_id,
        { name: q.topic?.name ?? 'Other topics', course: q.course?.code },
      ]),
    ).entries(),
  ];
  const candidates = bank.filter((q) => !topics.length || topics.includes(q.topic_id));
  const actualCount = Math.min(count, candidates.length);
  const valid =
    actualCount > 0 &&
    Number.isInteger(count) &&
    count >= 1 &&
    count <= 30 &&
    Number.isInteger(minutes) &&
    minutes >= 5 &&
    minutes <= 90 &&
    count >= topics.length;

  return (
    <Card className="mx-auto max-w-3xl">
      <CardContent className="space-y-6 p-5 sm:p-8">
        <div>
          <h2 className="font-serif text-2xl font-semibold">Build your paper</h2>
          <p className="mt-2 text-sm text-stone-500 dark:text-stone-400">
            Questions come from the existing question bank. Work on paper or keep brief answers
            here. Hints and solutions stay locked during the exam.
          </p>
        </div>
        <div className="flex flex-wrap gap-2" aria-label="Exam presets">
          {[
            { label: 'Quick quiz · 20 min', count: 5, minutes: 20 },
            { label: 'Practice exam · 45 min', count: 10, minutes: 45 },
            { label: 'Mock exam · 75 min', count: 15, minutes: 75 },
          ].map((preset) => (
            <Button
              key={preset.minutes}
              variant={minutes === preset.minutes && count === preset.count ? 'default' : 'outline'}
              onClick={() => {
                setMinutes(preset.minutes);
                setCount(preset.count);
              }}
            >
              {preset.label}
            </Button>
          ))}
        </div>
        <label className="block text-sm font-medium">
          Course
          <select
            className={fieldClass}
            value={courseId}
            onChange={(event) => {
              setCourseId(event.target.value);
              setTopics([]);
            }}
          >
            <option value="">All my courses</option>
            {courses.map((course) => (
              <option key={course.id} value={course.id}>
                {course.code} — {course.name}
              </option>
            ))}
          </select>
        </label>
        <fieldset className="space-y-3">
          <legend className="text-sm font-semibold">Topics to include</legend>
          <p className="text-sm text-stone-500 dark:text-stone-400">
            Leave all unchecked for a random mix. Selected topics each get at least one question.
          </p>
          <div className="grid max-h-64 gap-2 overflow-y-auto sm:grid-cols-2">
            {availableTopics.map(([id, topic]) => (
              <label
                key={id}
                className="flex items-center gap-3 rounded-lg border border-stone-200 p-3 text-sm dark:border-stone-700"
              >
                <input
                  type="checkbox"
                  checked={topics.includes(id)}
                  onChange={(event) =>
                    setTopics(
                      event.target.checked
                        ? [...topics, id]
                        : topics.filter((topicId) => topicId !== id),
                    )
                  }
                  className="size-4 accent-brand-900"
                />
                <span>
                  {topic.name}
                  <span className="ml-2 text-xs text-stone-500">{topic.course}</span>
                </span>
              </label>
            ))}
          </div>
          {topics.length > 0 && (
            <Button variant="ghost" size="sm" onClick={() => setTopics([])}>
              Use random topics
            </Button>
          )}
        </fieldset>
        <div className="grid gap-4 sm:grid-cols-2">
          <label className="text-sm font-medium">
            Number of questions
            <input
              className={fieldClass}
              type="number"
              min={1}
              max={30}
              value={count}
              onChange={(event) => setCount(Number(event.target.value))}
            />
          </label>
          <label className="text-sm font-medium">
            Time limit (minutes)
            <input
              className={fieldClass}
              type="number"
              min={5}
              max={90}
              value={minutes}
              onChange={(event) => setMinutes(Number(event.target.value))}
            />
          </label>
        </div>
        <p className="text-sm text-stone-500 dark:text-stone-400">
          {candidates.length} available questions. Your paper will contain {actualCount} questions.
          Choose 1–30 questions and 5–90 minutes. Timing is your study budget, not an estimate of
          question difficulty.
        </p>
        {count < topics.length && (
          <p role="alert" className="text-sm text-red-600">
            Choose at least {topics.length} questions to include every selected topic.
          </p>
        )}
        {!candidates.length && <p role="status">No questions are available for this selection.</p>}
        <Button
          size="lg"
          className="w-full"
          disabled={!valid}
          onClick={() => onStart(createExam(selectExamQuestions(bank, topics, count), minutes))}
        >
          Create paper & start timer
        </Button>
        <p className="text-xs text-stone-500">
          The timer keeps running if you leave. This tab saves your paper across refreshes; closing
          the tab ends that saved session.
        </p>
      </CardContent>
    </Card>
  );
}
