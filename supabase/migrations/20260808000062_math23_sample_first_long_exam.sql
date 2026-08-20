-- ============================================================================
-- Math 23 Elementary Analysis III — Sample 1st Long Exam, A.Y. 2023-2024
-- 8 problems (domain/level curves, continuity, partial derivatives,
-- Clairaut's theorem, differentiability, chain rule, gradient/directional
-- derivatives, tangent plane).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced:
--   • Functions of Several Variables
--   • Continuity of Multivariable Functions
--   • Partial Derivatives
--   • Differentiability and Differentials
--   • Chain Rule
--   • Gradient and Directional Derivatives
--   • Tangent Planes and Normal Lines
-- ============================================================================

insert into public.courses (id, code, name, description)
values (
  'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
  'MATH 23',
  'Elementary Analysis III',
  'Multivariable calculus: functions of several variables, partial derivatives, multiple integrals, and vector calculus.'
)
on conflict (code) do nothing;

insert into public.topics (id, course_id, name, description)
values
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c01',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Functions of Several Variables',
    'Domain, range, level curves, and graphs of functions of two or more variables.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c02',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Continuity of Multivariable Functions',
    'Continuity, limits, and types of discontinuities for functions of several variables.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Partial Derivatives',
    'First and higher-order partial derivatives, Clairaut''s Theorem, and implicit differentiation.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c04',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Differentiability and Differentials',
    'Differentiability, the total differential, and local linear approximation.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c05',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Chain Rule',
    'The multivariable chain rule for composite functions.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c06',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Gradient and Directional Derivatives',
    'The gradient vector, directional derivatives, and maximum rate of change.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c07',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'Tangent Planes and Normal Lines',
    'Equations of tangent planes and normal lines to surfaces.'
  )
on conflict (id) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Domain and level curves
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d01',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c01',
    'Domain and Level Curves of $f(x,y) = \sqrt{\frac{(x-y)^2}{x^2+y^2-2}}$',
    $BODY$Let $f(x,y)=\sqrt{\dfrac{(x-y)^2}{x^2+y^2-2}}$. Identify and sketch the domain of $f$. Hence, sketch the level curves of $f$ for $k=0,1$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    1,
    $BODY$For the square root to be defined, the radicand must be nonnegative. Since the numerator $(x-y)^2$ is always $\geq 0$, the denominator must be strictly positive. Find the level curves by setting $f(x,y) = k$ and simplifying.$BODY$,
    $BODY$The domain is $\{(x,y) \in \mathbb{R}^2 \mid x^2 + y^2 > 2\}$ (the exterior of the circle of radius $\sqrt{2}$ centered at the origin). The level curve for $k = 0$ is the line $y = x$. The level curve for $k = 1$ is the hyperbola $y = \frac{1}{x}$.$BODY$,
    $BODY$For square roots to be defined, the radicand must be nonnegative. Therefore, we require

$$\frac{(x-y)^2}{x^2+y^2-2} \geq 0.$$

The numerator $(x-y)^2$ is always nonnegative since it is a square. The denominator must therefore be nonzero and nonnegative, i.e., $x^2 + y^2 - 2 > 0$. The domain is

$$\{(x,y) \in \mathbb{R}^2 \mid x^2 + y^2 > 2\}.$$

Graphically, $x^2 + y^2 > 2$ is the region outside the circle centered at the origin with radius $\sqrt{2}$. The circle $x^2 + y^2 = 2$ is not part of the domain. A test point $(0,0)$ does not satisfy $x^2 + y^2 > 2$, confirming that the interior of the circle is excluded. $\blacksquare$

---

For the level curves, we set $f(x,y) = k$ for $k = 0, 1$.

**$k = 0$:**

$$\sqrt{\frac{(x-y)^2}{x^2+y^2-2}} = 0 \implies \frac{(x-y)^2}{x^2+y^2-2} = 0 \implies (x-y)^2 = 0 \implies x - y = 0 \implies y = x.$$

**$k = 1$:**

$$\sqrt{\frac{(x-y)^2}{x^2+y^2-2}} = 1 \implies \frac{(x-y)^2}{x^2+y^2-2} = 1 \implies x^2 - 2xy + y^2 = x^2 + y^2 - 2 \implies -2xy = -2 \implies y = \frac{1}{x}.$$

The level curve for $k = 0$ is the line $y = x$, and the level curve for $k = 1$ is the hyperbola $y = \frac{1}{x}$. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Continuity of piecewise multivariable functions
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d02',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c02',
    'Continuity of Piecewise Multivariable Functions',
    $BODY$Determine whether the following functions are continuous at the specified point. If discontinuous, identify the type of discontinuity.

