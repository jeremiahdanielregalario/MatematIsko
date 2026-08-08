-- ============================================================================
-- Math 20 First Long Examination — split the combined "Short Problems"
-- question into three separate questions.
--
--   • Deletes the combined question (bookmarks/progress cascade).
--   • Inserts three standalone questions (perpendicular line, circle, age).
--   • Renumbers the line-and-parabola question from 4 to 6 so the exam
--     numbering becomes 1, 2, 3, 4, 5, 6.
-- ============================================================================

delete from public.questions
where id = 'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6c03';

update public.questions
set question_number = 6
where id = 'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6c04';

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q3 — Perpendicular line
    '1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f02',
    'The Perpendicular to $-2x - 6y - 1 = 0$ Through $(4, -5)$',
    $BODY$Find the slope-intercept form of the equation of a line passing through the point $(4, -5)$ and perpendicular to the line $-2x - 6y - 1 = 0$.$BODY$,
    'easy',
    2024,
    'First Long Examination',
    3,
    $BODY$Use the negative reciprocal of the slope of the given line, then the point-slope form.$BODY$,
    $BODY$The required line is $y = 3x - 17$.$BODY$,
    $BODY$The line $-2x - 6y - 1 = 0$ has slope $m = -\frac{2}{6} = -\frac{1}{3}$. A perpendicular line has slope $3$. Passing through $(4, -5)$:
$$y + 5 = 3(x - 4) \implies y = 3x - 17. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Circle
    '1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f02',
    'A Circle Centered at $(5, -5)$ Through $(7, -4)$',
    $BODY$Find an equation of a circle with center at $(5, -5)$ and passing through $(7, -4)$.$BODY$,
    'easy',
    2024,
    'First Long Examination',
    4,
    $BODY$The radius is the distance between the center and the given point.$BODY$,
    $BODY$The circle has equation $(x - 5)^2 + (y + 5)^2 = 5$.$BODY$,
    $BODY$The radius is the distance from $(5, -5)$ to $(7, -4)$:
$$r = \sqrt{(7 - 5)^2 + (-4 + 5)^2} = \sqrt{4 + 1} = \sqrt{5}.$$
The equation is $(x - 5)^2 + (y + 5)^2 = 5$. $\blacksquare$ $BODY$
  ),
  (
    -- Q5 — Age word problem
    '1a2b3c4d-5e6f-4a7b-8c9d-0e1f2a3b4c03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f01',
    'Ryzza and Baste: An Age Word Problem',
    $BODY$Five years ago, Ryzza was twice as old as Baste. The sum of their ages now is $31$. How many years older is Ryzza compared to Baste?$BODY$,
    'medium',
    2024,
    'First Long Examination',
    5,
    $BODY$Let $R$ and $B$ be the current ages. Set up $R + B = 31$ and $R - 5 = 2(B - 5)$, then solve for $R - B$.$BODY$,
    $BODY$Ryzza is $7$ years older than Baste.$BODY$,
    $BODY$Let $R$ and $B$ be Ryzza's and Baste's current ages. Five years ago, Ryzza was twice as old as Baste: $R - 5 = 2(B - 5)$. The sum of current ages is $R + B = 31$. From the first equation $R = 2B - 5$; substituting gives $2B - 5 + B = 31$, so $B = 12$ and $R = 19$. Hence Ryzza is $19 - 12 = 7$ years older. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
