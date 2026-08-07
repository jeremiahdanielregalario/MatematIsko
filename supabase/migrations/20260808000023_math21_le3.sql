-- ============================================================================
-- Math 21 Long Exam 3 — linear approximation (A.Y. 2025-2026)
-- 1 problem with 2 parts, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'e922ee84-9d44-41f3-9cd9-41e507f5aa80',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Linear Approximation of $f(x) = (x+1)\\sin^{-1}(x/2)$',
    $BODY$Let $f(x) = (x + 1)\sin^{-1}(x/2)$.

**(a)** Find the linear approximation of $f(x)$ at $x_0 = 0$.

**(b)** Use the previous item to approximate $(1.1)\sin^{-1}(0.05)$.$BODY$,
    'easy',
    2025,
    'Long Exam 3',
    1,
    $BODY$The local linear approximation near $x_0 = c$ is $L(x) = f(c) + f'(c)(x - c)$. For (b), observe that $(1.1)\sin^{-1}(0.05) = f(0.1)$ since $1 + x = 1.1 \implies x = 0.1$.$BODY$,
    $BODY$**(a)** $L(x) = \dfrac{x}{2}$. **(b)** $f(0.1) \approx 0.05$.$BODY$,
    $BODY$**(a)** The local linear approximation of $f(x)$ near $x_0 = c$ is

$$
\begin{equation*}f(x) \approx L(x) = f(c) + f'(c)(x - c).\end{equation*}
$$

For our problem, we set $x_0 = 0$:

$$
\begin{equation*}f(x) \approx L(x) = f(0) + f'(0)x.\end{equation*}
$$

We find $f'(x)$:

$$
\begin{aligned}
f'(x) &= [(x + 1)\sin^{-1}(x/2)]' \\
      &= \sin^{-1}(x/2) + (x + 1) \cdot \frac{1}{\sqrt{1 - (x/2)^2}} \cdot \frac{1}{2}.
\end{aligned}
$$

Then,

$$
\begin{equation*}f'(0) = \sin^{-1}(0) + \frac{1}{2} \cdot \frac{1}{\sqrt{1}} = 0 + \frac{1}{2} = \frac{1}{2},\end{equation*}
$$

and

$$
\begin{equation*}f(0) = (0 + 1)\sin^{-1}(0) = 0.\end{equation*}
$$

Therefore,

$$
\begin{equation*}\boxed{L(x) = \frac{1}{2} x}.\end{equation*}
$$

---

**(b)** Note that $1 + x = 1.1 \implies x = 0.1$. Then,

$$
\begin{equation*}f(0.1) \approx L(0.1) = \frac{1}{2}(0.1) = \boxed{0.05}.\end{equation*}
$$

$\blacksquare$$BODY$
  )
on conflict (id) do nothing;
