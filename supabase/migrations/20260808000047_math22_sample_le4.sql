-- ============================================================================
-- MATH 22 Elementary Analysis II — Sample 4th Long Exam, A.Y. 2023-2024
-- 13 cards (direction angles, projection, cross product, lines, planes,
--           curve intersection, domains, tangent lines, arc length).
--
-- Independent subitems have been split into separate question cards.
-- Q2 was commented out in the source and is omitted.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Direction angles
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e01',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Direction Angles of $\\vec{A} = \\langle \\sqrt{3}, -1, 0 \\rangle$',
    $BODY$Consider the vector $\vec{A} = \langle \sqrt{3}, -1, 0 \rangle$. Find the direction angles $\alpha$, $\beta$, and $\gamma$, the angles formed by the vector and the positive $x$-, $y$-, and $z$-axes respectively.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    1,
    $BODY$Use the formulas $\cos\alpha = \frac{a}{\|\vec{v}\|}$, $\cos\beta = \frac{b}{\|\vec{v}\|}$, $\cos\gamma = \frac{c}{\|\vec{v}\|}$ where $\vec{v} = \langle a, b, c \rangle$ and $\alpha, \beta, \gamma \in [0, \pi]$. Compute $\|\vec{A}\|$ first.$BODY$,
    $BODY$$\alpha = \frac{\pi}{6}$, $\beta = \frac{2\pi}{3}$, $\gamma = \frac{\pi}{2}$.$BODY$,
    $BODY$For a vector $\vec{v} = \langle a, b, c \rangle$, the direction angles satisfy:
$$
\cos\alpha = \frac{a}{\|\vec{v}\|}, \quad \cos\beta = \frac{b}{\|\vec{v}\|}, \quad \cos\gamma = \frac{c}{\|\vec{v}\|}, \quad \alpha, \beta, \gamma \in [0, \pi].
$$

First, compute the norm:
$$
\|\vec{A}\| = \sqrt{(\sqrt{3})^2 + (-1)^2 + 0^2} = \sqrt{3 + 1 + 0} = \sqrt{4} = 2.
$$

Using the formulas:
$$
\alpha = \cos^{-1}\!\left(\frac{\sqrt{3}}{2}\right) = \frac{\pi}{6}, \qquad
\beta = \cos^{-1}\!\left(\frac{-1}{2}\right) = \frac{2\pi}{3}, \qquad
\gamma = \cos^{-1}\!\left(\frac{0}{2}\right) = \frac{\pi}{2}.
$$

$$
\boxed{\alpha = \frac{\pi}{6}, \quad \beta = \frac{2\pi}{3}, \quad \gamma = \frac{\pi}{2}} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q3 — Projection
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e02',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Projection of $\\vec{u}$ onto $\\vec{v}$',
    $BODY$Let $\vec{u} = \langle 4, -1, 0 \rangle$ and $\vec{v} = \langle -3, 2, -1 \rangle$. Find $\operatorname{proj}_{\vec{v}} \vec{u}$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    3,
    $BODY$Use the formula $\operatorname{proj}_{\vec{v}} \vec{u} = \frac{\vec{u} \cdot \vec{v}}{\|\vec{v}\|^2} \vec{v}$.$BODY$,
    $BODY$$\operatorname{proj}_{\vec{v}} \vec{u} = \langle 3, -2, 1 \rangle$.$BODY$,
    $BODY$The formula for the projection of $\vec{u}$ onto $\vec{v}$ is:
$$
\operatorname{proj}_{\vec{v}} \vec{u} = \frac{\vec{u} \cdot \vec{v}}{\|\vec{v}\|^2} \vec{v}
$$

Compute the dot product and norm:
$$
\vec{u} \cdot \vec{v} = (4)(-3) + (-1)(2) + (0)(-1) = -12 - 2 + 0 = -14
$$
$$
\|\vec{v}\|^2 = (-3)^2 + 2^2 + (-1)^2 = 9 + 4 + 1 = 14
$$

