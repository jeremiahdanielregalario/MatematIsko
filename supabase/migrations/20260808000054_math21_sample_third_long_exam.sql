-- ============================================================================
-- Math 21 Elementary Analysis II — Sample 3rd Long Exam, A.Y. 2023-2024
-- 7 problems (absolute extrema, optimization, related rates, motion,
-- linear approximation, differentials, L'Hôpital's rule).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Absolute extrema
    '3e4f5a6b-7c8d-4e0f-9a1b-2c3d4e5f6a01',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Absolute Extrema on Closed and Unbounded Intervals',
    $BODY$Find the values of $x$ where the following functions attain their absolute extrema.

**(a)** $f(x)=4x^{3}-15x^{2}-18x+34$ on the interval $[-1,5]$.

**(b)** $f(x)=x^4 + 4x$ on the interval $(-\infty, +\infty)$.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    1,
    $BODY$For (a), find critical numbers in $[-1,5]$ and evaluate $f$ at critical numbers and endpoints; apply the Extreme Value Theorem. For (b), analyze end behavior to show no absolute max exists, then use the second derivative test on the only critical number.$BODY$,
    $BODY$**(a)** Absolute minimum at $x = 3$, absolute maximum at $x = 5$.

**(b)** Absolute minimum at $x = -1$; no absolute maximum.$BODY$,
    $BODY$**(a)** $f$ is a polynomial, hence continuous on $[-1,5]$. By the Extreme Value Theorem, absolute extrema exist. Find critical numbers:

$$f'(x) = 12x^2 - 30x - 18 = 6(2x+1)(x-3) = 0 \implies x = -\frac{1}{2} \text{ or } x = 3.$$

Both are in $[-1,5]$. Evaluate $f$ at critical numbers and endpoints:

$$f(-1) = 33, \quad f\left(-\frac{1}{2}\right) = 38.75, \quad f(3) = -47, \quad f(5) = 69.$$

Absolute minimum at $x = 3$ (value $-47$); absolute maximum at $x = 5$ (value $69$). $\blacksquare$

---

**(b)** $f$ is continuous on $(-\infty, +\infty)$. Check end behavior:

$$\lim_{x \to -\infty}f(x) = +\infty, \qquad \lim_{x \to +\infty}f(x) = +\infty.$$

So $f$ has no absolute maximum. Find critical numbers:

$$f'(x) = 4x^3 + 4 = 4(x+1)(x^2 - x + 1) = 0 \implies x = -1$$

(the quadratic factor has no real roots). Since $f''(-1) = 12(-1)^2 = 12 > 0$, the second derivative test gives a relative minimum at $x = -1$. Since it is the only relative extremum and $f(x) \to +\infty$ at both ends, this is also the **absolute minimum**. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Optimization (wire problem)
    '3e4f5a6b-7c8d-4e0f-9a1b-2c3d4e5f6a02',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Optimization: Minimum Combined Area of Square and Equilateral Triangle',
    $BODY$A wire of length $10$ cm is cut into two such that one piece is shaped into an equilateral triangle and the other into a square. Let $x$ be the length of wire used for the square.

**(a)** Determine the function of $x$ representing the combined areas.

**(b)** Find $x$ so that the combined areas will be minimum.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    2,
    $BODY$For (a), express the side of the square as $x/4$ and the side of the triangle as $(10-x)/3$, then use area formulas. For (b), differentiate, find the critical number on $(0,10)$, and confirm it is a minimum using the second derivative test.$BODY$,
    $BODY$**(a)** $A(x) = \frac{x^2}{16} + \frac{(10-x)^2}{12\sqrt{3}}$.

**(b)** $x = \frac{40}{3\sqrt{3}+4}$ cm.$BODY$,
    $BODY$**(a)** The square has perimeter $x$, so each side is $\frac{x}{4}$ and area $\frac{x^2}{16}$. The equilateral triangle has perimeter $10 - x$, so each side is $\frac{10-x}{3}$ and area $\frac{\sqrt{3}}{4}\left(\frac{10-x}{3}\right)^2 = \frac{(10-x)^2}{12\sqrt{3}}$. The combined area is

$$\boxed{A(x) = \frac{x^2}{16} + \frac{(10-x)^2}{12\sqrt{3}}.} \;\blacksquare$$

---

**(b)** $A$ is continuous on $(0, 10)$. Differentiate:

$$A'(x) = \frac{x}{8} + \frac{x - 10}{6\sqrt{3}} = \frac{3\sqrt{3}x + 4x - 40}{24\sqrt{3}}.$$

Setting $A'(x) = 0$: $(3\sqrt{3} + 4)x = 40$, so $x = \frac{40}{3\sqrt{3} + 4}$.

