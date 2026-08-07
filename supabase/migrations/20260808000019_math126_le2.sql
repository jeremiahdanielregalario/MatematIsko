-- ============================================================================
-- Math 126 Long Exam 2 — Lebesgue integration
-- Adds a new "Lebesgue Integration" topic and 4 questions with solutions.
-- Converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'c0000000-0000-4000-8000-000000000004',
    'Lebesgue Integration',
    'Simple functions, convergence theorems of the Lebesgue integral, and the Riemann integral comparison.'
  )
on conflict (id) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'fd734218-ab09-4b0b-829a-a31c5560528d',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'State the Theorems',
    $BODY$State the following theorems: _(1 point each)_

**(a)** Simple Approximation Lemma.

**(b)** Chebychev's Inequality.

**(c)** Fatou's Lemma.

**(d)** Lebesgue Dominated Convergence Theorem.$BODY$,
    'medium',
    2024,
    'Long Exam 2',
    1,
    $BODY$For (a), approximate a bounded measurable function from below and above by simple functions. For (b), bound the measure of the super-level set by the integral. For (c) and (d), state the conclusion about the limit of the integrals.$BODY$,
    $BODY$Statements of the four theorems (see solution).$BODY$,
    $BODY$**(a)** Let $f : E \to \mathbb{R}$ be a bounded and measurable function. Then, for all $\varepsilon > 0$, there exist simple functions $\varphi_{\varepsilon} : E \to \mathbb{R}$ and $\psi_{\varepsilon} : E \to \mathbb{R}$ such that

$$
\begin{equation*}\varphi_{\varepsilon} \le f \le \psi_{\varepsilon} \quad \text{and} \quad 0 \le \psi_{\varepsilon} - \varphi_{\varepsilon} < \varepsilon \text{ on } E.\end{equation*}
$$

---

**(b)** Let $f$ be a nonnegative measurable function defined on $E$. Then,

$$
\begin{equation*}m(\{x \in E : f(x) \ge \lambda\}) \le \frac{1}{\lambda} \int_E f, \quad \forall\, \lambda > 0.\end{equation*}
$$

---

**(c)** Let $\{f_n\}$ be a sequence of nonnegative measurable functions on $E$. If $f_n \to f$ pointwise a.e. on $E$, then

$$
\begin{equation*}\int_E \lim_{n \to \infty} f_n = \int_E f \le \liminf_{n \to \infty} \int_E f_n.\end{equation*}
$$

---

**(d)** Let $\{f_n\}$ be a sequence of measurable functions on $E$. Suppose there is a function $g$ that is integrable over $E$ and dominates $\{f_n\}$ on $E$ in the sense that $|f_n| \le g$ on $E$, $\forall\, n \in \mathbb{N}$.

If $f_n \to f$ pointwise a.e. on $E$, then $f$ is integrable over $E$ and

$$
\begin{equation*}\lim_{n \to \infty} \int_E f_n = \int_E f = \int_E \lim_{n \to \infty} f_n.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    'fd44f212-f31a-420c-8368-5a9aff33cde3',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'Examples of Integrable Functions',
    $BODY$Give an example of the following. Justify your answer. _(2 points each)_

**(a)** A simple function $\varphi$ defined on $[0, 1]$ such that $\displaystyle\int_{[0,1]} \varphi = 1$.

**(b)** A Lebesgue integrable function $f$ over $[0, 1]$ that is NOT Riemann integrable over $[0, 1]$.

**(c)** A bounded function $g$ defined on $[-1, 1]$ such that $g \not\equiv 0$ almost everywhere in $[-1, 1]$ but

$$\int_{[-1,1]} g = 0.$$