Therefore:
$$
\operatorname{proj}_{\vec{v}} \vec{u} = \frac{-14}{14} \langle -3, 2, -1 \rangle = (-1)\langle -3, 2, -1 \rangle = \boxed{\langle 3, -2, 1 \rangle} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q4 — Parallelogram area
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e03',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Area of Parallelogram from Cross Product',
    $BODY$Consider the points $A(-2, 6, 1)$, $B(2, -3, 4)$, and $C(2, 0, 2)$ and the parallelogram with $\overline{AB}$ and $\overline{AC}$ as adjacent sides. Find the area of the parallelogram.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    4,
    $BODY$Compute the vectors $\vec{AB}$ and $\vec{AC}$, then find $\|\vec{AB} \times \vec{AC}\|$. The area of the parallelogram equals the magnitude of the cross product of two adjacent side vectors.$BODY$,
    $BODY$$\text{Area} = 17$.$BODY$,
    $BODY$Compute the vectors:
$$
\vec{AB} = \langle 2-(-2), -3-6, 4-1 \rangle = \langle 4, -9, 3 \rangle
$$
$$
\vec{AC} = \langle 2-(-2), 0-6, 2-1 \rangle = \langle 4, -6, 1 \rangle
$$

The area of the parallelogram is $\|\vec{AB} \times \vec{AC}\|$:
$$
\vec{AB} \times \vec{AC} = \begin{vmatrix} \hat{i} & \hat{j} & \hat{k} \\ 4 & -9 & 3 \\ 4 & -6 & 1 \end{vmatrix}
$$

$$
= \langle (-9)(1) - (3)(-6),\; -((4)(1) - (3)(4)),\; (4)(-6) - (-9)(4) \rangle
$$

$$
= \langle -9 + 18,\; -(4 - 12),\; -24 + 36 \rangle = \langle 9, 8, 12 \rangle
$$

$$
\text{Area} = \|\langle 9, 8, 12 \rangle\| = \sqrt{81 + 64 + 144} = \sqrt{289} = \boxed{17} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q5 — Line equations
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e04',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Parametric and Symmetric Equations of a Line',
    $BODY$Find parametric and symmetric equations of the line that passes through points $A(1, -1, -9)$ and $B(4, 7, -1)$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    5,
    $BODY$Compute the direction vector $\vec{AB}$. Use point $A$ with this direction vector for the parametric equations. Isolate $t$ in each parametric equation to obtain the symmetric equations.$BODY$,
    $BODY$Parametric: $x = 1 + 3t$, $y = -1 + 8t$, $z = -9 + 8t$. Symmetric: $\frac{x-1}{3} = \frac{y+1}{8} = \frac{z+9}{8}$.$BODY$,
    $BODY$Compute the direction vector from $A$ to $B$:
$$
\vec{AB} = \langle 4-1,\; 7-(-1),\; -1-(-9) \rangle = \langle 3, 8, 8 \rangle
$$

Using point $A(1, -1, -9)$ and the direction vector, the parametric equations are:
$$
x = 1 + 3t, \quad y = -1 + 8t, \quad z = -9 + 8t
$$

Isolating $t$ in each equation gives the symmetric equations:
$$
\boxed{\frac{x-1}{3} = \frac{y+1}{8} = \frac{z+9}{8}}
$$

Note: Using point $B(4, 7, -1)$ yields equivalent equations $x = 4 + 3t$, $y = 7 + 8t$, $z = -1 + 8t$ with symmetric form $\frac{x-4}{3} = \frac{y-7}{8} = \frac{z+1}{8}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q6 — Perpendicular planes
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e05',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Perpendicular Planes and Their Line of Intersection',
    $BODY$Find value(s) of $k$ such that the planes $\pi_1: 2kx + y + 5z + 11 = 0$ and $\pi_2: kx - ky - 3z - 3 = 0$ are perpendicular. Provide a possible equation for their intersection when $k > 0$.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    6,
    $BODY$Two planes are perpendicular when their normal vectors have dot product zero. Compute $\vec{n}_1 \cdot \vec{n}_2$ and solve for $k$. For $k > 0$, solve the system of two plane equations to find two points on the line of intersection, then write the parametric equations.$BODY$,
    $BODY$$k = -\frac{5}{2}$ or $k = 3$. For $k = 3$: $x = -2 - 4t$, $y = -4 - 11t$, $z = 1 + 7t$.$BODY$,
    $BODY$Let $\vec{n}_1 = \langle 2k, 1, 5 \rangle$ and $\vec{n}_2 = \langle k, -k, -3 \rangle$. For perpendicularity:
$$
\vec{n}_1 \cdot \vec{n}_2 = 2k^2 - k - 15 = 0
$$

Solving: $(2k + 5)(k - 3) = 0$, so $\boxed{k = -\frac{5}{2} \text{ or } k = 3}$.

For $k = 3$: $\pi_1: 6x + y + 5z + 11 = 0$ and $\pi_2: x - y - z - 1 = 0$.

Adding the equations: $7x + 4z + 10 = 0$, so $x = -\frac{4z + 10}{7}$. Substituting back: $y = -\frac{11z + 17}{7}$.

Let $z = 1$: $x = -2$, $y = -4$, giving point $C(-2, -4, 1)$.
Let $z = 8$: $x = -6$, $y = -15$, giving point $D(-6, -15, 8)$.

Direction vector: $\vec{CD} = \langle -4, -11, 7 \rangle$.

The line of intersection is:
$$
\boxed{x = -2 - 4t, \quad y = -4 - 11t, \quad z = 1 + 7t} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q7 — Curve of intersection
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e06',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Parametric Equations of Curve of Intersection',
    $BODY$Find the parametric equations of the curve of intersection of the elliptic cylinder $4x^2 + 25z^2 = 100$ and the plane $x - 2y + 3z = 6$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    7,
    $BODY$Parametrize the ellipse $\frac{x^2}{25} + \frac{z^2}{4} = 1$ as $x = 5\cos t$, $z = 2\sin t$. Then solve for $y$ from the plane equation and substitute.$BODY$,
    $BODY$$x(t) = 5\cos t$, $y(t) = \frac{5\cos t}{2} + 3\sin t - 3$, $z(t) = 2\sin t$.$BODY$,
    $BODY$Divide the cylinder equation by 100:
$$
\frac{x^2}{25} + \frac{z^2}{4} = 1
$$

This is an ellipse, parametrized as:
$$
x(t) = 5\cos t, \qquad z(t) = 2\sin t
$$

From the plane equation, solve for $y$:
$$
y = \frac{x}{2} + \frac{3z}{2} - 3
$$

Substituting:
$$
y(t) = \frac{5\cos t}{2} + \frac{3(2\sin t)}{2} - 3 = \frac{5\cos t}{2} + 3\sin t - 3
$$

The parametric equations are:
$$
\boxed{x(t) = 5\cos t, \quad y(t) = \frac{5\cos t}{2} + 3\sin t - 3, \quad z(t) = 2\sin t} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q8a — Domain of R(t)
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e07',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Domain of $\\vec{R}(t) = \\frac{e^{-t/2} + 3t}{t^2 - 36}\\hat{i} + \\frac{\\sqrt{t^2 - 4}}{t + 10}\\hat{j}$',
    $BODY$Find the domain of the vector-valued function
$$
\vec{R}(t) = \frac{e^{-t/2} + 3t}{t^2 - 36}\,\hat{i} + \frac{\sqrt{t^2 - 4}}{t + 10}\,\hat{j}.
$$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    8,
    $BODY$For the $x$-component, the denominator $t^2 - 36 \neq 0$. For the $y$-component, require $t^2 - 4 \geq 0$ and $t + 10 \neq 0$. Take the intersection of both domains.$BODY$,
    $BODY$$\operatorname{dom} \vec{R} = (-\infty, -10) \cup (-10, -6) \cup (-6, -2] \cup [2, 6) \cup (6, \infty)$.$BODY$,
    $BODY$For the $x$-component: $t^2 - 36 \neq 0 \implies t \neq \pm 6$. So $\operatorname{dom} x = \mathbb{R} \setminus \{-6, 6\}$.