**(a)** $f(x,y)=\begin{cases}\dfrac{y \ln x}{x-y-1}&\text{if}\; (x,y)\neq(1,0)\\[0.3cm] 0&\text{if}\; (x,y)=(1,0) \end{cases}$ \quad at $P(1,0)$

**(b)** $g(x,y)=\begin{cases}\dfrac{xy-y^3}{\sqrt{x}+y}&\text{if}\; (x,y)\neq(0,0)\\[0.3cm] 0&\text{if}\; (x,y)=(0,0) \end{cases}$ \quad at the origin$BODY$,
    'hard',
    2023,
    'Sample 1st Long Exam',
    2,
    $BODY$For (a), evaluate the limit along the curves $x = 1$, $y = 0$, and $x = e^y$ through $(1,0)$. If limits along different curves differ, the overall limit does not exist. For (b), try to simplify the expression and show the limit equals the function value.$BODY$,
    $BODY$**(a)** $f$ has an essential discontinuity at $(1,0)$.

**(b)** $g$ is continuous at the origin.$BODY$,
    $BODY$**(a)** Let $C_1: x = 1$ and $C_2: y = 0$ be curves passing through $(1, 0)$.

Along $C_1$:

$$\lim_{\substack{(x,y)\to (1,0)\\ \text{along}\, C_1}}f(x,y) = \lim_{y\to 0}\frac{y \ln(1)}{1 - y - 1} = 0.$$

Along $C_2$:

$$\lim_{\substack{(x,y)\to (1,0)\\ \text{along}\, C_2}}f(x,y) = \lim_{x\to 1}\frac{0 \cdot \ln x}{x - 0 - 1} = 0.$$

Since these limits along curves are equal, we are still uncertain about continuity. Consider another curve $C_3: x = e^y$ through $(1, 0)$. Using L'H\^opital's rule:

$$\lim_{\substack{(x,y)\to (1,0)\\ \text{along}\, C_3}}f(x,y) = \lim_{y\to 0}\frac{y \ln(e^y)}{e^y - y - 1} = \lim_{y\to 0}\frac{y^2}{e^y - y - 1} \overset{\text{LHR}}{=} \lim_{y\to 0}\frac{2y}{e^y - 1} \overset{\text{LHR}}{=} \lim_{y\to 0}\frac{2}{e^y} = 2.$$

Because the limits along $C_1$ (or $C_2$) and $C_3$ are not equal, $\lim_{(x,y)\to(1,0)}f(x,y)$ does not exist. Therefore $f$ has an **essential discontinuity** at $(1,0)$. $\blacksquare$

---

**(b)** We rationalize the expression by multiplying numerator and denominator by $\sqrt{x} - y$:

$$\lim_{(x,y)\to (0,0)}g(x,y) = \lim_{(x,y)\to (0,0)}\frac{xy - y^3}{\sqrt{x} + y} = \lim_{(x,y)\to (0,0)}\frac{y(x - y^2)}{\sqrt{x} + y} \cdot \frac{\sqrt{x} - y}{\sqrt{x} - y}.$$

$$= \lim_{(x,y)\to (0,0)}\frac{y(x - y^2)(\sqrt{x} - y)}{x - y^2} = \lim_{(x,y)\to (0,0)}y(\sqrt{x} - y) = 0.$$

Since $\lim_{(x,y)\to (0,0)}g(x,y) = g(0,0) = 0$, we conclude that $g$ is **continuous** at the origin. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Partial derivatives and mixed partial
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d03',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Partial Derivatives and Mixed Partial of $f(x,y,z)$',
    $BODY$Consider the function $f(x,y,z)=\dfrac{x^{2}-2yz}{xy}+\cot(2xz)$. Find $f_{x}$, $f_{z}$, and $f_{xz}$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    3,
    $BODY$First simplify $f$ as $\frac{x}{y} - \frac{2z}{x} + \cot(2xz)$. Differentiate term by term, treating other variables as constants. For $f_{xz}$, differentiate $f_x$ with respect to $z$.$BODY$,
    $BODY$f_x = \dfrac{1}{y} + \dfrac{2z}{x^2} - 2z\csc^2(2xz)$, $f_z = -\dfrac{2}{x} - 2x\csc^2(2xz)$, $f_{xz} = \dfrac{2}{x^2} - 2\csc^2(2xz) + 8xz\cot(2xz)\csc^2(2xz)$.$BODY$,
    $BODY$First, simplify $f$:

