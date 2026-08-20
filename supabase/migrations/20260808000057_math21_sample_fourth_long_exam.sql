-- ============================================================================
-- Math 21 Elementary Analysis II — Sample 4th Long Exam, A.Y. 2023-2024
-- 5 problems (integration techniques, motion, FTC, definite integrals,
-- area/arc length/volume).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Four integration problems
    '5a6b7c8d-9e0f-4a1b-8c2d-3e4f5a6b7c01',
    'c0000000-0000-4000-8000-000000000001',
    '56ed8f8c-e735-5966-8bdf-d69fb026face',
    'Evaluating Integrals: Completing the Square, Hyperbolic, Substitution',
    $BODY$Evaluate the following integrals.

**(a)** $\displaystyle\int\left(\frac{1}{\sqrt{-(x+1)(x-5)}}+\frac{2x-3}{x^2-4x+13}\right)\,dx$

**(b)** $\displaystyle\int\frac{1+\tanh x}{e^x+e^{-x}}\,dx$

**(c)** $\displaystyle\int_0^{\pi/6}2^{\sin(3x)}\cos(3x)\,dx$

**(d)** $\displaystyle\int_{2}^{10}\sqrt[3]{x^4 - 2x^3}\,dx$$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    1,
    $BODY$For (a), complete the square in both denominators: the first yields an arcsine form, the second splits into an arctangent and a logarithm. For (b), rewrite in terms of $\operatorname{sech}x$ and $\tanh x$. For (c), substitute $u = \sin(3x)$. For (d), factor out $x^3$ and substitute $u = x - 2$.$BODY$,
    $BODY$**(a)** $\sin^{-1}\left(\frac{x-2}{3}\right) + \frac{1}{3}\tan^{-1}\left(\frac{x-2}{3}\right) + \ln|x^2 - 4x + 13| + C$.

**(b)** $\frac{1}{2}\left(\tan^{-1}(\sinh x) - \operatorname{sech} x\right) + C$.

**(c)** $\frac{1}{3\ln 2}$.

**(d)** $\frac{552}{7}$.$BODY$,
    $BODY$**(a)** Complete the square for the first term:

$$\int\frac{1}{\sqrt{-(x+1)(x-5)}}\,dx = \int\frac{1}{\sqrt{9 - (x-2)^2}}\,dx = \sin^{-1}\left(\frac{x-2}{3}\right) + C.$$

For the second term, split and complete the square:

$$\int\frac{2x-3}{x^2-4x+13}\,dx = \int\frac{(2x-4)+1}{(x-2)^2+9}\,dx = \ln|x^2-4x+13| + \frac{1}{3}\tan^{-1}\left(\frac{x-2}{3}\right) + C.$$

$$\boxed{\sin^{-1}\left(\frac{x-2}{3}\right) + \frac{1}{3}\tan^{-1}\left(\frac{x-2}{3}\right) + \ln|x^2 - 4x + 13| + C.} \;\blacksquare$$

---

**(b)** Rewrite using $\frac{2}{e^x + e^{-x}} = \operatorname{sech}x$:

$$\int\frac{1+\tanh x}{e^x+e^{-x}}\,dx = \frac{1}{2}\int\operatorname{sech}x(1 + \tanh x)\,dx = \frac{1}{2}\int(\operatorname{sech}x + \operatorname{sech}x\tanh x)\,dx.$$

Using standard integrals $\int\operatorname{sech}x\,dx = \tan^{-1}(\sinh x) + C$ and $\int\operatorname{sech}x\tanh x\,dx = -\operatorname{sech}x + C$:

$$\boxed{\frac{1}{2}\left(\tan^{-1}(\sinh x) - \operatorname{sech}x\right) + C.} \;\blacksquare$$

---

**(c)** Let $u = \sin(3x)$, $du = 3\cos(3x)\,dx$:

$$\int_0^{\pi/6} 2^{\sin(3x)}\cos(3x)\,dx = \frac{1}{3}\int_0^1 2^u\,du = \frac{1}{3}\left[\frac{2^u}{\ln 2}\right]_0^1 = \frac{1}{3}\cdot\frac{2-1}{\ln 2} = \boxed{\frac{1}{3\ln 2}.} \;\blacksquare$$

---

**(d)** Factor: $\sqrt[3]{x^4 - 2x^3} = \sqrt[3]{x^3(x-2)} = x\sqrt[3]{x-2}$. Let $u = x - 2$, $du = dx$, $x = u + 2$:

