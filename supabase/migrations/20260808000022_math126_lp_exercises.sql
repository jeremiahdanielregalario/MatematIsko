-- ============================================================================
-- Math 126 Exercises — L^p Spaces and Linear Transformations (A.Y. 2025-2026)
-- Adds a new topic and 10 problems with solutions.
-- Converted from Typst to Markdown + LaTeX. Blank answers filled in.
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'c0000000-0000-4000-8000-000000000004',
    'L^p Spaces and Linear Transformations',
    'L^p norms, Hölder and interpolation inequalities, convergence in L^p, and continuous linear operators on normed spaces.'
  )
on conflict (id) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '6343171b-86c5-4a2c-a1dc-6cef2374c44f',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'The Inequality $\\left(\\int f\\right)\\left(\\int 1/f\\right) \\ge 1$',
    $BODY$Let $f$ be a strictly positive real-valued function defined on $[0, 1]$. Show that

$$\left( \int_{[0,1]} f \right) \left( \int_{[0,1]} \frac{1}{f} \right) \ge 1.$$$BODY$,
    'medium',
    2025,
    'Exercises',
    1,
    $BODY$If either integral is infinite, the result is trivial. Otherwise $\sqrt{f}, 1/\sqrt{f} \in L^2([0,1])$ and apply Cauchy-Schwarz: $\|\sqrt{f}\|_2 \|\sqrt{1/f}\|_2 \ge \|\sqrt{f} \cdot \sqrt{1/f}\|_1 = 1$.$BODY$,
    $BODY$By Cauchy-Schwarz, $\sqrt{\int f} \cdot \sqrt{\int 1/f} \ge \int \sqrt{f \cdot 1/f} = 1$; squaring gives the result.$BODY$,
    $BODY$Note that since $f > 0$ on $[0, 1]$, we have $|f| = f$ on $[0, 1]$.

If $\int_{[0,1]} f = +\infty$ or $\int_{[0,1]} 1/f = +\infty$, then the inequality holds since $+\infty \ge 1$.

If $\int_{[0,1]} f < +\infty$ and $\int_{[0,1]} 1/f < \infty$, then $f, 1/f \in L^1([0,1])$, and so $\sqrt{f}, \sqrt{1/f} \in L^2([0,1])$, since

$$
\begin{equation*}\int_{[0,1]} \left| \sqrt{f} \right|^2 = \int_{[0,1]} f < \infty \quad \text{and} \quad \int_{[0,1]} \left| \sqrt{1/f} \right|^2 = \int_{[0,1]} \frac{1}{f} < \infty.\end{equation*}
$$

By the Cauchy-Schwarz inequality,

$$
\begin{equation*}\left\| \sqrt{f} \right\|_2 \cdot \left\| \sqrt{1/f} \right\|_2 \ge \left\| \sqrt{f} \cdot \sqrt{1/f} \right\|_1.\end{equation*}
$$

For the LHS,

$$
\begin{equation*}\left\| \sqrt{f} \right\|_2 \cdot \left\| \sqrt{1/f} \right\|_2 = \sqrt{\int_{[0,1]} f} \cdot \sqrt{\int_{[0,1]} \frac{1}{f}}.\end{equation*}
$$

For the RHS,

$$
\begin{equation*}\left\| \sqrt{f} \cdot \sqrt{1/f} \right\|_1 = \int_{[0,1]} \left| \sqrt{f \cdot \frac{1}{f}} \right| = \int_{[0,1]} 1 = m([0, 1]) = 1.\end{equation*}
$$

Hence,

$$
\begin{equation*}\sqrt{\int_{[0,1]} f} \cdot \sqrt{\int_{[0,1]} \frac{1}{f}} \ge 1,\end{equation*}
$$

and squaring both sides,

$$
\begin{equation*}\boxed{\left( \int_{[0,1]} f \right) \left( \int_{[0,1]} \frac{1}{f} \right) \ge 1}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '25e582a0-bd99-481e-83b2-aaefc50a421c',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'The Interpolation Inequality for $L^r$',
    $BODY$Let $\Omega$ be a measurable subset of $\mathbb{R}$. Let $\alpha \in (0, 1)$ and let $p, q, r \ge 1$ such that $p, q \ge r$ and

$$\frac{1}{r} = \frac{\alpha}{p} + \frac{1 - \alpha}{q}.$$

Show that for every measurable function $f$ on $\Omega$,

