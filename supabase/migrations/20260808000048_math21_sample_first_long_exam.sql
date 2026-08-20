-- ============================================================================
-- Math 21 Elementary Analysis I — Sample 1st Long Exam, A.Y. 2023-2024
-- 4 problems (limit calculations, piecewise continuity, IVT, graphical limits).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Six limit calculations
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c01',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Six Limit Calculations',
    $BODY$Calculate the following limits.

**(a)** $\displaystyle\lim_{x \to 4}\frac{x^2-16}{4-x}$

**(b)** $\displaystyle\lim_{x \to -1^-}\frac{-x}{3x^2+10x+7}+\frac{1}{(x+1)^2}$

**(c)** $\displaystyle\lim_{x \to -\infty}\sqrt{4x^2+3x}+2x$

**(d)** $\displaystyle\lim_{x \to 0^+}\cos^{-1}\left(\frac{1}{\ln(x)}\right)$

**(e)** $\displaystyle\lim_{x \to 0}\frac{x\cos^2(5x)}{\sin(-3x)}+\frac{1-\cos(x)}{x}$

**(f)** $\displaystyle\lim_{x \to +\infty} \frac{\sin(2x-3)}{xe^x}$$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    1,
    $BODY$For (a), factor and cancel the common factor. For (b), combine the fractions and analyze the sign near $x = -1$. For (c), rationalize by multiplying by the conjugate. For (d), use the chain rule for limits and the behavior of $\ln(x)$ as $x \to 0^+$. For (e), use $\lim_{x \to 0}\frac{\sin x}{x} = 1$ and $\lim_{x \to 0}\frac{1 - \cos x}{x} = 0$. For (f), use the Squeeze Theorem.$BODY$,
    $BODY$**(a)** $-8$. **(b)** $+\infty$. **(c)** $-\frac{3}{4}$. **(d)** $\frac{\pi}{2}$. **(e)** $-\frac{1}{3}$. **(f)** $0$.$BODY$,
    $BODY$**(a)** Factor and cancel:

$$\lim_{x \to 4}\frac{x^2-16}{4-x} = \lim_{x \to 4}\frac{(x-4)(x+4)}{-(x-4)} = \lim_{x \to 4}-(x+4) = -8. \;\blacksquare$$

---

**(b)** Factor the denominator $3x^2 + 10x + 7 = (3x + 7)(x + 1)$:

$$\lim_{x \to -1^-}\frac{-x}{(3x+7)(x+1)}+\frac{1}{(x+1)^2} = \lim_{x \to -1^-}\frac{-x(x+1) + (3x+7)}{(3x+7)(x+1)^2} = \lim_{x \to -1^-}\frac{-x^2+2x+7}{(3x+7)(x+1)^2}.$$

As $x \to -1^-$, the numerator approaches $-1 - 2 + 7 = 4 > 0$, and the denominator approaches $(4)(0^+)^2 = 0^+$. Therefore the limit is $+\infty$. $\blacksquare$

---

**(c)** Rationalize by multiplying by the conjugate:

$$\lim_{x \to -\infty}\sqrt{4x^2+3x}+2x = \lim_{x \to -\infty}\frac{(\sqrt{4x^2+3x}+2x)(\sqrt{4x^2+3x}-2x)}{\sqrt{4x^2+3x}-2x} = \lim_{x \to -\infty}\frac{4x^2+3x-4x^2}{\sqrt{4x^2+3x}-2x}.$$

$$= \lim_{x \to -\infty}\frac{3x}{\sqrt{4x^2+3x}-2x} = \lim_{x \to -\infty}\frac{3x}{|x|\sqrt{4+\frac{3}{x}}-2x}.$$

Since $x \to -\infty$, $|x| = -x$, so

$$= \lim_{x \to -\infty}\frac{3x}{-x\sqrt{4+\frac{3}{x}}-2x} = \lim_{x \to -\infty}\frac{3x}{x\left(-\sqrt{4+\frac{3}{x}}-2\right)} = \frac{3}{-\sqrt{4}-2} = -\frac{3}{4}. \;\blacksquare$$

