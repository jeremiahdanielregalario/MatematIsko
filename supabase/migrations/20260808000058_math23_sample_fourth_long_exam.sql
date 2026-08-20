-- ============================================================================
-- Math 23 Elementary Analysis III — Sample 4th Long Exam, A.Y. 2023-2024
-- 6 problems (conservative fields, surface integrals, line integrals,
-- Green's Theorem, Stokes' Theorem, Divergence Theorem).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Conservative force field and work
    '6b7c8d9e-0f1a-4b2c-8d3e-4f5a6b7c8d01',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0b',
    'Conservative Force Field and Work Along a Closed Curve',
    $BODY$Consider the force field $\vec{F}(x,y) = \langle 9x^2 + 6xy,\, 3x^2 + 5y^4 \rangle$.

**(a)** Verify that $\vec{F}$ is conservative.

**(b)** Determine the work done by $\vec{F}$ in revolving an object clockwise three times along the circle $x^2 + 6x + y^2 - 10y = 135$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    1,
    $BODY$For (a), check $P_y = Q_x$. For (b), a conservative field does zero work along any closed path.$BODY$,
    $BODY$**(a)** $P_y = 6x = Q_x$, so $\vec{F}$ is conservative.

**(b)** $0$ (since the path is closed and $\vec{F}$ is conservative).$BODY$,
    $BODY$**(a)** Let $P = 9x^2 + 6xy$ and $Q = 3x^2 + 5y^4$. Then

$$P_y = \frac{\partial P}{\partial y} = 6x, \qquad Q_x = \frac{\partial Q}{\partial x} = 6x.$$

Since $P_y = Q_x$ and both partials are continuous on $\mathbb{R}^2$ (which is simply connected), $\vec{F}$ is conservative. $\blacksquare$

---

**(b)** Since $\vec{F}$ is conservative and the path is a closed curve (a circle traversed three times), by the Fundamental Theorem of Line Integrals:

$$\oint_C \vec{F} \cdot d\vec{R} = 0. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — Surface mass and flux integrals
    '6b7c8d9e-0f1a-4b2c-8d3e-4f5a6b7c8d02',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0a',
    'Set Up Surface Mass and Flux Integrals',
    $BODY$**Set up but do not evaluate** the required iterated integrals.

**(a)** The mass of a curved lamina parametrized by $\vec{R}(u,v) = \langle u^2,\, uv^2,\, v \rangle$ for $0 \leq u \leq \sqrt{5}$, $0 \leq v \leq 2u$, with density $\delta(x,y,z) = \dfrac{3y}{\sqrt{4x + 16x^2z^2 + z^4}}$.

**(b)** The flux of $\vec{F}(x,y,z) = \langle x,\, y+1,\, z \rangle$ across the portion of the cone $z = 2 - \sqrt{x^2+y^2}$ in the first octant, in polar coordinates.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    2,
    $BODY$For (a), compute $\vec{R}_u \times \vec{R}_v$ and its magnitude, then set up $\iint_D \delta(\vec{R}(u,v))\|\vec{R}_u \times \vec{R}_v\|\, dA$. The density and the norm simplify nicely. For (b), use the upward normal $\langle -g_x, -g_y, 1 \rangle$, project onto the quarter disk in the first octant, and convert to polar.$BODY$,
    $BODY$**(a)** $\displaystyle\int_0^{\sqrt{5}}\int_0^{2u} 3uv^2\, dv\, du$.

**(b)** $\displaystyle\int_0^{\pi/2}\int_0^2 r(\sin\theta + 2)\, dr\, d\theta$.$BODY$,
    $BODY$**(a)** Compute the partial derivatives and cross product:

$$\vec{R}_u = \langle 2u,\, v^2,\, 0 \rangle, \qquad \vec{R}_v = \langle 0,\, 2uv,\, 1 \rangle.$$