**(d)** A nonnegative function $h$ defined on $\mathbb{R}$ with finite support.$BODY$,
    'medium',
    2024,
    'Long Exam 2',
    2,
    $BODY$For (a), use $\varphi \equiv 1$ with $m([0,1]) = 1$. For (b), the Dirichlet function $\chi_{\mathbb{Q} \cap [0,1]}$. For (c), an odd function like $g(x) = x$. For (d), a function vanishing off a single point, e.g. $h = \chi_{\{0\}}$ — supported on a null set.$BODY$,
    $BODY$**(a)** $\varphi \equiv 1$ on $[0,1]$. **(b)** $\chi_{\mathbb{Q} \cap [0,1]}$. **(c)** $g(x) = x$. **(d)** $h = \chi_{\{0\}}$.$BODY$,
    $BODY$**(a)** Take $\varphi \equiv 1$ on $[0, 1]$. Since $\varphi = 1 < \infty$ on $[0, 1]$ and $m([0, 1]) = 1$, $\varphi$ is a simple function. Hence,

$$
\begin{equation*}\int_{[0,1]} \varphi = 1 \cdot m([0, 1]) = 1.\end{equation*}
$$

---

**(b)** Consider the Dirichlet function

$$
\begin{equation*}f(x) = \begin{cases} 1, & \text{if } x \in [0, 1] \cap \mathbb{Q}, \\ 0, & \text{if } x \in [0, 1] \cap \mathbb{Q}'. \end{cases}\end{equation*}
$$

Since $f = \chi_{\mathbb{Q} \cap [0,1]}$ is a simple function (a finite linear combination of characteristic functions of measurable sets), it is Lebesgue integrable with $\int_{[0,1]} f = 1 \cdot m(\mathbb{Q} \cap [0,1]) = 0$. However, $f$ is discontinuous at every point of $[0,1]$, so its set of discontinuities has measure $1 \neq 0$; hence $f$ is **not** Riemann integrable. $\blacksquare$

---

**(c)** Take $g(x) = x$ on $[-1, 1]$. Then $g \not\equiv 0$ a.e. on $[-1, 1]$, but since $g$ is odd,

$$
\begin{equation*}\int_{[-1,1]} g = \int_{-1}^{1} x\, dx = 0.\end{equation*}
$$

---

