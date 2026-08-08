-- ============================================================================
-- Math 128 Complex Analysis — Problem Set 01, 1st Sem A.Y. 2024-2025
-- 3 problems (disk automorphism + argument bound, roots-of-unity sum,
-- entire function forced constant via Cauchy-Riemann).
--
-- The MATH 128 course row is added here because it exists in the catalog
-- migration but is not present in the live database.
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.courses (id, code, name, description)
values (
  'f2320f48-d0dc-4d1b-8bb0-2ca4997ec072',
  'MATH 128',
  'Complex Analysis',
  'Complex numbers, analytic functions, the Cauchy-Riemann equations, elementary functions, contour integration, power series, and residues.'
)
on conflict (code) do nothing;

insert into public.topics (id, course_id, name, description)
values
  (
    'a1f2e3d4-5c6b-4a7d-8e9f-0a1b2c3d4f01',
    'f2320f48-d0dc-4d1b-8bb0-2ca4997ec072',
    'Analytic Functions',
    'Holomorphic functions, Cauchy-Riemann equations, and conformal maps of the unit disk.'
  ),
  (
    'a1f2e3d4-5c6b-4a7d-8e9f-0a1b2c3d4f02',
    'f2320f48-d0dc-4d1b-8bb0-2ca4997ec072',
    'Complex Numbers',
    'Complex arithmetic, roots of unity, and algebraic identities.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Map b(z) sends D(0,1) into D(1,1), argument bound
    'b2c3d4e5-6f7a-4b8c-9d0e-1f2a3b4c5f01',
    'f2320f48-d0dc-4d1b-8bb0-2ca4997ec072',
    'a1f2e3d4-5c6b-4a7d-8e9f-0a1b2c3d4f01',
    'A Fractional Linear Map Sending $D(0, 1)$ into $D(1, 1)$',
    $BODY$Fix $a \in D(0, 1)$ and define for all $z \in D(0, 1)$,
$$b(z) = \frac{(1 - \overline{a})z + 1 - a}{1 - \overline{a}\, z}.$$

**(a)** Show that $b(z) \in D(1, 1)$.

**(b)** Explain briefly why $|\operatorname{Arg} b(z)| < \frac{\pi}{2}$.$BODY$,
    'hard',
    2024,
    'Problem Set 01',
    1,
    $BODY$For (a), compute $b(z) - 1$ and recognize the standard disk automorphism $\phi_a(z) = \frac{z - a}{1 - \overline{a}z}$. For (b), note every point of $D(1, 1)$ has positive real part.$BODY$,
    $BODY$**(a)** $b(z) - 1 = \frac{z - a}{1 - \overline{a}z} = \phi_a(z)$, and $|\phi_a(z)| < 1$ for $a, z \in D(0, 1)$.

**(b)** Since $b(z) \in D(1, 1)$, we have $\operatorname{Re} b(z) > 0$, so $\operatorname{Arg} b(z)$ lies strictly between $-\pi/2$ and $\pi/2$.$BODY$,
    $BODY$**(a)** Compute
$$b(z) - 1 = \frac{(1 - \overline{a})z + 1 - a - (1 - \overline{a}z)}{1 - \overline{a}z} = \frac{(1 - \overline{a})z - a + \overline{a}z}{1 - \overline{a}z} = \frac{z - a}{1 - \overline{a}z}.$$
The map $\phi_a(z) = \frac{z - a}{1 - \overline{a}z}$ with $|a| < 1$ is the standard automorphism of the unit disk: for $|z| < 1$ one has
$$|z - a| < |1 - \overline{a}z|,$$
since $|z - a|^2 - |1 - \overline{a}z|^2 = (|z|^2 - 1)(1 - |a|^2) < 0$. Hence $|b(z) - 1| = |\phi_a(z)| < 1$, i.e. $b(z) \in D(1, 1)$. $\blacksquare$

**(b)** The open disk $D(1, 1) = \{w : |w - 1| < 1\}$ lies in the open right half-plane: if $|w - 1| < 1$, then
$$\operatorname{Re} w = \operatorname{Re}(w - 1) + 1 > -|w - 1| + 1 > 0.$$
A complex number with positive real part has argument satisfying $-\frac{\pi}{2} < \operatorname{Arg} w < \frac{\pi}{2}$. Since $b(z) \in D(1, 1)$ by part (a), we get $|\operatorname{Arg} b(z)| < \frac{\pi}{2}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — Roots of unity sum identity
    'b2c3d4e5-6f7a-4b8c-9d0e-1f2a3b4c5f02',
    'f2320f48-d0dc-4d1b-8bb0-2ca4997ec072',
    'a1f2e3d4-5c6b-4a7d-8e9f-0a1b2c3d4f02',
    'The Sum $1 + 2\omega + 3\omega^2 + \cdots + n\omega^{n-1}$ for an $n$th Root of Unity',
    $BODY$Suppose that $\omega$ is an $n$th root of unity with $\omega \ne 1$. Show that
$$1 + 2\omega + 3\omega^2 + \cdots + n\omega^{n-1} = \frac{n}{\omega - 1}$$
without using derivatives.$BODY$,
    'medium',
    2024,
    'Problem Set 01',
    2,
    $BODY$Multiply the sum by $\omega$ and subtract from the original to telescope into a geometric series; then use $\omega^n = 1$ and $1 + \omega + \cdots + \omega^{n-1} = 0$.$BODY$,
    $BODY$Let $S = \sum_{k=1}^{n} k\omega^{k-1}$. Then $(1 - \omega)S = 1 + \omega + \cdots + \omega^{n-1} - n\omega^n = 0 - n$, so $S = \frac{n}{\omega - 1}$.$BODY$,
    $BODY$Let
$$S = 1 + 2\omega + 3\omega^2 + \cdots + n\omega^{n-1} = \sum_{k=1}^{n} k\omega^{k-1}.$$
Multiply both sides by $\omega$:
$$\omega S = \omega + 2\omega^2 + 3\omega^3 + \cdots + n\omega^n.$$
Subtracting,
$$(1 - \omega)S = S - \omega S = \sum_{k=1}^{n} k\omega^{k-1} - \sum_{k=1}^{n} k\omega^{k} = 1 + \omega + \omega^2 + \cdots + \omega^{n-1} - n\omega^n.$$

Now $\omega$ is an $n$th root of unity with $\omega \ne 1$, so $\omega^n = 1$ and
$$1 + \omega + \omega^2 + \cdots + \omega^{n-1} = \frac{1 - \omega^n}{1 - \omega} = 0.$$
Therefore
$$(1 - \omega)S = 0 - n \cdot 1 = -n,$$
and since $\omega \ne 1$,
$$S = \frac{-n}{1 - \omega} = \frac{n}{\omega - 1}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — v = e^u forces f constant
    'b2c3d4e5-6f7a-4b8c-9d0e-1f2a3b4c5f03',
    'f2320f48-d0dc-4d1b-8bb0-2ca4997ec072',
    'a1f2e3d4-5c6b-4a7d-8e9f-0a1b2c3d4f01',
    'If $v = e^u$, Then the Entire Function $f = u + iv$ Is Constant',
    $BODY$Let $f$ be entire and set $u = \operatorname{Re} f$ and $v = \operatorname{Im} f$. Suppose that
$$v(x, y) = e^{u(x, y)} \quad \text{for } z = x + iy \in \mathbb{C}.$$
Prove that $f$ must be constant.

*(Hint: Use the Cauchy-Riemann equations.)*$BODY$,
    'medium',
    2024,
    'Problem Set 01',
    3,
    $BODY$Write the Cauchy-Riemann equations $u_x = v_y$, $u_y = -v_x$, then differentiate $v = e^u$ and substitute to force $u_x = u_y = 0$.$BODY$,
    $BODY$From $v = e^u$ get $v_x = e^u u_x$ and $v_y = e^u u_y$. The Cauchy-Riemann equations give $u_x = e^u u_y$ and $u_y = -e^u u_x$, whence $u_x(1 + e^{2u}) = 0$, so $u_x = 0$ and then $u_y = 0$. Hence $u$ is constant, so $v = e^u$ and $f$ are constant.$BODY$,
    $BODY$Since $f = u + iv$ is entire, $u$ and $v$ are $C^{\infty}$ and satisfy the Cauchy-Riemann equations
$$u_x = v_y, \qquad u_y = -v_x.$$
From $v = e^u$ we differentiate with respect to $x$ and $y$:
$$v_x = e^u u_x, \qquad v_y = e^u u_y.$$
Substituting into the Cauchy-Riemann equations:
$$u_x = e^u u_y, \qquad u_y = -e^u u_x.$$
Now substitute the second equation into the first:
$$u_x = e^u (-e^u u_x) = -e^{2u} u_x,$$
so
$$u_x\left(1 + e^{2u}\right) = 0.$$
Since $e^{2u} \ge 0$, the factor $1 + e^{2u} \ge 1 > 0$, forcing $u_x = 0$ at every point of $\mathbb{C}$. Then from $u_y = -e^u u_x$ we get $u_y = 0$ as well.

Thus $u_x = u_y = 0$ on the whole plane, so $u$ is constant. Consequently $v = e^u$ is constant, and therefore $f = u + iv$ is constant. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
