-- ============================================================================
-- Math 126 Exercises — Lebesgue Integration (A.Y. 2025-2026)
-- 9 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '349ceee9-b349-4b0f-a0f5-eacd0e140483',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'Thomae''s Function',
    $BODY$Define the Thomae's function $h : (0, \infty) \to \mathbb{R}$ by

$$h(x) = \begin{cases} 0, & \text{if } x \in \mathbb{Q}', \\ \dfrac{1}{n}, & \text{if } x = \dfrac{m}{n} \text{ with } \gcd(m, n) = 1. \end{cases}$$

**(a)** Show that $h$ is measurable.

**(b)** Evaluate $\displaystyle\int_{(0, \infty)} h$.$BODY$,
    'hard',
    2025,
    'Exercises',
    1,
    $BODY$For (a), show the super-level sets $\{x : h(x) > a\}$ are measurable in the three cases $a \ge 1$, $a < 0$, $0 \le a < 1$ (in the last case the set is contained in the countable set $\mathbb{Q}$). For (b), note $h = 0$ a.e. since $h$ is nonzero only on $\mathbb{Q}$.$BODY$,
    $BODY$**(a)** $h$ is measurable. **(b)** $\displaystyle\int_{(0,\infty)} h = 0$ since $h = 0$ a.e.$BODY$,
    $BODY$**(a)** Note that $\operatorname{dom} h = (0, \infty)$ is an interval, so it is measurable. Let $a \in \mathbb{R}$ and consider

$$
\begin{equation*}\{x \in (0, \infty) : h(x) > a\}.\end{equation*}
$$

**Case 1: $a \ge 1$.** Since $h(x) = 1/n \le 1$ for any $n \in \mathbb{N}$,

$$
\begin{equation*}m^*(\{x \in (0, \infty) : h(x) > a\}) = m^*(\varnothing) = 0,\end{equation*}
$$

so the set is measurable.

**Case 2: $a < 0$.** Then $\{x \in (0, \infty) : h(x) > a\} = (0, \infty)$, which is measurable.

**Case 3: $0 \le a < 1$.** Here $\{x \in (0, \infty) : h(x) > a\} \subseteq (0, \infty) \cap \mathbb{Q} \subseteq \mathbb{Q}$, and by monotonicity of outer measure,

$$
\begin{equation*}m^*(\{x \in (0, \infty) : h(x) > a\}) \le m^*(\mathbb{Q}) = 0,\end{equation*}
$$

so the set has outer measure $0$ and is measurable.

In every case, $\{x \in (0, \infty) : h(x) > a\}$ is measurable, so $h$ is measurable. $\blacksquare$

---

**(b)** Note that $h$ is a nonnegative function defined on $(0, \infty)$ since $1/n > 0$. Since $h = 0$ on $(0, \infty) \setminus \mathbb{Q}$ and $m(\mathbb{Q}) = 0$, we have $h = 0$ a.e. on $(0, \infty)$. Hence,

$$
\begin{equation*}\int_{(0, \infty)} h = 0.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '9c6e3f68-1e9e-4fe1-889d-8d9fa87a798a',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'If $\\int_E f = M \\cdot m(E)$ Then $f = M$ a.e.',
    $BODY$Let $f : E \to \mathbb{R}$ be a bounded measurable function defined on a measurable set $E$ such that $|f(x)| \le M$ for all $x \in E$ and for some $M > 0$. Show that if

$$\int_E f = M \cdot m(E),$$

then $f(x) = M$ for almost every $x \in E$.$BODY$,
    'medium',
    2025,
    'Exercises',
    2,
    $BODY$Use $\int_E f \le \int_E |f| \le \int_E M = M \cdot m(E)$ together with the hypothesis to get $\int_E (M - f) = 0$ with $M - f \ge 0$, forcing $M - f = 0$ a.e.$BODY$,
    $BODY$Since $f \le M$ and $\int_E (M - f) = 0$ with $M - f \ge 0$, we get $f = M$ a.e.$BODY$,
    $BODY$Note that $|f(x)| \le M$ for any $x \in E$. By the comparison of integrals,

$$
\begin{equation*}M \cdot m(E) = \int_E f \le \int_E |f| \le \int_E M = M \cdot m(E).\end{equation*}
$$

Since the first and last terms are equal, equality holds throughout, so