$$\| f \|_{L^r(\Omega)} \le \| f \|_{L^p(\Omega)}^{\alpha} \| f \|_{L^q(\Omega)}^{1 - \alpha}.$$$BODY$,
    'hard',
    2025,
    'Exercises',
    2,
    $BODY$Write $|f|^r = |f|^{\alpha r} |f|^{(1-\alpha)r}$ and apply Hölder's inequality with exponents $p/(\alpha r)$ and $q/((1-\alpha)r)$, whose reciprocals sum to $1$ by the hypothesis.$BODY$,
    $BODY$Hölder applied to $|f|^{\alpha r} |f|^{(1-\alpha)r}$ gives $\|f\|_r^r \le \|f\|_p^{\alpha r} \|f\|_q^{(1-\alpha)r}$; take $r$-th roots.$BODY$,
    $BODY$Let $f$ be a measurable function on $\Omega$. Write

$$
\begin{equation*}|f|^r = |f|^{\alpha r} \cdot |f|^{(1 - \alpha)r}.\end{equation*}
$$

Define the conjugate exponents

$$
\begin{equation*}A = \frac{p}{\alpha r}, \qquad B = \frac{q}{(1 - \alpha) r}.\end{equation*}
$$

Then

$$
\begin{equation*}\frac{1}{A} + \frac{1}{B} = \frac{\alpha r}{p} + \frac{(1 - \alpha) r}{q} = r\left( \frac{\alpha}{p} + \frac{1 - \alpha}{q} \right) = r \cdot \frac{1}{r} = 1,\end{equation*}
$$

so $A$ and $B$ are conjugate. By Hölder's inequality,

$$
\begin{aligned}
\| f \|_r^r = \int_{\Omega} |f|^r &= \int_{\Omega} |f|^{\alpha r} |f|^{(1 - \alpha) r} \\
&\le \left( \int_{\Omega} |f|^{\alpha r \cdot A} \right)^{1/A} \left( \int_{\Omega} |f|^{(1 - \alpha) r \cdot B} \right)^{1/B} \\
&= \left( \int_{\Omega} |f|^p \right)^{\alpha r / p} \left( \int_{\Omega} |f|^q \right)^{(1 - \alpha) r / q} \\
&= \| f \|_p^{\alpha r} \cdot \| f \|_q^{(1 - \alpha) r}.
\end{aligned}
$$

Taking $r$-th roots,

$$
\begin{equation*}\boxed{\| f \|_r \le \| f \|_p^{\alpha} \| f \|_q^{1 - \alpha}}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    'abb474f6-d60b-4b2b-b4a5-ccbabfeb5c59',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Products of Convergent Sequences in $L^p$ and $L^{p''}$',
    $BODY$Let $\Omega$ be a measurable subset of $\mathbb{R}$. Let $p \in [1, \infty)$ and $p'$ be its conjugate. Let $\{f_n\}$ be a sequence in $L^p(\Omega)$ and $\{g_n\}$ be a sequence in $L^{p'}(\Omega)$ such that

