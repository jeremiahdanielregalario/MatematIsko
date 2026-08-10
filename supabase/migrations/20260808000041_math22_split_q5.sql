-- ============================================================================
-- MATH 22 Sample 1st Long Exam — split Q5 (Improper Integrals) into 3 cards
--
--   Deletes the combined Q5 (cascades bookmarks/progress).
--   Inserts three standalone questions (a, b, c).
-- ============================================================================

delete from public.questions
where id = 'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d05';

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q5a — Improper integral: convergent, value 0
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d06',
    'c0000000-0000-4000-8000-000000000002',
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5c01',
    'Convergence of $\\displaystyle\\int_{\\pi}^{\\infty} \\!\\!\\left(-\\frac{2\\sin x}{x^3} + \\frac{\\cos x}{x^2}\\right) dx$',
    $BODY$Examine the convergence of the integral. If it is convergent, state its value.
$$
\int_{\pi}^{+\infty} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx.
$$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    5,
    $BODY$Use integration by parts on $-\frac{2\sin x}{x^3}$ with $u = \sin x$ and $\text{d}v = -\frac{2}{x^3}\text{d}x$, then observe that the resulting integral cancels with $\int \frac{\cos x}{x^2}\, dx$. Use the Squeeze Theorem for the remaining limit.$BODY$,
    $BODY$Convergent. The integral equals $0$.$BODY$,
    $BODY$The function is continuous on $[\pi, +\infty)$. Write:

$$
\int_{\pi}^{+\infty} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx = \lim_{t\to\infty} \int_{\pi}^{t} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx.
$$

Split it into a sum of integrals. Solving the first integral by parts with $u = \sin x$, $\text{d}v = -\frac{2}{x^3}\,\text{d}x$ (so $\text{d}u = \cos x\,\text{d}x$, $v = \frac{1}{x^2}$):

$$
\int_{\pi}^{t} -\frac{2\sin x}{x^3}\, dx = \frac{\sin x}{x^2}\Bigg|_{\pi}^{t} - \int_{\pi}^{t} \frac{\cos x}{x^2}\, dx.
$$

Substituting back:

$$
\lim_{t\to\infty} \left(\frac{\sin x}{x^2}\Bigg|_{\pi}^{t} \cancel{- \int_{\pi}^{t} \frac{\cos x}{x^2}\, dx} + \cancel{\int_{\pi}^{t} \frac{\cos x}{x^2}\, dx}\right) = \lim_{t\to\infty} \frac{\sin x}{x^2}\Bigg|_{\pi}^{t}.
$$

By the Squeeze Theorem, since $\frac{-1}{t^2} \le \frac{\sin t}{t^2} \le \frac{1}{t^2}$ and both bounds tend to $0$, we get $\lim_{t\to\infty} \frac{\sin t}{t^2} = 0$. Therefore

$$
\int_{\pi}^{+\infty} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx = 0 - \frac{\sin\pi}{\pi^2} = \boxed{0.} \quad \textbf{Convergent.} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q5b — Improper integral: divergent
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d07',
    'c0000000-0000-4000-8000-000000000002',
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5c01',
    'Convergence of $\\displaystyle\\int_{0}^{2} \\frac{x}{x^4 - 2x^2 + 1}\\, dx$',
    $BODY$Examine the convergence of the integral. If it is convergent, state its value.
$$
\int_{0}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx.
$$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    5,
    $BODY$Factor the denominator as $(x^2 - 1)^2 = (x - 1)^2(x + 1)^2$. The integrand is discontinuous at $x = 1$; split the integral at $x = 1$ and use $u$-substitution with $u = x^2 - 1$ to evaluate the first piece.$BODY$,
    $BODY$Divergent.$BODY$,
    $BODY$By factoring the denominator, the function is discontinuous at $x = 1$ on $(0, 2)$:

$$
\int_{0}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx = \int_{0}^{2} \frac{x}{(x-1)^2(x+1)^2}\, dx.
$$