For the $y$-component: $t^2 - 4 \geq 0 \implies t \leq -2$ or $t \geq 2$, and $t + 10 \neq 0 \implies t \neq -10$. So $\operatorname{dom} y = (-\infty, -10) \cup (-10, -2] \cup [2, \infty)$.

Taking the intersection:
$$
\boxed{\operatorname{dom} \vec{R} = (-\infty, -10) \cup (-10, -6) \cup (-6, -2] \cup [2, 6) \cup (6, \infty)} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q8b — Domain of S(t)
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e08',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Domain of $\\vec{S}(t) = \\left\\langle \\frac{\\ln(5t)}{t^2},\\, \\cos(2t+1) + 3t^2,\\, \\frac{t^2 + 5}{\\sqrt{49 - t^2}} \\right\\rangle$',
    $BODY$Find the domain of the vector-valued function
$$
\vec{S}(t) = \left\langle \frac{\ln(5t)}{t^2},\; \cos(2t + 1) + 3t^2,\; \frac{t^2 + 5}{\sqrt{49 - t^2}} \right\rangle.
$$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    8,
    $BODY$For the $x$-component, require $5t > 0$. The $y$-component is defined for all $t$. For the $z$-component, require $49 - t^2 > 0$. Take the intersection.$BODY$,
    $BODY$$\operatorname{dom} \vec{S} = (0, 7)$.$BODY$,
    $BODY$For the $x$-component: $\ln(5t)$ requires $5t > 0 \implies t > 0$. So $\operatorname{dom} x = (0, \infty)$.

For the $y$-component: $\cos(2t+1) + 3t^2$ is defined for all $t \in \mathbb{R}$. So $\operatorname{dom} y = \mathbb{R}$.

For the $z$-component: $\sqrt{49 - t^2}$ requires $49 - t^2 > 0 \implies t^2 < 49 \implies -7 < t < 7$. So $\operatorname{dom} z = (-7, 7)$.

Taking the intersection:
$$
\boxed{\operatorname{dom} \vec{S} = (0, 7)} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q9a — Tangent line to vector curve
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e09',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Tangent Line to $\\vec{F}(t) = \\langle e^{3-2t}, -\\sin(\\pi t), 1 + t^2 \\rangle$',
    $BODY$Let $\vec{F}(t) = \langle e^{3-2t}, -\sin(\pi t), 1 + t^2 \rangle$. Find a vector equation of the tangent line to the graph of $\vec{F}$ at $(e, 0, 2)$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    9,
    $BODY$First find the value of $t$ at the point $(e, 0, 2)$. Then compute $\vec{F}'(t)$ and evaluate at that $t$. The tangent line is $\vec{R}(t) = \vec{F}(t_0) + t\,\vec{F}'(t_0)$.$BODY$,
    $BODY$$\vec{R}(t) = \langle e - 2et,\; \pi t,\; 2 + 2t \rangle$.$BODY$,
    $BODY$Find $t$ at $(e, 0, 2)$: $e^{3-2t} = e^1 \implies t = 1$. Check: $-\sin(\pi) = 0$ ✓, $1 + 1 = 2$ ✓.

Compute the derivative:
$$
\vec{F}'(t) = \langle -2e^{3-2t},\; -\pi\cos(\pi t),\; 2t \rangle
$$

Evaluate at $t = 1$:
$$
\vec{F}'(1) = \langle -2e,\; \pi,\; 2 \rangle
$$

