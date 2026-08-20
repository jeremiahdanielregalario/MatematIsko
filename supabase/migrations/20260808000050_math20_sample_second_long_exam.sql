-- ============================================================================
-- Math 20 Precalculus — Sample 2nd Long Exam, A.Y. 2023-2024
-- 7 problems (piecewise function, compositions/inverses, polynomial roots,
-- exponential/logarithmic equations, exponential evaluation, logarithm
-- evaluation, single logarithm).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Piecewise function: domain, intercepts, graph
    '5f6a7b8c-9d0e-4f1a-8b2c-3d4e5f6a7c01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    'Domain, Intercepts, and Graph of a Piecewise Function',
    $BODY$Let

$$f(x) = \begin{cases} -1, &\text{if } x < -6 \\[0.3cm] -|x + 4| + 1, &\text{if } -6 < x < -2 \\[0.3cm] \frac{2x^2 + 3x + 1}{2x + 1}, &\text{if } -2 \leq x \leq 0 \\[0.3cm] \frac{x^2 - 4x + 4}{2} - 1, &\text{if } x > 0. \end{cases}$$

**(a)** Determine the domain and intercepts of $f$.

**(b)** Sketch the graph of $f$.$BODY$,
    'hard',
    2023,
    'Sample 2nd Long Exam',
    1,
    $BODY$For the domain, note the gap at $x = -6$ and the restriction $2x + 1 \neq 0$ on the third piece. For the $x$-intercepts, solve $f(x) = 0$ on each piece and check that the solutions lie in the respective intervals.$BODY$,
    $BODY$Domain: $\mathbb{R} \setminus \left\{-6, -\frac{1}{2}\right\}$. $y$-intercept: $1$. $x$-intercepts: $-5, -3, -1, 2 - \sqrt{2}, 2 + \sqrt{2}$.$BODY$,
    $BODY$**(a)** **Domain:** Notice that $x = -6$ does not appear in any piece of the domain. Also, $2x + 1 \neq 0$ since $2x + 1$ is in the denominator of the third piece, implying $x \neq -\frac{1}{2}$. Since $-2 \leq -\frac{1}{2} \leq 0$, $x = -\frac{1}{2}$ is excluded. The domain is

$$\mathbb{R} \setminus \left\{-6, -\frac{1}{2}\right\}.$$

**$y$-intercept:** Evaluate $f(0)$ using the third piece (since $-2 \leq 0 \leq 0$ and $0 \neq -\frac{1}{2}$):

$$f(0) = \frac{2(0)^2 + 3(0) + 1}{2(0) + 1} = \frac{1}{1} = 1.$$

The $y$-intercept is $1$.

**$x$-intercepts:** We solve $f(x) = 0$ on each piece.

1. If $x < -6$: $f(x) = -1 \neq 0$. No $x$-intercepts.
2. If $-6 < x < -2$: $f(x) = -|x+4| + 1 = 0 \implies |x+4| = 1 \implies x = -3$ or $x = -5$. Both are in $(-6, -2)$.
3. If $-2 \leq x \leq 0$ and $x \neq -\frac{1}{2}$:

$$f(x) = \frac{2x^2 + 3x + 1}{2x + 1} = \frac{(2x+1)(x+1)}{2x+1} = x + 1.$$

Setting $x + 1 = 0$ gives $x = -1$, which is in $[-2, 0] \setminus \{-\frac{1}{2}\}$.

4. If $x > 0$:

$$f(x) = \frac{x^2 - 4x + 4}{2} - 1 = \frac{(x-2)^2 - 2}{2} = \frac{1}{2}x^2 - 2x + 1.$$

Setting $\frac{1}{2}x^2 - 2x + 1 = 0$ and using the quadratic formula:

$$x = \frac{2 \pm \sqrt{4 - 2}}{1} = 2 \pm \sqrt{2}.$$

Both $2 - \sqrt{2} \approx 0.59$ and $2 + \sqrt{2} \approx 3.41$ are in $(0, +\infty)$.

The $x$-intercepts are $\boxed{-5, -3, -1, 2 - \sqrt{2}, \text{ and } 2 + \sqrt{2}}$. $\blacksquare$

---

**(b)** We plot each expression of the piecewise function on its respective domain using the domain and intercepts from part (a). The graph consists of:

