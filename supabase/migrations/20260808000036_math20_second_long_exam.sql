-- ============================================================================
-- Math 20 Precalculus — Second Long Examination, 1st Sem A.Y. 2024-2025
-- 10 problems (split into individual questions where possible).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced:
--   • Polynomial and Rational Functions
--   • Exponential and Logarithmic Functions
--   • Functions and Their Graphs
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Polynomial and Rational Functions',
    'Polynomial equations, the remainder theorem, and rational functions.'
  ),
  (
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Exponential and Logarithmic Functions',
    'Exponential and logarithmic equations.'
  ),
  (
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Functions and Their Graphs',
    'Domain, composition, inverse functions, and piecewise-defined functions.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Cubic equation
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f03',
    'Solution Set of $9x^3 - x^2 - 11x - 1 = 0$',
    $BODY$Find the solution set of the equation. Include imaginary roots if there are any.
$$9x^3 - x^2 - 11x - 1 = 0.$$$BODY$,
    'medium',
    2024,
    'Second Long Examination',
    1,
    $BODY$Try the rational root $x = -1$, then factor and solve the resulting quadratic with the quadratic formula.$BODY$,
    $BODY$\left\{ -1, \frac{5 + \sqrt{34}}{9}, \frac{5 - \sqrt{34}}{9} \right\}$BODY$,
    $BODY$Test rational candidates: $x = -1$ gives $9(-1) - 1 + 11 - 1 = 0$, so $x + 1$ is a factor. Synthetic division of $9x^3 - x^2 - 11x - 1$ by $x + 1$ gives the quotient $9x^2 - 10x - 1$. Hence
$$9x^3 - x^2 - 11x - 1 = (x + 1)(9x^2 - 10x - 1).$$
By the quadratic formula,
$$x = \frac{10 \pm \sqrt{100 + 36}}{18} = \frac{10 \pm \sqrt{136}}{18} = \frac{5 \pm \sqrt{34}}{9}.$$
All three roots are real, so the solution set is
$$\left\{ -1, \frac{5 + \sqrt{34}}{9}, \frac{5 - \sqrt{34}}{9} \right\}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — Exponential equation
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f04',
    'Solution Set of $4^x - 24 = 5(2^x)$',
    $BODY$Find the solution set of the equation. Include imaginary roots if there are any.
$$4^x - 24 = 5(2^x).$$$BODY$,
    'easy',
    2024,
    'Second Long Examination',
    2,
    $BODY$Let $u = 2^x$; then $4^x = u^2$. Solve the quadratic in $u$ and reject the negative root.$BODY$,
    $BODY$\{3\}$BODY$,
    $BODY$Let $u = 2^x > 0$. Then $4^x = (2^2)^x = (2^x)^2 = u^2$, and the equation becomes
$$u^2 - 24 = 5u \iff u^2 - 5u - 24 = 0 \iff (u - 8)(u + 3) = 0.$$
So $u = 8$ or $u = -3$. Since $u = 2^x > 0$, reject $u = -3$. From $2^x = 8$ we get $x = 3$. The solution set is $\{3\}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q3 — Logarithmic equation
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f04',
    'Solution Set of $2\log_5(x - 5) = \log_5(17 - x)$',
    $BODY$Find the solution set of the equation. Include imaginary roots if there are any.
$$2\log_5(x - 5) = \log_5(17 - x).$$$BODY$,
    'medium',
    2024,
    'Second Long Examination',
    3,
    $BODY$Use $\log$ properties to combine the left side into $\log_5(x - 5)^2$, drop the logarithms, and check the domain $5 < x < 17$.$BODY$,
    $BODY$\{8\}$BODY$,
    $BODY$The domain requires $x - 5 > 0$ and $17 - x > 0$, so $5 < x < 17$. Rewriting,
$$\log_5(x - 5)^2 = \log_5(17 - x).$$
Since $\log_5$ is one-to-one,
$$(x - 5)^2 = 17 - x \iff x^2 - 10x + 25 = 17 - x \iff x^2 - 9x + 8 = 0 \iff (x - 1)(x - 8) = 0.$$
Thus $x = 1$ or $x = 8$; only $x = 8$ lies in the domain $(5, 17)$. The solution set is $\{8\}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q4 — Domain of f(x) = sqrt(2x+3)
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    'Domain of $f(x) = \sqrt{2x + 3}$',
    $BODY$Given $f(x) = \sqrt{2x + 3}$, find the domain of $f$.$BODY$,
    'easy',
    2024,
    'Second Long Examination',
    4,
    $BODY$The radicand must be nonnegative: $2x + 3 \ge 0$.$BODY$,
    $BODY$The domain is $\left[-\frac{3}{2}, \infty\right)$.$BODY$,
    $BODY$The square root is defined only for nonnegative radicands:
$$2x + 3 \ge 0 \iff x \ge -\frac{3}{2}.$$
So the domain of $f$ is $\left[-\frac{3}{2}, \infty\right)$. $\blacksquare$ $BODY$
  ),
  (
    -- Q5 — Composition g∘f
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    'The Composition $(g \circ f)(x)$ for $f(x) = \sqrt{2x + 3}$ and $g(x) = \frac{1}{x^2 - 5}$',
    $BODY$Given $f(x) = \sqrt{2x + 3}$ and $g(x) = \frac{1}{x^2 - 5}$, find $(g \circ f)(x)$ and its domain.$BODY$,
    'medium',
    2024,
    'Second Long Examination',
    5,
    $BODY$Substitute $f(x)$ into $g$, simplify, and intersect the domain of $f$ with the restriction that the denominator is nonzero.$BODY$,
    $BODY$(g \circ f)(x) = \frac{1}{2x - 2}$, with domain $\left[-\frac{3}{2}, 1\right) \cup (1, \infty)$.$BODY$,
    $BODY$Compute
$$(g \circ f)(x) = g(f(x)) = \frac{1}{\left(\sqrt{2x + 3}\right)^2 - 5} = \frac{1}{2x + 3 - 5} = \frac{1}{2x - 2}.$$
The domain of $f$ is $x \ge -\frac{3}{2}$, and the denominator requires $2x - 2 \ne 0$, i.e. $x \ne 1$. Hence the domain of $g \circ f$ is
$$\left[-\frac{3}{2}, 1\right) \cup (1, \infty). \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Inverse of f
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    'The Inverse of $f(x) = \frac{x - 2}{2x + 7}$',
    $BODY$Let $f(x) = \frac{x - 2}{2x + 7}$. Find the inverse of $f$.$BODY$,
    'medium',
    2024,
    'Second Long Examination',
    6,
    $BODY$Set $y = f(x)$, swap $x$ and $y$, then solve for $y$; state the domain restriction of the inverse.$BODY$,
    $BODY$f^{-1}(x) = \frac{-7x - 2}{2x - 1}$, $x \ne \frac{1}{2}$.$BODY$,
    $BODY$Write $y = \frac{x - 2}{2x + 7}$ and swap $x$ and $y$:
$$x = \frac{y - 2}{2y + 7}.$$
Multiplying out: $x(2y + 7) = y - 2$, so $2xy + 7x = y - 2$, and collecting the $y$-terms:
$$y(2x - 1) = -2 - 7x \implies y = \frac{-7x - 2}{2x - 1}.$$
Therefore $f^{-1}(x) = \frac{-7x - 2}{2x - 1}$ with $x \ne \frac{1}{2}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q7 — Domain and range of f(x) = (x-2)/(2x+7)
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d07',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f03',
    'Domain and Range of $f(x) = \frac{x - 2}{2x + 7}$',
    $BODY$Let $f(x) = \frac{x - 2}{2x + 7}$. Determine the domain and range of $f$.$BODY$,
    'easy',
    2024,
    'Second Long Examination',
    7,
    $BODY$The denominator vanishes at $x = -\frac{7}{2}$; the horizontal asymptote $y = \frac{1}{2}$ is never attained.$BODY$,
    $BODY$Domain: $\mathbb{R} \setminus \left\{-\frac{7}{2}\right\}$. Range: $\mathbb{R} \setminus \left\{\frac{1}{2}\right\}$.$BODY$,
    $BODY$The denominator $2x + 7$ vanishes when $x = -\frac{7}{2}$, so the domain is $\mathbb{R} \setminus \left\{-\frac{7}{2}\right\}$.

For the range, suppose $y = \frac{x - 2}{2x + 7}$; then $y(2x + 7) = x - 2$, giving $x(2y - 1) = -7y - 2$. A solution $x$ exists iff $2y - 1 \ne 0$, so the value $y = \frac{1}{2}$ is excluded (indeed $\frac{x-2}{2x+7} = \frac{1}{2}$ would force $-4 = 7$, impossible). The range is $\mathbb{R} \setminus \left\{\frac{1}{2}\right\}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q8 — Remainder theorem k
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d08',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f03',
    'Values of $k$ With Integer Coefficients and Remainder $-7$',
    $BODY$Find all values of $k$ so that $p(x) = 2x^3 + (kx)^2 + kx + 5$ has integer coefficients and the remainder is $-7$ when $p(x)$ is divided by $x + 3$.$BODY$,
    'medium',
    2024,
    'Second Long Examination',
    8,
    $BODY$Integer coefficients force $k \in \mathbb{Z}$. By the Remainder Theorem, set $p(-3) = -7$ and solve the resulting quadratic.$BODY$,
    $BODY$k = -2$BODY$,
    $BODY$Writing $p(x) = 2x^3 + k^2x^2 + kx + 5$, the coefficients are integers iff $k^2$ and $k$ are integers, so $k \in \mathbb{Z}$.

By the Remainder Theorem, the remainder upon division by $x + 3$ is $p(-3)$. We require
$$p(-3) = 2(-27) + k^2(9) + k(-3) + 5 = 9k^2 - 3k - 49 = -7.$$
Thus $9k^2 - 3k - 42 = 0$, or $3k^2 - k - 14 = 0$, which factors as $(3k - 7)(k + 2) = 0$. Hence $k = \frac{7}{3}$ or $k = -2$. Only $k = -2$ is an integer, so the answer is $k = -2$. $\blacksquare$ $BODY$
  ),
  (
    -- Q9 — Sketch piecewise function
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d09',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    'Sketching a Piecewise-Defined Function With a Hole',
    $BODY$Consider the piecewise-defined function defined by
$$f(x) = \begin{cases} \dfrac{x^2 - 4}{x + 2}, & \text{if } x < -1, \\[2mm] |x^2 + 2x - 3|, & \text{if } x \ge -1. \end{cases}$$

Sketch the graph of $f$. Label the coordinates of vertices, intercepts, endpoints, and any holes (discontinuities).$BODY$,
    'hard',
    2024,
    'Second Long Examination',
    9,
    $BODY$On $x < -1$ the first piece simplifies to $x - 2$ with a hole at $x = -2$; on $x \ge -1$ sketch the absolute value of the parabola, whose vertex is at $(-1, 4)$.$BODY$,
    $BODY$Left branch: the line $y = x - 2$ on $(-\infty, -1)$ with a hole at $(-2, -4)$. Right branch: $|x^2 + 2x - 3|$ on $[-1, \infty)$, with vertex $(-1, 4)$, zeros at $x = 1$, and a jump at $x = -1$ (left limit $-3$, value $4$).$BODY$,
    $BODY$**Left branch, $x < -1$:** $f(x) = \frac{x^2 - 4}{x + 2} = \frac{(x - 2)(x + 2)}{x + 2} = x - 2$ for $x \ne -2$. So the graph is the line $y = x - 2$ with a **hole at $(-2, -4)$** (the point is removed because the original expression is undefined there). On $x < -1$ this line approaches $(-1, -3)$ but does not include it (endpoint $(-1, -3)$ is open).

**Right branch, $x \ge -1$:** $f(x) = |x^2 + 2x - 3| = |(x + 3)(x - 1)|$. The parabola $x^2 + 2x - 3$ has vertex at $x = -1$, value $(-1)^2 - 2 - 3 = -4$, so the absolute value has **vertex $(-1, 4)$**. It is negative on $(-1, 1)$ and reflected to positive, then positive for $x \ge 1$. The zeros are at $x = -3$ (not in this branch's domain) and $x = 1$. So the right branch contains the point $(-1, 4)$ (closed endpoint).

**Join at $x = -1$:** the left branch approaches $-3$ as $x \to -1^-$, while the right branch has value $4$ at $x = -1$, so there is a **jump discontinuity** at $x = -1$.

**Intercepts:** $y$-intercept at $x = 0$: $f(0) = |0 + 0 - 3| = 3$, giving $(0, 3)$. Zero at $(1, 0)$.

Important points to label: the hole $(-2, -4)$, the open endpoint $(-1, -3)$, the vertex $(-1, 4)$, the $y$-intercept $(0, 3)$, and the zero $(1, 0)$. $\blacksquare$ $BODY$
  ),
  (
    -- Q10 — Piecewise domain, range, zeros
    'e4f5a6b7-8c9d-4e0f-9a1b-2c3d4e5f6d10',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    'Domain, Range, and Zeros of a Piecewise Function',
    $BODY$Consider the piecewise-defined function defined by
$$f(x) = \begin{cases} \dfrac{x^2 - 4}{x + 2}, & \text{if } x < -1, \\[2mm] |x^2 + 2x - 3|, & \text{if } x \ge -1. \end{cases}$$

Identify the domain, range, and zeros of $f$ from its graph.$BODY$,
    'medium',
    2024,
    'Second Long Examination',
    10,
    $BODY$The only excluded point is the hole at $x = -2$. The right branch takes all values $[0, \infty)$; the left branch takes $(-\infty, -3)$ except the hole value $-4$. The only zero is at $x = 1$.$BODY$,
    $BODY$Domain: $(-\infty, -2) \cup (-2, \infty)$. Range: $(-\infty, -3) \setminus \{-4\} \cup [0, \infty)$. Zeros: $x = 1$.$BODY$,
    $BODY$**Domain.** The expression $\frac{x^2 - 4}{x + 2}$ is undefined at $x = -2$, and every other real number is in one of the branches. Hence
$$\operatorname{dom} f = (-\infty, -2) \cup (-2, \infty).$$

**Range.** On $x < -1$, $f(x) = x - 2$ takes the values $(-\infty, -3)$, except that the hole at $x = -2$ removes the value $-4$. On $x \ge -1$, $f(x) = |x^2 + 2x - 3|$ takes all values $[0, \infty)$ (minimum $0$ at $x = 1$, unbounded above). Therefore
$$\operatorname{ran} f = (-\infty, -3) \setminus \{-4\} \cup [0, \infty).$$

**Zeros.** The left branch $x - 2 = 0$ gives $x = 2$, which is not in $x < -1$. On the right branch, $|x^2 + 2x - 3| = 0$ gives $x = 1$ (in the domain) and $x = -3$ (not in $x \ge -1$). Hence the only zero is $x = 1$. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
