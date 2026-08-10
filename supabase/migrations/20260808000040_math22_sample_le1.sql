-- ============================================================================
-- MATH 22 Elementary Analysis II — Sample 1st Long Exam, A.Y. 2023-2024
-- 5 problems (integration by parts, trig substitution, rational functions,
-- partial fractions, improper integrals).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.courses (id, code, name, description)
values (
  'c0000000-0000-4000-8000-000000000002',
  'MATH 22',
  'Elementary Analysis II',
  'Definite integrals, integration techniques, sequences and series.'
)
on conflict (code) do nothing;

insert into public.topics (id, course_id, name, description)
values
  (
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5c01',
    'c0000000-0000-4000-8000-000000000002',
    'Improper Integrals',
    'Convergence and evaluation of improper integrals via limits, comparison tests, and integration techniques.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Integration by parts
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d01',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
    'Integration by Parts of $(2x + 1)\\ln^2(\\pi x)$',
    $BODY$Consider the function $f(x) = (2x + 1) \ln^2(\pi x)$. Determine $\displaystyle\int f(x)\, dx$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    1,
    $BODY$Use integration by parts twice. Apply the LIATE rule to choose $u$ each time. For the first pass, let $u = \ln^2(\pi x)$ and $\text{d}v = (2x+1)\,\text{d}x$; then let $u = \ln(\pi x)$ for the second pass.$BODY$,
    $BODY$$\displaystyle \int (2x+1)\ln^2(\pi x)\, dx = (\ln^2(\pi x))(x^2 + x) - (\ln(\pi x))(x^2 + 2x) + \frac{1}{2}x^2 + 2x + C, \quad C \in \mathbb{R}.$BODY$,
    $BODY$Since $f$ is a product of "simpler" functions, we use integration by parts. Recall that for setting the variable $u$, the mnemonic "LIATE" can be helpful, and in this case, we have L (logarithms), so we apply this.

First, let $u = \ln^2(\pi x)$ and $\text{d}v = (2x + 1)\,\text{d}x$. It follows that
$$
\text{d}u = 2\pi \frac{\ln(\pi x)}{\pi x}\, \text{d}x = \frac{2\ln(\pi x)}{x}\, \text{d}x
$$
and $v = x^2 + x$. By IBP, we have

$$
\int u\, \text{d}v = uv - \int v\, \text{d}u = (\ln^2(\pi x))(x^2 + x) - \int (x^2 + x)\left(\frac{2\ln(\pi x)}{x}\right) \text{d}x
$$

$$
= (\ln^2(\pi x))(x^2 + x) - \int 2(x + 1)\ln(\pi x)\, \text{d}x
$$

Since we have another integral of product of functions, we perform integration by parts for the second time. Applying LIATE again, let $\bar{u} = \ln(\pi x)$ and $\text{d}\bar{v} = 2(x+1)\,\text{d}x$. Then $\text{d}\bar{u} = \frac{1}{x}\,\text{d}x$ and $\bar{v} = x^2 + 2x$.

$$
\int \bar{u}\, \text{d}\bar{v} = \bar{u}\,\bar{v} - \int \bar{v}\, \text{d}\bar{u} = (\ln(\pi x))(x^2 + 2x) - \int (x^2 + 2x)\left(\frac{1}{x}\right) \text{d}x
$$

$$
= (\ln(\pi x))(x^2 + 2x) - \int (x + 2)\, \text{d}x = (\ln(\pi x))(x^2 + 2x) - \frac{1}{2}x^2 - 2x + C_1, \quad C_1 \in \mathbb{R}
$$

Combining the results that we have, we get:

$$
\int f(x)\, \text{d}x = (\ln^2(\pi x))(x^2 + x) - \left[(\ln(\pi x))(x^2 + 2x) - \frac{1}{2}x^2 - 2x + C_1\right]
$$

$$
= \boxed{(\ln^2(\pi x))(x^2 + x) - (\ln(\pi x))(x^2 + 2x) + \frac{1}{2}x^2 + 2x + C, \quad C \in \mathbb{R}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — Trig substitution
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d02',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
    'Evaluate $\\displaystyle\\int \\frac{\\sqrt{2}\\tan^7(ex)}{\\sqrt[3]{\\sec^7(ex)}}\\, dx$',
    $BODY$Evaluate the integral
$$
\int \frac{\sqrt{2}\tan^7(ex)}{\sqrt[3]{\sec^7(ex)}}\, dx.
$$BODY$,
    'hard',
    2023,
    'Sample 1st Long Exam',
    2,
    $BODY$Multiply numerator and denominator by $\sec(ex)$ to prepare for the substitution $u = \sec(ex)$. Then use the identity $1 + \tan^2 x = \sec^2 x$ to rewrite $\tan^6(ex)$ in terms of $\sec(ex)$. Expand and integrate term by term.$BODY$,
    $BODY$$\displaystyle \frac{3\sqrt{2}}{e}\left(\frac{1}{11}\sec^{11/3}(ex) - \frac{3}{5}\sec^{5/3}(ex) - 3\sec^{-1/3}(ex) + \frac{1}{7}\sec^{-7/3}(ex)\right) + C.$BODY$,
    $BODY$For this integral, we need to use techniques for trigonometric integrals. Our first intuition is to substitute the "inner" function in the denominator with a variable $u = \sec(ex)$. Since $\text{d}u = e\sec(ex)\tan(ex)\,\text{d}x$, we need to manipulate the expression to have a factor of $\sec(ex)$ in the numerator. Also, recall the identity $1 + \tan^2 x = \sec^2 x$.

$$
\int \frac{\sqrt{2}\tan^7(ex)}{\sqrt[3]{\sec^7(ex)}}\, \text{d}x = \int \frac{\sqrt{2}\tan^7(ex)}{\sqrt[3]{\sec^7(ex)}} \cdot \frac{\sec(ex)}{\sec(ex)}\, \text{d}x
$$

$$
= \sqrt{2}\int \frac{\tan^7(ex)\sec(ex)}{(\sec(ex))^{10/3}}\, \text{d}x = \sqrt{2}\int \frac{\tan^6(ex)[\sec(ex)\tan(ex)]}{(\sec(ex))^{10/3}}\, \text{d}x
$$

$$
= \sqrt{2}\int \frac{(\tan^2(ex))^3[\sec(ex)\tan(ex)]}{(\sec(ex))^{10/3}}\, \text{d}x
$$

$$
= \frac{\sqrt{2}}{e}\int \frac{(\sec^2(ex) - 1)^3[e\sec(ex)\tan(ex)]}{(\sec(ex))^{10/3}}\, \text{d}x
$$

$$
= \frac{\sqrt{2}}{e}\int \frac{(u^2 - 1)^3}{u^{10/3}}\, \text{d}u = \frac{\sqrt{2}}{e}\int \frac{u^6 - 3u^4 + 3u^2 - 1}{u^{10/3}}\, \text{d}u
$$

$$
= \frac{\sqrt{2}}{e}\int \left(u^{8/3} - 3u^{2/3} + 3u^{-4/3} - u^{-10/3}\right)\, \text{d}u
$$

$$
= \frac{\sqrt{2}}{e}\left(\frac{3}{11}u^{11/3} - \frac{9}{5}u^{5/3} - 9u^{-1/3} + \frac{3}{7}u^{-7/3}\right)
$$

$$
= \boxed{\frac{3\sqrt{2}}{e}\left(\frac{1}{11}\sec^{11/3}(ex) - \frac{3}{5}\sec^{5/3}(ex) - 3\sec^{-1/3}(ex) + \frac{1}{7}\sec^{-7/3}(ex)\right) + C.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Decomposition + trig substitution
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d03',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
    'Decomposition and Trigonometric Substitution',
    $BODY$Integrate
$$
\int \frac{x^3\sqrt{9 - 16x^2} + \sqrt{1 + 2x^2}}{x^2\sqrt{-32x^4 + 2x^2 + 9}}\, dx.
$$BODY$,
    'hard',
    2023,
    'Sample 1st Long Exam',
    3,
    $BODY$Factor the denominator as $x^2\sqrt{9 - 16x^2}\,\sqrt{1 + 2x^2}$, then split the integral into two parts. Use $x = \frac{\tan\theta}{\sqrt{2}}$ for the first integral and $x = \frac{3\sin\theta}{4}$ for the second.$BODY$,
    $BODY$$\displaystyle \frac{\sqrt{1 + 2x^2}}{2} - \frac{\sqrt{1 - \frac{16}{9}x^2}}{3x} + C, \quad C \in \mathbb{R}.$BODY$,
    $BODY$Note that we can decompose the fraction into a sum of two simpler fractions:

$$
\int \frac{x^3\sqrt{9 - 16x^2} + \sqrt{1 + 2x^2}}{x^2\sqrt{-32x^4 + 2x^2 + 9}}\, dx = \int \frac{x^3\sqrt{9 - 16x^2} + \sqrt{1 + 2x^2}}{(x^2\sqrt{9 - 16x^2})(\sqrt{1 + 2x^2})}\, dx
$$

$$
= \int \left(\frac{x}{\sqrt{1 + 2x^2}} + \frac{1}{x^2\sqrt{9 - 16x^2}}\right) dx
$$

**First integral.** The denominator is similar to the form $\sqrt{a^2 + b^2x^2}$. We proceed with the trigonometric substitution

$$
x = \frac{\tan\theta}{\sqrt{2}}, \qquad dx = \frac{\sec^2\theta}{\sqrt{2}}\, d\theta
$$

to obtain

$$
\int \frac{x}{\sqrt{1 + 2x^2}}\, dx = \int \frac{\frac{\tan\theta}{\sqrt{2}}}{\sqrt{1 + \tan^2\theta}} \cdot \frac{\sec^2\theta}{\sqrt{2}}\, d\theta = \int \frac{\tan\theta}{\sqrt{2}\sec\theta} \cdot \frac{\sec^2\theta}{\sqrt{2}}\, d\theta
$$

$$
= \int \frac{\sec\theta\tan\theta}{2}\, d\theta = \frac{\sec\theta}{2} + C = \frac{\sqrt{1 + 2x^2}}{2} + C
$$

**Second integral.** The denominator is similar to the form $\sqrt{a^2 - b^2x^2}$. We proceed with the trigonometric substitution

$$
x = \frac{3\sin\theta}{4}, \qquad dx = \frac{3\cos\theta}{4}\, d\theta
$$

to obtain

$$
\int \frac{1}{x^2\sqrt{9 - 16x^2}}\, dx = \int \frac{16}{9\sin^2\theta} \cdot \frac{1}{3\cos\theta} \cdot \frac{3\cos\theta}{4}\, d\theta = \frac{4}{9}\int \csc^2\theta\, d\theta = -\frac{4}{9}\cot\theta + C
$$

Notice that $\cot\theta = \dfrac{\cos\theta}{\sin\theta} = \dfrac{\sqrt{1 - \sin^2\theta}}{\sin\theta} = \dfrac{3\sqrt{1 - \frac{16}{9}x^2}}{4x}$. Thus,

$$
\int \frac{1}{x^2\sqrt{9 - 16x^2}}\, dx = -\frac{\sqrt{1 - \frac{16}{9}x^2}}{3x} + C
$$

Combining the results we get

$$
\boxed{\int \frac{x^3\sqrt{9 - 16x^2} + \sqrt{1 + 2x^2}}{x^2\sqrt{-32x^4 + 2x^2 + 9}}\, dx = \frac{\sqrt{1 + 2x^2}}{2} - \frac{\sqrt{1 - \frac{16}{9}x^2}}{3x} + C, \quad C \in \mathbb{R}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Partial fraction decomposition
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d04',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
    'Partial Fraction Decomposition of a Rational Function',
    $BODY$Given the polynomial functions $f(x) = 3x^3 + 11x^2 - 2x - 4$ and $g(x) = (x + 1)^2(x^2 - x + 1)$, consider the rational function formed as $h(x) = \dfrac{f(x)}{g(x)}$. Determine the integral $\displaystyle\int h(x)\, \text{d}x$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    4,
    $BODY$Decompose $h(x)$ using partial fractions with repeated linear and irreducible quadratic factors, then integrate term by term.$BODY$,
    $BODY$$\displaystyle \int h(x)\, dx = -3\ln|x + 1| - \frac{2}{x + 1} + 3\ln|x^2 - x + 1| + C, \quad C \in \mathbb{R}.$BODY$,
    $BODY$Since we have a rational function, we wish to decompose it into partial fractions. By the Partial Fraction Decomposition method, for some $A, B, C, D \in \mathbb{R}$, we can express $h(x)$ as

$$
h(x) = \frac{3x^3 + 11x^2 - 2x - 4}{(x + 1)^2(x^2 - x + 1)} = \frac{A}{x + 1} + \frac{B}{(x+1)^2} + \frac{Cx + D}{x^2 - x + 1}
$$

By multiplying the LCD $(x + 1)^2(x^2 - x + 1)$ on both sides of the equation, then comparing coefficients, we have:

$$
3x^3 + 11x^2 - 2x - 4 = A(x+1)(x^2 - x + 1) + B(x^2 - x + 1) + (Cx + D)(x+1)^2
$$

$$
= A(x^3 + 1) + B(x^2 - x + 1) + (Cx + D)(x^2 + 2x + 1)
$$

$$
= (A + C)x^3 + (B + 2C + D)x^2 + (C - B + 2D)x + (B + A + D)
$$

By comparing coefficients, we yield the following system of equations:

$$
\begin{cases}
A + C = 3 \\
B + 2C + D = 11 \\
C - B + 2D = -2 \\
B + A + D = -4
\end{cases}
$$

Solving this system (using substitution and elimination), we get $(A, B, C, D) = (-3, 2, 6, -3)$.

Hence, solving for the integral we get

$$
h(x) = \frac{-3}{x+1} + \frac{2}{(x+1)^2} + \frac{6x - 3}{x^2 - x + 1}
$$

$$
\int h(x)\, \text{d}x = -3\ln|x + 1| + 2\int \frac{1}{(x+1)^2}\, \text{d}x + 3\int \frac{2x - 1}{x^2 - x + 1}\, \text{d}x
$$

$$
= \boxed{-3\ln|x + 1| - \frac{2}{x + 1} + 3\ln|x^2 - x + 1| + C, \quad C \in \mathbb{R}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — Improper integrals (3 parts)
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5d05',
    'c0000000-0000-4000-8000-000000000002',
    'a2b3c4d5-6e7f-4a8b-9c0d-1e2f3a4b5c01',
    'Convergence of Improper Integrals',
    $BODY$Examine the convergence of the following integrals. If it is convergent, state its value.

**(a)** $\displaystyle\int_{\pi}^{+\infty} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx$

**(b)** $\displaystyle\int_{0}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx$

**(c)** $\displaystyle\int_{0}^{2} \frac{(2x - 3)e^x}{\sqrt{2 - x}}\, dx$$BODY$,
    'hard',
    2023,
    'Sample 1st Long Exam',
    5,
    $BODY$For (a), use integration by parts on the first term and observe cancellation. For (b), the integrand is discontinuous at $x = 1$; split and use $u$-substitution. For (c), substitute $u = 2 - x$ and use integration by parts.$BODY$,
    $BODY$**(a)** Convergent, value $= 0$. **(b)** Divergent. **(c)** Convergent, value $= 2\sqrt{2}$.$BODY$,
    $BODY$**(a)** Note that the function is continuous on $[\pi, +\infty)$. Write:

$$
\int_{\pi}^{+\infty} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx = \lim_{t\to\infty} \int_{\pi}^{t} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx
$$

We split it into a sum of integrals. Solving the first integral by parts with $u = \sin x$, $\text{d}v = -\frac{2}{x^3}\,\text{d}x$ (so $\text{d}u = \cos x\,\text{d}x$, $v = \frac{1}{x^2}$):

$$
\int_{\pi}^{t} -\frac{2\sin x}{x^3}\, dx = \frac{\sin x}{x^2}\Bigg|_{\pi}^{t} - \int_{\pi}^{t} \frac{\cos x}{x^2}\, dx
$$

Substituting back:

$$
\lim_{t\to\infty} \left(\frac{\sin x}{x^2}\Bigg|_{\pi}^{t} - \int_{\pi}^{t} \frac{\cos x}{x^2}\, dx + \int_{\pi}^{t} \frac{\cos x}{x^2}\, dx\right) = \lim_{t\to\infty} \frac{\sin x}{x^2}\Bigg|_{\pi}^{t}
$$

By the Squeeze Theorem, since $\frac{-1}{t^2} \le \frac{\sin t}{t^2} \le \frac{1}{t^2}$ and both bounds tend to $0$:

$$
\lim_{t\to\infty} \frac{\sin t}{t^2} = 0
$$

Therefore

$$
\int_{\pi}^{+\infty} \left(-\frac{2\sin x}{x^3} + \frac{\cos x}{x^2}\right) dx = 0 - \frac{\sin\pi}{\pi^2} = \boxed{0.} \quad \textbf{Convergent.} \;\blacksquare
$$

---

**(b)** By factoring the denominator, the function is discontinuous at $x = 1$ on $(0, 2)$:

$$
\int_{0}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx = \int_{0}^{2} \frac{x}{(x-1)^2(x+1)^2}\, dx
$$

We write the integral as such:

$$
\int_{0}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx = \lim_{t\to 1^-} \int_{0}^{t} \frac{x}{x^4 - 2x^2 + 1}\, dx + \lim_{t\to 1^+} \int_{t}^{2} \frac{x}{x^4 - 2x^2 + 1}\, dx
$$

Using $u$-substitution with $u = x^2 - 1$, $\text{d}u = 2x\,\text{d}x$:

$$
\lim_{t\to 1^-} \int_{0}^{t} \frac{x}{x^4 - 2x^2 + 1}\, dx = \lim_{t\to 1^-} \frac{1}{2}\int_{-1}^{t^2 - 1} \frac{du}{u^2} = \lim_{t\to 1^-} \frac{1}{2}\left(-\frac{1}{u}\Bigg|_{-1}^{t^2 - 1}\right) = \lim_{t\to 1^-} \frac{1}{2}\left(-\frac{1}{t^2 - 1} - 1\right) = +\infty
$$

Because the first integral is already divergent, the whole improper integral is $\textbf{divergent.}$ $\blacksquare$

---

**(c)** Note that the function is discontinuous at $x = 2$. Using the substitution $u = 2 - x$, $\text{d}u = -\text{d}x$:

$$
\int_{0}^{2} \frac{(2x - 3)e^x}{\sqrt{2 - x}}\, dx = \lim_{t\to 2^-} \int_{0}^{t} \frac{(2x - 3)e^x}{\sqrt{2 - x}}\, dx = \lim_{t\to 2^-} e^2 \int_{2}^{2-t} \frac{(2u - 1)e^{-u}}{\sqrt{u}}\, du
$$

$$
= \lim_{t\to 2^-} e^2\left(\int_{2}^{2-t} \frac{-e^{-u}}{\sqrt{u}}\, du + \int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du\right)
$$

We solve the first integral using integration by parts with $h = -e^{-u}$, $\text{d}k = \frac{1}{\sqrt{u}}\, du$ (so $\text{d}h = e^{-u}\, du$, $k = 2\sqrt{u}$):

$$
\int_{2}^{2-t} \frac{-e^{-u}}{\sqrt{u}}\, du = -2\sqrt{u}\, e^{-u}\Bigg|_{2}^{2-t} - \int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du
$$

Substituting back, the two integrals cancel:

$$
\lim_{t\to 2^-} e^2\left(-2\sqrt{u}\, e^{-u}\Bigg|_{2}^{2-t} \cancel{- \int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du} + \cancel{\int_{2}^{2-t} 2\sqrt{u}\, e^{-u}\, du}\right)
$$

$$
= \lim_{t\to 2^-} e^2\left(-2\sqrt{2 - t}\, e^{t - 2} + 2\sqrt{2}\, e^{-2}\right) = e^2(0 + 2\sqrt{2}\, e^{-2}) = \boxed{2\sqrt{2}.} \quad \textbf{Convergent.} \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