- A horizontal line $y = -1$ for $x < -6$ (with an open circle at $(-6, -1)$).
- An inverted V-shape $y = -|x+4| + 1$ for $-6 < x < -2$ (open circles at endpoints).
- The line $y = x + 1$ for $-2 \leq x \leq 0$ (with a hole at $(-\frac{1}{2}, \frac{1}{2})$).
- A parabola $y = \frac{1}{2}x^2 - 2x + 1$ for $x > 0$ (open circle at $(0, 1)$). $BODY$
  ),
  (
    -- Q2 — Function compositions and inverses
    '5f6a7b8c-9d0e-4f1a-8b2c-3d4e5f6a7c02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f05',
    'Function Compositions, Domain, Inverse, and Parity',
    $BODY$Let $f(x) = x^{2} - 4$, $g(x) = x - 2$, $h(x) = \sqrt{x+1}$, $k(x) = |x|$, $\ell(x) = \llbracket x - 1 \rrbracket$, and $m(x) = \dfrac{2x+3}{x-5}$. Determine the following.

**(a)** $\operatorname{dom}\left(h \circ \dfrac{f}{g}\right)$

**(b)** $(k \circ (f+g))(-1)$

**(c)** $\left(h \circ \ell \circ (\ell g)\right)\left(\frac{1}{2}\right)$

**(d)** The inverse and range of $m$.

**(e)** Is $h \circ f$ odd, even, or neither?$BODY$,
    'hard',
    2023,
    'Sample 2nd Long Exam',
    2,
    $BODY$For (a), find $\operatorname{dom}(f/g)$ first (exclude $x$ where $g(x) = 0$), then find where $(f/g)(x) \in \operatorname{dom} h$ (the radicand must be nonnegative). For (b), evaluate from the inside out. For (c), evaluate $\ell g$ first, then compose. For (d), solve $y = m(x)$ for $x$. For (e), check if $h(f(-x)) = h(f(x))$ or $-h(f(x))$.$BODY$,
    $BODY$**(a)** $[-3, 2) \cup (2, +\infty)$. **(b)** $6$. **(c)** $1$. **(d)** $m^{-1}(x) = \frac{5x+3}{x-2}$; $\operatorname{ran} m = \mathbb{R} \setminus \{2\}$. **(e)** Even.$BODY$,
    $BODY$**(a)** The composition is

$$h \circ \frac{f}{g}(x) = h\left(\frac{f(x)}{g(x)}\right) = \sqrt{\frac{x^2-4}{x-2}+1}.$$

We need $\operatorname{dom}\frac{f}{g} = \mathbb{R} \setminus \{2\}$ (since $g(x) = 0$ at $x = 2$) and the radicand $\frac{f}{g}(x) + 1 \geq 0$:

$$\frac{x^2-4}{x-2}+1 = \frac{x^2+x-6}{x-2} = \frac{(x-2)(x+3)}{x-2} \geq 0.$$

Using a sign table, the solution is $[-3, 2) \cup (2, +\infty)$. Intersecting with $\mathbb{R} \setminus \{2\}$:

$$\operatorname{dom}\left(h \circ \frac{f}{g}\right) = [-3, 2) \cup (2, +\infty). \;\blacksquare$$

---

**(b)** First, $(f+g)(-1) = f(-1) + g(-1) = ((-1)^2 - 4) + (-1 - 2) = -3 - 3 = -6$. Then

$$k \circ (f+g)(-1) = k(-6) = |-6| = 6. \;\blacksquare$$

---

**(c)** Evaluate from the inside out. First, $(\ell g)\left(\frac{1}{2}\right) = \llbracket \frac{1}{2} - 1 \rrbracket \cdot g\left(\frac{1}{2}\right) = \llbracket -\frac{1}{2} \rrbracket \cdot \left(-\frac{3}{2}\right) = (-1)\left(-\frac{3}{2}\right) = \frac{3}{2}$.

Then $\ell\left(\frac{3}{2}\right) = \llbracket \frac{3}{2} - 1 \rrbracket = \llbracket \frac{1}{2} \rrbracket = 0$ (since $0 \leq \frac{1}{2} < 1$).

Finally, $h(0) = \sqrt{0 + 1} = 1$. $\blacksquare$

---

**(d)** Set $y = \frac{2x+3}{x-5}$ and solve for $x$:

$$y(x-5) = 2x+3 \implies xy - 5y = 2x + 3 \implies x(y-2) = 5y + 3 \implies x = \frac{5y+3}{y-2}.$$

Interchanging $x$ and $y$: $m^{-1}(x) = \frac{5x+3}{x-2}$. The range of $m$ equals the domain of $m^{-1}$:

$$\operatorname{ran} m = \operatorname{dom} m^{-1} = \mathbb{R} \setminus \{2\}. \;\blacksquare$$

---

**(e)** Compute $h \circ f(x) = h(f(x)) = \sqrt{(x^2-4)+1} = \sqrt{x^2-3}$. Then

$$h(f(-x)) = \sqrt{(-x)^2 - 3} = \sqrt{x^2 - 3} = h(f(x)).$$

Since $h(f(-x)) = h(f(x))$ for all $x$ in the domain, $h \circ f$ is an **even** function. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Polynomial roots
    '5f6a7b8c-9d0e-4f1a-8b2c-3d4e5f6a7c03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f03',
    'Roots of $f(x) = x^4 - x^3 - 7x^2 + x + 6$',
    $BODY$Find the roots of $f(x) = x^4 - x^3 - 7x^2 + x + 6$.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    3,
    $BODY$Use the Rational Root Theorem to test possible rational roots ($\pm 1, \pm 2, \pm 3, \pm 6$). Once a root is found, use synthetic division to factor and repeat or factor the quotient by grouping.$BODY$,
    $BODY$The roots are $\{-2, -1, 1, 3\}$.$BODY$,
    $BODY$By the Rational Root Theorem, the possible rational roots are $\frac{p}{q} = \pm 1, \pm 2, \pm 3, \pm 6$. Testing $x = 3$:

$$f(3) = 81 - 27 - 63 + 3 + 6 = 0.$$

So $x = 3$ is a root. Performing synthetic division:

$$\begin{array}{c|ccccc}
3 & 1 & -1 & -7 & 1 & 6 \\
  &   &  3 &  6 & -3 & -6 \\
\hline
  & 1 &  2 & -1 & -2 & 0
\end{array}$$

Thus $f(x) = (x - 3)(x^3 + 2x^2 - x - 2)$. Factor the cubic by grouping:

$$x^3 + 2x^2 - x - 2 = x^2(x + 2) - (x + 2) = (x^2 - 1)(x + 2) = (x + 1)(x - 1)(x + 2).$$

Therefore $f(x) = (x - 3)(x + 1)(x - 1)(x + 2)$ and the roots are $\{-2, -1, 1, 3\}$. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — Exponential and logarithmic equations
    '5f6a7b8c-9d0e-4f1a-8b2c-3d4e5f6a7c04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f04',
    'Exponential and Logarithmic Equations',
    $BODY$Find all values of $x$ satisfying:

**(a)** $7^{2-x}=\left(\frac{1}{49}\right)^{x}$

**(b)** $2^{3-x}+4^{\frac{2-x}{2}}=48$

**(c)** $\log_5(x^2-1)=2(1+\log_5(x-1))$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    4,
    $BODY$For (a), rewrite both sides with base $7$. For (b), express $4$ as $2^2$ and factor. For (c), use log properties to combine, then convert to exponential form. Check all solutions against the domain.$BODY$,
    $BODY$**(a)** $x = -2$. **(b)** $x = -2$. **(c)** $x = \frac{13}{12}$.$BODY$,
    $BODY$**(a)** Note that $\frac{1}{49} = 7^{-2}$. The equation becomes

$$7^{2-x} = (7^{-2})^x = 7^{-2x}.$$

Since the bases are equal: $2 - x = -2x \implies x = -2$. $\blacksquare$

---

**(b)** Since $4 = 2^2$, rewrite as

$$2^{3-x} + (2^2)^{\frac{2-x}{2}} = 48 \implies 2^{3-x} + 2^{2-x} = 48.$$

Factor: $2^{2-x}(2 + 1) = 48 \implies 2^{2-x} = 16 = 2^4$. So $2 - x = 4 \implies x = -2$. $\blacksquare$

---

**(c)** Use log properties:

$$\log_5(x^2-1) = 2 + \log_5(x-1)^2 \implies \log_5(x^2-1) - \log_5(x-1)^2 = 2.$$

$$\log_5\left(\frac{(x-1)(x+1)}{(x-1)^2}\right) = 2 \implies \log_5\left(\frac{x+1}{x-1}\right) = 2.$$

Converting: $\frac{x+1}{x-1} = 5^2 = 25 \implies x + 1 = 25x - 25 \implies 24x = 26 \implies x = \frac{13}{12}$.

Checking the domain: $x^2 - 1 = \frac{169}{144} - 1 = \frac{25}{144} > 0$ and $x - 1 = \frac{1}{12} > 0$. Both are valid. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Exponential evaluation
    '5f6a7b8c-9d0e-4f1a-8b2c-3d4e5f6a7c05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f04',
    'Evaluating $5^{12x}$ Given $125^x = 2$',
    $BODY$Let there be an $x \in \mathbb{R}$ such that $125^{x}=2$. What is the value of $5^{12x}$?$BODY$,
    'easy',
    2023,
    'Sample 2nd Long Exam',
    5,
    $BODY$Rewrite $125^x$ as $(5^3)^x = 5^{3x} = 2$, then express $5^{12x}$ as $(5^{3x})^4$.$BODY$,
    $BODY$5^{12x} = 16$.$BODY$,
    $BODY$Rewrite $125^x$ as $(5^3)^x = 5^{3x} = 2$. Then

$$5^{12x} = 5^{3x \cdot 4} = (5^{3x})^4 = 2^4 = 16. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Logarithm evaluation
    '5f6a7b8c-9d0e-4f1a-8b2c-3d4e5f6a7c06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f04',
    'Evaluating $\log 100^r + \log\left(\frac{1}{100}\right)^s$',
    $BODY$Evaluate $\log 100^{r}+\log \left( \frac{1}{100} \right)^{s}$ in terms of $r$ and $s$.$BODY$,
    'easy',
    2023,
    'Sample 2nd Long Exam',
    6,
    $BODY$Rewrite $100 = 10^2$ and $\frac{1}{100} = 10^{-2}$, then use log power rule and the fact that $\log = \log_{10}$.$BODY$,
    $BODY$2r - 2s$.$BODY$,
    $BODY$Write $100 = 10^2$ and $\frac{1}{100} = 10^{-2}$. Since $\log = \log_{10}$:

$$\log 100^r + \log\left(\frac{1}{100}\right)^s = \log 10^{2r} + \log 10^{-2s} = \log 10^{2r-2s} = (2r - 2s)\log 10 = 2r - 2s. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q7 — Single logarithm
    '5f6a7b8c-9d0e-4f1a-8b2c-3d4e5f6a7c07',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'd3e4f5a6-7b8c-4d9e-8f0a-1b2c3d4e5f04',
    'Writing as a Single Logarithm of Base 2',
    $BODY$Write $\log_{2}(x+1)-2\log_{2} 5-\log_{4}(x^{2})+\log_{8}(x^{3}+3x^{2}+3x+1)$ as a single logarithm of base $2$ with coefficient $1$.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    7,
    $BODY$Convert all logarithms to base $2$ using the change-of-base formula: $\log_4 x = \frac{\log_2 x}{2}$ and $\log_8 x = \frac{\log_2 x}{3}$. Factor $x^3 + 3x^2 + 3x + 1 = (x+1)^3$. Then use log properties to combine.$BODY$,
    $BODY$\log_{2}\left(\frac{(x+1)^2}{25x}\right)$$BODY$,
    $BODY$Note that $4 = 2^2$ and $8 = 2^3$, so by the change-of-base formula:

$$\log_4 x = \frac{\log_2 x}{\log_2 4} = \frac{\log_2 x}{2}, \qquad \log_8 x = \frac{\log_2 x}{\log_2 8} = \frac{\log_2 x}{3}.$$

Also, $x^3 + 3x^2 + 3x + 1 = (x+1)^3$. Applying log properties:

$$\log_{2}(x+1)-2\log_{2} 5-\log_{4}(x^{2})+\log_{8}((x+1)^3)$$

$$= \log_{2}(x+1) - \log_{2} 25 - \frac{\log_2(x^2)}{2} + \frac{\log_2((x+1)^3)}{3}$$

$$= \log_{2}(x+1) - \log_{2} 25 - \log_{2}(x) + \log_{2}(x+1)$$

$$= \log_{2}((x+1)^2) - \log_{2}(25x)$$

$$= \boxed{\log_{2}\left(\frac{(x+1)^{2}}{25x}\right)}. \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
