-- ============================================================================
-- Math 123.2 Advanced Calculus II — Problem Set II
-- 11 problems (series convergence tests, proofs about convergent series,
-- uniform convergence via the Weierstrass M-Test and Cauchy Criterion, and
-- power series summation).
--
-- The MATH 123.2 course row is added here because it exists in the catalog
-- migration but may not be present in the live database.
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.courses (id, code, name, description)
values (
  '18324841-e967-45c4-8ec9-c5267defe480',
  'MATH 123.2',
  'Advanced Calculus II',
  'Sequences and series of functions, uniform convergence, power series, and their applications.'
)
on conflict (code) do nothing;

insert into public.topics (id, course_id, name, description)
values
  (
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e01',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'Series Convergence Tests',
    'Convergence and divergence of numerical series via the ratio test, comparison test, limit comparison test, alternating series test, and Cauchy criterion.'
  ),
  (
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e02',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'Uniform Convergence',
    'Pointwise and uniform convergence of series of functions, the Weierstrass M-Test, and the Cauchy criterion for uniform convergence.'
  ),
  (
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e03',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'Power Series',
    'Power series representations, term-by-term differentiation and integration, and evaluating sums.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Classify five series as convergent or divergent
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f01',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e01',
    'Convergent or Divergent: Five Series to Classify',
    $BODY$Determine which of the following series are convergent and which are divergent.

**(a)** $\displaystyle \sum_{n=0}^{\infty} \frac{2^n + 3^n}{n!}$

**(b)** $\displaystyle \sum_{n=1}^{\infty} \ln\!\left( \frac{n}{n+1} \right)$

**(c)** $\displaystyle \sum_{n=1}^{\infty} (-1)^{n-1} \frac{e^{1/n}}{n}$

**(d)** $\displaystyle \sum_{n=1}^{\infty} \frac{(3n)! + 4^{n+1}}{(3n+1)!}$

**(e)** $\displaystyle \sum_{n=1}^{\infty} a_n$ where $a_1 = 1$ and $a_{n+1} = \dfrac{2 + \cos n}{\sqrt{n}}\, a_n$.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    1,
    $BODY$For (a) use the exponential power series or the ratio test. For (b) compute the partial sums of $\ln(n/(n+1))$ and telescope. For (c) apply the alternating series test. For (d) use the limit comparison test with $\sum 1/(3n+1)$. For (e) use the ratio test together with $|\cos n| \le 1$.$BODY$,
    $BODY$**(a)** Convergent — equals $e^2 + e^3$.

**(b)** Divergent — partial sums tend to $-\infty$.

**(c)** Convergent — by the alternating series test.

**(d)** Divergent — by the comparison test.

**(e)** Convergent — by the ratio test.$BODY$,
    $BODY$**(a) Solution 1 (power series).** Recall the power series for the exponential function:

$$
e^x = 1 + \frac{x}{1!} + \frac{x^2}{2!} + \cdots = \sum_{n=0}^{\infty} \frac{x^n}{n!}.
$$

Evaluating at $x = 2$ and $x = 3$ gives the convergent series

$$
\sum_{n=0}^{\infty} \frac{2^n}{n!} = e^2 \in \mathbb{R} \qquad \text{and} \qquad \sum_{n=0}^{\infty} \frac{3^n}{n!} = e^3 \in \mathbb{R}.
$$

Therefore, by the theorem,

$$
\sum_{n=0}^{\infty} \frac{2^n + 3^n}{n!} = \sum_{n=0}^{\infty} \frac{2^n}{n!} + \sum_{n=0}^{\infty} \frac{3^n}{n!} = e^2 + e^3 \in \mathbb{R}.
$$

Hence the series is **convergent**. $\blacksquare$

**Solution 2 (ratio test).** Note that $\dfrac{2^n + 3^n}{n!} \ne 0$ for any $n \in \mathbb{N}$. Then,

$$
\lim_{n \to \infty} \left| \frac{2^{n+1} + 3^{n+1}}{(n+1)!} \cdot \frac{n!}{2^n + 3^n} \right| = \lim_{n \to \infty} \frac{1}{n+1} \cdot \frac{2^{n+1} + 3^{n+1}}{2^n + 3^n}.
$$

For any $n \ge 0$, $\dfrac{2^{n+1} + 3^{n+1}}{2^n + 3^n} < \dfrac{3(2^n + 3^n)}{2^n + 3^n} = 3$, and $\dfrac{1}{n+1} \to 0$ as $n \to \infty$. Therefore,

$$
\lim_{n \to \infty} \left| \frac{2^{n+1} + 3^{n+1}}{(n+1)!} \cdot \frac{n!}{2^n + 3^n} \right| = 0 < 1.
$$

Hence, by the corollary of the ratio test, the given series is absolutely convergent, so it is convergent. $\blacksquare$

---

**(b)** Using the properties of the logarithm,

$$
\ln\!\left( \frac{n}{n+1} \right) = \ln n - \ln(n+1).
$$

Therefore, the $k$th partial sum of the series is given by

$$
\sum_{n=1}^{k} \ln\!\left( \frac{n}{n+1} \right) = \sum_{n=1}^{k} \bigl[ \ln n - \ln(n+1) \bigr] = \ln 1 - \ln 2 + \ln 2 - \ln 3 + \cdots + \ln(k-1) - \ln k + \ln k - \ln(k+1) = -\ln(k+1).
$$

Since $\displaystyle\lim_{k \to \infty} -\ln(k+1) = -\infty$, the sequence of partial sums of the given series is unbounded. Hence the series is **divergent**. $\blacksquare$

---

**(c)** Consider the sequence $\{e^{1/n}/n\}$. Note that $e^{1/n}/n > 0$ for all $n \in \mathbb{N}$, and

(1) $\displaystyle\lim_{n \to \infty} \frac{e^{1/n}}{n} = 0$.

(2) The sequence $\{e^{1/n}/n\}$ is decreasing since

$$
\frac{e^{1/(n+1)}}{n+1} \cdot \frac{n}{e^{1/n}} = \frac{n}{n+1} \cdot \frac{e^{1/(n+1)}}{e^{1/n}} < \frac{n}{n} \cdot \frac{e^{1/n}}{e^{1/n}} = 1.
$$


Then, by the Alternating Series Test, the alternating series $\sum (-1)^{n+1} \frac{e^{1/n}}{n}$ is convergent. Note that $(-1)^{n+1} = (-1)^{n+1}(-1)^{-2} = (-1)^{n-1}$. Therefore the alternating series $\sum (-1)^{n-1} \frac{e^{1/n}}{n}$ is **convergent**. $\blacksquare$

---

**(d)** Consider the series $\sum \dfrac{(3n)!}{(3n+1)!} = \sum \dfrac{1}{3n+1}$ and the harmonic series $\sum \dfrac{1}{n}$, which is known to diverge. Applying the Limit Comparison Test, we have

$$
\lim_{n \to \infty} \left| \frac{1/(3n+1)}{1/n} \right| = \lim_{n \to \infty} \frac{n}{3n+1} = \lim_{n \to \infty} \frac{1}{3 + 1/n} = \frac{1}{3 + 0} = \frac{1}{3} \ne 0.
$$

Therefore $\sum \dfrac{(3n)!}{(3n+1)!}$ diverges. Note that

$$
\frac{(3n)!}{(3n+1)!} < \frac{(3n)! + 4^{n+1}}{(3n+1)!} \quad \text{for all } n \in \mathbb{N}.
$$

Hence, by the Comparison Test, the series $\sum \dfrac{(3n)! + 4^{n+1}}{(3n+1)!}$ is **divergent**. $\blacksquare$

---

**(e)** Observe the first few terms of the sequence: $a_2 = \dfrac{2 + \cos 1}{\sqrt{1}}$, $a_3 = \dfrac{2 + \cos 2}{\sqrt{2}} \cdot \dfrac{2 + \cos 1}{\sqrt{1}}$, $\ldots$

We deduce that $\left| \dfrac{a_{n+1}}{a_n} \right| = \left| \dfrac{2 + \cos n}{\sqrt{n}} \right|$. Note that $|\cos n| \le 1$. We use the ratio test to get

$$
\lim_{n \to \infty} \frac{|2 + \cos n|}{\sqrt{n}} \le \lim_{n \to \infty} \frac{2 + |\cos n|}{\sqrt{n}} \le \lim_{n \to \infty} \frac{2 + 1}{\sqrt{n}} = \lim_{n \to \infty} \frac{3}{\sqrt{n}} = 0 < 1.
$$

Alternatively,

$$
\frac{1}{\sqrt{n}} \le \left| \frac{2 + \cos n}{\sqrt{n}} \right| \le \frac{3}{\sqrt{n}}.
$$

Note that $\displaystyle\lim_{n \to \infty} \frac{1}{\sqrt{n}} = 0 = \lim_{n \to \infty} \frac{3}{\sqrt{n}}$. Hence, by the Squeeze Theorem,

$$
\lim_{n \to \infty} \left| \frac{2 + \cos n}{\sqrt{n}} \right| = 0 < 1.
$$

Therefore the series $\sum a_n$ is **convergent** by the corollary of the Ratio Test. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — If Σa_n converges then Σa_n^2 converges
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f02',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e01',
    'If $\\sum a_n$ Converges, Then $\\sum a_n^2$ Converges',
    $BODY$Let $a_n > 0$. Prove that if $\displaystyle\sum_{n=1}^{\infty} a_n$ converges, then $\displaystyle\sum_{n=1}^{\infty} a_n^2$ also converges.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    2,
    $BODY$Since $a_n > 0$, $|a_n| = a_n$. Because $\sum a_n$ converges, $a_n \to 0$, so eventually $0 < a_n < 1$, whence $0 < a_n^2 < a_n$; then apply the Comparison Test. Alternatively, use the Cauchy Criterion for Series directly.$BODY$,
    $BODY$Since $a_n \to 0$, for all sufficiently large $n$ we have $0 < a_n < 1$, so $0 < a_n^2 < a_n$; hence $\sum a_n^2$ converges by the Comparison Test.$BODY$,
    $BODY$**Solution 1 (limit definition).** Note that $a_n > 0 \implies |a_n| = a_n$. Suppose $\sum_{n=1}^{\infty} a_n$ converges. It follows that $\lim_{n \to \infty} a_n = 0$. Hence, there exists $K \in \mathbb{N}$ such that whenever $n \ge K$, we have $|a_n - 0| < 1$, by setting $\varepsilon = 1 > 0$.

Suppose $n \ge K$. Then

$$
|a_n - 0| < 1 \implies 0 < a_n < 1 \implies 0 < a_n^2 < a_n.
$$

Since the series $\sum a_n$ converges, by the Comparison Test it follows that the series $\sum a_n^2$ also converges. $\blacksquare$

---

**Solution 2 (Cauchy Criterion for Series).** Let $\varepsilon > 0$. It follows that $\sqrt{\varepsilon} > 0$. Then, by the Cauchy Criterion for Series, there is an $M \in \mathbb{N}$ such that whenever $m > n \ge M$, we have

$$
\left| a_{n+1} + a_{n+2} + \cdots + a_m \right| < \sqrt{\varepsilon}.
$$

Suppose $m, n \in \mathbb{N}$ such that $m > n \ge M$. Then, using $a_n > 0$ so that $|a_n| = a_n$,

$$
\left| a_{n+1}^2 + a_{n+2}^2 + \cdots + a_m^2 \right| \le |a_{n+1}|^2 + |a_{n+2}|^2 + \cdots + |a_m|^2 \le \left( |a_{n+1}| + |a_{n+2}| + \cdots + |a_m| \right)^2 = \left( a_{n+1} + a_{n+2} + \cdots + a_m \right)^2 < \left( \sqrt{\varepsilon} \right)^2 = \varepsilon.
$$

Therefore $\sum a_n^2$ converges by the Cauchy Criterion for Series. $\blacksquare$ $BODY$
  ),
  (
    -- Q3 — Σ√(a_n b_n) converges
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f03',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e01',
    'Convergence of $\\sum \\sqrt{a_n b_n}$',
    $BODY$Show that if $\displaystyle\sum_{n=1}^{\infty} a_n$ and $\displaystyle\sum_{n=1}^{\infty} b_n$ are convergent series of non-negative numbers, then $\displaystyle\sum_{n=1}^{\infty} \sqrt{a_n b_n}$ converges.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    3,
    $BODY$Use the AM-GM inequality $(\sqrt{a_n} - \sqrt{b_n})^2 \ge 0$ to get $\sqrt{a_n b_n} \le a_n + b_n$, then apply the Comparison Test.$BODY$,
    $BODY$From $(\sqrt{a_n} - \sqrt{b_n})^2 \ge 0$ we get $\sqrt{a_n b_n} \le \frac{a_n + b_n}{2} \le a_n + b_n$, and $\sum (a_n + b_n)$ converges; hence $\sum \sqrt{a_n b_n}$ converges by the Comparison Test.$BODY$,
    $BODY$Suppose that $\sum a_n$ and $\sum b_n$ are convergent series of non-negative numbers, i.e. $a_n, b_n \ge 0$ for all $n \in \mathbb{N}$. It follows that $\sqrt{a_n}, \sqrt{b_n} \ge 0$ for all $n \in \mathbb{N}$. By the trivial inequality ($x^2 \ge 0$ for any $x \in \mathbb{R}$),

$$
\left( \sqrt{a_n} - \sqrt{b_n} \right)^2 \ge 0 \iff a_n + b_n - 2\sqrt{a_n}\sqrt{b_n} \ge 0 \implies a_n + b_n \ge 2\sqrt{a_n b_n} \ge \sqrt{a_n b_n}
$$

for all $n \in \mathbb{N}$. (This is the Arithmetic Mean – Geometric Mean Inequality.)

Hence we get that $\sqrt{a_n b_n} \le a_n + b_n$ for all $n \in \mathbb{N}$. Note that $\sum (a_n + b_n)$ converges since $\sum a_n$ and $\sum b_n$ converge. Therefore $\sum \sqrt{a_n b_n}$ converges by the Comparison Test. $\blacksquare$ $BODY$
  ),
  (
    -- Q4 — Divergence consequences for a_n/(1 + n a_n) and a_n/(1 + n^2 a_n)
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f04',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e01',
    'Divergence of $\\sum \\frac{a_n}{1 + n a_n}$ and $\\sum \\frac{a_n}{1 + n^2 a_n}$',
    $BODY$Let $a_n > 0$ and suppose that $\displaystyle\sum_{n=1}^{\infty} a_n$ diverges. What can we conclude about the series
$$\sum_{n=1}^{\infty} \frac{a_n}{1 + n a_n} \qquad \text{and} \qquad \sum_{n=1}^{\infty} \frac{a_n}{1 + n^2 a_n}?$$$BODY$,
    'hard',
    2024,
    'Problem Set II',
    4,
    $BODY$Apply the Limit Comparison Test against $\sum a_n$, using the fact that $\lim (1 + n a_n) \ne 0$ and $\lim (1 + n^2 a_n) \ne 0$ by the simple test for divergence.$BODY$,
    $BODY$Both series diverge: the Limit Comparison Test against $\sum a_n$ gives nonzero limits $\lim (1 + n a_n)$ and $\lim (1 + n^2 a_n)$.$BODY$,
    $BODY$Given: $a_n > 0$ and $\sum a_n$ diverges. It follows that the series $\sum (1 + n a_n)$ diverges by the Comparison Test since $1 + n a_n > a_n$ for all $n \in \mathbb{N}$. Then using the Limit Comparison Test, we have

$$
\lim_{n \to \infty} \left| \frac{a_n}{a_n/(1 + n a_n)} \right| = \lim_{n \to \infty} (1 + n a_n) \ne 0,
$$

which follows from the simple test for divergence. Hence the series $\sum \dfrac{a_n}{1 + n a_n}$ also diverges.

Similarly, it follows that the series $\sum (1 + n^2 a_n)$ diverges by the Comparison Test since $1 + n^2 a_n > a_n$ for all $n \in \mathbb{N}$. Then using the Limit Comparison Test, we have

$$
\lim_{n \to \infty} \left| \frac{a_n}{a_n/(1 + n^2 a_n)} \right| = \lim_{n \to \infty} (1 + n^2 a_n) \ne 0,
$$

which follows from the simple test for divergence. Hence the series $\sum \dfrac{a_n}{1 + n^2 a_n}$ also diverges. $\blacksquare$ $BODY$
  ),
  (
    -- Q5 — Uniform convergence of Σ x^n/n on [-r, r]
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f05',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e02',
    'Uniform Convergence of $\\sum \\frac{x^n}{n}$ on $[-r, r]$',
    $BODY$Prove the uniform convergence of the series $\displaystyle\sum_{n=1}^{\infty} \frac{x^n}{n}$ on $[-r, r]$ for any $r \in [0, 1)$.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    5,
    $BODY$Bound the terms by $|x^n/n| \le r^n$ and apply the Weierstrass M-Test with $M_n = r^n$; $\sum r^n$ converges since $0 \le r < 1$.$BODY$,
    $BODY$For $x \in [-r, r]$, $|x^n/n| \le r^n =: M_n$, and $\sum M_n = \sum r^n$ converges since $|r| < 1$; hence the Weierstrass M-Test applies.$BODY$,
    $BODY$Let $r \in [0, 1)$. For $x \in [-r, r]$, we get $|x| \le r$. Hence, for any $x \in [-r, r]$ and $n \in \mathbb{N}$,

$$
\left| \frac{x^n}{n} \right| = \frac{|x|^n}{n} \le \frac{r^n}{n} \le r^n =: M_n.
$$

Consider the geometric series of non-negative real numbers (since $0 \le r < 1$): $\sum r^n = \sum M_n$, which is convergent since $|r| < 1$.

Therefore, the series $\sum \dfrac{x^n}{n}$ converges uniformly on $[-r, r]$ for any $r \in [0, 1)$ by the Weierstrass M-Test. $\blacksquare$ $BODY$
  ),
  (
    -- Q6 — Uniform convergence of Σ x/(n^(3/2) + n^(3/4) x^2) on [0,1]
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f06',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e02',
    'Uniform Convergence of $\\sum \\frac{x}{n^{3/2} + n^{3/4} x^2}$ on $[0, 1]$',
    $BODY$Determine whether $\displaystyle\sum_{n=1}^{\infty} \frac{x}{n^{3/2} + n^{3/4} x^2}$ is uniformly convergent on $[0, 1]$ or not.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    6,
    $BODY$Show $|f_n(x)| \le 1/n^{3/2} =: M_n$ on $[0, 1]$ and apply the Weierstrass M-Test; the $p$-series $\sum 1/n^{3/2}$ converges since $p = 3/2 > 1$.$BODY$,
    $BODY$Yes — uniformly convergent on $[0, 1]$ by the Weierstrass M-Test with $M_n = 1/n^{3/2}$.$BODY$,
    $BODY$We define the sequence of functions $\{f_n\}$ on $[0, 1]$ with

$$
f_n(x) = \frac{x}{n^{3/2} + n^{3/4} x^2} \quad \text{for all } x \in [0, 1],\ n \in \mathbb{N}.
$$

Now, consider the $p$-series $\sum_{n=1}^{\infty} \frac{1}{n^{3/2}} =: \sum M_n$ with $p = \frac{3}{2} > 1$ (so it converges), where $M_n > 0$ for all $n \in \mathbb{N}$.

Let $x \in [0, 1] \iff 0 \le x \le 1$. Then, for any $n \in \mathbb{N}$, we have

$$
\left| f_n(x) \right| = \left| \frac{x}{n^{3/2} + n^{3/4} x^2} \right| = \frac{x}{n^{3/2} + n^{3/4} x^2} \le \frac{1}{n^{3/2} + n^{3/4} x^2} \le \frac{1}{n^{3/2}} = M_n.
$$

Therefore, by the Weierstrass M-Test, $\sum_{n=1}^{\infty} \dfrac{x}{n^{3/2} + n^{3/4} x^2}$ is uniformly convergent on $[0, 1]$. $\blacksquare$ $BODY$
  ),
  (
    -- Q7 — Power series for arctan x via uniform convergence
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f07',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e03',
    'The Power Series for $\\arctan x$ via Uniform Convergence',
    $BODY$Prove that $\arctan x = \displaystyle\sum_{n=0}^{\infty} \frac{(-1)^n x^{2n+1}}{2n+1}$ for $|x| < 1$ by using uniform convergence arguments.$BODY$,
    'hard',
    2024,
    'Problem Set II',
    7,
    $BODY$Write $1/(1 + t^2)$ as the sum of the geometric series $\sum (-t^2)^n$, justify uniform convergence on $[-a, a]$ with $|x| < a < 1$, then integrate term by term from $0$ to $x$.$BODY$,
    $BODY$On $[-a, a]$ with $a < 1$ the geometric series converges uniformly, so integrating term by term gives $\arctan x = x - \frac{x^3}{3} + \frac{x^5}{5} - \cdots = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n+1}}{2n+1}$ for $|x| < 1$.$BODY$,
    $BODY$Let $x \in (-1, 1)$ so that $|x| < 1$. By the density theorem, there exists $a \in \mathbb{R}$ such that $0 \le |x| < a < 1$. Consider the geometric series $\sum (-t^2)^n$ for $|t| \le a$. Note that $|-t^2| = t^2 \le a^2 < 1$, so this is convergent.