$$\vec{R}_u \times \vec{R}_v = \langle v^2,\, -2u,\, 4u^2v \rangle, \qquad \|\vec{R}_u \times \vec{R}_v\| = \sqrt{v^4 + 4u^2 + 16u^4v^2}.$$

Evaluate the density at the parametrization:

$$\delta(\vec{R}(u,v)) = \frac{3uv^2}{\sqrt{4u^4 + 16u^4v^4 + v^4}} \cdot \sqrt{v^4 + 4u^2 + 16u^4v^2} \quad \text{(after simplification)}.$$

After simplification, $\delta \cdot \|\vec{R}_u \times \vec{R}_v\| = 3uv^2$. Therefore

$$\text{Mass} = \boxed{\int_0^{\sqrt{5}}\int_0^{2u} 3uv^2\, dv\, du.} \;\blacksquare$$

---

**(b)** The surface is $z = g(x,y) = 2 - \sqrt{x^2+y^2}$ with $g_x = \frac{-x}{\sqrt{x^2+y^2}}$, $g_y = \frac{-y}{\sqrt{x^2+y^2}}$. The projection $D$ is the quarter disk $x^2+y^2 \leq 4$, $x,y \geq 0$.

$$\vec{F} \cdot \langle -g_x, -g_y, 1 \rangle = \frac{x^2}{\sqrt{x^2+y^2}} + \frac{y(y+1)}{\sqrt{x^2+y^2}} + 2 - \sqrt{x^2+y^2} = \frac{y}{\sqrt{x^2+y^2}} + 2.$$

In polar ($0 \leq \theta \leq \frac{\pi}{2}$, $0 \leq r \leq 2$):