$$f(x,y,z) = \frac{x}{y} - \frac{2z}{x} + \cot(2xz).$$

Differentiating with respect to $x$ (treating $y$ and $z$ as constants):

$$f_x = \frac{1}{y} - 2z\left(-\frac{1}{x^2}\right) + (-\csc^2(2xz))(2z) = \frac{1}{y} + \frac{2z}{x^2} - 2z\csc^2(2xz).$$

Differentiating with respect to $z$ (treating $x$ and $y$ as constants):

$$f_z = 0 - \frac{2}{x} + (-\csc^2(2xz))(2x) = -\frac{2}{x} - 2x\csc^2(2xz).$$

Now compute $f_{xz}$ by differentiating $f_x$ with respect to $z$:

$$f_{xz} = \frac{\partial}{\partial z}\left(\frac{1}{y} + \frac{2z}{x^2} - 2z\csc^2(2xz)\right).$$

$$= 0 + \frac{2}{x^2} - 2\left[\csc^2(2xz) + z \cdot 2\csc(2xz) \cdot (-\csc(2xz)\cot(2xz)) \cdot 2x\right].$$

$$= \frac{2}{x^2} - 2\csc^2(2xz) + 8xz\cot(2xz)\csc^2(2xz). \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Clairaut's Theorem
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d04',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Clairaut''s Theorem: Does a Function Exist?',
    $BODY$Identify, using Clairaut's Theorem, whether there exists a function on the unit disc given the following partial derivatives:

$$f_{x}=e^{2xy}+x^3, \qquad f_{y}=\sec y+e^{2xy}.$$$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    4,
    $BODY$If such a function exists, Clairaut's Theorem requires $f_{xy} = f_{yx}$. Compute both mixed partials and check whether they are equal on the unit disc.$BODY$,
    $BODY$No such function exists, because $f_{xy} = 2xe^{2xy} \neq 2ye^{2xy} = f_{yx}$ on the unit disc.$BODY$,
    $BODY$If such a function $f$ exists, then Clairaut's Theorem states that $f_{xy} = f_{yx}$ provided both mixed partials are continuous on the unit disc. Compute:

$$f_{xy} = \frac{\partial}{\partial y}(e^{2xy} + x^3) = 2xe^{2xy},$$

$$f_{yx} = \frac{\partial}{\partial x}(\sec y + e^{2xy}) = 2ye^{2xy}.$$

Both $f_{xy}$ and $f_{yx}$ are continuous on $\mathbb{R}^2$ (and hence on the unit disc), but $f_{xy} = 2xe^{2xy} \neq 2ye^{2xy} = f_{yx}$ (for example, at $(1, 0)$: $f_{xy} = 2$ but $f_{yx} = 0$).

By Clairaut's Theorem, since $f_{xy} \neq f_{yx}$, **no such function exists** on the unit disc with the given partial derivatives. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Differentiability and local linear approximation
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d05',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c04',
    'Differentiability, Differential, and Local Linear Approximation',
    $BODY$Consider the function $f(x,y)=e^{xy}\sin x+xy^{2}$.

**(a)** Show that it is differentiable at $(0,0)$. *(Hint: Show existence and continuity of partial derivatives at $(0,0)$.)*

**(b)** Compute the differential of $z$ at $(x,y)$ and at $(0,0)$.

**(c)** Using a local linear approximation, approximate $f(-0.02, 0.13)$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    5,
    $BODY$For (a), compute $f_x$ and $f_y$ and show they are continuous at $(0,0)$. For (b), use $dz = f_x\,dx + f_y\,dy$. For (c), the local linear approximation at $(0,0)$ is $L(x,y) = f(0,0) + f_x(0,0)x + f_y(0,0)y$.$BODY$,
    $BODY$**(a)** $f_x$ and $f_y$ exist and are continuous everywhere, so $f$ is differentiable at $(0,0)$.

**(b)** $dz = (e^{xy}\cos x + ye^{xy}\sin x + y^2)\,dx + (xe^{xy}\sin x + 2xy)\,dy$; at $(0,0)$: $dz = dx$.

**(c)** $f(-0.02, 0.13) \approx -0.02$.$BODY$,
    $BODY$**(a)** Compute the partial derivatives:

$$f_x = e^{xy}\cos x + ye^{xy}\sin x + y^2, \qquad f_y = xe^{xy}\sin x + 2xy.$$