**(d)** Take $h = \chi_{\{0\}}$, i.e. $h(x) = 1$ if $x = 0$ and $h(x) = 0$ for $x \in \mathbb{R} \setminus \{0\}$. The support of $h$ is $\{0\}$, a finite (and null) set, so $h$ is nonnegative with finite support. $\blacksquare$$BODY$
  ),
  (
    '8b732fdc-3866-4763-9c76-abe76a52decf',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'The Sequence $f_n(x) = \\frac{nx}{1 + nx}$',
    $BODY$Consider the sequence of functions $\{f_n\}$ defined on the interval $[0, 1]$, where

$$f_n(x) = \frac{nx}{1 + nx}, \quad \forall\, x \in [0, 1],\ \forall\, n \in \mathbb{N}.$$

**(a)** Show that the sequence of functions $\{f_n\}$ is uniformly bounded by $1$, that is,

$$|f_n(x)| \le 1, \quad \forall\, x \in [0, 1],\ \forall\, n \in \mathbb{N}.$$

**(b)** Evaluate $\displaystyle\lim_{n \to \infty} \int_{[0,1]} \frac{nx}{1 + nx}\, dx$.$BODY$,
    'hard',
    2024,
    'Long Exam 2',
    3,
    $BODY$For (a), note $nx \ge 0$ and $nx < 1 + nx$ on $[0,1]$. For (b), the pointwise limit is $f(x) = 1$ for $x > 0$ (and $f(0) = 0$); apply the Lebesgue Dominated Convergence Theorem with $g \equiv 1$, or compute the integral directly.$BODY$,
    $BODY$**(a)** $0 \le f_n(x) < 1 \le 1$ for all $x, n$. **(b)** The limit is $1$.$BODY$,
    $BODY$**(a)** For $x \in [0, 1]$ and $n \in \mathbb{N}$, we have $nx \ge 0$, so $f_n(x) \ge 0$. Moreover $nx < 1 + nx$, hence

$$
\begin{equation*}0 \le f_n(x) = \frac{nx}{1 + nx} < 1 \le 1.\end{equation*}
$$

Therefore $|f_n(x)| \le 1$ for all $x \in [0, 1]$ and $n \in \mathbb{N}$. $\blacksquare$

---

**(b)** Pointwise, for $x = 0$, $f_n(0) = 0$ for all $n$; for $x > 0$,

$$
\begin{equation*}\lim_{n \to \infty} \frac{nx}{1 + nx} = 1.\end{equation*}
$$

So $f_n \to f$ pointwise on $[0,1]$ where $f = \chi_{(0,1]}$ (i.e. $f = 1$ a.e. on $[0,1]$). Since $|f_n| \le 1$ and $g \equiv 1$ is integrable on $[0,1]$, the Lebesgue Dominated Convergence Theorem gives

$$
\begin{equation*}\lim_{n \to \infty} \int_{[0,1]} \frac{nx}{1 + nx}\, dx = \int_{[0,1]} 1\, dx = \boxed{1}.\end{equation*}
$$

(Equivalently, computing directly: $\int_0^1 \frac{nx}{1+nx}\, dx = 1 - \frac{\ln(1+n)}{n} \to 1$.) $\blacksquare$$BODY$
  ),
  (
    '0be68c8f-f96c-4012-b841-b61de248d56f',
    'c0000000-0000-4000-8000-000000000004',
    '436307b0-b252-4f1e-a950-aae7aabb9af5',
    'Comparing Integrals of $f \\le g$ a.e.',
    $BODY$Let $f$ and $g$ be nonnegative measurable functions defined on a measurable set $E$ such that $f \le g$ a.e. on $E$. _(2 points each)_

**(a)** Show that if

$$\int_E f = \int_E g < \infty,$$

then $f = g$ a.e. on $E$.

**(b)** Give a counterexample that shows that the previous item does not hold if we remove the assumption that the integrals of $f$ and $g$ are finite. Justify your example.$BODY$,
    'hard',
    2024,
    'Long Exam 2',
    4,
    $BODY$For (a), apply the standard result: a nonnegative measurable function with integral zero vanishes a.e. to $h = g - f \ge 0$ with $\int h = 0$. For (b), use an infinite-measure domain where $f < g$ on a set of positive measure yet both integrals are infinite.$BODY$,
    $BODY$**(a)** $f = g$ a.e. **(b)** On $E = [0, \infty)$: $f = 1$ and $g = 1 + \chi_{[0,1]}$. Then $f \le g$, $\int f = \int g = \infty$, but $f \neq g$ on $[0,1]$ (measure $1$).$BODY$,
    $BODY$**(a)** Let $h = g - f$. Since $f \le g$ a.e. on $E$, we have $h \ge 0$ a.e. on $E$, and $h$ is measurable. Moreover,

$$
\begin{equation*}\int_E h = \int_E g - \int_E f = 0.\end{equation*}
$$

Since $h$ is a nonnegative measurable function with $\int_E h = 0$, the standard result gives $h = 0$ a.e. on $E$. Therefore, $f = g$ a.e. on $E$. $\blacksquare$

---

**(b)** Take $E = [0, \infty)$ and define

$$
\begin{equation*}f(x) = 1, \qquad g(x) = 1 + \chi_{[0,1]}(x) = \begin{cases} 2, & x \in [0, 1], \\ 1, & x > 1. \end{cases}\end{equation*}
$$

Then $f \le g$ a.e. on $E$, and

$$
\begin{equation*}\int_E f = \infty, \qquad \int_E g = \int_0^{\infty} 1\, dx + \int_0^1 dx = \infty + 1 = \infty.\end{equation*}
$$

So $\int_E f = \int_E g = \infty$, but $f \neq g$ on $[0, 1]$, which has measure $1 > 0$. Hence the finiteness assumption in (a) is necessary. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