The sequence of its partial sums $\{s_n\}$ is defined as

$$
s_n(t) = \frac{1 - (-t^2)^n}{1 + t^2}, \qquad \text{so we have} \qquad \sum_{n=0}^{\infty} (-t^2)^n = \lim_{n \to \infty} s_n(t) = \frac{1}{1 + t^2} = s(t).
$$

Note that $0 \le t^{2n} \le a^{2n} < 1$ and $1 < 1 + t^2 < 2$, so $\dfrac{t^{2n}}{1 + t^2} \le a^{2n}$ for all $n \in \mathbb{N}$.

Thus, for $t \in [-a, a]$, we have

$$
\lim_{n \to \infty} \|s_n - s\| = \lim_{n \to \infty} \sup |s_n - s| = \lim_{n \to \infty} \sup \left| \frac{1 - (-t^2)^n}{1 + t^2} - \frac{1}{1 + t^2} \right| = \lim_{n \to \infty} \sup \left| \frac{-(-t^2)^n}{1 + t^2} \right| = \lim_{n \to \infty} \sup \frac{t^{2n}}{1 + t^2} \le \lim_{n \to \infty} a^{2n} = 0 \quad (\text{since } |a| < 1).
$$

Therefore, $s_n$ converges uniformly on $[-a, a]$. Hence we can interchange infinite summation and integration within the interval $[-a, a]$. Thus, for $x \in [-a, a]$, we get