---

**(d)** Note that $\lim_{x \to 0^+}\ln(x) = -\infty$, so $\lim_{x \to 0^+}\frac{1}{\ln(x)} = 0^-$. Therefore

$$\lim_{x \to 0^+}\cos^{-1}\left(\frac{1}{\ln(x)}\right) = \cos^{-1}(0) = \frac{\pi}{2}. \;\blacksquare$$

---

**(e)** Split the limit:

$$\lim_{x \to 0}\frac{x\cos^2(5x)}{\sin(-3x)}+\lim_{x \to 0}\frac{1-\cos(x)}{x}.$$

The second limit is $0$ (a standard result). For the first, multiply by $\frac{-3}{-3}$:

$$\lim_{x \to 0}\frac{-3x}{\sin(-3x)}\cdot\frac{\cos^2(5x)}{-3} = 1 \cdot \frac{\cos^2(0)}{-3} = -\frac{1}{3}. \;\blacksquare$$

---

**(f)** Since $-1 \leq \sin(2x - 3) \leq 1$, we have

$$-\frac{1}{xe^x} \leq \frac{\sin(2x-3)}{xe^x} \leq \frac{1}{xe^x}.$$

Since $\lim_{x \to +\infty}\frac{1}{xe^x} = 0$, the Squeeze Theorem gives

$$\lim_{x \to +\infty}\frac{\sin(2x-3)}{xe^x} = 0. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — Piecewise continuity
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c02',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Continuity of a Piecewise Function at $x = 1$ and $x = 3$',
    $BODY$Define the function

$$f(x)=\begin{cases} \llbracket 2x-1 \rrbracket &\text{if } x<1\\[0.2cm] \frac{x^2-7x+12}{|x-3|}&\text{if } 1\leq x<3\\[0.3cm] \cosh(\sinh(x-3)) &\text{if } x\geq 3. \end{cases}$$

Is $f(x)$ continuous at $x=1$ and $x=3$? If it is discontinuous at either point, identify the type of discontinuity.$BODY$,
    'hard',
    2023,
    'Sample 1st Long Exam',
    2,
    $BODY$Compute the one-sided limits at $x = 1$ and $x = 3$. At $x = 1$, evaluate $\llbracket 2(1^-) - 1 \rrbracket$ and the rational expression from the right. At $x = 3$, note that $|x-3| = -(x-3)$ for $x < 3$ and use $\cosh(\sinh 0) = \cosh 0 = 1$.$BODY$,
    $BODY$f(x)$ has a jump discontinuity at $x = 1$ and is continuous at $x = 3$.$BODY$,
    $BODY$We examine the one-sided limits at each point.

**At $x = 1$:**

$$\lim_{x \to 1^-}f(x) = \lim_{x \to 1^-}\llbracket 2x - 1 \rrbracket = \llbracket 2(1^-) - 1 \rrbracket = \llbracket 1^- \rrbracket = 0.$$

$$\lim_{x \to 1^+}f(x) = \lim_{x \to 1^+}\frac{x^2 - 7x + 12}{|x - 3|} = \frac{1 - 7 + 12}{|1 - 3|} = \frac{6}{2} = 3.$$

Since $\lim_{x \to 1^-}f(x) = 0 \neq 3 = \lim_{x \to 1^+}f(x)$, both one-sided limits exist but are not equal. Therefore $f(x)$ has a **jump discontinuity** at $x = 1$.

---

**At $x = 3$:**

$$\lim_{x \to 3^-}f(x) = \lim_{x \to 3^-}\frac{x^2 - 7x + 12}{|x - 3|} = \lim_{x \to 3^-}\frac{(x - 3)(x - 4)}{-(x - 3)} = \lim_{x \to 3^-}-(x - 4) = 1.$$

(Here $|x - 3| = -(x - 3)$ since $x - 3 < 0$ for $x < 3$.)

