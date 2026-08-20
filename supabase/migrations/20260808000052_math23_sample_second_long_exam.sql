-- ============================================================================
-- Math 23 Elementary Analysis III — Sample 2nd Long Exam, A.Y. 2023-2024
-- 7 problems (critical points, Lagrange multipliers, parametric surfaces,
-- double integrals, change of order, surface area).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced:
--   • Optimization and Lagrange Multipliers
--   • Multiple Integrals
--   • Vector-Valued Functions and Parametric Surfaces
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c08',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Optimization and Lagrange Multipliers',
    'Relative and absolute extrema, critical points, and constrained optimization using Lagrange multipliers.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c09',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Multiple Integrals',
    'Double integrals in rectangular and polar coordinates, change of order of integration, and applications.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0a',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Vector-Valued Functions and Parametric Surfaces',
    'Parametric surfaces, surface integrals, and surface area.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Critical points and classification
    'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e01',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Critical Points and Classification of $f(x,y) = x^3 + y^3 - xy$',
    $BODY$Let $f(x,y)=x^3+y^3-xy$. Find all critical point(s) of $f$ and classify each point as a saddle point, a relative minimum point, or a relative maximum point.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    1,
    $BODY$Set $f_x = 3x^2 - y = 0$ and $f_y = 3y^2 - x = 0$. Solve the system by substitution. Then apply the second derivative test with $D = f_{xx}f_{yy} - (f_{xy})^2$.$BODY$,
    $BODY$Saddle point at $(0, 0)$; relative minimum at $\left(\frac{1}{3}, \frac{1}{3}\right)$.$BODY$,
    $BODY$Set up the system $f_x = 3x^2 - y = 0$ and $f_y = 3y^2 - x = 0$.

From $f_x = 0$: $y = 3x^2$. Substituting into $f_y = 0$: $3(3x^2)^2 - x = 0 \implies 27x^4 - x = 0 \implies x(27x^3 - 1) = 0$.

So $x = 0$ or $x = \frac{1}{3}$.

- If $x = 0$: $y = 0$. Critical point: $(0, 0)$.
- If $x = \frac{1}{3}$: $y = 3\left(\frac{1}{3}\right)^2 = \frac{1}{3}$. Critical point: $\left(\frac{1}{3}, \frac{1}{3}\right)$.

Compute second-order partials: $f_{xx} = 6x$, $f_{yy} = 6y$, $f_{xy} = -1$.

$$\begin{array}{|c||c|c|c|c|c|}
\hline
(x_0, y_0) & f_{xx} & f_{yy} & f_{xy} & D & \text{Conclusion} \\
\hline
(0, 0) & 0 & 0 & -1 & -1 & \text{saddle point} \\
\hline
\left(\frac{1}{3}, \frac{1}{3}\right) & 2 & 2 & -1 & 3 & \text{relative minimum} \\
\hline
\end{array}$$

$f$ has a saddle point at $(0, 0)$ and a relative minimum at $\left(\frac{1}{3}, \frac{1}{3}\right)$. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Lagrange multipliers
    'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e02',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c08',
    'Absolute Extrema of $f(x,y) = x^2y$ on the Ellipse $2x^2 + 4y^2 = 9$',
    $BODY$Find the points on the ellipse $2x^2+ 4y^2 = 9$ where $f(x,y)=x^2y$ has an absolute maximum or minimum.$BODY$,
    'hard',
    2023,
    'Sample 2nd Long Exam',
    2,
    $BODY$Use Lagrange multipliers with $g(x,y) = 2x^2 + 4y^2 = 9$. Solve $\nabla f = \lambda \nabla g$ together with the constraint. Evaluate $f$ at all candidate points to determine absolute extrema.$BODY$,
    $BODY$Absolute maximum at $\left(\pm\sqrt{3}, \frac{\sqrt{3}}{2}\right)$ with value $\frac{3\sqrt{3}}{2}$. Absolute minimum at $\left(\pm\sqrt{3}, -\frac{\sqrt{3}}{2}\right)$ with value $-\frac{3\sqrt{3}}{2}$.$BODY$,
    $BODY$Let $g(x,y) = 2x^2 + 4y^2 = 9$. We solve $\nabla f = \lambda \nabla g$:

$$\begin{cases} 2xy = 4x\lambda & (1) \\ x^2 = 8y\lambda & (2) \\ 2x^2 + 4y^2 = 9 & (3) \end{cases}$$

From (1): $2x(y - 2\lambda) = 0$, so $x = 0$ or $y = 2\lambda$.

**Case 1: $y = 2\lambda$.** From (2): $x^2 = 16\lambda^2 \implies x = \pm 4\lambda$. Substituting into (3):