Since $f_x$ and $f_y$ are sums and products of everywhere continuous functions ($e^{xy}$, $\cos x$, $\sin x$, polynomials), they are continuous on all of $\mathbb{R}^2$. In particular, they exist and are continuous at $(0,0)$. By the sufficient condition for differentiability, $f$ is differentiable at $(0,0)$. $\blacksquare$

---

**(b)** The differential of $z = f(x,y)$ at the point $(x_0, y_0)$ is

$$dz = f_x(x_0, y_0)\,dx + f_y(x_0, y_0)\,dy.$$

At a general point $(x, y)$:

$$dz = \left(e^{xy}\cos x + ye^{xy}\sin x + y^2\right)dx + \left(xe^{xy}\sin x + 2xy\right)dy.$$

At $(0, 0)$: $f_x(0,0) = e^0 \cdot 1 + 0 + 0 = 1$ and $f_y(0,0) = 0 + 0 = 0$. Therefore

$$dz = 1 \cdot dx + 0 \cdot dy = dx. \;\blacksquare$$

---

**(c)** The local linear approximation of $f$ at $(x_0, y_0)$ is

$$L(x,y) = f(x_0, y_0) + f_x(x_0, y_0)(x - x_0) + f_y(x_0, y_0)(y - y_0).$$

At $(0, 0)$: $f(0,0) = e^0 \cdot \sin 0 + 0 = 0$, $f_x(0,0) = 1$, $f_y(0,0) = 0$. Thus

$$L(x,y) = 0 + 1 \cdot x + 0 \cdot y = x.$$

Therefore

$$f(-0.02, 0.13) \approx L(-0.02, 0.13) = -0.02. \;\blacksquare$$