$$
\int_0^x \frac{dt}{1 + t^2} = \int_0^x s(t)\, dt = \int_0^x \sum_{n=0}^{\infty} (-t^2)^n \, dt = \sum_{n=0}^{\infty} (-1)^n \int_0^x t^{2n}\, dt = \int_0^x dt - \int_0^x t^2\, dt + \int_0^x t^4\, dt - \cdots.
$$

By performing the integration, we get that
$$\arctan x = x - \frac{x^3}{3} + \frac{x^5}{5} - \cdots = \sum_{n=0}^{\infty} \frac{(-1)^n x^{2n+1}}{2n+1} \quad \text{for } |x| < 1. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q8 — Cauchy criterion for Σ cos(x^n)/n^2
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f08',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e02',
    'Convergence of $\\sum \\frac{\\cos(x^n)}{n^2}$ via the Cauchy Criterion',
    $BODY$Use the Cauchy Criterion for Series to show that the series $\displaystyle\sum_{n=1}^{\infty} \frac{\cos(x^n)}{n^2}$ converges.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    8,
    $BODY$Note $|\cos x| \le 1$ for all $x \in \mathbb{R}$; bound the tail of $\sum \cos(x^n)/n^2$ by the tail of the convergent $p$-series $\sum 1/n^2$ (with $p = 2 > 1$).$BODY$,
    $BODY$For every $x \in \mathbb{R}$ the tail is bounded by the tail of $\sum 1/n^2$, which is arbitrarily small, so the Cauchy Criterion gives convergence.$BODY$,
    $BODY$Note that for any $x \in \mathbb{R}$, we have $|\cos x| \le 1$.