We write the integral as such:

$$
\int_{0}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx = \lim_{t\to 1^-} \int_{0}^{t} \frac{x}{x^4 - 2x^2 + 1}\, dx + \lim_{t\to 1^+} \int_{t}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx.
$$

Using $u$-substitution with $u = x^2 - 1$, $\text{d}u = 2x\,\text{d}x$:

$$
\lim_{t\to 1^-} \int_{0}^{t} \frac{x}{x^4 - 2x^2 + 1}\, dx = \lim_{t\to 1^-} \frac{1}{2}\int_{-1}^{t^2 - 1} \frac{du}{u^2} = \lim_{t\to 1^-} \frac{1}{2}\left(-\frac{1}{u}\Bigg|_{-1}^{t^2 - 1}\right)
$$

$$
= \lim_{t\to 1^-} \frac{1}{2}\left(-\frac{1}{t^2 - 1} - 1\right) = +\infty.
$$

Because the first integral is already divergent, the whole improper integral is $\textbf{divergent.}$ $\blacksquare$ $BODY$
  ),
  (
    -- Q5c — Improper integral: convergent, value 2√2
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d08',
    'c0000000-0000-4000-8000-000000000002',
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5c01',
    'Convergence of $\\displaystyle\\int_{0}^{2} \\frac{(2x - 3)e^x}{\\sqrt{2 - x}}\\, dx$',
    $BODY$Examine the convergence of the integral. If it is convergent, state its value.
$$
\int_{0}^{2} \frac{(2x - 3)e^x}{\sqrt{2 - x}}\, dx.
$$BODY$,
    'hard',
    2023,
    'Sample 1st Long Exam',
    5,
    $BODY$The integrand is discontinuous at $x = 2$. Substitute $u = 2 - x$, then split into two integrals and use integration by parts on the first piece. The two integrals will cancel, leaving a simple limit.$BODY$,
    $BODY$Convergent. The integral equals $2\sqrt{2}$.$BODY$,
    $BODY$Note that the function is discontinuous at $x = 2$. Using the substitution $u = 2 - x$, $\text{d}u = -\text{d}x$:

$$
\int_{0}^{2} \frac{(2x - 3)e^x}{\sqrt{2 - x}}\, dx = \lim_{t\to 2^-} \int_{0}^{t} \frac{(2x - 3)e^x}{\sqrt{2 - x}}\, dx = \lim_{t\to 2^-} e^2 \int_{2}^{2-t} \frac{(2u - 1)e^{-u}}{\sqrt{u}}\, du.
$$

$$
= \lim_{t\to 2^-} e^2\left(\int_{2}^{2-t} \frac{-e^{-u}}{\sqrt{u}}\, du + \int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du\right).
$$

We solve the first integral using integration by parts with $h = -e^{-u}$, $\text{d}k = \frac{1}{\sqrt{u}}\, du$ (so $\text{d}h = e^{-u}\, du$, $k = 2\sqrt{u}$):

$$
\int_{2}^{2-t} \frac{-e^{-u}}{\sqrt{u}}\, du = -2\sqrt{u}\, e^{-u}\Bigg|_{2}^{2-t} - \int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du.
$$

Substituting back, the two integrals cancel:

$$
\lim_{t\to 2^-} e^2\left(-2\sqrt{u}\, e^{-u}\Bigg|_{2}^{2-t} \cancel{- \int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du} + \cancel{\int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du}\right)
$$

$$
= \lim_{t\to 2^-} e^2\left(-2\sqrt{2 - t}\, e^{t - 2} + 2\sqrt{2}\, e^{-2}\right) = e^2(0 + 2\sqrt{2}\, e^{-2}) = \boxed{2\sqrt{2}.} \quad \textbf{Convergent.} \;\blacksquare
$$ $BODY$
  )
on conflict (id) do nothing;
