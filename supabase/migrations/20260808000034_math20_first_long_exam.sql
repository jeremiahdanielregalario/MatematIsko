-- ============================================================================
-- Math 20 Precalculus — First Long Examination, 1st Sem A.Y. 2024-2025
-- 4 problems (true/false, solution sets, short problems, line-and-parabola
-- system).
--
-- The MATH 20 course row is added here because it exists in the catalog
-- migration but is not present in the live database.
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.courses (id, code, name, description)
values (
  '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
  'MATH 20',
  'Precalculus: Functions and their Graphs',
  'Functions and their graphs, equations and inequalities, and analytic geometry of lines and conic sections.'
)
on conflict (code) do nothing;

insert into public.topics (id, course_id, name, description)
values
  (
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Equations and Inequalities',
    'Quadratic, radical, and absolute value equations and inequalities.'
  ),
  (
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Analytic Geometry',
    'Lines, circles, conic sections, and systems of inequalities.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — True/False
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6c01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f02',
    'True or False: Quadratic, Lines, and Ellipse',
    $BODY$Write **TRUE** if the statement is always true. Otherwise, write **FALSE**.

**(1)** The quadratic equation $x^2 - 2x + 5k = 0$ has no real solutions whenever $k > \frac{1}{5}$.

**(2)** The lines having equations $7x - 3y - 6 = 0$ and $\frac{x}{7} + \frac{y}{3} = 1$ are parallel.

**(3)** The ellipse with equation $x^2 + 16y^2 - 32y + 15 = 0$ has a vertical major axis.$BODY$,
    'easy',
    2024,
    'First Long Examination',
    1,
    $BODY$For (1) use the discriminant. For (2) compare slopes. For (3) complete the square to identify which variable carries the larger denominator.$BODY$,
    $BODY$**(1)** **TRUE** — the discriminant is $4 - 20k < 0$ exactly when $k > 1/5$.

**(2)** **FALSE** — the slopes are $\frac{7}{3}$ and $-\frac{3}{7}$, which are not equal (they are actually negative reciprocals, so the lines are perpendicular).

**(3)** **FALSE** — completing the square gives $x^2 + 16(y - 1)^2 = 1$, a horizontally oriented ellipse, so the major axis is horizontal, not vertical.$BODY$,
    $BODY$**(1)** For $x^2 - 2x + 5k = 0$ the discriminant is
$$\Delta = (-2)^2 - 4(1)(5k) = 4 - 20k.$$
There are no real solutions iff $\Delta < 0$, i.e. $4 - 20k < 0$, i.e. $k > 1/5$. The statement is **TRUE**. $\blacksquare$

**(2)** Rewrite each line in slope-intercept form:
$$7x - 3y - 6 = 0 \iff y = \tfrac{7}{3}x - 2, \qquad \tfrac{x}{7} + \tfrac{y}{3} = 1 \iff y = -\tfrac{3}{7}x + 3.$$
The slopes $\frac{7}{3}$ and $-\frac{3}{7}$ are unequal, so the lines are **not parallel**. (Since the slopes are negative reciprocals, the lines are actually perpendicular.) The statement is **FALSE**. $\blacksquare$

**(3)** Complete the square in $y$:
$$x^2 + 16y^2 - 32y + 15 = x^2 + 16(y - 1)^2 - 16 + 15 = 0 \implies x^2 + 16(y - 1)^2 = 1.$$
Dividing, $\frac{x^2}{1} + \frac{(y - 1)^2}{1/16} = 1$; the larger denominator is under $x^2$, so the major axis is horizontal. The statement is **FALSE**. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — Solution sets
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6c02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f01',
    'Solution Sets: Radical Equation and Absolute Value Inequality',
    $BODY$Find the solution set.

**(a)** $\sqrt{x + 4} - 1 = \sqrt{x - 3}$

**(b)** $\left|5x + \frac{2}{x}\right| \le 7$$BODY$,
    'medium',
    2024,
    'First Long Examination',
    2,
    $BODY$For (a), isolate one radical, square, and check the domain and extraneous roots. For (b), split into two inequalities and treat $x > 0$ and $x < 0$ separately because of the $\frac{1}{x}$ term.$BODY$,
    $BODY$**(a)** $\{12\}$.

**(b)** $\left[ -1, -\tfrac{2}{5} \right] \cup \left[ \tfrac{2}{5}, 1 \right]$.$BODY$,
    $BODY$**(a)** The domain requires $x \ge 3$. Isolate the radical:
$$\sqrt{x + 4} = \sqrt{x - 3} + 1.$$
Squaring gives $x + 4 = x - 3 + 2\sqrt{x - 3} + 1$, so $6 = 2\sqrt{x - 3}$, i.e. $\sqrt{x - 3} = 3$, hence $x = 12$. Checking: $\sqrt{16} - 1 = 3 = \sqrt{9}$. Since $12 \ge 3$, the solution set is $\{12\}$. $\blacksquare$

**(b)** Note $x \ne 0$. Solve $-7 \le 5x + \frac{2}{x} \le 7$.

*Case $x > 0$:* multiplying by $x > 0$ preserves the inequality:
$$-7x \le 5x^2 + 2 \le 7x.$$
From $5x^2 - 7x + 2 \le 0$, i.e. $(5x - 2)(x - 1) \le 0$, we get $\frac{2}{5} \le x \le 1$. The other inequality $5x^2 + 7x + 2 \ge 0$ holds for all $x > 0$ (its roots are $-1$ and $-\frac{2}{5}$). So for $x > 0$: $x \in \left[\frac{2}{5}, 1\right]$.

*Case $x < 0$:* multiplying by $x < 0$ reverses the inequality:
$$-7x \ge 5x^2 + 2 \ge 7x.$$
Now $5x^2 + 7x + 2 \le 0$, i.e. $(5x + 2)(x + 1) \le 0$, gives $-1 \le x \le -\frac{2}{5}$; and $5x^2 - 7x + 2 \ge 0$ holds for all $x < 0$. So for $x < 0$: $x \in \left[-1, -\frac{2}{5}\right]$.

Therefore the solution set is
$$\left[-1, -\tfrac{2}{5}\right] \cup \left[\tfrac{2}{5}, 1\right]. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Short problems
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6c03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f02',
    'Short Problems: Perpendicular Line, Circle, and Age Word Problem',
    $BODY$Solve the following short problems.

**(a)** Find the slope-intercept form of the equation of a line passing through the point $(4, -5)$ and perpendicular to the line $-2x - 6y - 1 = 0$.

**(b)** Find an equation of a circle with center at $(5, -5)$ and passing through $(7, -4)$.

**(c)** Five years ago, Ryzza was twice as old as Baste. The sum of their ages now is $31$. How many years older is Ryzza compared to Baste?$BODY$,
    'medium',
    2024,
    'First Long Examination',
    3,
    $BODY$For (a), use the negative reciprocal of the slope of the given line. For (b), the radius is the distance from the center to the given point. For (c), set up two equations in the current ages.$BODY$,
    $BODY$**(a)** $y = 3x - 17$.

**(b)** $(x - 5)^2 + (y + 5)^2 = 5$.

**(c)** Ryzza is $7$ years older than Baste.$BODY$,
    $BODY$**(a)** The line $-2x - 6y - 1 = 0$ has slope $m = -\frac{2}{6} = -\frac{1}{3}$. A perpendicular line has slope $3$. Passing through $(4, -5)$:
$$y + 5 = 3(x - 4) \implies y = 3x - 17. \;\blacksquare$$

**(b)** The radius is the distance from $(5, -5)$ to $(7, -4)$:
$$r = \sqrt{(7 - 5)^2 + (-4 + 5)^2} = \sqrt{4 + 1} = \sqrt{5}.$$
The equation is $(x - 5)^2 + (y + 5)^2 = 5$. $\blacksquare$

**(c)** Let $R$ and $B$ be Ryzza's and Baste's current ages. Five years ago, Ryzza was twice as old as Baste: $R - 5 = 2(B - 5)$. The sum of current ages is $R + B = 31$. From the first equation $R = 2B - 5$; substituting gives $2B - 5 + B = 31$, so $B = 12$ and $R = 19$. Hence Ryzza is $19 - 12 = 7$ years older. $\blacksquare$ $BODY$
  ),
  (
    -- Q4 — Line and parabola system
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6c04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f02',
    'The Line $x - 2y - 1 = 0$ and the Parabola $x^2 - 6x + 6y + 3 = 0$',
    $BODY$Consider the line $\ell : x - 2y - 1 = 0$ and the parabola $\mathcal{P} : x^2 - 6x + 6y + 3 = 0$.

**(a)** Find the $y$-intercepts of line $\ell$ and parabola $\mathcal{P}$.

**(b)** Determine the equation of the directrix, and find the coordinates of the vertex, focus, and endpoints of the latus rectum of parabola $\mathcal{P}$.

**(c)** Solve algebraically for the point(s) of intersection of the graphs of line $\ell$ and parabola $\mathcal{P}$.

**(d)** Sketch the solution region of the system
$$\begin{cases} x^2 - 6x + 6y + 3 \ge 0, \\ x - 2y - 1 < 0. \end{cases}$$
Label all the important points in your sketch.$BODY$,
    'hard',
    2024,
    'First Long Examination',
    4,
    $BODY$For (a) set $x = 0$. For (b) complete the square to write $(x - 3)^2 = -6(y - 1)$. For (c) substitute $x = 2y + 1$ from $\ell$ into $\mathcal{P}$. For (d) combine $y \ge 1 - (x-3)^2/6$ with $y > (x-1)/2$.$BODY$,
    $BODY$**(a)** $\ell$ has $y$-intercept $(0, -\tfrac{1}{2})$; $\mathcal{P}$ has $y$-intercept $(0, -\tfrac{1}{2})$.

**(b)** $\mathcal{P}$: vertex $(3, 1)$, focus $\left(3, -\tfrac{1}{2}\right)$, directrix $y = \tfrac{5}{2}$, latus rectum endpoints $\left(0, -\tfrac{1}{2}\right)$ and $\left(6, -\tfrac{1}{2}\right)$.

**(c)** $(0, -\tfrac{1}{2})$ and $(3, 1)$.

**(d)** The region consists of the points on or above the parabola and strictly above the line $\ell$.$BODY$,
    $BODY$**(a)** Setting $x = 0$:
$$\ell:\; -2y - 1 = 0 \implies y = -\tfrac{1}{2}; \qquad \mathcal{P}:\; 6y + 3 = 0 \implies y = -\tfrac{1}{2}.$$
Both graphs pass through $\left(0, -\tfrac{1}{2}\right)$. $\blacksquare$

**(b)** Complete the square:
$$x^2 - 6x + 6y + 3 = (x - 3)^2 - 9 + 6y + 3 = 0 \implies (x - 3)^2 = -6(y - 1).$$
Comparing with $(x - h)^2 = 4p(y - k)$ gives $h = 3$, $k = 1$, and $4p = -6$, so $p = -\tfrac{3}{2}$. The parabola opens downward with:
- **Vertex:** $(3, 1)$.
- **Focus:** $(h, k + p) = \left(3, 1 - \tfrac{3}{2}\right) = \left(3, -\tfrac{1}{2}\right)$.
- **Directrix:** $y = k - p = 1 + \tfrac{3}{2} = \tfrac{5}{2}$.
- **Latus rectum:** length $|4p| = 6$, horizontal through the focus at $y = -\tfrac{1}{2}$, so endpoints $\left(3 \pm 3, -\tfrac{1}{2}\right) = \left(0, -\tfrac{1}{2}\right)$ and $\left(6, -\tfrac{1}{2}\right)$. $\blacksquare$

**(c)** From $\ell$, $x = 2y + 1$. Substitute into $\mathcal{P}$:
$$(2y + 1)^2 - 6(2y + 1) + 6y + 3 = 4y^2 + 4y + 1 - 12y - 6 + 6y + 3 = 2y^2 - y - 1 = 0.$$
So $(2y + 1)(y - 1) = 0$, giving $y = -\tfrac{1}{2}$ or $y = 1$. Then $x = 2y + 1$ gives $(0, -\tfrac{1}{2})$ and $(3, 1)$. The graphs intersect at $(0, -\tfrac{1}{2})$ and $(3, 1)$. $\blacksquare$

**(d)** The system is
$$x^2 - 6x + 6y + 3 \ge 0 \iff (x - 3)^2 \ge 6 - 6y \iff y \ge 1 - \tfrac{(x - 3)^2}{6},$$
and $x - 2y - 1 < 0 \iff y > \tfrac{x - 1}{2}$.

So the solution region is the set of points that lie **on or above the parabola** and **strictly above the line**. Important points to label: the vertex $(3, 1)$, focus $\left(3, -\tfrac{1}{2}\right)$, the directrix $y = \tfrac{5}{2}$, the $y$-intercept/intersection points $(0, -\tfrac{1}{2})$ and $(3, 1)$, and the other latus rectum endpoint $\left(6, -\tfrac{1}{2}\right)$. The boundary is drawn solid on the parabola (the $\ge$ inequality) and dashed on the line (the strict $<$ inequality). $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