$$\text{Flux} = \boxed{\int_0^{\pi/2}\int_0^2 r(\sin\theta + 2)\, dr\, d\theta.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Line integral
    '6b7c8d9e-0f1a-4b2c-8d3e-4f5a6b7c8d03',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0b',
    'Line Integral Along a Line Segment',
    $BODY$Evaluate the line integral $\displaystyle\int_C \vec{F}\cdot d\vec{R}$ where $\vec{F}(x,y,z) = \langle xy,\, yz,\, xz \rangle$ and $C$ is the line segment from $A(1,2,3)$ to $B(-3,-2,-1)$.$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    3,
    $BODY$Parametrize the line segment as $\vec{R}(t) = A + t(B - A)$ for $t \in [0,1]$, compute $\vec{R}'(t)$, substitute into $\vec{F}$, and integrate.$BODY$,
    $BODY$-12$.$BODY$,
    $BODY$Parametrize: $\vec{R}(t) = \langle 1-4t,\, 2-4t,\, 3-4t \rangle$, $t \in [0,1]$. Then $\vec{R}'(t) = \langle -4,\, -4,\, -4 \rangle$.

$$\vec{F}(\vec{R}(t)) = \langle (1-4t)(2-4t),\, (2-4t)(3-4t),\, (1-4t)(3-4t) \rangle.$$

$$\vec{F} \cdot \vec{R}' = -4[(1-4t)(2-4t) + (2-4t)(3-4t) + (1-4t)(3-4t)].$$

Expanding and simplifying the sum inside: $(2-12t+16t^2) + (6-20t+16t^2) + (3-16t+16t^2) = 11 - 48t + 48t^2$.

$$\int_0^1 -4(11 - 48t + 48t^2)\, dt = -4\left[11t - 24t^2 + 16t^3\right]_0^1 = -4(11 - 24 + 16) = -4(3) = \boxed{-12}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Green's Theorem
    '6b7c8d9e-0f1a-4b2c-8d3e-4f5a6b7c8d04',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0b',
    'Green\'s Theorem: Work Along a Closed Path',
    $BODY$Using Green's Theorem, calculate the work done by the force field $\vec{F}(x, y) = \langle ye^x + 4xy,\, e^x - 2x^2 \rangle$ in moving a particle along the line segment from $(-1, 2)$ to $(2, -1)$ then along the portion of the parabola $y + 1 = x^2 - 2x$ from $(2, -1)$ to $(-1, 2)$.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    4,
    $BODY$Identify $P$ and $Q$, compute $Q_x - P_y = -8x$. The path is negatively oriented (clockwise), so apply Green's Theorem with $-C$ and negate the result.$BODY$,
    $BODY$18$.$BODY$,
    $BODY$Let $P = ye^x + 4xy$ and $Q = e^x - 2x^2$. Then $Q_x - P_y = (e^x - 4x) - (e^x + 4x) = -8x$.

The path is traced from $(-1,2) \to (2,-1)$ along the line, then $(2,-1) \to (-1,2)$ along the parabola. This is **clockwise** (negative orientation). Apply Green's Theorem to $-C$ (positive orientation):

$$\oint_{-C} P\, dx + Q\, dy = \iint_R (-8x)\, dA = \int_{-1}^{2}\int_{x^2-2x-1}^{-x+1} (-8x)\, dy\, dx.$$

$$= \int_{-1}^{2} (-8x)[(-x+1) - (x^2-2x-1)]\, dx = \int_{-1}^{2} (-8x)(-x^2+x+2)\, dx = \int_{-1}^{2}(8x^3 - 8x^2 - 16x)\, dx.$$

$$= \left[2x^4 - \frac{8}{3}x^3 - 8x^2\right]_{-1}^{2} = \left(32 - \frac{64}{3} - 32\right) - \left(2 + \frac{8}{3} - 8\right) = -\frac{64}{3} - \left(-\frac{10}{3}\right) = -18.$$

Since the original path $C$ is negatively oriented: $\int_C P\, dx + Q\, dy = -(-18) = \boxed{18.} \;\blacksquare$$BODY$
  ),
  (
    -- Q5 — Stokes' Theorem
    '6b7c8d9e-0f1a-4b2c-8d3e-4f5a6b7c8d05',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0b',
    'Stokes\' Theorem: Line Integral Over a Triangle',
    $BODY$Using Stokes' Theorem, calculate $\displaystyle\oint_C \vec{F}\cdot d\vec{R}$, where

$$\vec{F}(x,y,z) = \left\langle \sin x + 2y^2,\; e^y + \frac{x^2}{2},\; xz \right\rangle$$

and $C$ is the triangle with vertices $(4,0,0)$, $(0,0,-4)$, and $(0,-4,0)$.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    5,
    $BODY$Compute $\operatorname{curl}\vec{F}$. Choose the planar surface enclosed by the triangle ($z = x - y - 4$), project onto the $xy$-plane (triangle with vertices $(0,0)$, $(4,0)$, $(0,-4)$), and evaluate $\iint_D \operatorname{curl}\vec{F} \cdot \langle -g_x, -g_y, 1 \rangle\, dA$.$BODY$,
    $BODY$64$.$BODY$,
    $BODY$Compute $\operatorname{curl}\vec{F}$:

$$\operatorname{curl}\vec{F} = \begin{vmatrix} \mathbf{i} & \mathbf{j} & \mathbf{k} \\ \frac{\partial}{\partial x} & \frac{\partial}{\partial y} & \frac{\partial}{\partial z} \\ \sin x + 2y^2 & e^y + \frac{x^2}{2} & xz \end{vmatrix} = \langle 0,\; -z,\; x - 4y \rangle.$$

The triangle lies on the plane through $(4,0,0)$, $(0,0,-4)$, $(0,-4,0)$: $z = x - y - 4$, so $g(x,y) = x - y - 4$, $g_x = 1$, $g_y = -1$. The projection $D$ has vertices $(0,0)$, $(4,0)$, $(0,-4)$.

$$\operatorname{curl}\vec{F}(x,y,g) \cdot \langle -g_x, -g_y, 1 \rangle = \langle 0,\; -(x-y-4),\; x-4y \rangle \cdot \langle -1,\; 1,\; 1 \rangle = -x + y + 4 + x - 4y = 4 - 3y.$$

$$\oint_C \vec{F}\cdot d\vec{R} = \int_0^4\int_{x-4}^{0}(4 - 3y)\, dy\, dx = \int_0^4\left[4y - \frac{3y^2}{2}\right]_{x-4}^{0} dx = \int_0^4\left(-4(x-4) + \frac{3(x-4)^2}{2}\right)dx.$$

Let $u = x-4$:

$$= \int_{-4}^{0}\left(-4u + \frac{3u^2}{2}\right)du = \left[-2u^2 + \frac{u^3}{2}\right]_{-4}^{0} = 0 - (-32 - 32) = \boxed{64.} \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Divergence Theorem
    '6b7c8d9e-0f1a-4b2c-8d3e-4f5a6b7c8d06',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c0b',
    'Gauss\'s Divergence Theorem: Flux Across a Cone-Sphere Boundary',
    $BODY$Using Gauss's Divergence Theorem, calculate $\displaystyle\oiint_S \vec{F}\cdot\vec{n}\,d\sigma$, where

$$\vec{F}(x,y,z) = \left\langle x^3,\; x^2+4z+2yz,\; e^{3y} - 3x^2z \right\rangle$$

and $S$ is the boundary of the solid in the first octant inside the sphere $z = \sqrt{4-x^2-y^2}$ and outside the cone $z = \sqrt{3x^2+3y^2}$.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    6,
    $BODY$Compute $\operatorname{div}\vec{F} = 2z$. Convert to spherical coordinates: the sphere is $\rho = 2$, the cone is $\phi = \pi/6$. The first octant gives $0 \leq \theta \leq \pi/2$, $\pi/6 \leq \phi \leq \pi/2$, $0 \leq \rho \leq 2$. Then $2z = 2\rho\cos\phi$ and $dV = \rho^2\sin\phi\, d\rho\, d\theta\, d\phi$.$BODY$,
    $BODY$\frac{3\pi}{2}$.$BODY$,
    $BODY$Compute the divergence:

$$\operatorname{div}\vec{F} = \frac{\partial(x^3)}{\partial x} + \frac{\partial(x^2+4z+2yz)}{\partial y} + \frac{\partial(e^{3y}-3x^2z)}{\partial z} = 3x^2 + 2z - 3x^2 = 2z.$$

In spherical coordinates: the sphere $\rho = 2$, the cone $z = \sqrt{3(x^2+y^2)}$ gives $\tan\phi = \frac{1}{\sqrt{3}}$, i.e., $\phi = \frac{\pi}{6}$. First octant: $0 \leq \theta \leq \frac{\pi}{2}$. The solid: $\frac{\pi}{6} \leq \phi \leq \frac{\pi}{2}$, $0 \leq \rho \leq 2$.

$$\iiint_G 2z\, dV = \int_{\pi/6}^{\pi/2}\int_0^{\pi/2}\int_0^2 (2\rho\cos\phi)\rho^2\sin\phi\, d\rho\, d\theta\, d\phi = \int_{\pi/6}^{\pi/2}\int_0^{\pi/2}\int_0^2 2\rho^3\cos\phi\sin\phi\, d\rho\, d\theta\, d\phi.$$

$$= \int_{\pi/6}^{\pi/2}\int_0^{\pi/2} 8\cos\phi\sin\phi\, d\theta\, d\phi = 4\pi\int_{\pi/6}^{\pi/2}\sin\phi\cos\phi\, d\phi.$$

Let $u = \sin\phi$:

$$= 4\pi\int_{1/2}^{1} u\, du = 4\pi\left[\frac{u^2}{2}\right]_{1/2}^{1} = 4\pi\left(\frac{1}{2} - \frac{1}{8}\right) = 4\pi\cdot\frac{3}{8} = \boxed{\frac{3\pi}{2}.} \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