Let $\varepsilon > 0$. Note that the $p$-series at $p = 2 > 1$ given by $\sum_{n=1}^{\infty} \frac{1}{n^2}$ converges. Therefore, by the Cauchy Criterion for Series, there exists $M \in \mathbb{N}$ such that whenever $m > n \ge M$, we have

$$
\left| \frac{1}{(n+1)^2} + \frac{1}{(n+2)^2} + \cdots + \frac{1}{m^2} \right| < \varepsilon.
$$

Suppose $m > n \ge M$. Then, for any $x \in \mathbb{R}$, we have

$$
\left| \frac{\cos(x^{n+1})}{(n+1)^2} + \frac{\cos(x^{n+2})}{(n+2)^2} + \cdots + \frac{\cos(x^m)}{m^2} \right| \le \frac{|\cos(x^{n+1})|}{(n+1)^2} + \frac{|\cos(x^{n+2})|}{(n+2)^2} + \cdots + \frac{|\cos(x^m)|}{m^2} \le \frac{1}{(n+1)^2} + \frac{1}{(n+2)^2} + \cdots + \frac{1}{m^2} = \left| \frac{1}{(n+1)^2} + \frac{1}{(n+2)^2} + \cdots + \frac{1}{m^2} \right| < \varepsilon.
$$