$$f_n \to f \text{ in } L^p(\Omega) \qquad \text{and} \qquad g_n \to g \text{ in } L^{p'}(\Omega),$$

for some $f \in L^p(\Omega)$ and $g \in L^{p'}(\Omega)$. Show that

$$f_n g_n \to f g \text{ in } L^1(\Omega).$$$BODY$,
    'hard',
    2025,
    'Exercises',
    3,
    $BODY$Decompose $f_n g_n - fg = f_n(g_n - g) + g(f_n - f)$, apply the triangle inequality, then Hölder. The boundedness of $\{f_n\}$ in $L^p$ follows from strong convergence.$BODY$,
    $BODY$By the triangle inequality and Hölder, $\|f_n g_n - fg\|_1 \le \|f_n\|_p \|g_n - g\|_{p'} + \|g\|_{p'} \|f_n - f\|_p \to 0$.$BODY$,
    $BODY$By Hölder's inequality, $f_n g_n \in L^1(\Omega)$ for any $n \in \mathbb{N}$. By the definition of convergence,

$$
\begin{equation*}\lim_{n \to \infty} \| f_n - f \|_p = 0, \qquad \lim_{n \to \infty} \| g_n - g \|_{p'} = 0.\end{equation*}
$$

Note that

$$
\begin{equation*}f_n g_n - fg = f_n (g_n - g) + g (f_n - f).\end{equation*}
$$

By the triangle inequality,

$$
\begin{equation*}\| f_n g_n - fg \|_1 \le \| f_n (g_n - g) \|_1 + \| g (f_n - f) \|_1.\end{equation*}
$$

By Hölder's inequality,

$$
\begin{equation*}\| f_n g_n - fg \|_1 \le \| f_n \|_p \| g_n - g \|_{p'} + \| g \|_{p'} \| f_n - f \|_p.\end{equation*}
$$

Since $f_n \to f$ in $L^p(\Omega)$, the sequence $\{f_n\}$ is bounded in $L^p(\Omega)$, i.e. there exists $M > 0$ such that $\| f_n \|_p \le M$ for all $n \in \mathbb{N}$. Also, $\| g \|_{p'} < \infty$ since $g \in L^{p'}(\Omega)$.

Hence,

$$
\begin{aligned}
0 \le \lim_{n \to \infty} \| f_n g_n - fg \|_1
&\le \lim_{n \to \infty} \left( \| f_n \|_p \| g_n - g \|_{p'} + \| g \|_{p'} \| f_n - f \|_p \right) \\
&\le M \cdot 0 + \| g \|_{p'} \cdot 0 = 0.
\end{aligned}
$$

Hence, $\displaystyle\lim_{n \to \infty} \| f_n g_n - fg \|_1 = 0$, and therefore $f_n g_n \to fg$ in $L^1(\Omega)$. $\blacksquare$$BODY$
  ),
  (
    'b6e8c91b-32d3-40ed-9dcd-41fdfefe320f',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Generalized Hölder Inequality',
    $BODY$Let $f_1, f_2, \ldots, f_k$ be functions such that $f_i \in L^{p_i}(\Omega)$ for any $i = 1, 2, \ldots, k$ with $1 \le p_i \le \infty$ and $\displaystyle\sum_{i=1}^{k} \frac{1}{p_i} \le 1$. Set

$$f = \prod_{i=1}^{k} f_i \qquad \text{and} \qquad \frac{1}{p} = \sum_{i=1}^{k} \frac{1}{p_i}.$$

Prove that $f \in L^p(\Omega)$ and

$$\| f \|_{L^p(\Omega)} \le \prod_{i=1}^{k} \| f_i \|_{L^{p_i}(\Omega)}.$$$BODY$,
    'hard',
    2025,
    'Exercises',
    4,
    $BODY$Induct on $k$. Order the exponents so $p_1 \le \cdots \le p_k$. If $p_k = \infty$, bound $f_k$ by its essential supremum; if $p_k < \infty$, apply Hölder with exponents $q = p_k/(p_k - p)$ and $q' = p_k/p$, then use the induction hypothesis.$BODY$,
    $BODY$By induction on $k$: for $p_k = \infty$ use $\|f_k\|_\infty$; for $p_k < \infty$ Hölder with exponents $p_k/(p_k-p)$ and $p_k/p$ reduces to the $k-1$ case.$BODY$,
    $BODY$We prove this by induction on $k$.

**Base case $k = 1$.** Then $f = f_1$ and $p = p_1$, so $f = f_1 \in L^{p_1}(\Omega) = L^p(\Omega)$ and

$$
\begin{equation*}\| f \|_p = \| f_1 \|_{p_1}.\end{equation*}
$$

**Inductive step.** WLOG, assume $p_1 \le \cdots \le p_k$, and suppose the result holds for $k - 1$ functions, i.e. $\| g_1 \cdots g_{k-1} \|_q \le \prod_{i=1}^{k-1} \| g_i \|_{p_i}$ whenever $1/q = \sum_{i=1}^{k-1} 1/p_i$.

*Case 1: $p_k = \infty$.* Then $\sum_{i=1}^{k-1} 1/p_i = 1/p$, and $|f_k| \le \mathrm{ess\,sup}|f_k| = \| f_k \|_\infty =: M$ a.e. on $\Omega$. Hence,

$$
\begin{aligned}
\| f \|_p = \| f_1 \cdots f_{k-1} f_k \|_p &\le \| f_1 \cdots f_{k-1} M \|_p \\
&= M \cdot \| f_1 \cdots f_{k-1} \|_p \\
&\le \| f_1 \|_{p_1} \cdots \| f_{k-1} \|_{p_{k-1}} \cdot \| f_k \|_\infty.
\end{aligned}
$$

*Case 2: $p_k < \infty$.* Then $p < \infty$ (since $1/p = \sum_i 1/p_i > 1/p_k$), and we can take conjugate exponents

$$
\begin{equation*}q := \frac{p_k}{p_k - p}, \qquad q' := \frac{p_k}{p},\end{equation*}
$$

with $1/q + 1/q' = 1$. By Hölder's inequality,

$$
\begin{aligned}
\| f \|_p^p &= \int_{\Omega} |f|^p = \int_{\Omega} |(f_1 \cdots f_{k-1})^p| \cdot |f_k^p| \\
&\le \left\| (f_1 \cdots f_{k-1})^p \right\|_q \cdot \left\| f_k^p \right\|_{q'}.
\end{aligned}
$$

Raising both sides to $1/p$,

$$
\begin{aligned}
\| f \|_p &\le \left\| (f_1 \cdots f_{k-1})^p \right\|_q^{1/p} \cdot \left\| f_k^p \right\|_{q'}^{1/p} \\
&= \left( \int_{\Omega} |f_1 \cdots f_{k-1}|^{pq} \right)^{1/(pq)} \left( \int_{\Omega} |f_k|^{pq'} \right)^{1/(pq')} \\
&= \| f_1 \cdots f_{k-1} \|_{pq} \cdot \| f_k \|_{pq'}.
\end{aligned}
$$

Since $pq' = p_k$ and

$$
\begin{equation*}\frac{1}{pq} + \frac{1}{p_k} = \frac{1}{pq} + \frac{1}{pq'} = \frac{1}{p}\left( \frac{1}{q} + \frac{1}{q'} \right) = \frac{1}{p} = \sum_{i=1}^{k} \frac{1}{p_i},\end{equation*}
$$

we have $\sum_{i=1}^{k-1} 1/p_i = 1/(pq)$, so the induction hypothesis gives

$$
\begin{equation*}\| f_1 \cdots f_{k-1} \|_{pq} \le \prod_{i=1}^{k-1} \| f_i \|_{p_i}.\end{equation*}
$$

Therefore,

$$
\begin{equation*}\| f \|_p \le \prod_{i=1}^{k-1} \| f_i \|_{p_i} \cdot \| f_k \|_{p_k}.\end{equation*}
$$

Hence, $\| f \|_p \le \prod_{i=1}^k \| f_i \|_{p_i}$.

Since $f_i \in L^{p_i}(\Omega)$, we have $\| f_i \|_{p_i} < \infty$ for each $i$, so $\| f \|_p < \infty$ and $f \in L^p(\Omega)$. $\blacksquare$$BODY$
  ),
  (
    'ac5e9cca-cdd7-4ff5-aa56-ed5047e10c5b',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    '$L^1 \\cap L^\\infty \\subseteq L^p$',
    $BODY$Let $\Omega$ be a measurable subset of $\mathbb{R}$. Suppose $f \in L^1(\Omega) \cap L^{\infty}(\Omega)$. Show that $f \in L^p(\Omega)$ for all $p \in [1, \infty]$.$BODY$,
    'easy',
    2025,
    'Exercises',
    5,
    $BODY$For $p \in [1, \infty)$, use $|f| \le \|f\|_\infty$ a.e. and write $|f|^p = |f|^{p-1}|f| \le \|f\|_\infty^{p-1} |f|$.$BODY$,
    $BODY$Since $|f| \le \|f\|_\infty$ a.e., $\int |f|^p \le \|f\|_\infty^{p-1} \int |f| < \infty$, so $f \in L^p$ for all $p \in [1,\infty]$.$BODY$,
    $BODY$Let $p \in [1, \infty]$. For $p = \infty$, $f \in L^{\infty}(\Omega)$ by assumption.

Let $p \in [1, \infty)$. Since $f \in L^{\infty}(\Omega)$, we have $|f(x)| \le \| f \|_{\infty}$ a.e. on $\Omega$. Then

$$
\begin{equation*}|f|^p = |f|^{p-1} |f| \le \| f \|_{\infty}^{p-1} |f| \quad \text{a.e. on } \Omega.\end{equation*}
$$

Integrating over $\Omega$,

$$
\begin{equation*}\int_{\Omega} |f|^p \le \| f \|_{\infty}^{p-1} \int_{\Omega} |f| < \infty,\end{equation*}
$$

since $f \in L^1(\Omega)$. Hence, $f \in L^p(\Omega)$ for every $p \in [1, \infty)$.

$\therefore$ $f \in L^p(\Omega)$ for all $p \in [1, \infty]$. $\blacksquare$$BODY$
  ),
  (
    '7f264d89-070e-4116-b57f-69d3c6293c02',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Equal Dual Pairings Imply Equality a.e.',
    $BODY$Let $p \in [1, \infty)$ and $p'$ its conjugate. Let $f_1, f_2 \in L^p(\Omega)$. Show that if

$$\int f_1 g = \int f_2 g \quad \forall\, g \in L^{p'}(\Omega),$$

then $f_1 = f_2$ a.e. in $\Omega$.$BODY$,
    'hard',
    2025,
    'Exercises',
    6,
    $BODY$Let $h = f_1 - f_2 \in L^p$ and take $g = \mathrm{sgn}(h)|h|^{p-1} \in L^{p'}$. Then $\int |h|^p = \int h g = 0$, so $h = 0$ a.e. (For $p = 1$, use $g = \mathrm{sgn}(h)$.)$BODY$,
    $BODY$Choosing $g = \mathrm{sgn}(f_1 - f_2)|f_1 - f_2|^{p-1} \in L^{p'}$ forces $\int |f_1 - f_2|^p = 0$, so $f_1 = f_2$ a.e.$BODY$,
    $BODY$Let $h = f_1 - f_2 \in L^p(\Omega)$. By hypothesis, for every $g \in L^{p'}(\Omega)$,

$$
\begin{equation*}\int_{\Omega} h g = \int_{\Omega} f_1 g - \int_{\Omega} f_2 g = 0.\end{equation*}
$$

For $p \in (1, \infty)$, choose $g = \mathrm{sgn}(h) |h|^{p-1} \in L^{p'}(\Omega)$. Indeed,

$$
\begin{equation*}\int_{\Omega} |g|^{p'} = \int_{\Omega} |h|^{(p-1)p'} = \int_{\Omega} |h|^p < \infty,\end{equation*}
$$

since $(p-1)p' = p$. Then,

$$
\begin{equation*}0 = \int_{\Omega} h g = \int_{\Omega} |h|^p.\end{equation*}
$$

A nonnegative measurable function with zero integral vanishes a.e., so $h = 0$ a.e. on $\Omega$.

For $p = 1$ (so $p' = \infty$), take $g = \mathrm{sgn}(h) \in L^{\infty}(\Omega)$; the same argument gives $\int_{\Omega} |h| = 0$, hence $h = 0$ a.e.

$\therefore$ $f_1 = f_2$ a.e. in $\Omega$. $\blacksquare$$BODY$
  ),
  (
    '8aeced31-227d-48c3-9832-05f632547ce5',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'The Sequence $g_n(x) = n^{1/p} e^{-nx}$',
    $BODY$Let $\Omega = (0, 1)$ and $1 < p < \infty$. Consider the sequence of functions $\{g_n\}$ where

$$g_n(x) = n^{1/p} e^{-nx}, \quad \forall\, x \in \Omega,\ \forall\, n \in \mathbb{N}.$$

Prove the following:

**(a)** $g_n \to 0$ pointwise a.e. in $\Omega$.

**(b)** $g_n$ does not converge strongly to $0$ in $L^p(\Omega)$.

**(c)** $\{g_n\}$ is uniformly bounded in $L^p(\Omega)$, i.e. there exists $M > 0$ such that

$$\| g_n \|_{L^p(\Omega)} \le M.$$$BODY$,
    'hard',
    2025,
    'Exercises',
    7,
    $BODY$For (a), $n^{1/p}e^{-nx} = n^{1/p}/e^{nx} \to 0$ (exponential dominates polynomial; use L'Hôpital if desired). For (b), compute $\|g_n\|_p^p = \frac{1}{p}(1 - e^{-pn}) \to 1/p \neq 0$. For (c), use the same computation to get $\|g_n\|_p \le (1/p)^{1/p}$.$BODY$,
    $BODY$**(a)** $g_n \to 0$ pointwise on $(0,1)$. **(b)** $\|g_n\|_p^p = \frac{1}{p}(1 - e^{-pn}) \to \frac{1}{p} \neq 0$, so $g_n \not\to 0$ strongly. **(c)** $\|g_n\|_p \le (1/p)^{1/p}$.$BODY$,
    $BODY$**(a)** Let $x \in \Omega = (0, 1)$. Then

$$
\begin{equation*}\lim_{n \to \infty} n^{1/p} e^{-nx} = \lim_{n \to \infty} \frac{n^{1/p}}{e^{nx}} = 0,\end{equation*}
$$

since the exponential $e^{nx}$ grows faster than the power $n^{1/p}$. (For instance, L'Hôpital's rule gives $\frac{1/p \cdot n^{1/p - 1}}{x e^{nx}} \to 0$.) Hence, $g_n \to 0$ pointwise everywhere on $(0, 1)$, in particular a.e. $\blacksquare$

---

**(b)** Compute the $L^p$-norm:

$$
\begin{aligned}
\| g_n \|_p^p &= \int_0^1 \left| n^{1/p} e^{-nx} \right|^p dx \\
&= n \int_0^1 e^{-pnx} dx \\
&= n \cdot \frac{1 - e^{-pn}}{pn} = \frac{1}{p}\left( 1 - e^{-pn} \right).
\end{aligned}
$$

Hence,

$$
\begin{equation*}\lim_{n \to \infty} \| g_n \|_p = \left( \frac{1}{p} \right)^{1/p} \neq 0.\end{equation*}
$$

Since $\| g_n \|_p \not\to 0$, the sequence $\{g_n\}$ does **not** converge strongly to $0$ in $L^p(\Omega)$. $\blacksquare$

---

**(c)** From the computation in (b),

$$
\begin{equation*}\| g_n \|_p^p = \frac{1}{p}\left( 1 - e^{-pn} \right) \le \frac{1}{p},\end{equation*}
$$

so

$$
\begin{equation*}\| g_n \|_p \le \left( \frac{1}{p} \right)^{1/p} =: M.\end{equation*}
$$

$\therefore$ $\{g_n\}$ is uniformly bounded in $L^p(\Omega)$ by $M = (1/p)^{1/p}$. $\blacksquare$$BODY$
  ),
  (
    '74ea3f9e-df04-4697-970b-14678f72cd37',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Continuity and Boundedness of Linear Operators',
    $BODY$Let $X$ and $Y$ be normed linear spaces and $T : X \to Y$ be linear.

**(a)** Show that $T$ is continuous if and only if it is continuous at a single point $u_0$ in $X$.

**(b)** Show that $T$ is Lipschitz if and only if it is continuous.$BODY$,
    'hard',
    2025,
    'Exercises',
    8,
    $BODY$For (a), use linearity to translate continuity at $u_0$ to any other point. For (b), show continuity at $0$ implies $T$ is bounded on the unit ball, hence Lipschitz; the converse is immediate.$BODY$,
    $BODY$**(a)** Yes — linearity lets you shift continuity from one point to every point. **(b)** Continuous $\iff$ bounded $\iff$ Lipschitz (linear maps).$BODY$,
    $BODY$**(a)** $(\Rightarrow)$ If $T$ is continuous on $X$, then in particular it is continuous at $u_0$.

$(\Leftarrow)$ Suppose $T$ is continuous at $u_0 \in X$. Let $x_0 \in X$ and $\varepsilon > 0$. By continuity at $u_0$, there exists $\delta > 0$ such that

$$\| x - u_0 \|_X < \delta \implies \| T(x) - T(u_0) \|_Y < \varepsilon.$$

For any $x$ with $\| x - x_0 \|_X < \delta$, the point $x - x_0 + u_0$ satisfies

$$\| (x - x_0 + u_0) - u_0 \|_X = \| x - x_0 \|_X < \delta.$$

Hence, by linearity,

$$\| T(x) - T(x_0) \|_Y = \| T(x - x_0 + u_0) - T(u_0) \|_Y < \varepsilon.$$

So $T$ is continuous at $x_0$, and since $x_0$ was arbitrary, $T$ is continuous on $X$. $\blacksquare$

---

**(b)** $(\Leftarrow)$ If $T$ is Lipschitz, then there is $L \ge 0$ with $\| T(x) - T(x_0) \|_Y \le L \| x - x_0 \|_X$, so taking $\delta = \varepsilon / L$ (for $L > 0$; trivial if $L = 0$) shows $T$ is continuous.

$(\Rightarrow)$ Suppose $T$ is continuous. By part (a), $T$ is continuous at $0$, so for $\varepsilon = 1$ there exists $\delta > 0$ such that $\| x \|_X < \delta \implies \| T(x) \|_Y < 1$. By linearity, for any $x \neq 0$,

$$
\begin{equation*}\left\| T\left( \frac{\delta x}{2\| x \|_X} \right) \right\|_Y < 1 \implies \| T(x) \|_Y \le \frac{2}{\delta} \| x \|_X.\end{equation*}
$$

Thus $T$ is bounded with $\| T \| \le 2/\delta$. Then for all $x, y \in X$,

$$
\begin{equation*}\| T(x) - T(y) \|_Y = \| T(x - y) \|_Y \le \frac{2}{\delta} \| x - y \|_X,\end{equation*}
$$

so $T$ is Lipschitz with constant $2/\delta$. $\blacksquare$$BODY$
  ),
  (
    '9bc17355-6ed1-4083-a24f-ad1aa5dda645',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'The Neumann Series $(I - T)^{-1}$',
    $BODY$Let $X$ be a Banach space and $T \in \mathcal{L}(X, X)$ have $\| T \| < 1$. Define $T^0$ to be the identity map (that is, $T^0(x) = x$ for all $x \in X$).

**(a)** Use the completeness of $\mathcal{L}(X, X)$ to show that $\sum_{n=0}^{\infty} T^n$ converges in $\mathcal{L}(X, X)$.

**(b)** Show that $(I - T)^{-1} = \sum_{n=0}^{\infty} T^n$, where $I$ is the identity map.$BODY$,
    'hard',
    2025,
    'Exercises',
    9,
    $BODY$For (a), use $\|T^n\| \le \|T\|^n$ and the comparison with a geometric series — $\mathcal{L}(X,X)$ is complete, so absolute convergence gives convergence. For (b), compute the partial products $(I - T)\sum_{n=0}^{N} T^n = I - T^{N+1} \to I$.$BODY$,
    $BODY$**(a)** $\sum \|T^n\| \le \sum \|T\|^n < \infty$, so the series converges in the Banach space $\mathcal{L}(X,X)$. **(b)** $(I - T)\sum_{n=0}^{N} T^n = I - T^{N+1} \to I$, so $(I-T)^{-1} = \sum T^n$.$BODY$,
    $BODY$**(a)** Since $\| T \| < 1$ and $\| T^n \| \le \| T \|^n$ for every $n \in \mathbb{N}$, we have

$$
\begin{equation*}\sum_{n=0}^{\infty} \| T^n \| \le \sum_{n=0}^{\infty} \| T \|^n = \frac{1}{1 - \| T \|} < \infty.\end{equation*}
$$

Thus the series $\sum_{n=0}^{\infty} T^n$ converges absolutely in the normed space $\mathcal{L}(X, X)$. Since $X$ is a Banach space, $\mathcal{L}(X, X)$ is complete, so absolutely convergent series converge. Hence, $\sum_{n=0}^{\infty} T^n$ converges in $\mathcal{L}(X, X)$. $\blacksquare$

---

**(b)** Let $S_N = \sum_{n=0}^{N} T^n$. Then, using $I T^n = T^n$ and $T^n I = T^n$,

$$
\begin{aligned}
(I - T) S_N &= (I - T)(I + T + T^2 + \cdots + T^N) \\
            &= I + T + \cdots + T^N - T - T^2 - \cdots - T^{N+1} \\
            &= I - T^{N+1},
\end{aligned}
$$

and similarly $S_N (I - T) = I - T^{N+1}$. Since $\| T^{N+1} \| \le \| T \|^{N+1} \to 0$, we have $S_N \to \sum_{n=0}^{\infty} T^n =: S$ and $I - T^{N+1} \to I$. Therefore,

$$
\begin{equation*}(I - T) S = I = S (I - T).\end{equation*}
$$

Hence, $S$ is the inverse of $I - T$:

$$
\begin{equation*}\boxed{(I - T)^{-1} = \sum_{n=0}^{\infty} T^n}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '9afae312-f492-4b35-b4bd-6561806db55b',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'True or False: $L^p$ and Operator Statements',
    $BODY$Determine whether each statement is true or false. Justify your answer. Suppose the set $\Omega$ is a measurable subset of $\mathbb{R}$, $p'$ is the conjugate of the real number $p$, and $X$ and $Y$ are normed linear spaces.

**(a)** Every element of $L^{\infty}(\Omega)$ is bounded in $\Omega$, that is, for all $f \in L^{\infty}(\Omega)$, there exists $M > 0$ such that

$$|f(x)| \le M, \quad \forall\, x \in \Omega.$$

**(b)** If $f \in L^p(\Omega)$ and $g \in L^{p'}(\Omega)$, then $fg \in L^1(\Omega)$.

**(c)** Let $f \in L^p(\Omega)$, $p \in [1, \infty)$. If $f^* = \| f \|_p^{1 - p} \mathrm{sgn}(f)|f|^{p-1}$, then $\| f^* \|_{p'} = 1$.

**(d)** If $1 \le p \le q \le \infty$, then $L^q(\Omega) \subseteq L^p(\Omega)$.

**(e)** For any $p \in [1, \infty]$, $(L^p(\Omega))' = L^{p'}(\Omega)$.

**(f)** Let $T, S \in \mathcal{L}(X, Y)$. If $T$ and $S$ are continuous at $u_0 \in X$, then $T + S$ is also continuous at $u_0$.

**(g)** Let $p \in [1, \infty)$. For any $g \in L^{p'}(\Omega)$, the linear functional $T_g$ defined on $L^p(\Omega)$ by

$$T_g(f) = \int_{\Omega} f g, \quad \forall\, f \in L^p(\Omega),$$

is bounded.

**(h)** If $\{f_n\}$ is a strongly convergent sequence in $X$, then $\{f_n\}$ is weakly convergent.

**(i)** If $\{f_n\}$ is a weakly convergent sequence in $X$, then $\{f_n\}$ is strongly convergent.

**(j)** A weakly convergent sequence is bounded.$BODY$,
    'hard',
    2025,
    'Exercises',
    10,
    $BODY$For (a), $L^\infty$ bounds a.e., not everywhere — modify a bounded function on a null set. For (d), this holds for finite measure but fails on infinite measure (e.g. $\Omega = \mathbb{R}$, $f \equiv 1$). For (e), the dual of $L^\infty$ is not $L^1$. For (i), use an infinite-dimensional counterexample like the standard basis of $\ell^2$. For (j), use the Uniform Boundedness Principle.$BODY$,
    $BODY$**(a)** FALSE. **(b)** TRUE. **(c)** TRUE. **(d)** FALSE (in general). **(e)** FALSE. **(f)** TRUE. **(g)** TRUE. **(h)** TRUE. **(i)** FALSE. **(j)** TRUE.$BODY$,
    $BODY$**(a)** **FALSE.** The essential supremum is finite a.e., but $f$ may fail to be bounded pointwise on a null set. For example, on $\Omega = (0, 1)$, define $f(x) = n$ for $x = 1/n$ and $f(x) = 0$ otherwise. Then $f = 0$ a.e., so $f \in L^{\infty}(\Omega)$ with $\|f\|_\infty = 0$, but $f$ is unbounded on $\Omega$. $\blacksquare$

---

**(b)** **TRUE.** This is precisely Hölder's inequality: $fg \in L^1(\Omega)$ with $\| fg \|_1 \le \| f \|_p \| g \|_{p'}$. $\blacksquare$

---

**(c)** **TRUE.** Compute, using $(p-1)p' = p$ and $(1-p)p' = -p$:

$$
\begin{aligned}
\int_{\Omega} |f^*|^{p'} &= \int_{\Omega} \left| \| f \|_p^{1-p} \mathrm{sgn}(f)|f|^{p-1} \right|^{p'} \\
&= \| f \|_p^{(1-p)p'} \int_{\Omega} |f|^{(p-1)p'} \\
&= \| f \|_p^{-p} \int_{\Omega} |f|^p \\
&= \| f \|_p^{-p} \| f \|_p^p = 1.
\end{aligned}
$$

Hence, $\| f^* \|_{p'} = 1$. $\blacksquare$

---

**(d)** **FALSE (in general).** The inclusion $L^q \subseteq L^p$ for $p \le q$ holds on **finite** measure spaces but fails on infinite measure spaces. Take $\Omega = (0, \infty)$ with $p = 2$, $q = \infty$. The constant function $f \equiv 1 \in L^{\infty}(\Omega)$, but $\int_{\Omega} |f|^2 = \infty$, so $f \notin L^2(\Omega)$. Thus $L^{\infty}(\Omega) \nsubseteq L^2(\Omega)$. $\blacksquare$

---

**(e)** **FALSE.** The dual of $L^{\infty}(\Omega)$ is not $L^1(\Omega)$, but the space of (bounded finitely additive) measures $M(\Omega)$. The identification $(L^p)' = L^{p'}$ holds only for $1 \le p < \infty$. $\blacksquare$

---

**(f)** **TRUE.** Let $\varepsilon > 0$. Since $T$ and $S$ are continuous at $u_0 \in X$, there exist $\delta_1, \delta_2 > 0$ such that $\| x - u_0 \|_X < \delta_1 \implies \| S(x) - S(u_0) \|_Y < \varepsilon/2$ and $\| x - u_0 \|_X < \delta_2 \implies \| T(x) - T(u_0) \|_Y < \varepsilon/2$. Take $\delta = \min\{\delta_1, \delta_2\}$. Then $\| x - u_0 \|_X < \delta$ implies

$$
\begin{equation*}\| (T + S)(x) - (T + S)(u_0) \|_Y \le \| T(x) - T(u_0) \|_Y + \| S(x) - S(u_0) \|_Y < \frac{\varepsilon}{2} + \frac{\varepsilon}{2} = \varepsilon.\end{equation*}
$$

$\blacksquare$

---

**(g)** **TRUE.** By Hölder's inequality,

$$
\begin{equation*}|T_g(f)| = \left| \int_{\Omega} f g \right| \le \int_{\Omega} |fg| \le \| f \|_p \| g \|_{p'},\end{equation*}
$$

so $T_g$ is bounded with $\| T_g \| \le \| g \|_{p'}$. (Equality holds by the Riesz representation theorem.) $\blacksquare$

---

**(h)** **TRUE.** If $f_n \to f$ strongly, then for any $\varphi \in X'$,

$$
\begin{equation*}|\varphi(f_n) - \varphi(f)| \le \| \varphi \| \cdot \| f_n - f \|_X \to 0,\end{equation*}
$$

so $f_n \rightharpoonup f$ weakly. $\blacksquare$

---

**(i)** **FALSE.** In infinite-dimensional spaces, weak convergence does not imply strong convergence. For example, in $X = \ell^2$, the standard basis $\{e_n\}$ satisfies $e_n \rightharpoonup 0$ weakly, but $\| e_n \|_2 = 1 \not\to 0$, so $e_n \not\to 0$ strongly. (Note that in finite-dimensional spaces the implication does hold.) $\blacksquare$

---

**(j)** **TRUE.** Let $f_n \rightharpoonup f$ weakly. Then $\{\varphi(f_n)\}$ is bounded for each $\varphi \in X'$ (as a convergent sequence in $\mathbb{R}$). By the Uniform Boundedness Principle, $\sup_n \| f_n \|_X < \infty$, so $\{f_n\}$ is bounded. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