$$\lim_{x \to 3^+}f(x) = \lim_{x \to 3^+}\cosh(\sinh(x - 3)) = \cosh(\sinh 0) = \cosh 0 = 1.$$

Since $f(3) = \cosh(\sinh 0) = 1$ and $\lim_{x \to 3^-}f(x) = \lim_{x \to 3^+}f(x) = 1$, the function $f(x)$ is **continuous** at $x = 3$. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — IVT application
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c03',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'IVT: Showing $e^x = 3x$ Has a Solution in $[0,1]$',
    $BODY$Use the Intermediate Value Theorem to show that the equation $e^x = 3x$ has a solution in the interval $[0, 1]$.

*(Hint: Define $h(x) = e^x - 3x$.)*$BODY$,
    'easy',
    2023,
    'Sample 1st Long Exam',
    3,
    $BODY$Define $h(x) = e^x - 3x$. Show $h$ is continuous on $[0, 1]$ and evaluate $h(0)$ and $h(1)$. Apply the IVT since $0$ lies between $h(0)$ and $h(1)$.$BODY$,
    $BODY$By the IVT, there exists $c \in (0, 1)$ such that $h(c) = e^c - 3c = 0$, so $c$ is a solution to $e^x = 3x$.$BODY$,
    $BODY$Define $h(x) = e^x - 3x$. Since $e^x$ and $3x$ are both continuous on $\mathbb{R}$, $h$ is continuous on $[0, 1]$. Evaluate:

$$h(0) = e^0 - 3(0) = 1 > 0, \qquad h(1) = e^1 - 3(1) = e - 3 < 0.$$

Since $h(0) > 0 > h(1)$, the value $0$ lies between $h(0)$ and $h(1)$. By the Intermediate Value Theorem, there exists some $c \in (0, 1)$ such that $h(c) = 0$. Hence $e^c = 3c$, and $c$ is a solution to the equation $e^x = 3x$ in $[0, 1]$. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — Graphical limits interpretation
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c04',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Interpreting Limits and Discontinuities From a Graph',
    $BODY$Assume that $y = f(x)$ is graphed according to the figure below.

**(a)** Find $\displaystyle\lim_{x \to 1^{+}}f(x)$.

**(b)** Find $\displaystyle\lim_{x \to -\infty}f(x)$.

**(c)** True or False: $f(x)$ has a removable discontinuity at $x = 4$.

**(d)** True or False: $f(x)$ has the horizontal asymptote $x = 2$.$BODY$,
    'easy',
    2023,
    'Sample 1st Long Exam',
    4,
    $BODY$For (a) and (b), read the $y$-value the graph approaches from the right of $x = 1$ and as $x$ goes to $-\infty$. For (c), check whether the limit at $x = 4$ exists and differs from $f(4)$. For (d), recall that a horizontal asymptote is of the form $y = k$, not $x = k$.$BODY$,
    $BODY$**(a)** $1$. **(b)** $+\infty$. **(c)** True. **(d)** False (the horizontal asymptote is $y = 2$).$BODY$,
    $BODY$**(a)** From the figure, the graph approaches the $y$-value $1$ as $x$ approaches $1$ from the right. Hence $\lim_{x \to 1^{+}}f(x) = 1$. $\blacksquare$

**(b)** From the figure, the graph increases without bound as $x$ decreases without bound. Hence $\lim_{x \to -\infty}f(x) = +\infty$. $\blacksquare$

**(c)** **True.** From the figure, $\lim_{x \to 4}f(x) = 4$ exists but is not equal to $f(4) = 2$. A removable discontinuity occurs precisely when the limit exists but does not equal the function value. $\blacksquare$

**(d)** **False.** The line $x = 2$ is a vertical line, not a horizontal one. A horizontal asymptote has the form $y = k$. Since $\lim_{x \to +\infty}f(x) = 2$, the correct statement is that $f(x)$ has the horizontal asymptote $y = 2$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
