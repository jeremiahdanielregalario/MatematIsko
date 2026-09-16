-- ============================================================================
-- Math 133 Mathematical Modeling — Exercise 05
-- Update course description and Insert optimization questions.
-- ============================================================================

-- 1. Ensure Math 133 Course exists (Idempotent upsert)
INSERT INTO public.courses (id, code, name, description)
VALUES (
  '56de71e9-a366-4101-9aa8-33c2f4039fc7',
  'MATH 133',
  'Introduction to Mathematical Modeling',
  'Overview of mathematical modeling; discrete models; model fitting; linear programming; linear and nonlinear continuous models; numerical methods; optimization of continuous models.'
)
ON CONFLICT (id) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;

-- 2. Ensure Topic exists (Idempotent)
INSERT INTO public.topics (id, course_id, name)
VALUES (
  'a3a8a38a-38a3-4a38-a38a-a38a38a38a38',
  '56de71e9-a366-4101-9aa8-33c2f4039fc7',
  'Optimization and Simplex Method'
)
ON CONFLICT (id) DO UPDATE SET name = EXCLUDED.name;

-- 3. Insert Questions (Idempotent)
INSERT INTO public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
VALUES
  (
    'b3a8a38a-38a3-4a38-a38a-a38a38a38a01',
    '56de71e9-a366-4101-9aa8-33c2f4039fc7',
    'a3a8a38a-38a3-4a38-a38a-a38a38a38a38',
    'Optimal Trail Mix Profit',
    $BODY$Suppose we run a small candy shop whose premium product is specially-blended trail mix. Suppose the trail mix consists of a mix of nuts and chocolate and that we wish to maximize our profit margin on each pound of mix sold. Suppose that we sell the mix for $3/pound, buy nuts for $1/pound, and buy chocolate for $4/pound. Suppose furthermore that we only have 10 pounds of chocolate and 12 pounds of nuts available to us each day, and that each bag of trail mix must contain at least 40% chocolate. How many pounds of chocolate and pounds of nuts should we buy to maximize our daily profit? What is the proportion of chocolate in the optimal mix? Solve graphically to obtain the CPF.$BODY$,
    'hard',
    2025,
    'Exercise 05',
    1,
    $BODY$Let $x_1$ be lbs of nuts, $x_2$ be lbs of chocolate. Maximize profit $z = 3(x_1+x_2) - x_1 - 4x_2$. Subjects: $x_1 \le 12$, $x_2 \le 10$, $x_2 \ge 0.4(x_1+x_2)$. Rearrange constraints for graphical solution.$BODY$,
    $BODY$12 lbs of nuts, 8 lbs of chocolates, proportion of chocolate is 40%.$BODY$,
    $BODY$Let $x_1$ = lbs of nuts, $x_2$ = lbs of chocolate.
    Maximize $z = 2x_1 - x_2$ subject to:
    $x_1 \le 12$, $x_2 \le 10$, $2x_1 - 3x_2 \le 0$, $x_1, x_2 \ge 0$.
    Corner points: $(0,0), (12,0), (12,8), (0,0)$.
    Optimal point: $(12,8)$. Max profit: $2(12) - 8 = 16$.
    Proportion of chocolate = $8 / (12 + 8) = 8/20 = 40\%$.$BODY$
  ),
  (
    'b3a8a38a-38a3-4a38-a38a-a38a38a38a02',
    '56de71e9-a366-4101-9aa8-33c2f4039fc7',
    'a3a8a38a-38a3-4a38-a38a-a38a38a38a38',
    'Maximization using Simplex Method',
    $BODY$Use a software package based on the simplex method to solve the problem:
    Maximize $z = -2x_1 + x_2 - 4x_3 + 3x_4$
    subject to:
    $x_1 + x_2 + 3x_3 + 2x_4 \le 4$
    $x_1 - x_3 + x_4 \ge -1$
    $2x_1 + x_2 \le 2$
    $x_1 + 2x_2 + x_3 + 2x_4 = 2$
    $x_2, x_3, x_4 \ge 0$
    (no nonnegativity constraint on $x_1$).$BODY$,
    'hard',
    2025,
    'Exercise 05',
    2,
    $BODY$Let $x_1 = x_1^+ - x_1^-$ where $x_1^+, x_1^- \ge 0$ to handle unconstrained $x_1$. Set up the initial simplex tableau in software like Excel or use the Big-M/Two-Phase method.$BODY$,
    $BODY$z = 17$BODY$,
    $BODY$Since $x_1$ is unconstrained, replace $x_1$ with $x_1^+ - x_1^-$.
    Solve using simplex method. Maximum value is 17.$BODY$
  )
ON CONFLICT (id) DO UPDATE SET
  question_text = EXCLUDED.question_text,
  difficulty = EXCLUDED.difficulty,
  hint = EXCLUDED.hint,
  answer = EXCLUDED.answer,
  solution = EXCLUDED.solution;