The tangent line is:
$$
\boxed{\vec{R}(t) = \langle e, 0, 2 \rangle + t\langle -2e, \pi, 2 \rangle = \langle e - 2et,\; \pi t,\; 2 + 2t \rangle} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q9b — Derivative of cross product
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e10',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Derivative of Cross Product $(\\vec{G} \\times \\vec{G}'')(1)$',
    $BODY$Let $\vec{G}(1) = \langle -2, 1, -1 \rangle$, $\vec{G}'(1) = \langle 3, -2, 2 \rangle$, and $\vec{G}''(1) = \langle 0, -1, 1 \rangle$. Evaluate $(\vec{G} \times \vec{G}')'(1)$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    9,
    $BODY$Apply the product rule for cross products: $(\vec{G} \times \vec{G}')' = \vec{G}' \times \vec{G}' + \vec{G} \times \vec{G}''$. Note that $\vec{G}' \times \vec{G}' = \vec{0}$.$BODY$,
    $BODY$$(\vec{G} \times \vec{G}')'(1) = \langle 0, 2, 2 \rangle$.$BODY$,
    $BODY$By the product rule for cross products:
$$
(\vec{G} \times \vec{G}')' = \vec{G}' \times \vec{G}' + \vec{G} \times \vec{G}''
$$

Since $\vec{G}' \times \vec{G}' = \vec{0}$ (any vector crossed with itself is zero):
$$
(\vec{G} \times \vec{G}')'(1) = \vec{G}(1) \times \vec{G}''(1) = \langle -2, 1, -1 \rangle \times \langle 0, -1, 1 \rangle
$$

$$
= \begin{vmatrix} \hat{i} & \hat{j} & \hat{k} \\ -2 & 1 & -1 \\ 0 & -1 & 1 \end{vmatrix} = \langle (1)(1) - (-1)(-1),\; -((-2)(1) - (-1)(0)),\; (-2)(-1) - (1)(0) \rangle
$$

$$
= \langle 1 - 1,\; -(-2),\; 2 \rangle = \boxed{\langle 0, 2, 2 \rangle} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q10 — Normal plane
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e11',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Normal Plane to a Space Curve',
    $BODY$Given a curve $C$ defined by $\vec{R}$ with $\vec{R}(1) = \langle -1, 4, 3 \rangle$, the unit binormal vector $\vec{B}(1) = \left\langle \frac{1}{3}, \frac{2}{3}, \frac{2}{3} \right\rangle$, and $\vec{T}'(1) = 2\hat{i} - \hat{j}$, find the equation of the normal plane to $C$ at $t = 1$.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    10,
    $BODY$The normal plane uses $\vec{T}$ as its normal vector. Find $\vec{N}(1) = \vec{T}'(1)/\|\vec{T}'(1)\|$, then compute $\vec{T}(1) = \vec{N}(1) \times \vec{B}(1)$. Use the point-normal form with $\vec{R}(1)$.$BODY$,
    $BODY$$-\frac{2}{3\sqrt{5}}(x + 1) - \frac{4}{3\sqrt{5}}(y - 4) + \frac{5}{3\sqrt{5}}(z - 3) = 0$.$BODY$,
    $BODY$The normal plane uses $\vec{T}$ as its normal vector. First find $\vec{N}(1)$:
$$
\vec{N}(1) = \frac{\vec{T}'(1)}{\|\vec{T}'(1)\|} = \frac{\langle 2, -1, 0 \rangle}{\sqrt{5}} = \left\langle \frac{2}{\sqrt{5}}, -\frac{1}{\sqrt{5}}, 0 \right\rangle
$$

Then compute $\vec{T}(1) = \vec{N}(1) \times \vec{B}(1)$:
$$
\vec{T}(1) = \left\langle \frac{2}{\sqrt{5}}, -\frac{1}{\sqrt{5}}, 0 \right\rangle \times \left\langle \frac{1}{3}, \frac{2}{3}, \frac{2}{3} \right\rangle = \left\langle -\frac{2}{3\sqrt{5}}, -\frac{4}{3\sqrt{5}}, \frac{5}{3\sqrt{5}} \right\rangle
$$

Using point $(-1, 4, 3)$ and normal $\vec{T}(1)$:
$$
\boxed{-\frac{2}{3\sqrt{5}}(x + 1) - \frac{4}{3\sqrt{5}}(y - 4) + \frac{5}{3\sqrt{5}}(z - 3) = 0} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q11 — Position and acceleration
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e12',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Position and Acceleration from Velocity',
    $BODY$The velocity at any time $t \geq 0$ of a particle moving in space is $\vec{v}(t) = \langle 7t, 2, t^2 + 1 \rangle$. Determine the position and acceleration vectors at any time $t \geq 0$, if the particle starts at $P(2, -1, 0)$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    11,
    $BODY$Differentiate $\vec{v}(t)$ to get $\vec{a}(t)$. Integrate $\vec{v}(t)$ to get $\vec{r}(t)$, then use $\vec{r}(0) = \langle 2, -1, 0 \rangle$ to find the constants of integration.$BODY$,
    $BODY$$\vec{a}(t) = \langle 7, 0, 2t \rangle$; $\vec{r}(t) = \left\langle \frac{7t^2}{2} + 2,\; 2t - 1,\; \frac{t^3}{3} + t \right\rangle$.$BODY$,
    $BODY$Acceleration is the derivative of velocity:
$$
\vec{a}(t) = \vec{v}'(t) = \boxed{\langle 7, 0, 2t \rangle}
$$

Position is the integral of velocity:
$$
\vec{r}(t) = \int \vec{v}(t)\, dt = \left\langle \frac{7t^2}{2} + C_1,\; 2t + C_2,\; \frac{t^3}{3} + t + C_3 \right\rangle
$$

Using $\vec{r}(0) = \langle 2, -1, 0 \rangle$: $C_1 = 2$, $C_2 = -1$, $C_3 = 0$.

$$
\vec{r}(t) = \boxed{\left\langle \frac{7t^2}{2} + 2,\; 2t - 1,\; \frac{t^3}{3} + t \right\rangle} \;\blacksquare
$$ $BODY$
  ),
  (
    -- Q12 — Arc length parametrization
    'd4d5e6f7-8a9b-4c0d-1e2f-3a4b5c6d7e13',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Arc Length Parametrization of $\\vec{R}(t) = \\left\\langle \\cos(t^2), \\sin(t^2), \\frac{3\\sqrt{5}\\,t^2}{2} + \\frac{\\sqrt{2}\\pi}{3} \\right\\rangle$',
    $BODY$Consider the curve defined by $\vec{R}(t) = \left\langle \cos(t^2),\, \sin(t^2),\, \dfrac{3\sqrt{5}\,t^2}{2} + \dfrac{\sqrt{2}\pi}{3} \right\rangle$ for $t \geq 0$. Express $\vec{R}$ in terms of the arc length parameter $s$ from the point $P\!\left(1, 0, \dfrac{\sqrt{2}\pi}{3}\right)$.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    12,
    $BODY$Find the value of $t$ at $P$ (it is $t = 0$). Compute $\|\vec{R}'(t)\|$, then integrate to get $s(t)$. Solve for $t$ in terms of $s$ and substitute back into $\vec{R}(t)$.$BODY$,
    $BODY$$\vec{R}^*(s) = \left\langle \cos\!\left(\frac{2s}{7}\right),\, \sin\!\left(\frac{2s}{7}\right),\, \frac{3\sqrt{5}\,s}{7} + \frac{\sqrt{2}\pi}{3} \right\rangle$.$BODY$,
    $BODY$At $P$: $\frac{3\sqrt{5}\,t^2}{2} + \frac{\sqrt{2}\pi}{3} = \frac{\sqrt{2}\pi}{3} \implies t = 0$.

Compute the derivative and its magnitude:
$$
\vec{R}'(t) = \langle -2t\sin(t^2),\; 2t\cos(t^2),\; 3\sqrt{5}\,t \rangle
$$
$$
\|\vec{R}'(t)\| = \sqrt{4t^2\sin^2(t^2) + 4t^2\cos^2(t^2) + 45t^2} = \sqrt{4t^2 + 45t^2} = \sqrt{49t^2} = 7t \quad (t \geq 0)
$$

Arc length from $t = 0$:
$$
s = \int_0^t 7u\, du = \frac{7}{2}t^2 \implies t = \sqrt{\frac{2s}{7}}
$$

Substituting into $\vec{R}(t)$:
$$
\boxed{\vec{R}^*(s) = \left\langle \cos\!\left(\frac{2s}{7}\right),\; \sin\!\left(\frac{2s}{7}\right),\; \frac{3\sqrt{5}\,s}{7} + \frac{\sqrt{2}\pi}{3} \right\rangle} \;\blacksquare
$$ $BODY$
  )
on conflict (id) do nothing;
