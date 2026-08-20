-- ============================================================================
-- Math 20 Precalculus — Sample 1st Long Exam, A.Y. 2023-2024
-- 6 problems (equations, inequalities, analytic geometry, ellipse,
-- system of equations, system of inequalities).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced:
--   • Conic Sections
--   • Systems of Equations and Inequalities
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Conic Sections',
    'Ellipses, hyperbolas, and parabolas.'
  ),
  (
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f07',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Systems of Equations and Inequalities',
    'Solving systems of linear equations and graphing systems of inequalities.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Solution sets of equations (3 parts)
    '3d4e5f6a-7b8c-4d9e-8f0a-1b2c3d4e5c01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f01',
    'Solution Sets of Equations: Rational, Radical, and Absolute Value',
    $BODY$Find the solution sets of the following equations.

**(a)** $\dfrac{x+1}{2x^2-x-6}+\dfrac{x+5}{2x^2-11x-21} = \dfrac{x-1}{x^2-9x+14} - \dfrac{1}{2x+3}$

**(b)** $3\left(\sqrt[3]{x+2}-1\right)+ \left(\sqrt[3]{x+2}-1\right)^2 = 0$

**(c)** $|2x-3|=5$$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    1,
    $BODY$For (a), factor every denominator to find the LCD, multiply through, and solve the resulting polynomial. For (b), substitute $u = \sqrt[3]{x+2}-1$ to obtain a quadratic in $u$. For (c), split the absolute value into two cases.$BODY$,
    $BODY$**(a)** $\{0, 13\}$. **(b)** $\{-10, -1\}$. **(c)** $\{-1, 4\}$.$BODY$,
    $BODY$**(a)** Factor the denominators:

$$\frac{x+1}{(2x+3)(x-2)}+\frac{x+5}{(2x+3)(x-7)} = \frac{x-1}{(x-2)(x-7)} - \frac{1}{2x+3}.$$

The LCD is $(x-2)(x-7)(2x+3)$. Multiplying both sides by the LCD:

$$(x+1)(x-7) + (x+5)(x-2) = (x-1)(2x+3) - (x-2)(x-7).$$

Expanding:

$$(x^2 - 6x - 7) + (x^2 + 3x - 10) = (2x^2 + x - 3) - (x^2 - 9x + 14).$$

Combining like terms:

$$2x^2 - 3x - 17 = x^2 + 10x - 17 \implies x^2 - 13x = 0 \implies x(x - 13) = 0.$$

So $x = 0$ or $x = 13$. Both values satisfy the original equation (no extraneous solutions). The solution set is $\{0, 13\}$. $\blacksquare$

---

**(b)** Let $u = \sqrt[3]{x+2}-1$. Then the equation becomes

$$3u + u^2 = 0 \implies u(3 + u) = 0.$$

So $u = 0$ or $u = -3$. If $u = 0$: $\sqrt[3]{x+2} = 1 \implies x + 2 = 1 \implies x = -1$. If $u = -3$: $\sqrt[3]{x+2} = -2 \implies x + 2 = -8 \implies x = -10$. Both values satisfy the original equation. The solution set is $\{-10, -1\}$. $\blacksquare$

---

**(c)** Since $|2x - 3| = 5$, we have $2x - 3 = 5$ or $2x - 3 = -5$.

$$2x - 3 = 5 \implies 2x = 8 \implies x = 4.$$
$$2x - 3 = -5 \implies 2x = -2 \implies x = -1.$$

Both values satisfy the original equation. The solution set is $\{-1, 4\}$. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Solution sets of inequalities (2 parts)
    '3d4e5f6a-7b8c-4d9e-8f0a-1b2c3d4e5c02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f01',
    'Solution Sets of Inequalities: Rational and Absolute Value',
    $BODY$Find the solution sets of the following inequalities.

**(a)** $\dfrac{3x^2 - 10x -8}{x^2 - 16} \leq 5$

**(b)** $|1-2x|<7$$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    2,
    $BODY$For (a), subtract $5$ from both sides to obtain a single rational expression on one side, then use a sign table with the zeroes of the numerator and denominator. For (b), rewrite the absolute value inequality as a compound inequality and solve.$BODY$,
    $BODY$**(a)** $(-\infty, -9] \cup (-4, 4) \cup (4, +\infty)$. **(b)** $(-3, 4)$.$BODY$,
    $BODY$**(a)** Subtract $5$ and combine into a single fraction:

$$\frac{3x^2 - 10x - 8}{x^2 - 16} - 5 \leq 0 \implies \frac{3x^2 - 10x - 8 - 5(x^2 - 16)}{x^2 - 16} \leq 0 \implies \frac{-2x^2 - 10x + 72}{x^2 - 16} \leq 0.$$

Factor numerator and denominator:

$$\frac{-2(x - 4)(x + 9)}{(x - 4)(x + 4)} \leq 0.$$

The zeroes, arranged in ascending order, are: $-9, -4, 4$. We now use these zeroes and the factors to create a sign table:

$$\begin{array}{cccccccc}
& (-\infty,-9) & \mathbf{-9} & (-9,-4) & \mathbf{-4} & (-4,4) & \mathbf{4} & (4,+\infty)\\
x+9 & - & 0 & + & & + & & +\\
x+4 & - & & - & 0 & + & & +\\
x-4 & - & & - & & - & 0 & +\\
\\
-2(x-4)(x+9) & - & 0 & + & & + & 0 & -\\
(x-4)(x+4) & + & & + & 0 & - & 0 & +\\ \\
\frac{-2(x-4)(x+9)}{(x-4)(x+4)}
 & - & 0 & + & \text{undefined} & - & \text{undefined} & -
\end{array}$$

The solution set is the set of values of $x$ that give a negative or zero value. Therefore, the solution set is $(-\infty, -9] \cup (-4, 4) \cup (4, +\infty)$. $\blacksquare$

---

**(b)** The inequality $|1 - 2x| < 7$ is equivalent to $-7 < 1 - 2x$ and $1 - 2x < 7$. Solving each:

$$-7 < 1 - 2x \implies -8 < -2x \implies 4 > x.$$
$$1 - 2x < 7 \implies -2x < 6 \implies x > -3.$$

The solution set of $-7 < 1 - 2x$ is $(-\infty, 4)$ and the solution set of $1 - 2x < 7$ is $(-3, +\infty)$. The solution set of $|1 - 2x| < 7$ is the intersection $(-\infty, 4) \cap (-3, +\infty) = (-3, 4)$. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Analytic geometry (3 parts)
    '3d4e5f6a-7b8c-4d9e-8f0a-1b2c3d4e5c03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f02',
    'Analytic Geometry: Intercepts, Perpendicular Bisector, and Circle',
    $BODY$Given are the points $A(1,3)$, $B\left(-\frac{5}{2},4\right)$, and $C(0,7)$. Do as indicated.

**(a)** Find the $x$-intercept and $y$-intercept of the line passing through $A$ and $B$.

**(b)** Give the slope-intercept form of the equation of the perpendicular bisector of $\overline{BC}$.

**(c)** Give the center-radius form of the circle whose diameter is $\overline{AC}$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    3,
    $BODY$For (a), find the slope of the line through $A$ and $B$, use point-slope form, then set $y = 0$ and $x = 0$ for the intercepts. For (b), find the midpoint of $BC$ and the negative reciprocal of the slope of $BC$. For (c), the center is the midpoint of $AC$ and the radius is half the distance $|AC|$.$BODY$,
    $BODY$**(a)** $x$-intercept: $\frac{23}{2}$; $y$-intercept: $\frac{23}{7}$.

**(b)** $y = -\frac{5}{6}x + \frac{107}{24}$.

**(c)** $\left(x - \frac{1}{2}\right)^2 + (y - 5)^2 = \frac{17}{4}$.$BODY$,
    $BODY$**(a)** The slope of the line through $A(1, 3)$ and $B\left(-\frac{5}{2}, 4\right)$ is

$$m = \frac{4 - 3}{-\frac{5}{2} - 1} = \frac{1}{-\frac{7}{2}} = -\frac{2}{7}.$$

Using point-slope form with $A(1, 3)$: $y - 3 = -\frac{2}{7}(x - 1)$.

For the $x$-intercept, set $y = 0$:

$$0 - 3 = -\frac{2}{7}(x - 1) \implies -3 = -\frac{2}{7}(x - 1) \implies \frac{21}{2} = x - 1 \implies x = \frac{23}{2}.$$

For the $y$-intercept, set $x = 0$:

$$y - 3 = -\frac{2}{7}(0 - 1) \implies y - 3 = \frac{2}{7} \implies y = \frac{23}{7}.$$

The $x$-intercept is $\frac{23}{2}$ and the $y$-intercept is $\frac{23}{7}$. $\blacksquare$

---

**(b)** The midpoint of $\overline{BC}$ is

$$\left(\frac{0 + \left(-\frac{5}{2}\right)}{2}, \frac{7 + 4}{2}\right) = \left(-\frac{5}{4}, \frac{11}{2}\right).$$

The slope of $\overline{BC}$ is

$$m = \frac{7 - 4}{0 - \left(-\frac{5}{2}\right)} = \frac{3}{\frac{5}{2}} = \frac{6}{5}.$$

The slope of the perpendicular bisector is the negative reciprocal: $-\frac{5}{6}$. Using point-slope form with the midpoint:

$$y - \frac{11}{2} = -\frac{5}{6}\left(x + \frac{5}{4}\right).$$

Converting to slope-intercept form:

$$y = -\frac{5}{6}x - \frac{25}{24} + \frac{11}{2} = -\frac{5}{6}x + \frac{107}{24}.$$

The slope-intercept form is $y = -\frac{5}{6}x + \frac{107}{24}$. $\blacksquare$

---

**(c)** The midpoint of $\overline{AC}$ (which is the center of the circle) is

$$\left(\frac{1 + 0}{2}, \frac{3 + 7}{2}\right) = \left(\frac{1}{2}, 5\right).$$

The radius is half the distance $|AC|$:

$$|AC| = \sqrt{(0 - 1)^2 + (7 - 3)^2} = \sqrt{1 + 16} = \sqrt{17},$$

so $r = \frac{\sqrt{17}}{2}$ and $r^2 = \frac{17}{4}$. The center-radius form of the equation is

$$\left(x - \frac{1}{2}\right)^2 + (y - 5)^2 = \frac{17}{4}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Ellipse
    '3d4e5f6a-7b8c-4d9e-8f0a-1b2c3d4e5c04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f06',
    'Equation of the Ellipse With Foci $(4,-1)$, $(4,5)$ and Vertex $(4,-4)$',
    $BODY$Find the equation of the ellipse with foci at $(4,-1)$ and $(4,5)$ and a vertex at $(4,-4)$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    4,
    $BODY$The foci and vertex lie on the vertical line $x = 4$, so the major axis is vertical. Find the center as the midpoint of the foci, determine $c$ from the foci, and find $a$ from the vertex. Then use $b^2 = a^2 - c^2$.$BODY$,
    $BODY$\dfrac{(x-4)^2}{27} + \dfrac{(y-2)^2}{36} = 1$.$BODY$,
    $BODY$Since the foci $(4, -1)$ and $(4, 5)$ and the vertex $(4, -4)$ all lie on the vertical line $x = 4$, the ellipse has a vertical major axis. The equation of such an ellipse is

$$\frac{(x - h)^2}{b^2} + \frac{(y - k)^2}{a^2} = 1,$$

where $(h, k)$ is the center, $c$ is the distance from center to focus, and $a$ is the distance from center to vertex.

The center is the midpoint of the foci: $(h, k) = (4, 2)$. From the foci, $k - c = -1$ and $k + c = 5$, giving $c = 3$. Since the vertex $(4, -4)$ is below the center, $k - a = -4$, so $2 - a = -4$ and $a = 6$. Then

$$b^2 = a^2 - c^2 = 36 - 9 = 27.$$

The equation of the ellipse is

$$\boxed{\frac{(x - 4)^2}{27} + \frac{(y - 2)^2}{36} = 1.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — System of equations
    '3d4e5f6a-7b8c-4d9e-8f0a-1b2c3d4e5c05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f07',
    'Solving a $3 \times 3$ System of Linear Equations',
    $BODY$Solve the system of equalities:

$$\begin{cases} 3x-2y-z = 0 \\ x+3y+2z = 1 \\ 2x-4y-z = 2. \end{cases}$$$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    5,
    $BODY$Eliminate $z$ using equations (1) and (2), and equations (1) and (3), to obtain two equations in $x$ and $y$. Solve the resulting $2 \times 2$ system, then back-substitute.$BODY$,
    $BODY$(x, y, z) = (0, -1, 2)$.$BODY$,
    $BODY$Eliminate $z$ from pairs of equations. Using equations (1) and (2): multiply (1) by $2$ and add to (2):

$$\begin{cases} 6x - 4y - 2z = 0 \\ x + 3y + 2z = 1 \end{cases} \implies 7x - y = 1. \quad (4)$$

Using equations (1) and (3):

$$\begin{cases} 3x - 2y - z = 0 \\ 2x - 4y - z = 2 \end{cases} \implies x + 2y = -2. \quad (5)$$

Now solve equations (4) and (5). Multiply (4) by $2$:

$$14x - 2y = 2.$$

Add to (5):

$$15x = 0 \implies x = 0.$$

Substituting $x = 0$ into (5): $0 + 2y = -2 \implies y = -1$. Substituting $x = 0$ and $y = -1$ into (1): $0 - 2(-1) - z = 0 \implies z = 2$.

Therefore the solution is $(x, y, z) = (0, -1, 2)$. $\blacksquare$$BODY$
  ),
  (
    -- Q6 — System of inequalities
    '3d4e5f6a-7b8c-4d9e-8f0a-1b2c3d4e5c06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f07',
    'Sketching the Solution Region of a System of Inequalities',
    $BODY$Sketch the solution region of the following system of inequalities:

$$\begin{cases} x+y+3 > 0 \\ (x+2)^{2} + (y+2)^{2} \leq 4 \\ (x+3)^2-y<4. \end{cases}$$$BODY$,
    'hard',
    2023,
    'Sample 1st Long Exam',
    6,
    $BODY$Graph the boundary equations: the line $x + y + 3 = 0$, the circle $(x+2)^2 + (y+2)^2 = 4$, and the parabola $y = (x+3)^2 - 4$. Use the test point $(0, 0)$ to determine which side of each boundary satisfies the inequality, then find the intersection of the three regions.$BODY$,
    $BODY$The solution region is the intersection of: the half-plane above the line $x + y + 3 = 0$, the closed disk of radius $2$ centered at $(-2, -2)$, and the region above the parabola $y = (x+3)^2 - 4$.$BODY$,
    $BODY$First, we sketch the equations associated with the inequalities.

- $x + y + 3 = 0$ is the line through $(0, -3)$ with slope $m = -1$, or equivalently through its intercepts $(-3, 0)$ and $(0, -3)$.
- $(x + 2)^2 + (y + 2)^2 = 4$ is a circle centered at $(-2, -2)$ with radius $2$.
- $(x + 3)^2 - y = 4$ can be written as $y = (x + 3)^2 - 4$. This is a parabola opening upward with vertex at $(-3, -4)$. Its intercepts are: when $x = 0$, $y = 5$; when $y = 0$, $(x + 3)^2 = 4 \implies x = -1$ or $x = -5$.

Next, we identify the region satisfying each inequality using the test point $(0, 0)$:

- For the line: $0 + 0 + 3 = 3 > 0$. So the region satisfying the inequality contains $(0, 0)$, i.e., the region **above** the line.
- For the circle: $(0 + 2)^2 + (0 + 2)^2 = 8 \nleq 4$. So the region satisfying the inequality does **not** contain $(0, 0)$, i.e., the region **inside** the circle.
- For the parabola: $(0 + 3)^2 - 0 = 9 \nless 4$. So the region satisfying the inequality does **not** contain $(0, 0)$, i.e., the region **above** the parabola.

The solution region is the overlap (intersection) of these three regions: the set of points that lie above the line $x + y + 3 = 0$, inside the circle $(x + 2)^2 + (y + 2)^2 = 4$, and above the parabola $y = (x + 3)^2 - 4$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
