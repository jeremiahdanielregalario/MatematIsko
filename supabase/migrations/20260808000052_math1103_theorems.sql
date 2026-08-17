-- ============================================================================
-- MATH 110.3 — Topics + Named Theorems from Unit I notes
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Topics
-- ---------------------------------------------------------------------------
insert into public.topics (id, course_id, name, description)
values
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c01',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'Factorization of Polynomials',
    'Division algorithm for F[x], polynomial factors, remainder and factor theorems.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c02',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'Ideals, Factor Rings, and Homomorphisms',
    'Principal ideals, maximal/prime ideals, evaluation homomorphism, first isomorphism theorem.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'Unique Factorization Domains',
    'Irreducibles, primes, PIDs, UFDs, Gauss'' Lemma, ascending chain condition.'
  ),
  (
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c04',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'Euclidean Domains',
    'Euclidean valuation, ED implies PID, multiplicative norms.'
  )
on conflict (course_id, name) do nothing;

-- ---------------------------------------------------------------------------
-- Theorems
-- ---------------------------------------------------------------------------
insert into public.theorems
  (id, course_id, topic_id, name, reference, statement, formal_notation)
values
  (
    -- Theorem 1.3 — Division Algorithm for F[x]
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b01',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c01',
    'Division Algorithm for $F[x]$',
    'Theorem 1.3',
    $BODY$Let $F$ be a field, and let $f(x), g(x) \in F[x]$ with $g(x) \neq 0$. Then there exist unique polynomials $q(x), r(x) \in F[x]$ such that $f(x) = q(x)g(x) + r(x)$, where either $r(x) = 0$ or $\deg r(x) < \deg g(x)$.$BODY$,
    null
  ),
  (
    -- Corollary 1.4 — Remainder Theorem
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b02',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c01',
    'Remainder Theorem',
    'Corollary 1.4',
    $BODY$Let $F$ be a field and $a \in F$. Then the remainder when $f(x) \in F[x]$ is divided by $x - a$ is $f(a)$.$BODY$,
    null
  ),
  (
    -- Corollary 1.5 — Factor Theorem
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b03',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c01',
    'Factor Theorem',
    'Corollary 1.5',
    $BODY$Let $F$ be a field, $a \in F$, and $f(x) \in F[x]$. Then $x - a$ is a factor of $f(x)$ if and only if $f(a) = 0$.$BODY$,
    $BODY$$(x - a) \mid f(x) \iff f(a) = 0$$
    $BODY$
  ),
  (
    -- Corollary 1.6 — At most n zeros
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b04',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c01',
    'Zeros of a Polynomial',
    'Corollary 1.6',
    $BODY$A polynomial $f(x) \in F[x]$ of positive degree $n$ has at most $n$ distinct zeros in the field $F$.$BODY$,
    null
  ),
  (
    -- Theorem 1.13 — Every ideal of F[x] is principal
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b05',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c02',
    'Ideals of $F[x]$ Are Principal',
    'Theorem 1.13',
    $BODY$Let $F$ be a field. Then every ideal of $F[x]$ is a principal ideal.$BODY$,
    null
  ),
  (
    -- Theorem 1.14 — Maximal ideals of F[x]
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b06',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c02',
    'Maximal Ideals of $F[x]$',
    'Theorem 1.14',
    $BODY$Let $F$ be a field and $p(x) \in F[x]$. Then $\langle p(x) \rangle$ is a maximal ideal of $F[x]$ if and only if $p(x)$ is irreducible over $F$.$BODY$,
    $BODY$$\langle p(x)rangle \text{ is maximal } \iff p(x) \text{ is irreducible}$$
    $BODY$
  ),
  (
    -- Theorem 1.17 — Every prime is irreducible
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b07',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Primes Are Irreducible',
    'Theorem 1.17',
    $BODY$Let $D$ be an integral domain. Then every prime of $D$ is an irreducible of $D$.$BODY$,
    $BODY$$\text{prime} \implies \text{irreducible}$$
    $BODY$
  ),
  (
    -- Theorem 1.18 — In a PID, irreducible iff prime
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b08',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Irreducible iff Prime in a PID',
    'Theorem 1.18',
    $BODY$Let $D$ be a PID. Then $p$ is an irreducible of $D$ if and only if $p$ is a prime of $D$.$BODY$,
    $BODY$$\text{irreducible} \iff \text{prime (in a PID)}$$
    $BODY$
  ),
  (
    -- Theorem 1.21 — Every PID is a UFD
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b09',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Every PID Is a UFD',
    'Theorem 1.21',
    $BODY$Every PID is a UFD.$BODY$,
    $BODY$$\text{PID} \implies \text{UFD}$$
    $BODY$
  ),
  (
    -- Lemma 1.22 — Gauss' Lemma
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b10',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Gauss'' Lemma',
    'Lemma 1.22',
    $BODY$If $D$ is a UFD, then the product of two primitive polynomials in $D[x]$ is again primitive.$BODY$,
    null
  ),
  (
    -- Theorem 1.24 — D UFD => D[x] UFD
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b11',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    '$D$ UFD Implies $D[x]$ UFD',
    'Theorem 1.24',
    $BODY$If $D$ is a UFD, then $D[x]$ is a UFD.$BODY$,
    $BODY$$D \text{ UFD} \implies D[x] \text{ UFD}$$
    $BODY$
  ),
  (
    -- Theorem 1.25 — Every ED is a PID
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b12',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c04',
    'Every ED Is a PID',
    'Theorem 1.25',
    $BODY$Every ED is a PID.$BODY$,
    $BODY$$\text{ED} \implies \text{PID}$$
    $BODY$
  ),
  (
    -- Theorem 1.26 — v(1) minimal, units characterized
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b13',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c04',
    'Euclidean Valuation and Units',
    'Theorem 1.26',
    $BODY$Let $D$ be an ED with Euclidean norm $v$. Then $v(1)$ is minimal among all $v(a)$ for $a \neq 0$, and $u \neq 0$ is a unit if and only if $v(u) = v(1)$.$BODY$,
    $BODY$$u \text{ is a unit} \iff v(u) = v(1)$$
    $BODY$
  ),
  (
    -- Theorem 1.27 — Multiplicative norms
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b14',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c04',
    'Multiplicative Norms',
    'Theorem 1.27',
    $BODY$Let $N$ be a multiplicative norm on an integral domain $D$. Then $N(1) = 1$, every unit $u$ satisfies $|N(u)| = 1$, and if every $\alpha$ with $|N(\alpha)| = 1$ is a unit, then $|N(\pi)| = p$ (prime in $\mathbb{Z}$) implies $\pi$ is irreducible.$BODY$,
    null
  ),
  (
    -- Lemma 1.19 — Union of ascending chain
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b15',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Union of an Ascending Chain of Ideals',
    'Lemma 1.19',
    $BODY$Let $R$ be a commutative ring. If $I_1 \subseteq I_2 \subseteq \cdots$ is an ascending chain of ideals in $R$, then $I = \bigcup_i I_i$ is an ideal of $R$.$BODY$,
    null
  ),
  (
    -- Lemma 1.20 — ACC for PIDs
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b16',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Ascending Chain Condition for PIDs',
    'Lemma 1.20',
    $BODY$Let $D$ be a PID. If $I_1 \subseteq I_2 \subseteq \cdots$ is an ascending chain of ideals in $D$, then there exists a positive integer $r$ such that $I_s = I_r$ for all $s \ge r$.$BODY$,
    null
  ),
  (
    -- Lemma 1.23 — Irreducibility over F from D[x]
    'f1a2b3c4-d5e6-4f7a-8b9c-0d1e2f3a4b17',
    '9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab',
    'a1b2c3d4-e5f6-4a7b-8c9d-0e1f2a3b4c03',
    'Irreducibility over the Field of Quotients',
    'Lemma 1.23',
    $BODY$Let $D$ be a UFD with field of quotients $F$. If $f(x) \in D[x]$ is irreducible in $D[x]$, then $f(x)$ is irreducible over $F$.$BODY$,
    null
  )
on conflict (id) do nothing;