$$32\lambda^2 + 16\lambda^2 = 9 \implies \lambda^2 = \frac{9}{48} \implies \lambda = \pm\frac{\sqrt{3}}{4}.$$

- $\lambda = \frac{\sqrt{3}}{4}$: $x = \pm\sqrt{3}$, $y = \frac{\sqrt{3}}{2}$.
- $\lambda = -\frac{\sqrt{3}}{4}$: $x = \mp\sqrt{3}$, $y = -\frac{\sqrt{3}}{2}$.

**Case 2: $x = 0$.** From (3): $4y^2 = 9 \implies y = \pm\frac{3}{2}$.

Evaluate $f(x,y) = x^2 y$ at all candidates:

$$\begin{array}{|c|c|}
\hline
(x_0, y_0) & f(x_0, y_0) \\
\hline
\left(\pm\sqrt{3}, \frac{\sqrt{3}}{2}\right) & \frac{3\sqrt{3}}{2} \\
\hline
\left(\pm\sqrt{3}, -\frac{\sqrt{3}}{2}\right) & -\frac{3\sqrt{3}}{2} \\
\hline
\left(0, \pm\frac{3}{2}\right) & 0 \\
\hline
\end{array}$$

Absolute maximum at $\left(\pm\sqrt{3}, \frac{\sqrt{3}}{2}\right)$; absolute minimum at $\left(\pm\sqrt{3}, -\frac{\sqrt{3}}{2}\right)$. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Parametric surface
    'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e03',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0a',
    'Parametric Surface: Cartesian Equation and Normal Line',
    $BODY$Let $S$ be the parametric surface with vector equation $\vec{R}(u,v)=\langle u-2v+3,\, u+2v,\, 2v-3u\rangle$.

**(a)** Give a corresponding Cartesian equation for $S$.

**(b)** Find a vector equation of the normal line to $S$ at the point corresponding to $u=1$ and $v=-1$.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    3,
    $BODY$For (a), solve the parametric equations for $u$ and $v$ in terms of $x$, $y$, $z$ using two of the equations, then substitute into the third. For (b), compute $\vec{R}_u \times \vec{R}_v$ at the given point to get the normal vector, and evaluate $\vec{R}(1,-1)$ for the point.$BODY$,
    $BODY$**(a)** $x = \frac{-y - z + 6}{2}$, or equivalently $2x + y + z = 6$.

**(b)** $\vec{L}(t) = \langle 6 + 8t,\, -1 + 4t,\, -5 + 4t \rangle$.$BODY$,
    $BODY$**(a)** The parametric equations are

$$x = u - 2v + 3, \qquad y = u + 2v, \qquad z = 2v - 3u.$$

From (2) and (3): $y - z = (u + 2v) - (2v - 3u) = 4u$, so $u = \frac{y - z}{4}$.

From (3): $2v = z + 3u = z + \frac{3(y-z)}{4} = \frac{z + 3y}{4}$, so $v = \frac{z + 3y}{8}$.

Substituting into (1):

$$x = \frac{y-z}{4} - 2\cdot\frac{z+3y}{8} + 3 = \frac{y-z}{4} - \frac{z+3y}{4} + 3 = \frac{-2y - 2z + 12}{4} = \frac{-y - z + 6}{2}.$$

The Cartesian equation is $x = \frac{-y - z + 6}{2}$, or equivalently $2x + y + z = 6$. $\blacksquare$

---

**(b)** Compute the partial derivatives:

$$\vec{R}_u(u,v) = \langle 1, 1, -3 \rangle, \qquad \vec{R}_v(u,v) = \langle -2, 2, 2 \rangle.$$

The normal vector is

$$\vec{N} = \vec{R}_u \times \vec{R}_v = \begin{vmatrix} \mathbf{i} & \mathbf{j} & \mathbf{k} \\ 1 & 1 & -3 \\ -2 & 2 & 2 \end{vmatrix} = \langle 2+6,\; -(2-6),\; 2+2 \rangle = \langle 8, 4, 4 \rangle.$$

The point at $u = 1$, $v = -1$:

$$\vec{R}(1,-1) = \langle 1+2+3,\; 1-2,\; -2-3 \rangle = \langle 6, -1, -5 \rangle.$$

The normal line is

