-- ============================================================================
-- MATH 22 Elementary Analysis II — Sample 2nd Long Exam, A.Y. 2023-2024
-- 9 problems (sequences, series convergence, power series, Taylor polynomials).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Convergence/divergence of sequences
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d01',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Convergence of Sequences',
    $BODY$Determine if the following sequences are convergent or divergent. If a sequence converges, find the limit.

**(a)** $\displaystyle\left\{\frac{1}{n+1}\sin\!\left(\frac{n\pi}{2}\right)\right\}_{n=1}^{\infty}$

**(b)** $\displaystyle\left\{\frac{\log_b n}{n}\right\}_{n=1}^{\infty}, \quad b > 1$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    1,
    $BODY$For (a), use the Squeeze Theorem: bound $|\sin(n\pi/2)| \le 1$. For (b), apply L'Hôpital's Rule to $\lim_{x\to\infty} \frac{\log_b x}{x}$.$BODY$,
    $BODY$**(a)** Converges. **(b)** Converges with limit $0$.$BODY$,
    $BODY$**(a)** Let $f(x) = \frac{1}{x+1}\sin\!\left(\frac{x\pi}{2}\right)$. Since the sine function oscillates between $-1$ and $1$, we use the Squeeze Theorem.

$$
-1 \le \sin\!\left(\frac{x\pi}{2}\right) \le 1
$$

$$
\frac{-1}{x+1} \le \frac{1}{x+1}\sin\!\left(\frac{x\pi}{2}\right) \le \frac{1}{x+1}
$$

Evaluating both sides:

$$
\lim_{x\to+\infty} \frac{-1}{x+1} = 0, \qquad \lim_{x\to+\infty} \frac{1}{x+1} = 0
$$

By the Squeeze Theorem, $\lim_{x\to+\infty} f(x) = 0$. Since $f(n) = \frac{1}{n+1}\sin\!\left(\frac{n\pi}{2}\right)$ for all $n \in \mathbb{N}$, the sequence converges. $\blacksquare$

---

**(b)** Let $f(x) = \frac{\log_b x}{x}$. By L'Hôpital's Rule ($\frac{\infty}{\infty}$ form):

$$
\lim_{x\to+\infty} \frac{\log_b x}{x} = \lim_{x\to+\infty} \frac{\frac{1}{x\ln b}}{1} = \frac{1}{+\infty \cdot \ln b} = 0
$$

Hence the sequence $\left\{\frac{\log_b n}{n}\right\}_{n=1}^{\infty}$ converges with limit $0$. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — Telescoping series
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d02',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Telescoping Series: $\\sum \\frac{4n+2}{(2n^2+1)(2n^2+4n+3)}$',
    $BODY$Determine whether the series converges or diverges. If it converges, find the sum.
$$
\sum_{n=1}^{\infty} \frac{4n + 2}{(2n^2 + 1)(2n^2 + 4n + 3)}
$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    2,
    $BODY$Use partial fraction decomposition on $\frac{4n+2}{(2n^2+1)(2n^2+4n+3)}$ and observe that the resulting telescoping series collapses to a finite sum.$BODY$,
    $BODY$Convergent. The sum is $\frac{1}{3}$.$BODY$,
    $BODY$Observe that $2n^2 + 1$ and $2n^2 + 4n + 3$ are irreducible. We express

$$
\frac{4n + 2}{(2n^2 + 1)(2n^2 + 4n + 3)} = \frac{An + B}{2n^2 + 1} + \frac{Cn + D}{2n^2 + 4n + 3}
$$

Multiplying both sides by the LCD and comparing coefficients:

$$
4n + 2 = (An + B)(2n^2 + 4n + 3) + (Cn + D)(2n^2 + 1)
$$

$$
= (2A + 2C)n^3 + (4A + 2B + 2D)n^2 + (3A + 4B + C)n + (3B + D)
$$

Solving the resulting system yields $(A, B, C, D) = (0, 1, 0, -1)$, so

$$
\frac{4n + 2}{(2n^2 + 1)(2n^2 + 4n + 3)} = \frac{1}{2n^2 + 1} - \frac{1}{2n^2 + 4n + 3}
$$

Let $\displaystyle S_k = \sum_{n=1}^{k} \frac{4n+2}{(2n^2+1)(2n^2+4n+3)}$. We observe the telescoping:

