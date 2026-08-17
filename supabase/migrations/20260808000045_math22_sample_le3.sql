-- ============================================================================
-- MATH 22 Elementary Analysis II — Sample 3rd Long Exam, A.Y. 2023-2024
-- 13 cards (parametric concavity, polar coords, limaçon, polar perimeter/area,
--           sphere, cylinder, surface of revolution, quadric surface).
--
-- Independent subitems have been split into separate question cards.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Parametric concavity (single question, no subitems)
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d01',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Concavity of a Parametric Curve',
    $BODY$Determine the values of $t \in \mathbb{R}$ for which the curve $C$ described by the parametric equations
$$
x = \frac{t^2 + 4}{t - 2}, \qquad y = \frac{t^3}{3} - 2t^2 - 4t + 4
$$
is concave up and concave down.$BODY$,
    'hard',
    2023,
    'Sample 3rd Long Exam',
    1,
    $BODY$Compute $\frac{d^2y}{dx^2}$ using the formula $\frac{d^2y}{dx^2} = \frac{d(dy/dx)/dt}{dx/dt}$, where $\frac{dy}{dx} = \frac{dy/dt}{dx/dt}$. Then analyze the sign of $\frac{d^2y}{dx^2}$ using a sign chart.$BODY$,
    $BODY$Concave up when $t \in (2 - 2\sqrt{2},\, 2) \cup (2 + 2\sqrt{2},\, +\infty)$. Concave down when $t \in (-\infty,\, 2 - 2\sqrt{2}) \cup (2,\, 2 + 2\sqrt{2})$.$BODY$,
    $BODY$The curve $C$ is concave up when $\frac{d^2y}{dx^2} > 0$ and concave down when $\frac{d^2y}{dx^2} < 0$. We use the formula:
$$
\frac{d^2y}{dx^2} = \frac{d(dy/dx)/dt}{dx/dt}, \quad \text{where } \frac{dy}{dx} = \frac{dy/dt}{dx/dt}.
$$

First, compute the derivatives:
$$
\frac{dx}{dt} = \frac{(t-2)(2t) - (t^2 + 4)}{(t-2)^2} = \frac{t^2 - 4t - 4}{(t-2)^2}, \qquad \frac{dy}{dt} = t^2 - 4t - 4
$$

Therefore:
$$
\frac{dy}{dx} = (t^2 - 4t - 4) \cdot \frac{(t-2)^2}{t^2 - 4t - 4} = (t-2)^2
$$

And:
$$
\frac{d^2y}{dx^2} = \frac{d((t-2)^2)/dt}{\dfrac{t^2 - 4t - 4}{(t-2)^2}} = 2(t-2) \cdot \frac{(t-2)^2}{t^2 - 4t - 4} = \frac{2(t-2)^3}{t^2 - 4t - 4}
$$

Let $f(t) = 2(t-2)^3$ and $g(t) = t^2 - 4t - 4 = [t - (2 + 2\sqrt{2})][t - (2 - 2\sqrt{2})]$. The zero of $f(t)$ is $2$ and the zeros of $g(t)$ are $2 \pm 2\sqrt{2}$.

Using a sign chart:

| | $t < 2 - 2\sqrt{2}$ | $2 - 2\sqrt{2} < t < 2$ | $2 < t < 2 + 2\sqrt{2}$ | $t > 2 + 2\sqrt{2}$ |
|---|---|---|---|---|
| $f(t)$ | $-$ | $-$ | $+$ | $+$ |
| $g(t)$ | $+$ | $-$ | $-$ | $+$ |
| $f(t)/g(t)$ | $-$ | $+$ | $-$ | $+$ |