Since $A''(x) = \frac{1}{8} + \frac{1}{6\sqrt{3}} > 0$ for all $x$, this critical point is a relative minimum. Being the only critical point on $(0, 10)$, it is the absolute minimum.

$$\boxed{x = \frac{40}{3\sqrt{3}+4} \text{ cm}}$$ gives the minimum combined area. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Rocket motion
    '3e4f5a6b-7c8d-4e0f-9a1b-2c3d4e5f6a03',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Rocket Motion: Height, Velocity, Acceleration, and Distance',
    $BODY$A rocket is launched straight up from the ground of an unknown planet. It reaches a maximum height of $150$ feet after $5$ seconds. Use the model $h(t) = at^2 + bt + c$ where $h$ is in feet and $t$ is in seconds. Find:

**(a)** the particular function $h(t)$;

**(b)** the time at which it falls back to the ground;

**(c)** the instantaneous vertical velocity at $t = 3$;

**(d)** the acceleration due to gravity; and

**(e)** the total distance travelled by $t = 7$.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    3,
    $BODY$For (a), use $h(0) = 0$, $h'(5) = 0$ (max height), and $h(5) = 150$ to solve for $a$, $b$, $c$. For (b), solve $h(t) = 0$. For (c), compute $h'(3)$. For (d), $h''(t)$ is constant. For (e), split at the turning point $t = 5$.$BODY$,
    $BODY$**(a)** $h(t) = -6t^2 + 60t$. **(b)** $t = 10$ s. **(c)** $24$ ft/s. **(d)** $-12$ ft/s$^2$. **(e)** $174$ ft.$BODY$,
    $BODY$**(a)** Since the rocket starts on the ground: $h(0) = c = 0$. Maximum height at $t = 5$ gives $h'(5) = 0$ and $h(5) = 150$:

$$h'(t) = 2at + b \implies h'(5) = 10a + b = 0 \implies b = -10a.$$

$$h(5) = 25a + 5b = 150 \implies 25a + 5(-10a) = -25a = 150 \implies a = -6, \quad b = 60.$$

$$\boxed{h(t) = -6t^2 + 60t.} \;\blacksquare$$

---

**(b)** Set $h(t) = 0$: $-6t(t - 10) = 0 \implies t = 0$ or $t = 10$. The rocket falls back at $\boxed{t = 10 \text{ s}}$. $\blacksquare$

---

**(c)** $h'(t) = -12t + 60$. At $t = 3$: $h'(3) = -36 + 60 = \boxed{24 \text{ ft/s}}$. $\blacksquare$

---

**(d)** $h''(t) = -12$. The acceleration due to gravity is $\boxed{-12 \text{ ft/s}^2}$. $\blacksquare$

---