**Remark:** The actual value is $f(-0.02, 0.13) = e^{-0.0026}\sin(-0.02) + (-0.02)(0.0169) \approx -0.02028474.$ $BODY$
  ),
  (
    -- Q6 — Chain rule
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d06',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c05',
    'Chain Rule: $\frac{\partial z}{\partial u}$ for $z = \tan^{-1}x + x^2y$',
    $BODY$Let $z = \tan^{-1}x + x^2y$, where $x = v\sin u$ and $y = v\cos u$. Find $\dfrac{\partial z}{\partial u}$ at the point $(u,v) = \left(\dfrac{\pi}{4}, 2\right)$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    6,
    $BODY$Apply the multivariable chain rule: $\frac{\partial z}{\partial u} = \frac{\partial z}{\partial x}\frac{\partial x}{\partial u} + \frac{\partial z}{\partial y}\frac{\partial y}{\partial u}$. First find $x$ and $y$ at $(u,v) = (\pi/4, 2)$, then substitute.$BODY$,
    $BODY$\dfrac{\partial z}{\partial u}\left(\dfrac{\pi}{4}, 2\right) = \dfrac{7\sqrt{2}}{3}$.$BODY$,
    $BODY$By the multivariable chain rule:

$$\frac{\partial z}{\partial u} = \frac{\partial z}{\partial x}\frac{\partial x}{\partial u} + \frac{\partial z}{\partial y}\frac{\partial y}{\partial u}.$$

Compute the needed partial derivatives:

$$\frac{\partial z}{\partial x} = \frac{1}{1+x^2} + 2xy, \qquad \frac{\partial z}{\partial y} = x^2,$$

$$\frac{\partial x}{\partial u} = v\cos u, \qquad \frac{\partial y}{\partial u} = -v\sin u.$$

Therefore

$$\frac{\partial z}{\partial u} = \left(\frac{1}{1+x^2} + 2xy\right)(v\cos u) + x^2(-v\sin u).$$

At $(u, v) = \left(\frac{\pi}{4}, 2\right)$: $x = 2 \cdot \frac{\sqrt{2}}{2} = \sqrt{2}$ and $y = 2 \cdot \frac{\sqrt{2}}{2} = \sqrt{2}$. Substituting:

$$\frac{\partial z}{\partial u}\left(\frac{\pi}{4}, 2\right) = \left(\frac{1}{1+2} + 2(\sqrt{2})(\sqrt{2})\right)\left(2 \cdot \frac{\sqrt{2}}{2}\right) + (\sqrt{2})^2\left(-2 \cdot \frac{\sqrt{2}}{2}\right).$$

$$= \left(\frac{1}{3} + 4\right)\sqrt{2} + 2(-\sqrt{2}) = \frac{13\sqrt{2}}{3} - 2\sqrt{2} = \frac{13\sqrt{2} - 6\sqrt{2}}{3} = \frac{7\sqrt{2}}{3}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q7 — Gradient and directional derivatives
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d07',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c06',
    'Gradient, Maximum Rate of Change, and Directional Derivative',
    $BODY$Let $f(x,y,z) = 2x^2y + y\sin z - 24x$.

**(a)** Find the maximum rate of change at the point $(2,4,0)$ and give a vector along which it occurs.

**(b)** Find the rate of change at $(2,1,\pi)$ along $\langle 4,4,2 \rangle$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    7,
    $BODY$For (a), the maximum rate of change is $\|\nabla f\|$ and occurs along $\nabla f$. For (b), normalize the direction vector to get $\mathbf{u}$, then compute $D_{\mathbf{u}}f = \nabla f \cdot \mathbf{u}$.$BODY$,
    $BODY$**(a)** Maximum rate of change is $12$, occurring along $\langle 8, 8, 4 \rangle$.

**(b)** The rate of change is $-\dfrac{17}{3}$.$BODY$,
    $BODY$**(a)** The gradient is

$$\nabla f(x,y,z) = \langle 4xy - 24,\; 2x^2 + \sin z,\; y\cos z \rangle.$$

At $(2, 4, 0)$:

$$\nabla f(2,4,0) = \langle 32 - 24,\; 8 + 0,\; 4 \cdot 1 \rangle = \langle 8, 8, 4 \rangle.$$

The maximum rate of change is

$$\|\nabla f(2,4,0)\| = \sqrt{64 + 64 + 16} = \sqrt{144} = 12,$$

and it occurs along the vector $\langle 8, 8, 4 \rangle$. $\blacksquare$

---

**(b)** First normalize the direction vector $\langle 4, 4, 2 \rangle$:

$$\mathbf{u} = \frac{\langle 4, 4, 2 \rangle}{\|\langle 4, 4, 2 \rangle\|} = \frac{\langle 4, 4, 2 \rangle}{6} = \left\langle \frac{2}{3}, \frac{2}{3}, \frac{1}{3} \right\rangle.$$

Compute the gradient at $(2, 1, \pi)$:

$$\nabla f(2,1,\pi) = \langle 8 - 24,\; 8 + 0,\; 1 \cdot \cos\pi \rangle = \langle -16, 8, -1 \rangle.$$

The directional derivative is

$$D_{\mathbf{u}}f(2,1,\pi) = \nabla f(2,1,\pi) \cdot \mathbf{u} = \langle -16, 8, -1 \rangle \cdot \left\langle \frac{2}{3}, \frac{2}{3}, \frac{1}{3} \right\rangle = -\frac{32}{3} + \frac{16}{3} - \frac{1}{3} = -\frac{17}{3}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q8 — Tangent plane
    'b2c3d4e5-f6a7-4b8c-9d0e-1f2a3b4c5d08',
    'd3485837-0c50-4398-8b0a-ffb7c9fb124c',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c07',
    'Tangent Plane to $x^2yz + 3xy - 4yz^2 - 11 = 0$ at $(1,-1,2)$',
    $BODY$Find an equation of the tangent plane to the surface defined by $x^2yz + 3xy - 4yz^2 - 11 = 0$ at the point $(1, -1, 2)$.$BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    8,
    $BODY$Let $F(x,y,z) = x^2yz + 3xy - 4yz^2 - 11$. The normal vector at the point is $\nabla F(1,-1,2)$. Use the point-normal form of the plane equation.$BODY$,
    $BODY$The tangent plane is $-7(x - 1) - 11(y + 1) + 15(z - 2) = 0$, or equivalently $7x + 11y - 15z + 30 = 0$.$BODY$,
    $BODY$Let $F(x,y,z) = x^2yz + 3xy - 4yz^2 - 11$. The gradient $\nabla F$ gives a normal vector to the surface:

$$\nabla F(x,y,z) = \langle 2xyz + 3y,\; x^2z + 3x - 4z^2,\; x^2y - 8yz \rangle.$$

Evaluating at $(1, -1, 2)$:

$$\nabla F(1,-1,2) = \langle 2(1)(-1)(2) + 3(-1),\; (1)(2) + 3(1) - 4(4),\; (1)(-1) - 8(-1)(2) \rangle$$

$$= \langle -4 - 3,\; 2 + 3 - 16,\; -1 + 16 \rangle = \langle -7, -11, 15 \rangle.$$

The equation of the tangent plane is

$$-7(x - 1) - 11(y + 1) + 15(z - 2) = 0.$$

Expanding: $-7x + 7 - 11y - 11 + 15z - 30 = 0$, which simplifies to

$$\boxed{7x + 11y - 15z + 30 = 0.} \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