$$\boxed{\vec{L}(t) = \langle 6 + 8t,\; -1 + 4t,\; -5 + 4t \rangle.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Double integral (volume)
    'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e04',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c09',
    'Volume Under $z = e^{3x}\sec^2 y$ Over a Square Region',
    $BODY$Find the volume of the solid under the surface $z= e^{3x}\sec^2{y}$ that lies above the region $R=\left[-\frac{\pi}{4},\frac{\pi}{4}\right]\times\left[-\frac{\pi}{4},\frac{\pi}{4}\right]$.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    4,
    $BODY$Set up the double integral $\iint_R e^{3x}\sec^2 y\, dA$. Since the integrand is a product of a function of $x$ and a function of $y$, and the region is rectangular, separate into iterated integrals.$BODY$,
    $BODY$\frac{2}{3}\left(e^{3\pi/4} - e^{-3\pi/4}\right)$.$BODY$,
    $BODY$The volume is given by

$$V = \iint_R e^{3x}\sec^2 y\, dA = \int_{-\pi/4}^{\pi/4}\int_{-\pi/4}^{\pi/4} e^{3x}\sec^2 y\, dy\, dx.$$

Since the integrand factors and the region is rectangular, we separate:

$$V = \left(\int_{-\pi/4}^{\pi/4} e^{3x}\, dx\right)\left(\int_{-\pi/4}^{\pi/4} \sec^2 y\, dy\right).$$

Evaluate each integral:

$$\int_{-\pi/4}^{\pi/4} e^{3x}\, dx = \frac{1}{3}e^{3x}\bigg|_{-\pi/4}^{\pi/4} = \frac{1}{3}\left(e^{3\pi/4} - e^{-3\pi/4}\right).$$

$$\int_{-\pi/4}^{\pi/4} \sec^2 y\, dy = \tan y\bigg|_{-\pi/4}^{\pi/4} = \tan\frac{\pi}{4} - \tan\left(-\frac{\pi}{4}\right) = 1 - (-1) = 2.$$

Therefore

$$V = \frac{2}{3}\left(e^{3\pi/4} - e^{-3\pi/4}\right). \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — Double integral in rectangular and polar
    'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e05',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c09',
    'Evaluating $\iint_R xy\, dA$ in Rectangular and Polar Coordinates',
    $BODY$Let $R$ be the region in the first quadrant enclosed by $x^2 + (y-1)^2 = 1$ and $x^2 + y^2 = 9$. Evaluate $\iint_R xy\, dA$

**(a)** using rectangular coordinates, and

**(b)** using polar coordinates.$BODY$,
    'hard',
    2023,
    'Sample 2nd Long Exam',
    5,
    $BODY$For (a), split $R$ into two type II subregions: $R_1$ between $y = 0$ and $y = 2$ (between the two curves), and $R_2$ between $y = 2$ and $y = 3$ (between $x = 0$ and the circle). For (b), convert curves to polar: $r = 2\sin\theta$ and $r = 3$, then integrate with $0 \leq \theta \leq \frac{\pi}{2}$.$BODY$,
    $BODY$\frac{227}{24}$ (both methods agree).$BODY$,
    $BODY$**(a)** Split $R$ into two type II subregions. $R_1$: $0 \leq y \leq 2$, from $x = \sqrt{1 - (1-y)^2}$ to $x = \sqrt{9 - y^2}$. $R_2$: $2 \leq y \leq 3$, from $x = 0$ to $x = \sqrt{9 - y^2}$.

$$\iint_{R_1} xy\, dA = \int_0^2 \int_{\sqrt{1-(1-y)^2}}^{\sqrt{9-y^2}} xy\, dx\, dy = \int_0^2 \frac{y}{2}\left[(9-y^2) - (1-(1-y)^2)\right] dy = \int_0^2 \left(-y^2 + \frac{9y}{2}\right) dy = \frac{19}{3}.$$

$$\iint_{R_2} xy\, dA = \int_2^3 \int_0^{\sqrt{9-y^2}} xy\, dx\, dy = \int_2^3 \frac{y(9-y^2)}{2}\, dy = \int_2^3 \left(-\frac{y^3}{2} + \frac{9y}{2}\right) dy = \frac{25}{8}.$$

$$\iint_R xy\, dA = \frac{19}{3} + \frac{25}{8} = \frac{152 + 75}{24} = \frac{227}{24}. \;\blacksquare$$

---

**(b)** In polar coordinates: $x = r\cos\theta$, $y = r\sin\theta$, $dA = r\, dr\, d\theta$. The curves become $r = 2\sin\theta$ and $r = 3$. The region is swept by $0 \leq \theta \leq \frac{\pi}{2}$ with $2\sin\theta \leq r \leq 3$:

$$\iint_R xy\, dA = \int_0^{\pi/2}\int_{2\sin\theta}^{3} r\cos\theta \cdot r\sin\theta \cdot r\, dr\, d\theta = \int_0^{\pi/2}\int_{2\sin\theta}^{3} r^3\sin\theta\cos\theta\, dr\, d\theta.$$

$$= \int_0^{\pi/2} \frac{r^4}{4}\sin\theta\cos\theta\bigg|_{2\sin\theta}^{3} d\theta = \int_0^{\pi/2} \cos\theta\left(\frac{81}{4}\sin\theta - 4\sin^5\theta\right) d\theta.$$

Let $u = \sin\theta$, $du = \cos\theta\, d\theta$:

$$= \int_0^1 \left(\frac{81u}{4} - 4u^5\right) du = \left(\frac{81u^2}{8} - \frac{2u^6}{3}\right)\bigg|_0^1 = \frac{81}{8} - \frac{2}{3} = \frac{243 - 16}{24} = \frac{227}{24}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Change order of integration
    'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e06',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c09',
    'Changing the Order of Integration',
    $BODY$Evaluate $\displaystyle\int^{2}_{0}\int^{2y}_{y^2} e^{8x^{3/2}-3x^2}\,dx\,dy$ by changing the order of integration.$BODY$,
    'hard',
    2023,
    'Sample 2nd Long Exam',
    6,
    $BODY$The original region is type II with $0 \leq y \leq 2$ and $y^2 \leq x \leq 2y$. Convert to type I: $0 \leq x \leq 4$ and $\frac{x}{2} \leq y \leq \sqrt{x}$. After switching, the inner integral with respect to $y$ produces the factor needed for a $u$-substitution in the outer integral.$BODY$,
    $BODY$\frac{e^{16} - 1}{12}$.$BODY$,
    $BODY$The original region is type II: $0 \leq y \leq 2$, $y^2 \leq x \leq 2y$. Converting to type I (vertical strips): $0 \leq x \leq 4$, $\frac{x}{2} \leq y \leq \sqrt{x}$.

$$\int_0^2\int_{y^2}^{2y} e^{8x^{3/2}-3x^2}\, dx\, dy = \int_0^4\int_{x/2}^{\sqrt{x}} e^{8x^{3/2}-3x^2}\, dy\, dx = \int_0^4 \left(\sqrt{x} - \frac{x}{2}\right)e^{8x^{3/2}-3x^2}\, dx.$$

Let $u = 8x^{3/2} - 3x^2$, so $du = (12x^{1/2} - 6x)\, dx = 12\left(x^{1/2} - \frac{x}{2}\right) dx$. When $x = 0$, $u = 0$; when $x = 4$, $u = 8(8) - 3(16) = 16$.

$$= \frac{1}{12}\int_0^{16} e^u\, du = \frac{e^{16} - 1}{12}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q7 — Surface area integral setup
    'c3d4e5f6-a7b8-4c9d-0e1f-2a3b4c5d6e07',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0a',
    'Surface Area of a Parametric Surface',
    $BODY$Set up, but do not evaluate, the double integral giving the area of the surface $\vec{R}(u,v)=\langle u\cos v,\, u\sin v,\, u\rangle$ traced by points $(u,v)$ satisfying $0\leq u\leq 2v$ and $0 \leq v \leq \frac{\pi}{2}$.$BODY$,
    'medium',
    2023,
    'Sample 2nd Long Exam',
    7,
    $BODY$Compute $\vec{R}_u \times \vec{R}_v$ and its magnitude $\|\vec{R}_u \times \vec{R}_v\|$. The surface area is $\iint_D \|\vec{R}_u \times \vec{R}_v\|\, dA$ over the given domain $D$.$BODY$,
    $BODY$A(S) = \displaystyle\int_0^{\pi/2}\int_0^{2v} \sqrt{2}\, u\, du\, dv$ (since $u \geq 0$, $|u| = u$).$BODY$,
    $BODY$Compute the partial derivatives:

$$\vec{R}_u = \langle \cos v,\, \sin v,\, 1 \rangle, \qquad \vec{R}_v = \langle -u\sin v,\, u\cos v,\, 0 \rangle.$$

$$\vec{R}_u \times \vec{R}_v = \begin{vmatrix} \mathbf{i} & \mathbf{j} & \mathbf{k} \\ \cos v & \sin v & 1 \\ -u\sin v & u\cos v & 0 \end{vmatrix} = \langle -u\cos v,\, -u\sin v,\, u \rangle.$$

$$\|\vec{R}_u \times \vec{R}_v\| = \sqrt{u^2\cos^2 v + u^2\sin^2 v + u^2} = \sqrt{2u^2} = \sqrt{2}\,|u|.$$

Since $u \geq 0$ on the domain, $|u| = u$. The surface area is

$$\boxed{A(S) = \int_0^{\pi/2}\int_0^{2v} \sqrt{2}\, u\, du\, dv.} \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
