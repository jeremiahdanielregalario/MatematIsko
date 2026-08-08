-- ============================================================================
-- Math 142 First Long Exam — 1st Sem A.Y. 2024-2025
-- 4 problems (topology on a finite set, subspace topology, constant map
-- continuity, metric-induced topologies).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced for this exam's content:
--   • Continuous Functions
--   • Metric Spaces
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f01',
    'c0000000-0000-4000-8000-000000000009',
    'Continuous Functions',
    'Continuous maps between topological spaces and their properties.'
  ),
  (
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f02',
    'c0000000-0000-4000-8000-000000000009',
    'Metric Spaces',
    'Metrics and the topologies they induce.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Topology on X = {a, b, c, d, e}
    '8d4b0c5e-3f9a-4d7b-8c2e-6b8d4f9a3c01',
    'c0000000-0000-4000-8000-000000000009',
    'bda32821-a540-5b79-acfe-0691fa8dd2e3',
    'Basis, Closed Sets, Closure, and Derived Sets on $\{a, b, c, d, e\}$',
    $BODY$Let $X = \{a, b, c, d, e\}$ and define $\mathcal{B} = \{\{a\}, \{b, c\}, \{c, d, e\}, \{c\}\}$ to be a basis that generates a topology $\mathcal{T}$ given by
$$\mathcal{T} = \{\varnothing, \{a\}, \{b, c\}, \{c, d, e\}, \{c\}, \{a, b, c\}, \{a, c\}, \{a, c, d, e\}, \{b, c, d, e\}, \{a, b, c, d, e\}\}.$$

**(a)** Explain why the set $\{b, e\}$ cannot be an element of $\mathcal{T}$.

**(b)** Determine all the closed sets of $(X, \mathcal{T})$.

**(c)** Find the closure of the set $\{b, e\}$ in this topology.

**(d)** List down all the open neighborhoods of $d$.

**(e)** Compute the derived set of $\{b, e\}$.$BODY$,
    'medium',
    2024,
    'First Long Exam',
    1,
    $BODY$For (a), note that every basis element containing $b$ also contains $c$. For (b)–(e), work with complements and the definition of limit points.$BODY$,
    $BODY$**(a)** Every basis element that contains $b$ also contains $c$; since open sets are unions of basis elements, every open set containing $b$ must contain $c$. Hence $\{b, e\}$ is not open.

**(b)** The closed sets are the complements of the open sets: $\varnothing$, $\{a\}$, $\{b\}$, $\{a, b\}$, $\{d, e\}$, $\{a, d, e\}$, $\{b, d, e\}$, $\{a, b, d, e\}$, $\{b, c, d, e\}$, and $X$.

**(c)** $\overline{\{b, e\}} = \{b, d, e\}$.

**(d)** The open neighborhoods of $d$ are $\{c, d, e\}$, $\{a, c, d, e\}$, $\{b, c, d, e\}$, and $X$.

**(e)** $\{b, e\}' = \{d\}$.$BODY$,
    $BODY$**(a)** $\mathcal{T}$ consists of all unions of the basis elements $\{a\}$, $\{b, c\}$, $\{c, d, e\}$, $\{c\}$. The only basis element containing $b$ is $\{b, c\}$, which also contains $c$; hence any union that contains $b$ must contain $c$. Since $\{b, e\}$ contains $b$ but not $c$, it is not a union of basis elements and therefore $\{b, e\} \notin \mathcal{T}$. $\blacksquare$

**(b)** A set is closed iff its complement is open. Taking complements of the ten open sets:
$$X \setminus \varnothing = X, \quad X \setminus \{a\} = \{b, c, d, e\}, \quad X \setminus \{b, c\} = \{a, d, e\}, \quad X \setminus \{c, d, e\} = \{a, b\},$$
$$X \setminus \{c\} = \{a, b, d, e\}, \quad X \setminus \{a, b, c\} = \{d, e\}, \quad X \setminus \{a, c\} = \{b, d, e\}, \quad X \setminus \{a, c, d, e\} = \{b\},$$
$$X \setminus \{b, c, d, e\} = \{a\}, \quad X \setminus X = \varnothing.$$
So the closed sets are $\{\varnothing, \{a\}, \{b\}, \{a, b\}, \{d, e\}, \{a, d, e\}, \{b, d, e\}, \{a, b, d, e\}, \{b, c, d, e\}, X\}$. $\blacksquare$

**(c)** The closure of $\{b, e\}$ is the intersection of all closed sets containing both $b$ and $e$. Those are $\{a, b, d, e\}$, $\{b, d, e\}$, $\{b, c, d, e\}$, and $X$. Their intersection is
$$\overline{\{b, e\}} = \{a, b, d, e\} \cap \{b, d, e\} \cap \{b, c, d, e\} \cap X = \{b, d, e\}. \;\blacksquare$$

**(d)** The open neighborhoods of $d$ are the open sets containing $d$:
$$\{c, d, e\}, \quad \{a, c, d, e\}, \quad \{b, c, d, e\}, \quad X. \;\blacksquare$$

**(e)** A point $x$ is a limit point of $\{b, e\}$ if every open neighborhood of $x$ meets $\{b, e\}$ in a point different from $x$.

- $x = a$: $\{a\}$ is an open neighborhood of $a$ with $\{a\} \cap \{b, e\} = \varnothing$, so $a$ is not a limit point.
- $x = b$: $\{b, c\}$ is a neighborhood of $b$ with $\{b, c\} \cap \{b, e\} = \{b\}$, so $b$ is not a limit point.
- $x = c$: $\{c\}$ is a neighborhood of $c$ with $\{c\} \cap \{b, e\} = \varnothing$, so $c$ is not a limit point.
- $x = d$: every neighborhood of $d$ ($\{c, d, e\}$, $\{a, c, d, e\}$, $\{b, c, d, e\}$, $X$) contains $e$, so $d$ is a limit point.
- $x = e$: the neighborhood $\{c, d, e\}$ meets $\{b, e\}$ only in $\{e\}$, so $e$ is not a limit point.

Therefore the derived set is $\{b, e\}' = \{d\}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — Subspace topology
    '8d4b0c5e-3f9a-4d7b-8c2e-6b8d4f9a3c02',
    'c0000000-0000-4000-8000-000000000009',
    'bda32821-a540-5b79-acfe-0691fa8dd2e3',
    'The Subspace Topology on a Subset',
    $BODY$Let $X$ be a non-empty set. Let $\mathcal{T}$ be a topology on $X$ with $A \subseteq X$. Show that $\mathcal{T}_A = \{A \cap U \mid U \in \mathcal{T}\}$ defines a topology on $A$.$BODY$,
    'medium',
    2024,
    'First Long Exam',
    2,
    $BODY$Verify the three axioms of a topology: $\varnothing$ and $A$ belong to $\mathcal{T}_A$, finite intersections stay in $\mathcal{T}_A$, and arbitrary unions stay in $\mathcal{T}_A$ — using the properties of $\mathcal{T}$ on $X$.$BODY$,
    $BODY$$\mathcal{T}_A$ is a topology on $A$: (i) $\varnothing = A \cap \varnothing$ and $A = A \cap X$ are in $\mathcal{T}_A$; (ii) $(A \cap U_1) \cap (A \cap U_2) = A \cap (U_1 \cap U_2) \in \mathcal{T}_A$; (iii) $\bigcup_i (A \cap U_i) = A \cap (\bigcup_i U_i) \in \mathcal{T}_A$ because $\bigcup_i U_i \in \mathcal{T}$.$BODY$,
    $BODY$We verify the three axioms of a topology for $\mathcal{T}_A = \{A \cap U \mid U \in \mathcal{T}\}$.

**(i) The empty set and the whole set.** Since $\varnothing \in \mathcal{T}$ and $X \in \mathcal{T}$,
$$\varnothing = A \cap \varnothing \in \mathcal{T}_A, \qquad A = A \cap X \in \mathcal{T}_A.$$

**(ii) Finite intersections.** Let $A \cap U_1, A \cap U_2 \in \mathcal{T}_A$. Then
$$(A \cap U_1) \cap (A \cap U_2) = A \cap (U_1 \cap U_2),$$
and $U_1 \cap U_2 \in \mathcal{T}$ because $\mathcal{T}$ is a topology. Hence $(A \cap U_1) \cap (A \cap U_2) \in \mathcal{T}_A$.

**(iii) Arbitrary unions.** Let $\{A \cap U_i\}_{i \in I}$ be any family of elements of $\mathcal{T}_A$. Then
$$\bigcup_{i \in I} (A \cap U_i) = A \cap \left(\bigcup_{i \in I} U_i\right),$$
and $\bigcup_{i \in I} U_i \in \mathcal{T}$ because $\mathcal{T}$ is closed under arbitrary unions. Hence the union is in $\mathcal{T}_A$.

All three axioms hold, so $\mathcal{T}_A$ is a topology on $A$. (It is called the **subspace topology** on $A$.) $\blacksquare$ $BODY$
  ),
  (
    -- Q3 — Constant map is continuous
    '8d4b0c5e-3f9a-4d7b-8c2e-6b8d4f9a3c03',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f01',
    'A Constant Map Is Continuous',
    $BODY$Let $X$ and $Y$ be topological spaces with $y_0 \in Y$. Prove that the function $f : X \to Y$ where $f(x) = y_0$, for all $x \in X$, is a continuous function.$BODY$,
    'easy',
    2024,
    'First Long Exam',
    3,
    $BODY$Show the preimage of every open set in $Y$ is open in $X$ — split into the cases $y_0 \in V$ and $y_0 \notin V$.$BODY$,
    $BODY$For any open $V \subseteq Y$, the preimage is $f^{-1}(V) = X$ if $y_0 \in V$, and $f^{-1}(V) = \varnothing$ if $y_0 \notin V$. Both are open in $X$, so $f$ is continuous.$BODY$,
    $BODY$Let $V \subseteq Y$ be open. Since $f$ is constant with value $y_0$, we have:
- if $y_0 \in V$, then every $x \in X$ satisfies $f(x) = y_0 \in V$, so $f^{-1}(V) = X$, which is open;
- if $y_0 \notin V$, then $f(x) = y_0 \notin V$ for every $x$, so $f^{-1}(V) = \varnothing$, which is open.

In both cases the preimage of an open set is open, so $f$ is continuous by the definition of continuity between topological spaces. $\blacksquare$ $BODY$
  ),
  (
    -- Q4 — Taxicab metric topology finer than Euclidean
    '8d4b0c5e-3f9a-4d7b-8c2e-6b8d4f9a3c04',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f02',
    'The Taxicab Topology Is Finer Than the Euclidean Topology on $\mathbb{R}^2$',
    $BODY$Define the following metrics on $\mathbb{R}^2$. Let $x = (x_1, x_2)$ and $y = (y_1, y_2) \in \mathbb{R}^2$.
$$d(x, y) = \sqrt{(x_1 - y_1)^2 + (x_2 - y_2)^2}, \qquad e(x, y) = |x_1 - y_1| + |x_2 - y_2|.$$
Show that the topology induced by $e$ is finer than the topology induced by $d$.$BODY$,
    'hard',
    2024,
    'First Long Exam',
    4,
    $BODY$Show every open ball for $d$ contains an open ball for $e$ centered at the same point, using $d(x, y) \le e(x, y)$.$BODY$,
    $BODY$Since $(x_1 - y_1)^2 + (x_2 - y_2)^2 \le (|x_1 - y_1| + |x_2 - y_2|)^2$, we have $d(x, y) \le e(x, y)$ for all $x, y$. Hence $B_e(x, r) \subseteq B_d(x, r)$ for every $x$ and $r > 0$, which implies every $d$-open set is $e$-open. So $\mathcal{T}_d \subseteq \mathcal{T}_e$, i.e. the topology of $e$ is finer than that of $d$.$BODY$,
    $BODY$We show $\mathcal{T}_d \subseteq \mathcal{T}_e$. Let $U$ be open in the $d$-topology and take $x \in U$. By definition of the induced topology there is $r > 0$ with $B_d(x, r) \subseteq U$.

First note the inequality
$$d(x, y)^2 = (x_1 - y_1)^2 + (x_2 - y_2)^2 \le \left(|x_1 - y_1| + |x_2 - y_2|\right)^2 = e(x, y)^2,$$
so $d(x, y) \le e(x, y)$ for all $x, y \in \mathbb{R}^2$. Therefore, if $e(x, y) < r$, then $d(x, y) \le e(x, y) < r$, which shows
$$B_e(x, r) \subseteq B_d(x, r).$$

Thus for our $x \in U$ we have an $e$-ball $B_e(x, r) \subseteq B_d(x, r) \subseteq U$. Every point of $U$ has an $e$-ball inside $U$, so $U$ is open in the $e$-topology. Hence $\mathcal{T}_d \subseteq \mathcal{T}_e$, i.e. the topology induced by $e$ is finer than the topology induced by $d$. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