Therefore, by the Cauchy Criterion for Series, the series $\sum_{n=1}^{\infty} \dfrac{\cos(x^n)}{n^2}$ converges. $\blacksquare$ $BODY$
  ),
  (
    -- Q9 — Pointwise/uniform convergence of Σ x^n/(x^n + 1)
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f09',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e02',
    'Convergence of $\\sum \\frac{x^n}{x^n + 1}$ for $x \\in [0, \\infty)$',
    $BODY$Investigate the pointwise or uniform convergence of $\displaystyle\sum_{n=1}^{\infty} \frac{x^n}{x^n + 1}$. Assume that $x \in [0, \infty)$.$BODY$,
    'hard',
    2024,
    'Problem Set II',
    9,
    $BODY$Split into the cases $x = 0$, $x \in (0, 1)$, $x = 1$, and $x \in (1, \infty)$. For $x \in (0, 1)$ use the Limit Comparison Test with $\sum x^n$ and then the Weierstrass M-Test; for $x \ge 1$ the terms do not tend to $0$.$BODY$,
    $BODY$The series converges (uniformly) on $[0, 1)$ and diverges for $x \ge 1$: at $x = 0$ it is $0$; on $(0, 1)$ it converges uniformly by the M-Test; at $x \ge 1$ the terms fail to tend to $0$.$BODY$,
    $BODY$- **If $x = 0$**, then

$$
\lim_{n \to \infty} \sum_{k=1}^{n} \frac{x^k}{x^k + 1} = \lim_{n \to \infty} \sum_{k=1}^{n} \frac{0^k}{0^k + 1} = \lim_{n \to \infty} \sum_{k=1}^{n} 0 = 0.
$$

Hence the series converges **pointwise** at $x = 0$.

---

- **If $x \in (0, 1)$**, consider the geometric series $\sum x^n$, which is convergent since $|x| < 1$. Then, by the Limit Comparison Test,

$$
\lim_{n \to \infty} \left| \frac{x^n/(x^n + 1)}{x^n} \right| = \lim_{n \to \infty} \frac{1}{x^n + 1} = \frac{1}{0 + 1} = 1 \ne 0.
$$

Hence the series converges pointwise on $(0, 1)$.

By the density theorem, there exists $a > 0$ such that $x < a < 1$. So $x^n < a^n$, and since $1 + x^n > 1$, we get

$$
\frac{x^n}{x^n + 1} \le a^n \quad \text{for all } n \in \mathbb{N}.
$$

Note that $\sum a^n =: \sum M_n$ converges since $|a| < 1$. Therefore, by the Weierstrass M-Test with $M_n = a^n$, the series converges **uniformly** on $(0, 1)$.

---

- **If $x = 1$**, we have

$$
\lim_{n \to \infty} \frac{x^n}{x^n + 1} = \lim_{n \to \infty} \frac{1^n}{1^n + 1} = \frac{1}{2} \ne 0.
$$

Therefore, the series diverges at $x = 1$ by the simple test for divergence.

---

- **If $x \in (1, \infty)$**, then

$$
\lim_{n \to \infty} \frac{x^n}{x^n + 1} = \lim_{n \to \infty} \frac{1}{1 + x^{-n}} = \frac{1}{1 + 0} = 1 \ne 0.
$$

By the simple test for divergence, the series diverges. $\blacksquare$ $BODY$
  ),
  (
    -- Q10 — Sum of Σ n^2/2^(n+1) via power series
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f10',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e03',
    'The Sum $\\sum \\frac{n^2}{2^{n+1}}$ via Power Series',
    $BODY$Use power series to find the sum of $\displaystyle\sum_{n=0}^{\infty} \frac{n^2}{2^{n+1}}$.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    10,
    $BODY$Start from $\sum x^n = 1/(1-x)$, differentiate twice to get $\sum n^2 x^{n-1}$, multiply by $x^2$, and evaluate at $x = 1/2$.$BODY$,
    $BODY$\sum_{n=0}^{\infty} \frac{n^2}{2^{n+1}} = 3$.$BODY$,
    $BODY$Recall the power series formula for the geometric series:

$$
\sum_{n=0}^{\infty} x^n = 1 + x + x^2 + \cdots = \frac{1}{1 - x} \quad \text{for } |x| < 1,
$$

which implies uniform convergence on $(-1, 1)$. Hence we can interchange the differentiation and summation operators. So for $|x| < 1$,

$$
\frac{d}{dx} \sum_{n=0}^{\infty} x^n = \frac{d}{dx} \left( 1 + x + x^2 + \cdots \right) \implies \sum_{n=1}^{\infty} n x^{n-1} = 1 + 2x + 3x^2 + \cdots = \frac{1}{(1-x)^2} \implies \sum_{n=1}^{\infty} n x^n = x + 2x^2 + 3x^3 + \cdots = \frac{x}{(1-x)^2}, \quad (x \ne 0),
$$

which also converges uniformly on $(-1, 1)$. Using the uniform convergence of this series on $(-1, 1)$, we can apply the interchange of summation and differentiation again to get

$$
\sum_{n=1}^{\infty} n^2 x^{n-1} = 1 + 4x + 9x^2 + \cdots = \frac{-2x(1-x) - (1-x)^2}{(1-x)^4} = \frac{1 - x^2}{(1-x)^4} = \frac{1 + x}{(1-x)^3} \implies \sum_{n=1}^{\infty} n^2 x^{n+1} = x^2 + 4x^3 + 9x^4 + \cdots = \frac{x^2(1+x)}{(1-x)^3}, \quad (x \ne 0).
$$

Now, we can set $x = \frac{1}{2} \in (-1, 1)$ so that

$$
\sum_{n=1}^{\infty} n^2 \left( \frac{1}{2} \right)^{n+1} = \sum_{n=1}^{\infty} \frac{n^2}{2^{n+1}} = \frac{(1/2)^2 (1 + 1/2)}{(1 - 1/2)^3} = \frac{(1/4)(3/2)}{(1/2)^3} = \frac{3/8}{1/8} = 3.
$$

We want this series to start from $n = 0$, so we have
$$\sum_{n=0}^{\infty} \frac{n^2}{2^{n+1}} = \frac{0^2}{2^{0+1}} + \sum_{n=1}^{\infty} \frac{n^2}{2^{n+1}} = 0 + 3 = \boxed{3}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q11 — Uniform absolute convergence implies uniform convergence
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6f11',
    '18324841-e967-45c4-8ec9-c5267defe480',
    'd4e5f6a7-8b9c-4d0e-9f1a-2b3c4d5e6e02',
    'Uniform Absolute Convergence Implies Uniform Convergence',
    $BODY$We say that $\displaystyle\sum_{n=1}^{\infty} f_n(x)$ is uniformly convergent on the interval $D \subseteq \mathbb{R}$ if $\displaystyle\sum_{n=1}^{\infty} |f_n(x)|$ is uniformly convergent on $D$. Prove that uniform absolute convergence implies uniform convergence.$BODY$,
    'medium',
    2024,
    'Problem Set II',
    11,
    $BODY$Use the Cauchy Criterion for Uniform Convergence together with the triangle inequality.$BODY$,
    $BODY$The tail of $\sum f_n(x)$ is bounded uniformly by the tail of $\sum |f_n(x)|$ via the triangle inequality, so the Cauchy criterion gives uniform convergence.$BODY$,
    $BODY$Suppose that $\sum_{n=1}^{\infty} |f_n(x)|$ converges uniformly on $D \subseteq \mathbb{R}$ (uniform absolute convergence).

Let $\varepsilon > 0$. By the Cauchy Criterion for Uniform Convergence, there exists $M \in \mathbb{N}$ such that whenever $m > n \ge M$, we have

$$
\left| |f_{n+1}(x)| + |f_{n+2}(x)| + \cdots + |f_m(x)| \right| < \varepsilon \quad \text{for all } x \in D.
$$

Suppose $m > n \ge M$ and let $x \in D$. Then

$$
\left| f_{n+1}(x) + f_{n+2}(x) + \cdots + f_m(x) \right| \le |f_{n+1}(x)| + |f_{n+2}(x)| + \cdots + |f_m(x)| = \left| |f_{n+1}(x)| + |f_{n+2}(x)| + \cdots + |f_m(x)| \right| < \varepsilon.
$$

Therefore, by the Cauchy Criterion for Uniform Convergence, the series $\sum_{n=1}^{\infty} f_n(x)$ converges uniformly on $D$ (uniform convergence). Hence, uniform absolute convergence implies uniform convergence. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