$$\int_2^{10} x\sqrt[3]{x-2}\,dx = \int_0^8 (u+2)u^{1/3}\,du = \int_0^8 (u^{4/3} + 2u^{1/3})\,du = \left[\frac{3}{7}u^{7/3} + \frac{3}{2}u^{4/3}\right]_0^8 = \frac{3 \cdot 128}{7} + \frac{3 \cdot 16}{2} = \frac{384}{7} + 24 = \boxed{\frac{552}{7}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — Motion problem
    '5a6b7c8d-9e0f-4a1b-8c2d-3e4f5a6b7c02',
    'c0000000-0000-4000-8000-000000000001',
    '56ed8f8c-e735-5966-8bdf-d69fb026face',
    'Motion: Height of Building From Projectile',
    $BODY$A ball is thrown from the top of a building. The ball reaches its maximum height $1.5$ seconds after being thrown, and it hits the ground after $3.5$ more seconds. How high is the building? (Assume acceleration due to gravity is $-32$ ft/s$^2$.)$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    2,
    $BODY$Integrate $a(t) = -32$ to get $v(t)$ and $s(t)$. Use $v(1.5) = 0$ (max height) to find one constant, then $s(5) = 0$ (hits ground at $t = 1.5 + 3.5 = 5$) to find the other. The building height is $s(0)$.$BODY$,
    $BODY$160 ft.$BODY$,
    $BODY$Integrate: $v(t) = -32t + C_1$, $s(t) = -16t^2 + C_1 t + C_2$.

Since max height at $t = 1.5$: $v(1.5) = -48 + C_1 = 0 \implies C_1 = 48$.

Since the ball hits the ground at $t = 1.5 + 3.5 = 5$: $s(5) = -16(25) + 48(5) + C_2 = -400 + 240 + C_2 = 0 \implies C_2 = 160$.

The height of the building is $s(0) = \boxed{160 \text{ ft}}$. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — FTC derivative of nested integrals
    '5a6b7c8d-9e0f-4a1b-8c2d-3e4f5a6b7c03',
    'c0000000-0000-4000-8000-000000000001',
    '56ed8f8c-e735-5966-8bdf-d69fb026face',
    'FTC: Derivative of a Function Defined by Nested Integrals',
    $BODY$Find the derivative of the function

$$F(x) = \int_{\pi}^{x^3}\left[\frac{d}{dt}\left(\int_{\tan^{-1}(2t)}^{2024}\sqrt{u + 1}\,du\right)\right]dt.$$ $BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    3,
    $BODY$First evaluate the inner derivative using FTC 1 (reversing limits, then chain rule). Then apply FTC 1 to the outer integral with the chain rule for $x^3$.$BODY$,
    $BODY$F'(x) = -\dfrac{6x^2\sqrt{\tan^{-1}(2x^3) + 1}}{1 + 4x^6}$.$BODY$,
    $BODY$**Inner derivative:** Reverse limits and apply FTC 1:

$$\frac{d}{dt}\left(\int_{\tan^{-1}(2t)}^{2024}\sqrt{u+1}\,du\right) = -\frac{d}{dt}\left(\int_{2024}^{\tan^{-1}(2t)}\sqrt{u+1}\,du\right) = -\sqrt{\tan^{-1}(2t)+1}\cdot\frac{2}{1+(2t)^2}.$$

So $F(x) = \int_\pi^{x^3} -\frac{2\sqrt{\tan^{-1}(2t)+1}}{1+4t^2}\,dt$.

**Outer derivative:** Apply FTC 1 with chain rule for $x^3$:

$$F'(x) = -\frac{2\sqrt{\tan^{-1}(2x^3)+1}}{1+4x^6}\cdot 3x^2 = \boxed{-\frac{6x^2\sqrt{\tan^{-1}(2x^3)+1}}{1+4x^6}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Definite integral properties and FTC
    '5a6b7c8d-9e0f-4a1b-8c2d-3e4f5a6b7c04',
    'c0000000-0000-4000-8000-000000000001',
    '56ed8f8c-e735-5966-8bdf-d69fb026face',
    'Definite Integral Properties and the Fundamental Theorem',
    $BODY$Suppose $f(x)$ is a function with a continuous derivative such that:

$$\int_0^1 f(x)\,dx=-4, \quad \int_0^3 f(x)\,dx=2, \quad f(0)=1, \quad f(1)=3, \quad f(3)=5.$$

**(a)** Find $\displaystyle\int_1^3 [2f(x)-x^2]\,dx$.

**(b)** Find $\displaystyle\int_0^3 f'(x)\,dx$.$BODY$,
    'easy',
    2023,
    'Sample 4th Long Exam',
    4,
    $BODY$For (a), use $\int_1^3 f = \int_0^3 f - \int_0^1 f$ and linearity. For (b), apply the Second Fundamental Theorem of Calculus.$BODY$,
    $BODY$**(a)** $\frac{10}{3}$. **(b)** $4$.$BODY$,
    $BODY$**(a)** Use properties of definite integrals:

$$\int_1^3 f(x)\,dx = \int_0^3 f(x)\,dx - \int_0^1 f(x)\,dx = 2 - (-4) = 6.$$

Therefore

$$\int_1^3 [2f(x) - x^2]\,dx = 2\int_1^3 f(x)\,dx - \int_1^3 x^2\,dx = 2(6) - \left[\frac{x^3}{3}\right]_1^3 = 12 - \left(9 - \frac{1}{3}\right) = 12 - \frac{26}{3} = \boxed{\frac{10}{3}.} \;\blacksquare$$

---

**(b)** By the Second Fundamental Theorem of Calculus:

$$\int_0^3 f'(x)\,dx = f(3) - f(0) = 5 - 1 = \boxed{4.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — Area, arc length, and volume setups
    '5a6b7c8d-9e0f-4a1b-8c2d-3e4f5a6b7c05',
    'c0000000-0000-4000-8000-000000000001',
    '56ed8f8c-e735-5966-8bdf-d69fb026face',
    'Area, Arc Length, and Volume of Revolution (Set Up Only)',
    $BODY$Consider the region $R$ bounded by $C_1: y=2^x-1$, $C_2: y+x=0$, and $C_3: y=3$.

**Set up but do not evaluate** the definite integral (or sum of definite integrals) equal to:

**(a)** the area of $R$ (using both vertical and horizontal strips);

**(b)** the arc length of the segment of $C_1$ bounding $R$;

**(c)** the volume of the solid generated when $R$ is revolved about the line $x=-3$.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    5,
    $BODY$For (a), vertical strips split at $x = 0$; horizontal strips use $x = \log_2(y+1)$ and $x = -y$. For (b), use the arc length formula with $dy/dx = 2^x\ln 2$ on $[0, 2]$. For (c), use the washer method with horizontal strips: $r_{\text{inner}} = -y+3$, $r_{\text{outer}} = \log_2(y+1)+3$.$BODY$,
    $BODY$**(a)** Vertical: $\int_{-3}^0 [3-(-x)]\,dx + \int_0^2 [3-(2^x-1)]\,dx$. Horizontal: $\int_0^3 [\log_2(y+1)+y]\,dy$.

**(b)** $\int_0^2\sqrt{1+(2^x\ln 2)^2}\,dx$.

**(c)** $\int_0^3 \pi\left[(\log_2(y+1)+3)^2 - (-y+3)^2\right]\,dy$.$BODY$,
    $BODY$**(a)** **Vertical strips:** $R$ covers $x \in [-3, 2]$, split at $x = 0$.

$$\text{Area} = \int_{-3}^0 [3 - (-x)]\,dx + \int_0^2 [3 - (2^x - 1)]\,dx. \;\blacksquare$$

**Horizontal strips:** $R$ covers $y \in [0, 3]$, bounded left by $x = -y$ and right by $x = \log_2(y+1)$.

$$\text{Area} = \int_0^3 [\log_2(y+1) - (-y)]\,dy = \int_0^3 [\log_2(y+1) + y]\,dy. \;\blacksquare$$

---

**(b)** The segment of $C_1$ covers $x \in [0, 2]$ with $\frac{dy}{dx} = 2^x\ln 2$.

$$\text{Arc Length} = \int_0^2\sqrt{1 + (2^x\ln 2)^2}\,dx. \;\blacksquare$$

---

**(c)** Using horizontal strips about $x = -3$: inner radius $r_{\text{inner}} = -y - (-3) = 3 - y$, outer radius $r_{\text{outer}} = \log_2(y+1) - (-3) = \log_2(y+1) + 3$.

$$\text{Volume} = \int_0^3 \pi\left[(\log_2(y+1) + 3)^2 - (3 - y)^2\right]\,dy. \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
