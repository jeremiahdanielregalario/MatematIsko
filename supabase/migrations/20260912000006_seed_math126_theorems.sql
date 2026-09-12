-- ============================================================================
-- Seed: MATH 126 named theorems (Unit I measure + Unit II L^p spaces)
-- Linked to the existing course c0000000-0000-4000-8000-000000000004 and
-- its existing topics: Lebesgue Measure (22b18b44-...) and L^p Spaces and
-- Linear Transformations (422cd013-...).
-- ============================================================================

insert into public.theorems
  (id, course_id, topic_id, name, statement, formal_notation)
values
  -- ---------------------------------------------------------------- Unit I
  (
    'b3f31a2e-8c4d-4a5b-9e7f-1c2d3e4f5a6b',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Vitali''s Theorem',
    $BODY$A bounded set $E$ of real numbers with positive measure contains a subset that fails to be measurable.$BODY$,
    null
  ),
  (
    'c4f42b3f-9d5e-4b6c-af80-2d3e4f5a6b7c',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Continuity of Measure',
    $BODY$If $\{A_k\}_{k=1}^{\infty}$ is an ascending collection of measurable sets, then

$$m\left(\bigcup_{k=1}^{\infty} A_k\right) = \lim_{n \to \infty} m(A_n).$$

If $\{B_k\}_{k=1}^{\infty}$ is a descending collection of measurable sets with $m(B_1) < \infty$, then

$$m\left(\bigcap_{k=1}^{\infty} B_k\right) = \lim_{n \to \infty} m(B_n).$$$BODY$,
    null
  ),
  (
    'd5a53c40-ae6f-4c7d-b091-3e4f5a6b7c8d',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Lusin''s Theorem',
    $BODY$Let $f : E \to \mathbb{R}$ be a measurable function. For every $\varepsilon > 0$, there exists a continuous function $g_{\varepsilon}$ on $\mathbb{R}$ and a closed set $F_{\varepsilon} \subseteq E$ such that $f = g_{\varepsilon}$ on $F_{\varepsilon}$ and

$$m(E \setminus F_{\varepsilon}) < \varepsilon.$$$BODY$,
    null
  ),
  (
    'e6b64d51-bf70-4d8e-c1a2-4f5a6b7c8d9e',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Egoroff''s Theorem',
    $BODY$Assume $E$ has finite measure. Let $\{f_n\}$ be a sequence of measurable functions on $E$ converging pointwise on $E$ to $f : E \to \mathbb{R}$. For every $\varepsilon > 0$, there exists a closed set $F_{\varepsilon} \subseteq E$ such that $f_n \to f$ uniformly on $F_{\varepsilon}$ and

$$m(E \setminus F_{\varepsilon}) < \varepsilon.$$$BODY$,
    null
  ),
  (
    'f7c75e62-d081-4e9f-d2b3-5a6b7c8d9e0f',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Pointwise Supremum, Infimum, Limsup and Liminf of Measurable Functions',
    $BODY$Let $\{f_n\}$ be a sequence of measurable functions on a measurable domain $E$. For $x \in E$, set

$$g_1(x) = \sup_{n \in \mathbb{N}} f_n(x), \qquad g_2(x) = \inf_{n \in \mathbb{N}} f_n(x),$$

$$h_1(x) = \limsup_{n \to \infty} f_n(x), \qquad h_2(x) = \liminf_{n \to \infty} f_n(x).$$

Then $g_1$, $g_2$, $h_1$ and $h_2$ are measurable functions.$BODY$,
    null
  ),
  -- ---------------------------------------------------------------- Unit II
  (
    '08d86f73-e192-4fa0-e3c4-6b7c8d9e0f10',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Young''s Inequality',
    $BODY$Let $1 < p < \infty$ and let $p' = \dfrac{p}{p - 1}$ be the conjugate of $p$. For any $a, b > 0$:

$$ab \le \frac{a^{p}}{p} + \frac{b^{p'}}{p'}.$$$BODY$,
    $BODY$$ab \le \frac{a^{p}}{p} + \frac{b^{p'}}{p'}$$$BODY$
  ),
  (
    '19e98084-f2a3-40b1-4d5e-7c8d9e0f1121',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Hölder''s Inequality',
    $BODY$Let $\Omega$ be a measurable set, $1 \le p < \infty$, and $p'$ the conjugate of $p$. If $f \in L^{p}(\Omega)$ and $g \in L^{p'}(\Omega)$, then $fg \in L^{1}(\Omega)$ and

$$\|fg\|_{1} \le \|f\|_{p} \, \|g\|_{p'}.$$$BODY$,
    $BODY$$\|fg\|_{1} \le \|f\|_{p} \, \|g\|_{p'}$$$BODY$
  ),
  (
    '2afab195-03b4-41c2-5e6f-8d9e0f122232',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Cauchy–Schwarz Inequality',
    $BODY$The special case of Hölder's inequality when $p = 2 = p'$:

$$\int_{\Omega} |fg| \le \left(\int_{\Omega} |f|^{2}\right)^{1/2} \left(\int_{\Omega} |g|^{2}\right)^{1/2}.$$$BODY$,
    $BODY$$\int_{\Omega} |fg| \le \left(\int_{\Omega} |f|^{2}\right)^{1/2} \left(\int_{\Omega} |g|^{2}\right)^{1/2}$$$BODY$
  ),
  (
    '3bac2ca6-14c5-42d3-6f70-9e0f13233343',
    'c0000000-0000-4000-8000-000000000004',
    '422cd013-4ce8-4c18-8d22-3ba737e3b730',
    'Minkowski Inequality',
    $BODY$Let $1 \le p \le \infty$. If $f, g \in L^{p}(\Omega)$, then $f + g \in L^{p}(\Omega)$ and

$$\|f + g\|_{p} \le \|f\|_{p} + \|g\|_{p}.$$$BODY$,
    $BODY$$\|f + g\|_{p} \le \|f\|_{p} + \|g\|_{p}$$$BODY$
  )
on conflict (id) do nothing;