**(e)** The rocket changes direction at $t = 5$ (where $h' = 0$). Total distance:

$$|h(5) - h(0)| + |h(7) - h(5)| = |150 - 0| + |(-6)(49) + 420 - 150| = 150 + |{-24}| = 150 + 24 = \boxed{174 \text{ ft}}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Related rates (conical tank)
    '3e4f5a6b-7c8d-4e0f-9a1b-2c3d4e5f6a04',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Related Rates: Filling a Conical Tank',
    $BODY$A tank in the shape of an inverted cone is being filled with water at a rate of $6$ cubic meters per second. The radius at the top is $20$ meters and the height is $10$ meters. At what rate is the depth of the water changing when the radius at the water's surface is $16$ meters?$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    4,
    $BODY$Express $V$ in terms of $h$ alone using similar triangles ($r/h = 20/10 = 2$). Differentiate $V = \frac{4}{3}\pi h^3$ with respect to $t$, then substitute $dV/dt = 6$ and $h = r/2 = 8$.$BODY$,
    $BODY$\frac{dh}{dt} = \frac{3}{128\pi}$ m/s.$BODY$,
    $BODY$Let $V$ be the volume and $h$ the depth of water, with $r$ the radius at the surface. By similar triangles:

$$\frac{r}{h} = \frac{20}{10} = 2 \implies r = 2h.$$

The volume of the cone is $V = \frac{1}{3}\pi r^2 h = \frac{1}{3}\pi(2h)^2 h = \frac{4}{3}\pi h^3$.

Differentiating with respect to $t$:

$$\frac{dV}{dt} = 4\pi h^2 \frac{dh}{dt}.$$

When $r = 16$: $h = \frac{r}{2} = 8$. Substituting $\frac{dV}{dt} = 6$ and $h = 8$:

$$6 = 4\pi(64)\frac{dh}{dt} \implies \frac{dh}{dt} = \frac{6}{256\pi} = \boxed{\frac{3}{128\pi} \text{ m/s}.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — Local linear approximation
    '3e4f5a6b-7c8d-4e0f-9a1b-2c3d4e5f6a05',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Local Linear Approximation of $\sqrt{4.02} + \sin(0.02)$',
    $BODY$Use the local linear approximation of a suitable function to approximate the value of $\sqrt{4.02}+\sin(0.02)$.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    5,
    $BODY$Define $f(x) = \sqrt{x+4} + \sin x$ and approximate $f(0.02)$ using $L(x) = f(0) + f'(0)x$.$BODY$,
    $BODY$f(0.02) \approx \frac{81}{40} = 2.025$.$BODY$,
    $BODY$Define $f(x) = \sqrt{x + 4} + \sin x$. Then $f(0.02) = \sqrt{4.02} + \sin(0.02)$. Compute:

$$f(0) = \sqrt{4} + \sin 0 = 2, \qquad f'(x) = \frac{1}{2\sqrt{x+4}} + \cos x, \qquad f'(0) = \frac{1}{4} + 1 = \frac{5}{4}.$$

The local linear approximation at $x = 0$:

$$L(x) = f(0) + f'(0)x = 2 + \frac{5}{4}x.$$

Therefore

$$\sqrt{4.02} + \sin(0.02) = f(0.02) \approx L(0.02) = 2 + \frac{5}{4}(0.02) = 2 + 0.025 = \boxed{\frac{81}{40} = 2.025.} \;\blacksquare$$

**Remark:** The exact value is $\sqrt{4.02} + \sin(0.02) \approx 2.02499243227\ldots$ $BODY$
  ),
  (
    -- Q6 — Differentials (paint volume)
    '3e4f5a6b-7c8d-4e0f-9a1b-2c3d4e5f6a06',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Estimating Paint Volume Using Differentials',
    $BODY$A cylindrical post with a height of $16$ meters and radius of $0.5$ meters is to be coated with paint $0.002$ meters thick. Using differentials, estimate the total volume of paint to be used (in cubic meters). Assume that only the side of the cylindrical post is to be painted.$BODY$,
    'easy',
    2023,
    'Sample 3rd Long Exam',
    6,
    $BODY$The volume of the side of the cylinder is $V = \pi r^2 h$ with $h = 16$ fixed. Compute $dV = V'(r)\, dr$ with $dr = 0.002$ and $r = 0.5$.$BODY$,
    $BODY$\Delta V \approx dV = 0.032\pi$ cubic meters.$BODY$,
    $BODY$The volume of the side of the cylinder is $V = \pi r^2 h = 16\pi r^2$ (height is fixed). The differential is

$$dV = V'(r)\, dr = 32\pi r\, dr.$$

With $r = 0.5$ m and $dr = 0.002$ m:

$$dV = 32\pi(0.5)(0.002) = \boxed{0.032\pi \text{ cubic meters} \approx 0.1005 \text{ m}^3.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q7 — Limit with L'Hôpital's rule
    '3e4f5a6b-7c8d-4e0f-9a1b-2c3d4e5f6a07',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Evaluating $\lim_{x \to 0^+}(1+\sin x)^{2\cot x}$',
    $BODY$Evaluate the limit:

$$\lim_{x \to 0^+}(1+\sin{x})^{2\cot{x}}.$$ $BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    7,
    $BODY$The limit has the indeterminate form $1^\infty$. Rewrite as $e^{2\cot x \ln(1+\sin x)}$ and evaluate the exponent limit using L'Hôpital's rule.$BODY$,
    $BODY$e^2$.$BODY$,
    $BODY$Since $\lim_{x \to 0^+}2\cot x = +\infty$ and $\lim_{x \to 0^+}(1+\sin x) = 1$, the limit has the indeterminate form $1^\infty$. Rewrite:

$$\lim_{x \to 0^+}(1+\sin x)^{2\cot x} = \lim_{x \to 0^+} e^{2\cot x \ln(1+\sin x)} = e^{\lim_{x \to 0^+} 2\cot x \ln(1+\sin x)}.$$

Evaluate the exponent limit. It has the form $\infty \cdot 0$, so rewrite as $\frac{0}{0}$:

$$\lim_{x \to 0^+} 2\cot x \ln(1+\sin x) = 2\lim_{x \to 0^+} \frac{\ln(1+\sin x)}{\tan x} \quad \left(\frac{0}{0}\right).$$

Apply L'Hôpital's rule:

$$= 2\lim_{x \to 0^+} \frac{\frac{\cos x}{1+\sin x}}{\sec^2 x} = 2\cdot\frac{\frac{1}{1+0}}{1} = 2.$$

Therefore the limit is $\boxed{e^2.} \;\blacksquare$$BODY$
  )
on conflict (id) do nothing;