$$
S_1 = \frac{1}{3} - \frac{1}{9}, \quad S_2 = \frac{1}{3} - \frac{1}{19}, \quad S_3 = \frac{1}{3} - \frac{1}{33}
$$

$$
S_k = \frac{1}{3} - \frac{1}{2k^2 + 4k + 3}
$$

$$
\sum_{n=1}^{\infty} \frac{4n + 2}{(2n^2 + 1)(2n^2 + 4n + 3)} = \lim_{k\to\infty} S_k = \lim_{k\to\infty}\left(\frac{1}{3} - \frac{1}{2k^2 + 4k + 3}\right) = \boxed{\frac{1}{3}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Integral test
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d03',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Integral Test: $\\sum \\frac{1}{(n-1)\\ln^4(n-1)}$',
    $BODY$Use the Integral Test to check the convergence of the infinite series
$$
\sum_{n=3}^{\infty} \frac{1}{(n-1)\ln^4(n-1)}.
$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    3,
    $BODY$Verify the hypotheses of the Integral Test (continuous, positive, decreasing), then evaluate $\int_3^\infty \frac{dx}{(x-1)\ln^4(x-1)}$ using the substitution $u = \ln(x-1)$.$BODY$,
    $BODY$Convergent by the Integral Test. The integral evaluates to $\frac{1}{3(\ln 2)^3}$.$BODY$,
    $BODY$Investigate the integral $\displaystyle\int_3^{\infty} \frac{dx}{(x-1)\ln^4(x-1)}$. The integrand is continuous, positive, and decreasing for $x \ge 3$.

Let $u = \ln(x-1)$, so $du = \frac{dx}{x-1}$. When $x = 3$, $u = \ln 2$; when $x = t$, $u = \ln(t-1)$.

$$
\int_3^{\infty} \frac{dx}{(x-1)\ln^4(x-1)} = \lim_{t\to\infty} \int_{\ln 2}^{\ln(t-1)} \frac{du}{u^4} = \lim_{t\to\infty} \left[-\frac{1}{3u^3}\right]_{\ln 2}^{\ln(t-1)}
$$

$$
= \lim_{t\to\infty} \left(-\frac{1}{3(\ln(t-1))^3} + \frac{1}{3(\ln 2)^3}\right) = 0 + \frac{1}{3(\ln 2)^3} \in \mathbb{R}
$$

$$
\therefore \text{The series } \sum_{n=3}^{\infty} \frac{1}{(n-1)\ln^4(n-1)} \text{ is \textbf{convergent} by the Integral Test.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Series convergence tests (3 parts)
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d04',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Convergence Tests: Comparison, Limit Comparison, and Alternating Series',
    $BODY$Determine whether the following series converges.

**(a)** $\displaystyle\sum_{n=1}^{\infty} \frac{3^{2n} + \sin^2 n}{2^{3n} - 1}$

**(b)** $\displaystyle\sum_{n=1}^{\infty} \frac{\sqrt{5n + 2}}{n^2 + 4n}$

**(c)** $\displaystyle\sum_{n=0}^{\infty} \frac{\cos(n\pi)}{11^n \log(n + 2)}$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    4,
    $BODY$For (a), compare with a geometric series $\sum (9/8)^n$. For (b), use the Limit Comparison Test with $\sum 1/n^{3/2}$. For (c), recognize $\cos(n\pi) = (-1)^n$ and apply the Alternating Series Test.$BODY$,
    $BODY$**(a)** Divergent (comparison with geometric series $r = 9/8 > 1$). **(b)** Convergent (limit comparison with $p$-series, $p = 3/2$). **(c)** Convergent (alternating series test).$BODY$,
    $BODY$**(a)** Recall $-1 \le \sin n \le 1$, so $0 \le \sin^2 n \le 1$. Since $2^{3n} - 1 < 2^{3n}$, we have $\frac{1}{2^{3n}-1} > \frac{1}{2^{3n}}$. Therefore

$$
\frac{3^{2n} + \sin^2 n}{2^{3n} - 1} \ge \frac{3^{2n}}{2^{3n} - 1} > \frac{3^{2n}}{2^{3n}} \implies \sum_{n=1}^{\infty} \frac{3^{2n}}{2^{3n}} = \sum_{n=1}^{\infty} \left(\frac{9}{8}\right)^n
$$

This is a geometric series with $r = \frac{9}{8} > 1$, which diverges. Hence the given series **diverges** by the Comparison Test. $\blacksquare$

---

**(b)** Let $x_n = \frac{\sqrt{5n+2}}{n^2 + 4n}$ and $y_n = \frac{1}{n^{3/2}}$. Then

$$
\lim_{n\to\infty} \frac{x_n}{y_n} = \lim_{n\to\infty} \frac{\sqrt{5n+2}}{n^2 + 4n} \cdot n^{3/2} = \lim_{n\to\infty} \frac{\sqrt{5n^4 + 2n^3}}{n^2 + 4n} = \lim_{n\to\infty} \frac{\sqrt{5 + 2/n}}{1 + 4/n} = \sqrt{5} \in \mathbb{R}
$$

Since $\sum y_n = \sum \frac{1}{n^{3/2}}$ is a convergent $p$-series ($p = \frac{3}{2} > 1$), by the Limit Comparison Test, the series $\sum_{n=1}^{\infty} \frac{\sqrt{5n+2}}{n^2 + 4n}$ is **convergent**. $\blacksquare$

---

**(c)** Note that $\cos(n\pi) = (-1)^n$ for all $n \in \mathbb{N}_0$. So

$$
\sum_{n=0}^{\infty} \frac{\cos(n\pi)}{11^n \log(n+2)} = \sum_{n=0}^{\infty} \frac{(-1)^n}{11^n \log(n+2)}
$$

The sequence $a_n = \frac{1}{11^n \log(n+2)}$ is positive and decreasing (since $11^n$ and $\log(n+2)$ are increasing), with $\lim_{n\to\infty} a_n = 0$. By the Alternating Series Test, the series is **convergent**. $\blacksquare$ $BODY$
  ),
  (
    -- Q5 — Conditional convergence at x = -2
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d05',
    'c0000000-0000-4000-8000-000000000002',
    'e25dbfed-dfba-520d-896d-0e6e8bad0930',
    'Conditional Convergence of $\\sum \\frac{(4x-3)^n}{11^n\\sqrt[5]{n^2}}$ at $x = -2$',
    $BODY$Determine whether the series converges absolutely, converges conditionally, or diverges at $x = -2$.
$$
\sum_{n=1}^{\infty} \frac{(4x - 3)^n}{11^n \sqrt[5]{n^2}}
$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    5,
    $BODY$Substitute $x = -2$ to get $\sum \frac{(-1)^n}{\sqrt[5]{n^2}}$. Check absolute convergence with the $p$-series test, then check conditional convergence with the Alternating Series Test.$BODY$,
    $BODY$Conditionally convergent.$BODY$,
    $BODY$At $x = -2$:

$$
\sum_{n=1}^{\infty} \frac{(4(-2) - 3)^n}{11^n \sqrt[5]{n^2}} = \sum_{n=1}^{\infty} \frac{(-11)^n}{11^n \sqrt[5]{n^2}} = \sum_{n=1}^{\infty} \frac{(-1)^n}{\sqrt[5]{n^2}}
$$

The series of absolute values is

$$
\sum_{n=1}^{\infty} \left|\frac{(-1)^n}{\sqrt[5]{n^2}}\right| = \sum_{n=1}^{\infty} \frac{1}{n^{2/5}}
$$

This is a divergent $p$-series since $p = \frac{2}{5} \le 1$.

Meanwhile, $a_n = \frac{1}{\sqrt[5]{n^2}}$ is positive and decreasing, and $\lim_{n\to\infty} \frac{(-1)^n}{\sqrt[5]{n^2}} = 0$. By the Alternating Series Test, $\sum \frac{(-1)^n}{\sqrt[5]{n^2}}$ converges.

Since the series converges but does not converge absolutely, the series is **conditionally convergent** at $x = -2$. $\blacksquare$ $BODY$
  ),
  (
    -- Q6 — Radius and interval of convergence
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d06',
    'c0000000-0000-4000-8000-000000000002',
    'e25dbfed-dfba-520d-896d-0e6e8bad0930',
    'Radius and Interval of Convergence of $\\sum \\frac{(x+3)^n}{(n+1)^2}$',
    $BODY$Find the radius and interval of convergence of the series
$$
\sum_{n=0}^{\infty} \frac{(x+3)^n}{(n+1)^2}.
$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    6,
    $BODY$Apply the Ratio Test to find the radius. Then test the endpoints $x = -4$ and $x = -2$ separately (comparison test at $x = -2$, alternating series test at $x = -4$).$BODY$,
    $BODY$$R = 1$; interval of convergence: $[-4, -2]$.$BODY$,
    $BODY$Let $a_n = \frac{(x+3)^n}{(n+1)^2}$. Using the Ratio Test:

$$
\lim_{n\to\infty} \left|\frac{a_{n+1}}{a_n}\right| = \lim_{n\to\infty} \left|\frac{(x+3)^{n+1}}{(n+2)^2} \cdot \frac{(n+1)^2}{(x+3)^n}\right| = |x+3| \cdot \lim_{n\to\infty} \left(\frac{n+1}{n+2}\right)^2 = |x+3|
$$

The series converges if $|x+3| < 1$, i.e. $-4 < x < -2$, and diverges if $|x+3| > 1$.

**At $x = -2$:**

$$
\sum_{n=0}^{\infty} \frac{((-2)+3)^n}{(n+1)^2} = \sum_{n=0}^{\infty} \frac{1}{(n+1)^2}
$$

Since $\frac{1}{(n+1)^2} < \frac{1}{n^2}$ and $\sum \frac{1}{n^2}$ is a convergent $p$-series ($p = 2 > 1$), this converges by the Comparison Test.

**At $x = -4$:**

$$
\sum_{n=0}^{\infty} \frac{((-4)+3)^n}{(n+1)^2} = \sum_{n=0}^{\infty} \frac{(-1)^n}{(n+1)^2}
$$

The sequence $b_n = \frac{1}{(n+1)^2}$ is positive, decreasing, and $\lim_{n\to\infty} b_n = 0$. By the Alternating Series Test, this converges.

Therefore, the radius of convergence is $\boxed{R = 1}$ and the interval of convergence is $\boxed{[-4, -2]}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q7 — Power series integral of sin(3x^5)
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d07',
    'c0000000-0000-4000-8000-000000000002',
    'e25dbfed-dfba-520d-896d-0e6e8bad0930',
    'Power Series for $\\int_0^1 \\sin(3x^5)\\, dx$',
    $BODY$Given $\sin(x) = \displaystyle\sum_{n=0}^{\infty} \frac{(-1)^n}{(2n+1)!} x^{2n+1}$ for all $x \in \mathbb{R}$, express the integral $\displaystyle\int_0^1 \sin(3x^5)\, dx$ as a series of constant terms.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    7,
    $BODY$Substitute $3x^5$ into the sine series, then integrate term by term from $0$ to $1$. Note that a power series can be integrated within its interval of convergence.$BODY$,
    $BODY$$\displaystyle \sum_{n=0}^{\infty} \frac{(-1)^n 3^{2n+1}}{(10n+6)(2n+1)!}.$BODY$,
    $BODY$First, find the power series representation of $\sin(3x^5)$:

$$
\sin(3x^5) = \sum_{n=0}^{\infty} \frac{(-1)^n}{(2n+1)!}(3x^5)^{2n+1} = \sum_{n=0}^{\infty} \frac{(-1)^n 3^{2n+1}}{(2n+1)!} x^{10n+5}
$$

Since this converges for all $x \in \mathbb{R}$, we can integrate term by term:

$$
\int_0^1 \sin(3x^5)\, dx = \int_0^1 \sum_{n=0}^{\infty} \frac{(-1)^n 3^{2n+1}}{(2n+1)!} x^{10n+5}\, dx
$$

$$
= \left[\sum_{n=0}^{\infty} \frac{(-1)^n 3^{2n+1}}{(10n+6)(2n+1)!} x^{10n+6}\right]_0^1 = \boxed{\sum_{n=0}^{\infty} \frac{(-1)^n 3^{2n+1}}{(10n+6)(2n+1)!}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q8 — Power series via differentiation
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d08',
    'c0000000-0000-4000-8000-000000000002',
    'e25dbfed-dfba-520d-896d-0e6e8bad0930',
    'Power Series for $\\frac{x^4}{(4 + x^4)^2}$ via Differentiation',
    $BODY$Given $f(x) = \dfrac{1}{4 + x^4}$, find the power series representation of $g(x) = \dfrac{x^4}{(4 + x^4)^2}$.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    8,
    $BODY$Write $f(x) = \frac{1}{4}\sum_{n=0}^{\infty}\left(-\frac{x^4}{4}\right)^n$ using the geometric series formula. Differentiate $f$ to get $f'(x) = -\frac{4x^3}{(4+x^4)^2}$, then note that $g(x) = -\frac{x}{4}f'(x)$.$BODY$,
    $BODY$$\displaystyle g(x) = \sum_{n=1}^{\infty} \frac{(-1)^{n+1} n x^{4n}}{4^{n+1}}.$BODY$,
    $BODY$Observe that $\frac{1}{4 + x^4} = \frac{1}{4}\cdot\frac{1}{1 - \left(-\frac{x^4}{4}\right)}$, so

$$
f(x) = \frac{1}{4 + x^4} = \frac{1}{4}\sum_{n=0}^{\infty}\left(-\frac{x^4}{4}\right)^n = \sum_{n=0}^{\infty} \frac{(-1)^n x^{4n}}{4^{n+1}}
$$

Next, differentiate:

$$
f'(x) = -\frac{4x^3}{(4 + x^4)^2} = \sum_{n=1}^{\infty} \frac{(-1)^n (4n) x^{4n-1}}{4^{n+1}} = \sum_{n=1}^{\infty} \frac{(-1)^n n x^{4n-1}}{4^n}
$$

Since $g(x) = \frac{x^4}{(4 + x^4)^2} = -\frac{x}{4}\cdot f'(x)$:

$$
g(x) = -\frac{x}{4}\sum_{n=1}^{\infty} \frac{(-1)^n n x^{4n-1}}{4^n} = \boxed{\sum_{n=1}^{\infty} \frac{(-1)^{n+1} n x^{4n}}{4^{n+1}}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q9 — Taylor polynomial approximation
    'b3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d09',
    'c0000000-0000-4000-8000-000000000002',
    'e25dbfed-dfba-520d-896d-0e6e8bad0930',
    'Second-Degree Taylor Polynomial of $f(x) = \\sqrt[3]{3x}$',
    $BODY$Let $f(x) = \sqrt[3]{3x}$. Find the second-degree Taylor polynomial of $f$ about $\frac{8}{3}$ and use it to approximate $\sqrt[3]{3e}$.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    9,
    $BODY$Compute $f$, $f'$, and $f''$ at $x = \frac{8}{3}$, then plug into $P_2(x) = f(a) + f'(a)(x-a) + \frac{f''(a)}{2}(x-a)^2$. Set $x = e$ for the approximation.$BODY$,
    $BODY$$P_2(x) = 2 + \frac{1}{4}\left(x - \frac{8}{3}\right) - \frac{1}{32}\left(x - \frac{8}{3}\right)^2$; $\sqrt[3]{3e} \approx P_2(e)$.$BODY$,
    $BODY$Compute the derivatives:
$$
f'(x) = (3x)^{-2/3}, \qquad f''(x) = -2(3x)^{-5/3}
$$

Evaluating at $a = \frac{8}{3}$: $f\!\left(\frac{8}{3}\right) = \sqrt[3]{8} = 2$, $f'\!\left(\frac{8}{3}\right) = 8^{-2/3} = \frac{1}{4}$, $f''\!\left(\frac{8}{3}\right) = -2 \cdot 8^{-5/3} = -\frac{1}{16}$.

The second-degree Taylor polynomial about $\frac{8}{3}$ is

$$
P_2(x) = \frac{f\!\left(\frac{8}{3}\right)}{0!} + \frac{f'\!\left(\frac{8}{3}\right)}{1!}\!\left(x - \frac{8}{3}\right) + \frac{f''\!\left(\frac{8}{3}\right)}{2!}\!\left(x - \frac{8}{3}\right)^2
$$

$$
= 2 + \frac{1}{4}\!\left(x - \frac{8}{3}\right) + \frac{-1/16}{2}\!\left(x - \frac{8}{3}\right)^2 = \boxed{2 + \frac{1}{4}\!\left(x - \frac{8}{3}\right) - \frac{1}{32}\!\left(x - \frac{8}{3}\right)^2.}
$$

To approximate $\sqrt[3]{3e}$, set $x = e$:

$$
f(e) \approx P_2(e) = \boxed{2 + \frac{1}{4}\!\left(e - \frac{8}{3}\right) - \frac{1}{32}\!\left(e - \frac{8}{3}\right)^2.} \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