$$
\begin{equation*}\int_E f = \int_E M.\end{equation*}
$$

Equivalently,

$$
\begin{equation*}\int_E (M - f) = 0.\end{equation*}
$$

Since $M - f \ge 0$ on $E$ (as $f \le |f| \le M$), the nonnegativity implies $M - f = 0$ a.e. on $E$.

$\therefore$ $f(x) = M$ for almost every $x \in E$. $\blacksquare$$BODY$
  ),
  (
    '821e006e-6303-4e4f-9941-f07dae98b5b5',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'The Sequence $f_n(x) = \\dfrac{nx}{1 + n^2 x^2}$',
    $BODY$Consider the sequence of functions $\{f_n\}$ defined on the interval $[0, 1]$, where

$$f_n(x) = \frac{nx}{1 + n^2 x^2}, \quad \forall\, x \in [0, 1],\ \forall\, n \in \mathbb{N}.$$

**(a)** Show that the sequence of functions $\{f_n\}$ is uniformly bounded, i.e. there exists $M > 0$ such that

$$|f_n(x)| \le M, \quad \forall\, x \in [0, 1],\ \forall\, n \in \mathbb{N}.$$

**(b)** Evaluate $\displaystyle\lim_{n \to \infty} \int_{[0,1]} \frac{nx}{1 + n^2 x^2}\, dx$.$BODY$,
    'hard',
    2025,
    'Exercises',
    3,
    $BODY$For (a), use $(nx - 1)^2 \ge 0$ to show $2nx \le n^2 x^2 + 1$, giving $f_n(x) \le 1/2$. For (b), the pointwise limit is $0$ everywhere; apply the bounded convergence theorem with bound $1/2$.$BODY$,
    $BODY$**(a)** $|f_n(x)| \le \dfrac{1}{2}$ for all $x, n$. **(b)** The limit is $0$.$BODY$,
    $BODY$**(a)** Let $x \in [0, 1]$ and $n \in \mathbb{N}$. Note that $(nx - 1)^2 \ge 0$, so $n^2 x^2 - 2nx + 1 \ge 0$, hence

$$
\begin{equation*}2nx \le n^2 x^2 + 1 \implies \frac{nx}{1 + n^2 x^2} \le \frac{1}{2}.\end{equation*}
$$

Since $f_n(x) \ge 0$,

$$
\begin{equation*}|f_n(x)| = \frac{nx}{1 + n^2 x^2} \le \frac{1}{2} =: M > 0.\end{equation*}
$$

Therefore, $\{f_n\}$ is uniformly bounded by $\dfrac{1}{2}$. $\blacksquare$

---

**(b)** Let $x \in [0, 1]$. If $x = 0$, then $f_n(0) = 0$ for all $n$. For $x \in (0, 1]$,

$$
\begin{aligned}
|f_n(x) - 0| &= \left| \frac{nx}{1 + n^2 x^2} \right| \le \frac{nx}{1 + n^2 x^2} \le \frac{1}{nx} \to 0
\end{aligned}
$$

as $n \to \infty$. Hence, $f_n \to 0$ pointwise on $[0, 1]$.

Since $\{f_n\}$ is uniformly bounded by $1/2$ (an integrable function on $[0, 1]$), the Bounded Convergence Theorem gives

$$
\begin{aligned}
\lim_{n \to \infty} \int_{[0,1]} \frac{nx}{1 + n^2 x^2}\, dx
&= \int_{[0,1]} \lim_{n \to \infty} \frac{nx}{1 + n^2 x^2}\, dx \\
&= \int_{[0,1]} 0\, dx = 0.
\end{aligned}
$$

$\blacksquare$$BODY$
  ),
  (
    '6fa95ca4-89fb-4e1a-ba44-a898755c2a23',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'Comparing Integrals of $f \\le g$ a.e.',
    $BODY$Let $f$ and $g$ be nonnegative measurable functions defined on a measurable set $E$ such that $f \le g$ a.e. on $E$.

**(a)** Show that if

$$\int_E f = \int_E g < \infty,$$

then $f = g$ a.e. on $E$.

**(b)** Give a counterexample that shows that the previous item does not hold if we remove the assumption that the integrals of $f$ and $g$ are finite.$BODY$,
    'medium',
    2025,
    'Exercises',
    4,
    $BODY$For (a), apply $\int_E (g - f) = 0$ with $g - f \ge 0$ a.e. For (b), take $f = 1$ and $g = 2$ on $E = \mathbb{R}$, so both integrals are infinite but $f \neq g$ a.e.$BODY$,
    $BODY$**(a)** $f = g$ a.e. **(b)** $f = 1$, $g = 2$ on $E = \mathbb{R}$ gives $\int f = \int g = \infty$ but $f \neq g$ everywhere.$BODY$,
    $BODY$**(a)** Take $h = g - f \ge 0$ a.e. on $E$. Then,

$$
\begin{equation*}\int_E h = \int_E g - \int_E f = 0.\end{equation*}
$$

Since $h \ge 0$ a.e. and $\int_E h = 0$, the standard result gives $h = 0$ a.e. on $E$.

$\therefore$ $f = g$ a.e. on $E$. $\blacksquare$

---

**(b)** One can take $f(x) = 1$ and $g(x) = 2$ on $E = \mathbb{R}$. Then $f \le g$ everywhere, but

$$
\begin{equation*}\int_{\mathbb{R}} f = \int_{\mathbb{R}} g = \infty,\end{equation*}
$$

while $f \neq g$ everywhere. Hence the finiteness assumption is necessary. $\blacksquare$$BODY$
  ),
  (
    '5b8f79cb-046e-4a3c-ba1c-284aeedaef72',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'Summability of $m(E_n)$',
    $BODY$Let $f$ be a bounded measurable function defined on a measurable set $E$. Define

$$E_n = \{x \in E : f(x) \ge n\},$$

for any $n \in \mathbb{N}$. Show that if $\displaystyle\int_E f < \infty$, then

$$\sum_{n=1}^{\infty} m(E_n) < \infty.$$$BODY$,
    'hard',
    2025,
    'Exercises',
    5,
    $BODY$Consider the simple function $s = \sum_{n=1}^{\infty} \chi_{E_n}$. Then $s(x)$ counts the integers $n$ with $f(x) \ge n$, so $s \le f^{+}$. Integrate: $\sum m(E_n) = \int s \le \int f < \infty$.$BODY$,
    $BODY$The simple function $s = \sum_n \chi_{E_n}$ satisfies $s \le f^{+}$, so $\sum_n m(E_n) = \int s \le \int f < \infty$.$BODY$,
    $BODY$Since $f$ is bounded, $|f| \le M$ for some $M > 0$ on $E$. We focus on $f^{+}$, since $E_n$ only depends on positive values.

For any $n > M$, we have $E_n = \{x \in E : f(x) \ge n\} = \varnothing$.

Consider the simple function

$$
\begin{equation*}s = \sum_{n=1}^{\infty} \chi_{E_n}.\end{equation*}
$$

Note that for any $x \in E$, $s(x)$ is the number of integers $n$ with $f(x) \ge n$, so $s(x) \le f^{+}(x)$. Then, by monotonicity of integrals,

$$
\begin{equation*}\int_E s \le \int_E f.\end{equation*}
$$

Hence,

$$
\begin{aligned}
\int_E s &= \int_E \sum_{n=1}^{\infty} \chi_{E_n} = \sum_{n=1}^{\infty} m(E_n) \le \int_E f < \infty.
\end{aligned}
$$

$\therefore$ $\displaystyle\sum_{n=1}^{\infty} m(E_n) < \infty$. $\blacksquare$$BODY$
  ),
  (
    '42eccdc4-b78f-4983-adab-d7a51dd92467',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'Equal Integrals Over Every Subset Imply Equality a.e.',
    $BODY$Let $f$ and $g$ be extended real-valued functions (that is, $f$ and $g$ can have infinite values) that are measurable and integrable over a measurable set $E$. Show that if

$$\int_D f = \int_D g$$

for every measurable subset $D$ of $E$, then $f = g$ a.e. on $E$.$BODY$,
    'hard',
    2025,
    'Exercises',
    6,
    $BODY$Let $h = f - g$, so $\int_D h = 0$ for every measurable $D \subseteq E$. For $A = \{x \in E : h(x) > 0\} = \bigcup_n A_n$ with $A_n = \{x : h(x) > 1/n\}$, Chebychev gives $m(A_n) = 0$; likewise $\{h < 0\}$ is null.$BODY$,
    $BODY$$f = g$ a.e. — consider $A = \{h > 0\}$ and $\{h < 0\}$ via Chebychev's inequality.$BODY$,
    $BODY$Suppose $\int_D f = \int_D g$ for every measurable subset $D$ of $E$. Let $h = f - g$, so that

$$
\begin{equation*}\int_D h = \int_D (f - g) = \int_D f - \int_D g = 0\end{equation*}
$$

for any measurable subset $D$ of $E$.

Consider the set $A = \{x \in E : h(x) > 0\}$, and define $A_n = \{x \in E : h(x) > 1/n\}$, noting that $A_n \subseteq A$ and $A = \bigcup_{n=1}^{\infty} A_n$. By Chebychev's Inequality,

$$
\begin{equation*}m(A_n) \le n \int_{A_n} h = n \cdot 0 = 0,\end{equation*}
$$

so $m(A_n) = 0$ for every $n$. Hence, $m(A) \le \sum_n m(A_n) = 0$, so $m(A) = 0$.

Applying the same argument to $-h$, the set $\{x \in E : h(x) < 0\}$ also has measure zero.

$\therefore$ $h = 0$ a.e. on $E$, i.e. $f = g$ a.e. on $E$. $\blacksquare$$BODY$
  ),
  (
    '5ddc5917-d0ba-4924-8ae3-c5b4bd4e353c',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'The Tails $E_n = \\{|f| \\ge n\\}$ Have Measure Zero',
    $BODY$Let $f$ be an extended real-valued function that is measurable and integrable on a measurable set $E$. Define $E_n = \{x \in E : |f(x)| \ge n\}$, for any $n \in \mathbb{N}$. Show that

$$\lim_{n \to \infty} m(E_n) = 0.$$$BODY$,
    'medium',
    2025,
    'Exercises',
    7,
    $BODY$Apply Chebychev's inequality to $|f|$: $m(E_n) \le \frac{1}{n} \int_E |f| \to 0$.$BODY$,
    $BODY$Chebychev gives $m(E_n) \le \frac{1}{n}\int_E |f| \to 0$.$BODY$,
    $BODY$By the integrability of $f$, $\displaystyle\int_E |f| < \infty$. By Chebychev's Inequality,

$$
\begin{equation*}m(\{x \in E : |f(x)| \ge n\}) \le \frac{1}{n} \int_E |f| \to 0\end{equation*}
$$

as $n \to \infty$.

$\therefore$ $\displaystyle\lim_{n \to \infty} m(E_n) = 0$. $\blacksquare$$BODY$
  ),
  (
    '891a5f5d-52b4-4b5c-897d-02d9c36865a2',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'Integrability From Approximating Subsets',
    $BODY$Let $f$ be an extended real-valued function that is measurable and integrable on a measurable set $E$. Suppose that for some increasing sequence of measurable subsets of $E$, $\{A_n\}$, with

$$\bigcup_{n=1}^{\infty} A_n = E,$$

we have

$$\lim_{n \to \infty} \int_{A_n} f < \infty.$$

Show that $f$ is integrable over $E$.$BODY$,
    'hard',
    2025,
    'Exercises',
    8,
    $BODY$Write $f = f^{+} - f^{-}$. Since $A_n \uparrow E$, apply the Monotone Convergence Theorem to the positive and negative parts and use the finiteness of the limit.$BODY$,
    $BODY$By MCT, $\int_E f^{+} = \lim_n \int_{A_n} f^{+}$ and $\int_E f^{-} = \lim_n \int_{A_n} f^{-}$ are both finite, so $\int_E |f| < \infty$.$BODY$,
    $BODY$Let $f = f^{+} - f^{-}$. Since $\{A_n\}$ is increasing with $\bigcup_n A_n = E$, by the Monotone Convergence Theorem,

$$
\begin{equation*}\int_E f^{+} = \lim_{n \to \infty} \int_{A_n} f^{+}, \qquad \int_E f^{-} = \lim_{n \to \infty} \int_{A_n} f^{-}.\end{equation*}
$$

Since

$$
\begin{equation*}\lim_{n \to \infty} \int_{A_n} f < \infty \implies \lim_{n \to \infty} \int_{A_n} f^{+},\ \lim_{n \to \infty} \int_{A_n} f^{-} < \infty,\end{equation*}
$$

both $\int_E f^{+}$ and $\int_E f^{-}$ are finite. Hence,

$$
\begin{equation*}\int_E |f| = \int_E f^{+} + \int_E f^{-} < \infty.\end{equation*}
$$

$\therefore$ $f$ is integrable over $E$. $\blacksquare$$BODY$
  ),
  (
    'caff0516-6f89-444b-8a83-8df9611aa402',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'True or False: Lebesgue Integration Statements',
    $BODY$Determine whether the statement is true or false. If the statement is true, provide a proof. Otherwise, give a counterexample.

**(a)** The pointwise limit of a sequence of measurable functions is also measurable.

**(b)** If $f$ is a bounded measurable function on $E$ such that $m^*(E) = 0$, then $\displaystyle\int_E f = 0$.

**(c)** If $f$ is a bounded function defined on a measurable set of finite measure $E$, then $f \equiv 0$ on $E$ if and only if $\displaystyle\int_E f = 0$.

**(d)** The Lebesgue integral and the Riemann integral of every function, if they exist, are always equal.

**(e)** Let $a, b \in \mathbb{R}$ such that $a < b$. Then $\displaystyle\int_{[a,b]} 1 = b - a$.

**(f)** Every continuous function defined on a closed and bounded interval is integrable.

**(g)** The integral of a bounded function defined on a measurable set $E$ is always defined.

**(h)** The function $f^{-}$ is nonnegative.

**(i)** For any nonnegative function $h$ defined on a measurable set $E$, $\displaystyle\int_{\operatorname{supp} h} h \neq 0$.$BODY$,
    'hard',
    2025,
    'Exercises',
    9,
    $BODY$For (c) and (i), a function supported on a single point has integral zero but is not identically zero. For (g), on infinite-measure sets bounded integrals may diverge. For (d), when both integrals exist they coincide for bounded functions.$BODY$,
    $BODY$**(a)** TRUE. **(b)** TRUE. **(c)** FALSE. **(d)** TRUE. **(e)** TRUE. **(f)** TRUE. **(g)** FALSE. **(h)** TRUE. **(i)** FALSE.$BODY$,
    $BODY$**(a)** **TRUE.** The domain of the functions is measurable, so the pointwise limit of the functions also has a measurable domain, and the pointwise limit of measurable functions is measurable. $\blacksquare$

---

**(b)** **TRUE.** Since $m^*(E) = 0$, we have $m(E) = 0$. By the standard result, a bounded measurable function on a set of measure zero has integral zero, so $\int_E f = 0$. $\blacksquare$

---

**(c)** **FALSE.** Consider $f(x) = 1$ for $x = a \in E$ and $f(x) = 0$ otherwise. Then $f$ is supported on $\{a\}$, which has measure zero, so $\int_E f = 0$ but $f \not\equiv 0$ on $E$. $\blacksquare$

---

**(d)** **TRUE.** By the theorem, this is true for bounded functions. For unbounded functions, we can take intervals of arbitrary lengths to make the function bounded, and the theorem applies — whenever both integrals exist, they coincide. $\blacksquare$

---

**(e)** **TRUE.** The function $f(x) = 1$ for $x \in [a, b]$ is bounded and measurable. Therefore,

$$
\begin{equation*}\int_{[a,b]} 1 = m([a, b]) = b - a.\end{equation*}
$$

$\blacksquare$

---

**(f)** **TRUE.** Continuous functions on a closed and bounded interval are Riemann integrable, and Riemann integrable (bounded) functions are Lebesgue integrable with the same integral. Hence they are Lebesgue integrable. $\blacksquare$

---

**(g)** **FALSE.** If $m(E) = \infty$, it is possible that the integral of a bounded function is infinite (e.g. the constant function $1$ on $\mathbb{R}$). So the integral need not be defined (finite). $\blacksquare$

---

**(h)** **TRUE.** Since $f^{-} = \max\{-f, 0\}$, it follows that $f^{-} \ge 0$, hence it is nonnegative. $\blacksquare$

---

**(i)** **FALSE.** Consider the function $h(x) = 1$ for $x = a \in E$ and $h(x) = 0$ for $x \in E \setminus \{a\}$. Then $m(\operatorname{supp} h) = m(\{a\}) = 0$, so $\int_{\operatorname{supp} h} h = 0$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
