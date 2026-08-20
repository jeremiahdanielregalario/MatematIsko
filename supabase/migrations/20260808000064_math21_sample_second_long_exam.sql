-- ============================================================================
-- Math 21 Elementary Analysis II — Sample 2nd Long Exam, A.Y. 2023-2024
-- 7 problems (derivatives, chain rule, differentiability, MVT,
-- critical numbers, inflection points, graph from f').
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Four derivative calculations
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e01',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Finding $\frac{dy}{dx}$: Quotient, Chain, Implicit, and Logarithmic Differentiation',
    $BODY$Find $\dfrac{dy}{dx}$. Do not simplify.

**(a)** $y=\dfrac{\cos{x}-x}{x^4\cot{x}-5}$

**(b)** $y = 4\csc^3{\left(e^{x^2}+3\sinh{x}\right)}$

**(c)** $3^{y} + \tan(x^{2}+1) = \log_{42}|y|-xy$

**(d)** $y = (\sin{x})^{\cos x} \tan^{-1} (x^4), \quad 0 < x < \pi$$BODY$,
    'hard',
    2023,
    'Sample 2nd Long Exam',
    1,
    $BODY$For (a), use the quotient rule. For (b), apply the chain rule repeatedly (power, then $\csc$, then the inner function). For (c), use implicit differentiation. For (d), use logarithmic differentiation.$BODY$,
    $BODY$**(a)** $\dfrac{(x^4\cot x - 5)(-\sin x - 1) - (\cos x - x)(-x^4\csc^2 x + 4x^3\cot x)}{(x^4\cot x - 5)^2}$.

**(b)** $-12\csc^3(e^{x^2}+3\sinh x)\cot(e^{x^2}+3\sinh x)(2xe^{x^2}+3\cosh x)$.

**(c)** $\dfrac{-2x\sec^2(x^2+1) - y}{3^y\ln 3 - \frac{1}{y\ln 42} + x}$.

**(d)** $(\sin x)^{\cos x}\tan^{-1}(x^4)\left[\dfrac{\cos^2 x}{\sin x} - \sin x\ln|\sin x| + \dfrac{4x^3}{(1+x^8)\tan^{-1}(x^4)}\right]$.$BODY$,
    $BODY$**(a)** Apply the quotient rule with $u = \cos x - x$ and $v = x^4\cot x - 5$:

$$\frac{dy}{dx} = \frac{(x^4\cot x - 5)(-\sin x - 1) - (\cos x - x)\left[x^4(-\csc^2 x) + \cot x \cdot 4x^3\right]}{(x^4\cot x - 5)^2}.$$

$$= \frac{(x^4\cot x - 5)(-\sin x - 1) - (\cos x - x)(-x^4\csc^2 x + 4x^3\cot x)}{(x^4\cot x - 5)^2}. \;\blacksquare$$

---

**(b)** Apply the chain rule step by step:

$$\frac{dy}{dx} = 4 \cdot 3\csc^2(e^{x^2}+3\sinh x) \cdot \left[-\csc(e^{x^2}+3\sinh x)\cot(e^{x^2}+3\sinh x)\right] \cdot (2xe^{x^2}+3\cosh x).$$

$$= -12\csc^3(e^{x^2}+3\sinh x)\cot(e^{x^2}+3\sinh x)(2xe^{x^2}+3\cosh x). \;\blacksquare$$

---

**(c)** Differentiate both sides with respect to $x$:

$$3^y\ln(3)\frac{dy}{dx} + \sec^2(x^2+1)(2x) = \frac{1}{y\ln(42)}\frac{dy}{dx} - y - x\frac{dy}{dx}.$$

Collect $\frac{dy}{dx}$ terms:

$$\frac{dy}{dx}\left[3^y\ln 3 - \frac{1}{y\ln 42} + x\right] = -2x\sec^2(x^2+1) - y.$$

$$\frac{dy}{dx} = \frac{-2x\sec^2(x^2+1) - y}{3^y\ln 3 - \frac{1}{y\ln 42} + x}. \;\blacksquare$$

---

**(d)** Apply logarithmic differentiation. Taking $\ln|y|$:

$$\ln|y| = \cos x \ln|\sin x| + \ln|\tan^{-1}(x^4)|.$$

Differentiating:

$$\frac{1}{y}\frac{dy}{dx} = \cos x \cdot \frac{\cos x}{\sin x} + \ln|\sin x|(-\sin x) + \frac{1}{\tan^{-1}(x^4)} \cdot \frac{4x^3}{1+x^8}.$$

$$\frac{dy}{dx} = (\sin x)^{\cos x}\tan^{-1}(x^4)\left[\frac{\cos^2 x}{\sin x} - \sin x\ln|\sin x| + \frac{4x^3}{(1+x^8)\tan^{-1}(x^4)}\right]. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — Chain rule with given values
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e02',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Chain Rule: Finding $h\'(3)$ Given Function Values',
    $BODY$Two functions $f$ and $g$ are both differentiable at $x=3$. Find $h'(3)$, given the following:

$$f(3)=\pi, \quad f'(3)=0, \quad g(3)=3, \quad g'(3)=-2, \quad h(x)=\left[x^2g(x)-f(x)\right]^2.$$ $BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    2,
    $BODY$Apply the chain rule and product rule to find $h'(x)$, then substitute $x = 3$ with the given values.$BODY$,
    $BODY$h'(3) = 0$.$BODY$,
    $BODY$Since $f$, $g$, and $x^2$ are differentiable at $x = 3$, the function $h(x) = [x^2g(x) - f(x)]^2$ is differentiable at $x = 3$. By the chain rule and product rule:

$$h'(x) = 2[x^2g(x) - f(x)] \cdot [2xg(x) + x^2g'(x) - f'(x)].$$

Substituting $x = 3$:

$$h'(3) = 2[(9)(3) - \pi] \cdot [(6)(3) + (9)(-2) - 0] = 2(27 - \pi)(18 - 18) = 2(27 - \pi)(0) = 0. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Differentiability of piecewise function
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e03',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Differentiability of a Piecewise Function at $x = 3$',
    $BODY$Determine if the following piecewise function $f$ is differentiable at $x = 3$:

$$f(x) = \begin{cases} \ln(x - 2), & x \leq 3 \\ \sqrt{x-3}, & x > 3. \end{cases}$$$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    3,
    $BODY$First check continuity at $x = 3$. Then compute the one-sided derivatives using the left and right limits of $f'(x)$ as $x \to 3$.$BODY$,
    $BODY$f$ is not differentiable at $x = 3$ because $f'_-(3) = 1$ but $f'_+(3)$ does not exist ($\lim_{x \to 3^+} f'(x) = +\infty$).$BODY$,
    $BODY$**Continuity:** $f(3) = \ln(1) = 0$, $\lim_{x \to 3^-}f(x) = \ln(1) = 0$, $\lim_{x \to 3^+}f(x) = \sqrt{0} = 0$. Since $f(3) = \lim_{x \to 3^-}f(x) = \lim_{x \to 3^+}f(x) = 0$, $f$ is continuous at $x = 3$.

**Differentiability:** The derivative of $f$ is

$$f'(x) = \begin{cases} \frac{1}{x-2}, & x < 3 \\[0.3cm] \frac{1}{2\sqrt{x-3}}, & x > 3. \end{cases}$$

The one-sided limits of $f'$ at $x = 3$:

$$\lim_{x \to 3^-}f'(x) = \lim_{x \to 3^-}\frac{1}{x-2} = 1, \qquad \lim_{x \to 3^+}f'(x) = \lim_{x \to 3^+}\frac{1}{2\sqrt{x-3}} = +\infty.$$

So $f'_-(3) = 1$ but $f'_+(3)$ does not exist. Since $f'_-(3) \neq f'_+(3)$, $f$ is **not differentiable** at $x = 3$. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — Mean Value Theorem
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e04',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Mean Value Theorem for $f(x) = e^x\sinh x$ on $[0,1]$',
    $BODY$Verify that the Mean Value Theorem applies to the function $f(x) = e^x\sinh{x}$ on the interval $[0, 1]$ and find all values of $c$ that satisfy the conclusion of the theorem.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    4,
    $BODY$Check that $f$ is continuous on $[0,1]$ and differentiable on $(0,1)$ (both hold since $e^x$ and $\sinh x$ are continuous and differentiable everywhere). Then solve $f'(c) = \frac{f(1)-f(0)}{1-0}$ using $\sinh c + \cosh c = e^c$.$BODY$,
    $BODY$c = \dfrac{1}{2}\ln\left(\dfrac{e^2-1}{2}\right)$.$BODY$,
    $BODY$**Verifying MVT hypotheses:** $f(x) = e^x\sinh x$ is continuous on $[0,1]$ (product of continuous functions) and differentiable on $(0,1)$ (product of differentiable functions). The MVT applies.

**Finding $c$:** Compute $\frac{f(1)-f(0)}{1-0}$:

$$\frac{f(1)-f(0)}{1} = e\sinh 1 - e^0\sinh 0 = e \cdot \frac{e - e^{-1}}{2} = \frac{e^2 - 1}{2}.$$

Compute $f'(x)$:

$$f'(x) = e^x\sinh x + e^x\cosh x = e^x(\sinh x + \cosh x) = e^x \cdot e^x = e^{2x}.$$

(Using the identity $\sinh x + \cosh x = e^x$.)

Set $f'(c) = \frac{e^2-1}{2}$:

$$e^{2c} = \frac{e^2-1}{2} \implies 2c = \ln\left(\frac{e^2-1}{2}\right) \implies c = \frac{1}{2}\ln\left(\frac{e^2-1}{2}\right).$$

Since $e^2 \approx 7.389$, we have $\frac{e^2-1}{2} \approx 3.195 > 1$, so $c > 0$. Also $c = \frac{1}{2}\ln(3.195) \approx 0.583 < 1$. Thus $c \in (0,1)$. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Critical numbers and second derivative test
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e05',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Critical Numbers and Second Derivative Test for $g(x)$',
    $BODY$Consider the following function and its derivatives:

$$g(x) = \frac{(5x-3)^3}{15} + \frac{16}{5(5x-3)^2}, \quad g'(x) = \frac{(5x-3)^5 - 32}{(5x-3)^3}, \quad g''(x) = \frac{10(5x - 3)^5+480}{(5x-3)^4}.$$

**(a)** Find the critical number(s) of $g$.

**(b)** Determine if the second derivative test is applicable to the critical number(s). If yes, what can you conclude?$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    5,
    $BODY$For (a), find where $g'(x) = 0$ or is undefined (but only values in the domain of $g$). For (b), evaluate $g''$ at the critical number; if $g''(c) > 0$ there is a relative min, if $g''(c) < 0$ a relative max.$BODY$,
    $BODY$**(a)** The only critical number is $x = 1$.

**(b)** The second derivative test is applicable: $g''(1) > 0$, so $g$ has a relative minimum at $x = 1$.$BODY$,
    $BODY$**(a)** The critical numbers are values of $x$ in the domain of $g$ where $g'(x) = 0$ or $g'(x)$ is undefined. Note $g'(x)$ is undefined at $x = \frac{3}{5}$, but this is not in the domain of $g$ (the denominator $(5x-3)^3$ would be zero).

Setting $g'(x) = 0$:

$$(5x-3)^5 - 32 = 0 \implies (5x-3)^5 = 32 \implies 5x - 3 = 2 \implies x = 1.$$

The only critical number is $x = 1$. $\blacksquare$

---

**(b)** Evaluate $g''$ at $x = 1$:

$$g''(1) = \frac{10(5(1)-3)^5 + 480}{(5(1)-3)^4} = \frac{10(32) + 480}{16} = \frac{800}{16} = 50 > 0.$$

Since $g'(1) = 0$ and $g''(1) > 0$, the second derivative test is applicable and $g$ attains a **relative minimum** at $x = 1$. $\blacksquare$$BODY$
  ),
  (
    -- Q6 — Points of inflection and concavity
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e06',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Points of Inflection and Concavity of $f(x) = \frac{x^4}{3} - 2x^2$',
    $BODY$Find all the points of inflection of $f(x) = \dfrac{x^4}{3} - 2x^2$ and discuss the concavity of $f$ on different intervals.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    6,
    $BODY$Compute $f''(x)$ and find where it is zero or undefined. Use a sign table to determine concavity on each interval. Points where concavity changes are inflection points.$BODY$,
    $BODY$Concave up on $(-\infty, -1)$ and $(1, +\infty)$; concave down on $(-1, 1)$. Points of inflection: $\left(-1, -\frac{5}{3}\right)$ and $\left(1, -\frac{5}{3}\right)$.$BODY$,
    $BODY$Compute the second derivative:

$$f'(x) = \frac{4x^3}{3} - 4x, \qquad f''(x) = 4x^2 - 4 = 4(x-1)(x+1).$$

$f''(x) = 0$ when $x = \pm 1$ and $f''$ is never undefined. We test the sign of $f''$ on each interval:

$$\begin{array}{c|c|c|c}
& x < -1 & -1 < x < 1 & x > 1 \\
\hline
\text{Test point} & -2 & 0 & 2 \\
\hline
f''(c) & + & - & +
\end{array}$$

- $f$ is **concave up** on $(-\infty, -1)$ and $(1, +\infty)$.
- $f$ is **concave down** on $(-1, 1)$.

Since concavity changes at $x = \pm 1$ and $f$ is continuous there:

$$f(-1) = \frac{1}{3} - 2 = -\frac{5}{3}, \qquad f(1) = \frac{1}{3} - 2 = -\frac{5}{3}.$$

The points of inflection are $\left(-1, -\frac{5}{3}\right)$ and $\left(1, -\frac{5}{3}\right)$. $\blacksquare$$BODY$
  ),
  (
    -- Q7 — Sketch graph from f' graph
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e07',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Sketching $f$ From the Graph of $f\'$',
    $BODY$Given that $f$ is a function that is continuous everywhere, sketch a possible graph of $f$ from the graph of $f'$ below.

*(The graph of $f'$ shows: $f'$ is negative on $(-\infty, -1-\sqrt{3})$, zero at $x = -1-\sqrt{3}$, positive on $(-1-\sqrt{3}, 0)$, zero at $x = 0$, negative on $(0, 2)$, zero at $x = 2$, and positive on $(2, +\infty)$. The graph of $f'$ is increasing on $(-\infty, -1)$, has a local max at $x = -1$, decreasing on $(-1, 0)$, has a local min at $x = 0$, decreasing on $(0, 1)$, has a local max at $x = 1$, and increasing on $(1, +\infty)$.)*$BODY$,
    'hard',
    2023,
    'Sample 2nd Long Exam',
    7,
    $BODY$From the graph of $f'$: (1) identify critical numbers where $f' = 0$ or is undefined; (2) identify possible inflection points where $f'$ has local extrema (i.e., $f''$ changes sign); (3) use the sign of $f'$ to determine where $f$ is increasing/decreasing; (4) use the monotonicity of $f'$ to determine concavity.$BODY$,
    $BODY$The critical numbers are $x = -1-\sqrt{3}$, $x = 0$, and $x = 2$. The possible points of inflection are $x = -1$, $x = 0$, and $x = 1$. From the sign analysis of $f'$ and $f''$, $f$ has a relative minimum at $x = -1-\sqrt{3}$ and $x = 2$, a relative maximum at $x = 0$, and points of inflection at $x = -1$ and $x = 1$.$BODY$,
    $BODY$To sketch a possible graph of $f$ from the graph of $f'$, we follow these steps:

1. **Critical numbers** (where $f' = 0$ or $f'$ is undefined): From the graph, $f' = 0$ at $x = -1-\sqrt{3}$, $x = 0$, and $x = 2$. These are the critical numbers.

2. **Possible points of inflection** (where $f''$ changes sign, i.e., where $f'$ has a local extremum): From the graph, $f'$ has local extrema at $x = -1$, $x = 0$, and $x = 1$. These are the possible points of inflection.

3. **Sign analysis of $f'$ and $f''$:**

$$\begin{array}{|c|c|c|c|c|c|c|}
\hline
x & (-\infty,-1-\sqrt{3}) & -1-\sqrt{3} & (-1-\sqrt{3},-1) & -1 & (-1,0) \\
\hline
f' & - & 0 & + & + & + \\
\hline
f'' & + & + & + & \text{und} & - \\
\hline
\text{behavior} & \text{dec, con. up} & \text{rel. min} & \text{inc, con. up} & \text{POI} & \text{inc, con. down} \\
\hline
\end{array}$$

$$\begin{array}{|c|c|c|c|c|c|c|}
\hline
x & 0 & (0,1) & 1 & (1,2) & 2 & (2,+\infty) \\
\hline
f' & 0 & - & - & - & 0 & + \\
\hline
f'' & 0 & - & \text{und} & + & + & + \\
\hline
\text{behavior} & \text{rel. max} & \text{dec, con. down} & \text{POI} & \text{dec, con. up} & \text{rel. min} & \text{inc, con. up} \\
\hline
\end{array}$$

4. **Summary of key features:**
 - **Relative minimum** at $x = -1-\sqrt{3}$ and $x = 2$ (where $f'$ changes from $-$ to $+$).
 - **Relative maximum** at $x = 0$ (where $f'$ changes from $+$ to $-$).
 - **Points of inflection** at $x = -1$ and $x = 1$ (where $f''$ changes sign).
 - $f$ is increasing on $(-1-\sqrt{3}, 0)$ and $(2, +\infty)$; decreasing on $(-\infty, -1-\sqrt{3})$ and $(0, 2)$.
 - $f$ is concave up on $(-\infty, -1)$ and $(1, +\infty)$; concave down on $(-1, 1)$.

A possible graph of $f$ can be constructed from these features. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