The curve $C$ is **concave up** when $t \in (2 - 2\sqrt{2},\, 2) \cup (2 + 2\sqrt{2},\, +\infty)$ and **concave down** when $t \in (-\infty,\, 2 - 2\sqrt{2}) \cup (2,\, 2 + 2\sqrt{2})$. $\blacksquare$ $BODY$
  ),
  (
    -- Q2a — Polar coordinates: find (r₁, θ₁) and (r₂, θ₂)
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d02',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Polar Coordinates of $(-\\sqrt{6}, -\\sqrt{2})$',
    $BODY$Find the polar coordinates $(r_1, \theta_1)$ and $(r_2, \theta_2)$, with $r_2 < 0 < r_1$ and $-2\pi \le \theta_2 \le 0 \le \theta_1 \le 2\pi$, of the point whose Cartesian coordinates are $(-\sqrt{6}, -\sqrt{2}).$$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    2,
    $BODY$Use $r = \sqrt{x^2 + y^2}$ and solve the system $\cos\theta = x/r$, $\sin\theta = y/r$ to find $\theta_1$. For $(r_2, \theta_2)$ with $r_2 < 0$, use the equivalent representation $(-r, \theta + (2k+1)\pi)$ for some integer $k$.$BODY$,
    $BODY$$(r_1, \theta_1) = \left(\sqrt{8},\, \frac{7\pi}{6}\right)$; $(r_2, \theta_2) = \left(-\sqrt{8},\, -\frac{11\pi}{6}\right).$$BODY$,
    $BODY$Using $r = \sqrt{x^2 + y^2}$:
$$
r = \sqrt{(-\sqrt{6})^2 + (-\sqrt{2})^2} = \sqrt{8}
$$

Solving the system:
$$
\cos\theta = \frac{x}{r} = \frac{-\sqrt{6}}{\sqrt{8}} = -\frac{\sqrt{3}}{2}, \qquad \sin\theta = \frac{y}{r} = \frac{-\sqrt{2}}{\sqrt{8}} = -\frac{1}{2}
$$

This gives $\theta = \frac{7\pi}{6}$, which satisfies $0 \le \theta_1 \le 2\pi$. Therefore $(r_1, \theta_1) = \boxed{\left(\sqrt{8},\, \frac{7\pi}{6}\right)}$.

A point $(r, \theta)$ in polar form can be equivalently represented by $(r, \theta + 2k\pi)$ or $(-r, \theta + (2k+1)\pi)$ for $k \in \mathbb{Z}$. Choosing $r_2 = -r$ and $\theta_2 = \theta - 3\pi$:
$$
(r_2, \theta_2) = \left(-\sqrt{8},\, \frac{7\pi}{6} - 3\pi\right) = \boxed{\left(-\sqrt{8},\, -\frac{11\pi}{6}\right)} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q2b — Polar coordinates: circle equidistant from (1,2)
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d03',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Cartesian and Polar Equation of a Circle through the Origin',
    $BODY$Find the Cartesian and polar equation of the set of all points that includes the origin and that are all equidistant from $(1, 2).$$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    2,
    $BODY$The set of points equidistant from $(1,2)$ and including the origin describes a circle centered at $(1,2)$ with radius $\sqrt{5}$. Expand the Cartesian equation and substitute $x = r\cos\theta$, $y = r\sin\theta$ to get the polar form.$BODY$,
    $BODY$Cartesian: $(x-1)^2 + (y-2)^2 = 5$. Polar: $r = 2\cos\theta + 4\sin\theta$.$BODY$,
    $BODY$The set of points graph a circle centered at $(1, 2)$ touching the origin. The radius is
$$
r = \sqrt{(1-0)^2 + (2-0)^2} = \sqrt{5}
$$

The Cartesian equation is:
$$
\boxed{(x-1)^2 + (y-2)^2 = 5}
$$

To convert to polar, expand:
$$
x^2 - 2x + 1 + y^2 - 4y + 4 = 5 \iff x^2 + y^2 = 2x + 4y
$$

Substituting $x = r\cos\theta$, $y = r\sin\theta$, and $x^2 + y^2 = r^2$:
$$
r^2 = 2r\cos\theta + 4r\sin\theta \iff \boxed{r = 2\cos\theta + 4\sin\theta} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q3a — Limaçon symmetries
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d04',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Symmetries of the Limaçon $r = 2 + 2\\sin\\theta$',
    $BODY$Determine the symmetries of the limaçon $r = 2 + 2\sin\theta$.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    3,
    $BODY$Test for symmetry about the $\frac{\pi}{2}$-axis using $r(\pi - \theta) = r(\theta)$, about the polar axis using $r(-\theta) = r(\theta)$ or $-r(\pi - \theta) = r(\theta)$, and about the pole using $-r(\theta) = r(\theta)$ or $r(\theta + \pi) = r(\theta)$.$BODY$,
    $BODY$The curve is symmetric about the $\frac{\pi}{2}$-axis only.$BODY$,
    $BODY$The limaçon is of the form $r = a + b\sin\theta$.

**Symmetry about the $\frac{\pi}{2}$-axis:**
$$
r(\pi - \theta) = 2 + 2\sin(\pi - \theta) = 2 + 2\sin\theta = r(\theta) \quad \checkmark
$$

**Symmetry about the polar axis:**
$$
r(-\theta) = 2 - 2\sin\theta \neq r(\theta)
$$
$$
-r(\pi - \theta) = -2 - 2\sin\theta \neq r(\theta) \quad \times
$$

**Symmetry about the pole:**
$$
-r(\theta) = -2 - 2\sin\theta \neq r(\theta)
$$
$$
r(\theta + \pi) = 2 - 2\sin\theta \neq r(\theta) \quad \times
$$

The curve is $\boxed{\text{symmetric about the } \frac{\pi}{2}\text{-axis only.}}$ $\blacksquare$ $BODY$
  ),
  (
    -- Q3b — Limaçon horizontal tangents
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d05',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Horizontal Tangent Lines of $r = 2 + 2\\sin\\theta$',
    $BODY$Determine the points on the limaçon $r = 2 + 2\sin\theta$, away from the cusp at the pole, where the tangent lines are horizontal.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    3,
    $BODY$Compute $\frac{dy}{d\theta} = \sin\theta \frac{dr}{d\theta} + r\cos\theta$ and set it equal to zero. Solve for $\theta$, then exclude values where $\frac{dx}{d\theta} = 0$ (which would indicate the cusp at the pole).$BODY$,
    $BODY$$\left(4, \frac{\pi}{2}\right)$, $\left(1, \frac{7\pi}{6}\right)$, $\left(1, \frac{11\pi}{6}\right)$$BODY$,
    $BODY$With $r = 2 + 2\sin\theta$ and $\frac{dr}{d\theta} = 2\cos\theta$:
$$
\frac{dy}{d\theta} = \sin\theta(2\cos\theta) + (2 + 2\sin\theta)\cos\theta = 4\sin\theta\cos\theta + 2\cos\theta = \cos\theta(2\sin\theta + 1)
$$

Setting $\frac{dy}{d\theta} = 0$:
$$
\cos\theta = 0 \implies \theta = \frac{\pi}{2}, \frac{3\pi}{2}; \qquad \sin\theta = -\frac{1}{2} \implies \theta = \frac{7\pi}{6}, \frac{11\pi}{6}
$$

At $\theta = \frac{3\pi}{2}$: $\frac{dx}{d\theta} = \cos 2\theta - \sin\theta = \cos 3\pi - \sin\frac{3\pi}{2} = -1 + 1 = 0$. This corresponds to the cusp at the pole, so we exclude it.

The points with horizontal tangent lines are:
$$
\boxed{\left(4, \frac{\pi}{2}\right),\; \left(1, \frac{7\pi}{6}\right),\; \left(1, \frac{11\pi}{6}\right)} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q4a — Perimeter of union of C₁ and C₂
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d06',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Perimeter of the Union of a Cardioid and Circle',
    $BODY$Consider the union of the regions enclosed by $C_1: r = 3 - 3\sin\theta$ (cardioid) and $C_2: r = 3\sin\theta$ (circle). Set up the integrals giving the perimeter of this region.$BODY$,
    'hard',
    2023,
    'Sample 3rd Long Exam',
    4,
    $BODY$Find where $C_1$ and $C_2$ intersect by solving $3 - 3\sin\theta = 3\sin\theta$. Then use the arc length formula $L = \int_\alpha^\beta \sqrt{r^2 + (dr/d\theta)^2}\, d\theta$ for each curve over the appropriate intervals.$BODY$,
    $BODY$$\displaystyle L = \int_{\pi/6}^{5\pi/6} 3\, d\theta + \int_0^{\pi/6} \sqrt{(3-3\sin\theta)^2 + 9\cos^2\theta}\, d\theta + \int_{5\pi/6}^{2\pi} \sqrt{(3-3\sin\theta)^2 + 9\cos^2\theta}\, d\theta.$BODY$,
    $BODY$The curves intersect where $3 - 3\sin\theta = 3\sin\theta$, giving $\sin\theta = \frac{1}{2}$, so $\theta = \frac{\pi}{6}$ and $\theta = \frac{5\pi}{6}$.

Referring to the graph:
- $C_1$ traces the perimeter when $\theta \in \left[0, \frac{\pi}{6}\right] \cup \left[\frac{5\pi}{6}, 2\pi\right]$
- $C_2$ traces the perimeter when $\theta \in \left[\frac{\pi}{6}, \frac{5\pi}{6}\right]$

Using the arc length formula $L = \int_\alpha^\beta \sqrt{r^2 + (dr/d\theta)^2}\, d\theta$:

For $C_2$: $\frac{dr}{d\theta} = 3\cos\theta$, so $\sqrt{r^2 + (dr/d\theta)^2} = \sqrt{9\sin^2\theta + 9\cos^2\theta} = 3$.

For $C_1$: $\frac{dr}{d\theta} = -3\cos\theta$, so $\sqrt{r^2 + (dr/d\theta)^2} = \sqrt{(3-3\sin\theta)^2 + 9\cos^2\theta}$.

The perimeter is:
$$
\boxed{L = \int_{\pi/6}^{5\pi/6} 3\, d\theta + \int_0^{\pi/6} \sqrt{(3-3\sin\theta)^2 + 9\cos^2\theta}\, d\theta + \int_{5\pi/6}^{2\pi} \sqrt{(3-3\sin\theta)^2 + 9\cos^2\theta}\, d\theta} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q4b — Area of intersection of C₁ and C₃
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d07',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Area of Intersection of a Cardioid and Circle',
    $BODY$Consider the intersection of the regions enclosed by $C_1: r = 3 - 3\sin\theta$ (cardioid) and $C_3: r = 3\cos\theta$ (circle). Set up the integrals giving the area of this region.$BODY$,
    'hard',
    2023,
    'Sample 3rd Long Exam',
    4,
    $BODY$Find where $C_1$ and $C_3$ intersect. Use symmetry: the portion above the polar axis is swept by $C_1$ from $\theta = 0$ to $\pi/2$, and the portion below is swept by $C_3$ from $\theta = 0$ to $\pi/2$. Apply the polar area formula $A = \frac{1}{2}\int r^2\, d\theta$.$BODY$,
    $BODY$$\displaystyle A = \frac{1}{2}\int_0^{\pi/2} (3 - 3\sin\theta)^2\, d\theta + \frac{1}{2}\int_0^{\pi/2} (3\cos\theta)^2\, d\theta.$BODY$,
    $BODY$The curves intersect where $3 - 3\sin\theta = 3\cos\theta$, giving $\theta = 0$ and $\theta = \frac{\pi}{2}$.

The portion of the area above the polar axis is swept out by the limaçon $C_1$ as $\theta$ varies from $0$ to $\pi/2$. Meanwhile, by symmetry, the portion below the polar axis is equal to the area swept out by the circle $C_3$ as $\theta$ varies from $0$ to $\pi/2$.

Using the polar area formula $A = \frac{1}{2}\int r^2\, d\theta$:
$$
\boxed{A = \frac{1}{2}\int_0^{\pi/2} (3 - 3\sin\theta)^2\, d\theta + \frac{1}{2}\int_0^{\pi/2} (3\cos\theta)^2\, d\theta} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q5 — Sphere equation
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d08',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
    'Equation of a Sphere with Diameter Endpoints',
    $BODY$Find the equation of the sphere with a diameter having endpoints $P(1, 1, 3)$ and $Q(7, -5, -11).$$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    5,
    $BODY$The center is the midpoint of $PQ$ and the radius is half the distance $|PQ|$. Use the midpoint formula and distance formula in $\mathbb{R}^3$.$BODY$,
    $BODY$$\displaystyle (x - 4)^2 + (y + 2)^2 + (z + 4)^2 = 67.$BODY$,
    $BODY$The center $C$ is the midpoint of $PQ$:
$$
C = \left(\frac{1+7}{2}, \frac{1+(-5)}{2}, \frac{3+(-11)}{2}\right) = (4, -2, -4)
$$

The radius is half the distance $|PQ|$:
$$
r = \frac{1}{2}\sqrt{(1-7)^2 + (1-(-5))^2 + (3-(-11))^2} = \frac{1}{2}\sqrt{36 + 36 + 196} = \frac{1}{2}\sqrt{268} = \sqrt{67}
$$

The equation of the sphere is:
$$
\boxed{(x - 4)^2 + (y + 2)^2 + (z + 4)^2 = 67} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q6a — Cylinder sketch
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d09',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Cylinder Determined by $z = \\frac{1}{\\sqrt{y}} - 2$',
    $BODY$Sketch the cylinder in $\mathbb{R}^3$ determined by the equation $E: z = \dfrac{1}{\sqrt{y}} - 2.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    6,
    $BODY$Identify the directrix as the curve $z = 1/\sqrt{y} - 2$ in the $yz$-plane. Since $x$ is missing from the equation, the rulings are parallel to the $x$-axis. Plot the directrix and translate it along the $x$-axis, connecting corresponding points with rulings.$BODY$,
    $BODY$The directrix is $z = 1/\sqrt{y} - 2$ in the $yz$-plane, with rulings parallel to the $x$-axis. The cylinder is defined for $y > 0$ and $z > -2$.$BODY$,
    $BODY$The directrix of the cylinder is $E: z = 1/\sqrt{y} - 2$. Since the variable $x$ is missing from $E$, the rulings are parallel to the $x$-axis.

To sketch: plot the directrix $z = 1/\sqrt{y} - 2$ as a curve in the $yz$-plane (for $y > 0$, the curve starts near $z = -2$ for large $y$ and rises toward $+\infty$ as $y \to 0^+$). Then translate this curve along the $x$-axis and connect corresponding points with lines parallel to the $x$-axis.

The surface exists only for $y > 0$ and $z > -2$. $\blacksquare$ $BODY$
  ),
  (
    -- Q6b — Surface of revolution
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d10',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Surface of Revolution of $z = \\frac{1}{\\sqrt{y}} - 2$ about the $z$-axis',
    $BODY$Find the equation of the surface generated by the curve $E: z = \dfrac{1}{\sqrt{y}} - 2$ revolved about the $z$-axis. Sketch this surface of revolution.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    6,
    $BODY$Express the generating curve as $y = f(z) = \frac{1}{(z+2)^2}$ with $z > -2$. Then the surface of revolution about the $z$-axis has equation $x^2 + y^2 = [f(z)]^2$.$BODY$,
    $BODY$$\displaystyle x^2 + y^2 = \frac{1}{(z+2)^4}, \quad z > -2.$BODY$,
    $BODY$Since the axis of revolution is the $z$-axis, express the generating curve as a function of $z$:
$$
z = \frac{1}{\sqrt{y}} - 2 \iff y = f(z) = \frac{1}{(z+2)^2}, \quad z > -2
$$

The restriction $z > -2$ is necessary because $1/\sqrt{y} > 0$, so $z = 1/\sqrt{y} - 2 > -2$.

The equation for the surface of revolution is:
$$
x^2 + y^2 = [f(z)]^2 \iff \boxed{x^2 + y^2 = \frac{1}{(z+2)^4}, \quad z > -2}
$$

To sketch: plot the generating curve $z = 1/\sqrt{y} - 2$ in the $yz$-plane, then plot identical curves rotated $90°$, $180°$, and $270°$ about the $z$-axis. Connect corresponding points with circles centered on the $z$-axis. $\blacksquare$ $BODY$
  ),
  (
    -- Q7a — Quadric surface traces
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d11',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Traces of the Quadric Surface $\\frac{x^2}{4} - \\frac{(y-2)^2}{16} + \\frac{z^2}{9} = \\frac{3}{4}$',
    $BODY$Consider the quadric surface $\mathcal{S}$ with equation $\dfrac{x^2}{4} - \dfrac{(y-2)^2}{16} + \dfrac{z^2}{9} = \dfrac{3}{4}.$ Find the equation of the traces of $\mathcal{S}$ on the coordinate planes and on the planes $y = 2$ and $y = 4$. Identify each trace.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    7,
    $BODY$Substitute the equation of each plane into the surface equation. For example, on $y = 4$: $\frac{x^2}{4} - \frac{1}{4} + \frac{z^2}{9} = \frac{3}{4}$ gives $\frac{x^2}{4} + \frac{z^2}{9} = 1$ (ellipse). Identify each resulting equation.$BODY$,
    $BODY$On $x = 0$: hyperbola. On $y = 0$: ellipse $\frac{x^2}{4} + \frac{z^2}{9} = 1$. On $z = 0$: hyperbola. On $y = 2$: ellipse $\frac{x^2}{4} + \frac{z^2}{9} = \frac{3}{4}$. On $y = 4$: ellipse $\frac{x^2}{4} + \frac{z^2}{9} = 1$.$BODY$,
    $BODY$Substitute the equation of each plane into $\frac{x^2}{4} - \frac{(y-2)^2}{16} + \frac{z^2}{9} = \frac{3}{4}$:

| Plane | Trace | Type |
|---|---|---|
| $x = 0$ | $-\frac{(y-2)^2}{16} + \frac{z^2}{9} = \frac{3}{4}$ | Hyperbola |
| $y = 0$ | $\frac{x^2}{4} + \frac{z^2}{9} = 1$ | Ellipse |
| $z = 0$ | $\frac{x^2}{4} - \frac{(y-2)^2}{16} = \frac{3}{4}$ | Hyperbola |
| $y = 2$ | $\frac{x^2}{4} + \frac{z^2}{9} = \frac{3}{4}$ | Ellipse |
| $y = 4$ | $\frac{x^2}{4} + \frac{z^2}{9} = 1$ | Ellipse |

$\blacksquare$ $BODY$
  ),
  (
    -- Q7b — Identify quadric surface
    'c3c4d5e6-7f8a-4b9c-0d1e-2f3a4b5c6d12',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Identification of the Quadric Surface $\\frac{x^2}{4} - \\frac{(y-2)^2}{16} + \\frac{z^2}{9} = \\frac{3}{4}$',
    $BODY$Consider the quadric surface $\mathcal{S}$ with equation $\dfrac{x^2}{4} - \dfrac{(y-2)^2}{16} + \dfrac{z^2}{9} = \dfrac{3}{4}.$ Identify the surface $\mathcal{S}$ and sketch it using the traces.$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    7,
    $BODY$Rewrite the equation in the form $\frac{x^2}{a} - \frac{(y-2)^2}{b} + \frac{z^2}{c} = 1$ by dividing both sides by $\frac{3}{4}$. Two positive coefficients and one negative coefficient indicates a hyperboloid of one sheet.$BODY$,
    $BODY$$\mathcal{S}$ is a hyperboloid of one sheet.$BODY$,
    $BODY$Manipulate the equation:
$$
\frac{x^2}{4} - \frac{(y-2)^2}{16} + \frac{z^2}{9} = \frac{3}{4} \implies \frac{x^2}{3} - \frac{(y-2)^2}{12} + \frac{z^2}{27/4} = 1
$$

Since the equation has the form $\frac{x^2}{a} - \frac{(y-2)^2}{b} + \frac{z^2}{c} = 1$ with two positive coefficients and one negative coefficient, $\mathcal{S}$ is a $\boxed{\text{hyperboloid of one sheet}}$.

To sketch: plot the ellipse traces on the planes $y = 0$, $y = 2$, and $y = 4$. Then plot the hyperbola traces on the planes $x = 0$ and $z = 0$ by connecting the endpoints of the ellipses. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
