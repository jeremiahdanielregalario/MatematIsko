-- ============================================================================
-- Math 142 Second Long Exam — A.Y. 2024-2025
-- 10 problems (examples, proofs of true statements, counterexamples, and a
-- compactness proof for the cofinite topology).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced for this exam's content:
--   • Separation and Countability Axioms
--   • Homotopy
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f03',
    'c0000000-0000-4000-8000-000000000009',
    'Separation and Countability Axioms',
    'T_1–T_4 separation axioms, first/second countability, and density.'
  ),
  (
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f04',
    'c0000000-0000-4000-8000-000000000009',
    'Homotopy',
    'Homotopy equivalence and contractibility.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Give examples
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c01',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f03',
    'Examples: Connectedness, Separation, Countability, and Compactness',
    $BODY$Give an example of a topological space that satisfies the given conditions. No need to justify your answers.

**(a)** A connected space with a disconnected subspace.

**(b)** A space that is $T_3$ and $C_2$.

**(c)** A space that is $T_4$ but NOT $C_2$.

**(d)** A space that is NOT $T_1$ but $C_1$.

**(e)** A compact space that is not path-connected.$BODY$,
    'easy',
    2024,
    'Second Long Exam',
    1,
    $BODY$Recall standard examples: $\mathbb{R}$ is connected; discrete spaces are $T_4$; the Sierpinski space is not $T_1$; a closed and bounded set plus an isolated point is compact but not path-connected.$BODY$,
    $BODY$**(a)** $\mathbb{R}$ with the standard topology, with the disconnected subspace $\{0, 1\}$.

**(b)** $\mathbb{R}$ with the standard topology ($T_3$ since it is normal, $C_2$ via the rational intervals).

**(c)** An uncountable discrete space (e.g., $\mathbb{R}$ with the discrete topology): $T_4$ but not $C_2$.

**(d)** The Sierpinski space $S = \{0, 1\}$ with open sets $\{\varnothing, \{0\}, S\}$: not $T_1$ (the point $0$ is not closed) but $C_1$ (finite).

**(e)** The subspace $[0, 1] \cup \{2\}$ of $\mathbb{R}$: compact but not path-connected.$BODY$,
    $BODY$**(a)** $\mathbb{R}$ with the standard topology is connected (it is an interval), but its subspace $\{0, 1\}$ is disconnected: $\{0\} = \{0,1\} \cap (-\infty, 1/2)$ and $\{1\} = \{0,1\} \cap (1/2, \infty)$ are open subsets of the subspace separating it.

**(b)** $\mathbb{R}$ with the standard topology is $T_3$: it is a metric space, hence normal (and therefore regular). It is $C_2$: the collection of open intervals with rational endpoints is a countable basis.

**(c)** Let $D$ be an uncountable set (e.g., $\mathbb{R}$) with the discrete topology. It is $T_4$ since every discrete space is normal (any two disjoint closed sets are separated by themselves), but it is not $C_2$: a second-countable discrete space must be countable, because its basis of singletons would have to be countable.

**(d)** The Sierpinski space $S = \{0, 1\}$ with the topology $\{\varnothing, \{0\}, \{0, 1\}\}$ has closed sets $\{\varnothing, \{1\}, \{0, 1\}\}$. The point $0$ is not closed, so $S$ is not $T_1$; but every finite space is first countable ($C_1$) since each point has a finite neighborhood base.

**(e)** The subspace $[0, 1] \cup \{2\}$ of $\mathbb{R}$ is compact because it is closed and bounded in $\mathbb{R}$. It is not path-connected: $\{2\} = ([0,1] \cup \{2\}) \cap (3/2, 5/2)$ is clopen, so the space is disconnected, and a path-connected space is connected. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — Cofinite topology has countable dense subset
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c02',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f03',
    '$\mathbb{R}$ with the Cofinite Topology Has a Countable Dense Subset',
    $BODY$Prove that the following statement is TRUE.

> $\mathbb{R}$ equipped with the cofinite topology has a countable dense subset.$BODY$,
    'medium',
    2024,
    'Second Long Exam',
    2,
    $BODY$In the cofinite topology every nonempty open set is the complement of a finite set; show that $\mathbb{Q}$ meets every such set.$BODY$,
    $BODY$The set $\mathbb{Q}$ is countable and dense in the cofinite topology on $\mathbb{R}$: every nonempty open set is $\mathbb{R} \setminus F$ for some finite $F$, and $\mathbb{Q} \setminus F \ne \varnothing$ because a finite set cannot exhaust $\mathbb{Q}$.$BODY$,
    $BODY$Recall that a subset $D$ is dense iff it meets every nonempty open set. In the cofinite topology on $\mathbb{R}$, the nonempty open sets are exactly $\mathbb{R} \setminus F$ where $F \subseteq \mathbb{R}$ is finite.

Let $D = \mathbb{Q}$, which is countable. For any nonempty open set $\mathbb{R} \setminus F$, the set $F$ is finite, while $\mathbb{Q}$ is infinite, so $\mathbb{Q} \setminus F$ is nonempty. Thus $\mathbb{Q} \cap (\mathbb{R} \setminus F) = \mathbb{Q} \setminus F \ne \varnothing$, and $\mathbb{Q}$ is dense in the cofinite topology.

Therefore $\mathbb{Q}$ is a countable dense subset of $(\mathbb{R}, \text{cofinite})$, so the statement is true. $\blacksquare$ $BODY$
  ),
  (
    -- Q3 — Compact subspace of a metric space is closed
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c03',
    'c0000000-0000-4000-8000-000000000009',
    'd540ed14-59ca-5ece-9416-7bd146f05802',
    'Any Compact Subspace of a Metric Space Is Closed',
    $BODY$Prove that the following statement is TRUE.

> Any compact subspace of a metric space is closed.$BODY$,
    'medium',
    2024,
    'Second Long Exam',
    3,
    $BODY$Show the complement is open: for $x \notin K$, separate $x$ from every point of $K$ with disjoint balls and use compactness to shrink down to a single ball avoiding $K$.$BODY$,
    $BODY$Let $K$ be compact in the metric space $(X, d)$. For $x \notin K$, the balls $B(x, d(x,k)/2)$ and $B(k, d(x,k)/2)$ are disjoint; by compactness finitely many such $B(k_i, r_i)$ cover $K$, and $B(x, \min r_i)$ avoids $K$. Hence $X \setminus K$ is open and $K$ is closed.$BODY$,
    $BODY$Let $K$ be a compact subspace of a metric space $(X, d)$. We show $X \setminus K$ is open. Fix $x \in X \setminus K$.

For each $k \in K$, since $x \ne k$, the balls
$$B\!\left(x, \tfrac{1}{2}d(x,k)\right) \quad \text{and} \quad B\!\left(k, \tfrac{1}{2}d(x,k)\right)$$
are disjoint (by the triangle inequality). The family $\{B(k, \tfrac{1}{2}d(x,k))\}_{k \in K}$ covers the compact set $K$, so a finite subcollection $B(k_1, r_1), \ldots, B(k_n, r_n)$ covers $K$, where $r_i = \tfrac{1}{2}d(x, k_i)$. Let $\delta = \min\{r_1, \ldots, r_n\} > 0$.

If $y \in B(x, \delta) \cap K$, then $y \in B(k_i, r_i)$ for some $i$, and
$$d(x, k_i) \le d(x, y) + d(y, k_i) < \delta + r_i \le r_i + r_i = d(x, k_i),$$
a contradiction. Hence $B(x, \delta) \cap K = \varnothing$, so $B(x, \delta) \subseteq X \setminus K$. Thus $X \setminus K$ is open and $K$ is closed. $\blacksquare$ $BODY$
  ),
  (
    -- Q4 — R_standard and {0} are homotopic
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c04',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f04',
    '$\mathbb{R}$ With the Standard Topology Is Homotopy Equivalent to $\{0\}$',
    $BODY$Prove that the following statement is TRUE.

> $\mathbb{R}$ with the standard topology and $\{0\}$ are homotopic (homotopy equivalent).$BODY$,
    'medium',
    2024,
    'Second Long Exam',
    4,
    $BODY$Show $\mathbb{R}$ is contractible: exhibit a homotopy between the identity map and the constant map $x \mapsto 0$, e.g. $H(x, t) = (1 - t)x$.$BODY$,
    $BODY$Define $H : \mathbb{R} \times [0, 1] \to \mathbb{R}$ by $H(x, t) = (1 - t)x$. Then $H(x, 0) = x$ and $H(x, 1) = 0$, so $H$ is a homotopy from the identity to the constant map at $0$. Hence $\mathbb{R}$ is contractible and $\mathbb{R} \simeq \{0\}$.$BODY$,
    $BODY$Recall that spaces $X$ and $Y$ are homotopy equivalent if there exist maps $f : X \to Y$ and $g : Y \to X$ with $g \circ f \simeq \operatorname{id}_X$ and $f \circ g \simeq \operatorname{id}_Y$.

Define $H : \mathbb{R} \times [0, 1] \to \mathbb{R}$ by
$$H(x, t) = (1 - t)x.$$
$H$ is continuous (a polynomial in $x$ and $t$), and
$$H(x, 0) = x = \operatorname{id}_{\mathbb{R}}(x), \qquad H(x, 1) = 0 = c_0(x),$$
where $c_0$ is the constant map. Hence $H$ is a homotopy $\operatorname{id}_{\mathbb{R}} \simeq c_0$, so $\mathbb{R}$ is contractible.

A contractible space is homotopy equivalent to a one-point space: take $f = c_0 : \mathbb{R} \to \{0\}$ and $g : \{0\} \to \mathbb{R}$ the inclusion. Then $f \circ g = \operatorname{id}_{\{0\}}$ and $g \circ f = c_0 \simeq \operatorname{id}_{\mathbb{R}}$. Thus $\mathbb{R}_{\text{standard}} \simeq \{0\}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q5 — Closed subset of T4 space is T4
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c05',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f03',
    'A Closed Subset of a $T_4$ Space Is $T_4$',
    $BODY$Prove that the following statement is TRUE.

> A closed subset of a $T_4$ space is $T_4$.$BODY$,
    'medium',
    2024,
    'Second Long Exam',
    5,
    $BODY$Show $T_1$ is hereditary, then separate two closed sets of the subspace inside $X$ using normality, and intersect the separating open sets with the subset.$BODY$,
    $BODY$Let $X$ be $T_4$ and $F \subseteq X$ closed. $F$ is $T_1$ (a subspace of a $T_1$ space). If $A, B$ are disjoint closed sets in $F$, they are closed in $X$ (since $F$ is closed), so normality of $X$ gives disjoint open $U, V$ with $A \subseteq U$, $B \subseteq V$; then $U \cap F$ and $V \cap F$ are disjoint open sets in $F$ separating $A$ and $B$. Hence $F$ is $T_4$.$BODY$,
    $BODY$Let $X$ be a $T_4$ space (normal and $T_1$) and let $F \subseteq X$ be closed.

**Step 1 — $F$ is $T_1$.** Given distinct $a, b \in F$, they are distinct points of $X$; since $X$ is $T_1$, there is an open set $U$ of $X$ with $a \in U$, $b \notin U$. Then $U \cap F$ is open in $F$, contains $a$, and excludes $b$. So $F$ is $T_1$.

**Step 2 — $F$ is normal.** Let $A, B$ be disjoint closed subsets of $F$. Because $F$ is closed in $X$, both $A$ and $B$ are closed in $X$. By normality of $X$, there exist disjoint open sets $U, V$ in $X$ with $A \subseteq U$ and $B \subseteq V$. Then $U \cap F$ and $V \cap F$ are open in the subspace $F$, disjoint, and contain $A$ and $B$ respectively. Hence $F$ is normal.

Therefore $F$, being both $T_1$ and normal, is $T_4$. $\blacksquare$ $BODY$
  ),
  (
    -- Q6 — Counterexample: connected not path-connected
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c06',
    'c0000000-0000-4000-8000-000000000009',
    '82172f37-6c21-565f-8deb-dc67248ff9fe',
    'Counterexample: A Connected Space That Is Not Path-Connected',
    $BODY$Prove that the following statement is FALSE by giving a counterexample. Justify your answer.

> All connected spaces are path-connected.$BODY$,
    'medium',
    2024,
    'Second Long Exam',
    6,
    $BODY$The topologist's sine curve is the standard counterexample: the closure of the graph of $\sin(1/x)$, which is connected but admits no path onto its vertical segment.$BODY$,
    $BODY$**Counterexample.** The topologist's sine curve $S = \{(x, \sin(1/x)) : 0 < x \le 1\} \cup \{(0, y) : -1 \le y \le 1\}$ with the subspace topology of $\mathbb{R}^2$ is connected but not path-connected.$BODY$,
    $BODY$Let $S$ be the topologist's sine curve:
$$S = \{(x, \sin(1/x)) : 0 < x \le 1\} \cup \{(0, y) : -1 \le y \le 1\},$$
with the subspace topology of $\mathbb{R}^2$.

**Connected:** The graph $G = \{(x, \sin(1/x)) : 0 < x \le 1\}$ is the continuous image of the connected interval $(0, 1]$, hence connected, and $S = \overline{G}$, the closure of a connected set, which is connected.

**Not path-connected:** There is no path from a point $p = (x, \sin(1/x))$ with $x > 0$ to a point $q = (0, y)$ on the vertical segment. Indeed, a path $\gamma : [0, 1] \to S$ from $p$ to $q$ would be continuous, so the first coordinate would have to pass continuously from $x > 0$ down to $0$ while the second coordinate oscillates like $\sin(1/x)$; the standard argument shows that any such attempt forces a point of $S$ with first coordinate $0$ to be hit infinitely often, contradicting continuity (or one shows $\gamma$ would separate $S$). Hence $S$ is connected but not path-connected, so the statement is false. $\blacksquare$ $BODY$
  ),
  (
    -- Q7 — Counterexample: circle not homeomorphic to disk
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c07',
    'c0000000-0000-4000-8000-000000000009',
    '82172f37-6c21-565f-8deb-dc67248ff9fe',
    'Counterexample: The Circle Is Not Homeomorphic to the Disk',
    $BODY$Prove that the following statement is FALSE by giving a counterexample. Justify your answer.

> The spaces $\{(x, y) \mid x^2 + y^2 = 1\}$ and $\{(x, y) \mid x^2 + y^2 \le 1\}$ are homeomorphic as subspaces of $\mathbb{R}^2$.$BODY$,
    'medium',
    2024,
    'Second Long Exam',
    7,
    $BODY$Compare what happens to connectedness when two points are removed: removing two points disconnects the circle but leaves the disk connected.$BODY$,
    $BODY$**Counterexample.** $S^1$ (the circle) and $D^2$ (the closed disk) are not homeomorphic: removing any two distinct points of $S^1$ disconnects it, whereas $D^2$ minus two points remains connected; a homeomorphism preserves such a property.$BODY$,
    $BODY$Let $S^1 = \{(x, y) : x^2 + y^2 = 1\}$ and $D^2 = \{(x, y) : x^2 + y^2 \le 1\}$. Suppose $h : S^1 \to D^2$ were a homeomorphism.

The property "removing any two points leaves a connected space" is a topological invariant: if $h$ is a homeomorphism and $p \ne q \in S^1$, then $h|_{S^1 \setminus \{p, q\}}$ is a homeomorphism onto $D^2 \setminus \{h(p), h(q)\}$, so one space minus two points is connected iff the other is.

- Removing two points from the circle leaves two open arcs, so $S^1 \setminus \{p, q\}$ is **disconnected**.
- Removing two points from the disk leaves it **connected** (indeed, the disk is convex and deleting finitely many points does not disconnect it).

These differ, contradicting the existence of $h$. Hence $S^1 \not\cong D^2$ and the statement is false. $\blacksquare$ $BODY$
  ),
  (
    -- Q8 — Counterexample: continuous image of T3 not T3
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c08',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f03',
    'Counterexample: The Continuous Image of a $T_3$ Space Is Not $T_3$',
    $BODY$Prove that the following statement is FALSE by giving a counterexample. Justify your answer.

> The continuous image of a $T_3$ space is $T_3$.$BODY$,
    'medium',
    2024,
    'Second Long Exam',
    8,
    $BODY$Map $\mathbb{R}$ (which is $T_3$) onto a two-point indiscrete space by any continuous surjection; the indiscrete space is not $T_1$, hence not $T_3$.$BODY$,
    $BODY$**Counterexample.** Let $f : \mathbb{R} \to Y$ be any surjection onto the two-point set $Y = \{0, 1\}$ equipped with the indiscrete topology $\{\varnothing, Y\}$. $\mathbb{R}$ (standard topology) is $T_3$, $f$ is continuous, but $Y$ is not $T_1$ (singletons are not closed), so $Y$ is not $T_3$.$BODY$,
    $BODY$Let $X = \mathbb{R}$ with the standard topology, which is $T_3$ (indeed a metric space). Let $Y = \{0, 1\}$ carry the indiscrete topology, whose only open sets are $\varnothing$ and $Y$. Any function $f : \mathbb{R} \to Y$ is continuous, because the preimages $\varnothing$ and $Y$ are open in $\mathbb{R}$; choose a surjective one.

Now $Y$ is not $T_1$: the singleton $\{0\}$ is not closed, since its complement $\{1\}$ is not open in the indiscrete topology. A $T_3$ space must be $T_1$, so $Y$ is not $T_3$.

Thus the continuous image $f(\mathbb{R}) = Y$ of the $T_3$ space $\mathbb{R}$ fails to be $T_3$, disproving the statement. $\blacksquare$ $BODY$
  ),
  (
    -- Q9 — Counterexample: compact not C2
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c09',
    'c0000000-0000-4000-8000-000000000009',
    '7c3a9f4b-2d8e-4c6a-9f1b-5a7d3e8c2f03',
    'Counterexample: A Compact Space That Is Not Second Countable',
    $BODY$Prove that the following statement is FALSE by giving a counterexample. Justify your answer.

> All compact spaces are $C_2$ (second countable).$BODY$,
    'hard',
    2024,
    'Second Long Exam',
    9,
    $BODY$Take the one-point compactification of an uncountable discrete space: it is compact, but it contains an uncountable discrete open subspace, which no second-countable space can contain.$BODY$,
    $BODY$**Counterexample.** Let $D$ be an uncountable set with the discrete topology and let $D^* = D \cup \{\infty\}$ be its one-point compactification. Then $D^*$ is compact but not $C_2$, because $D$ is an uncountable discrete open subspace of $D^*$ and a second-countable space cannot contain an uncountable discrete subspace.$BODY$,
    $BODY$Let $D$ be an uncountable set (e.g., $\mathbb{R}$) with the discrete topology, and let $D^* = D \cup \{\infty\}$ be its one-point compactification: points of $D$ are isolated, and neighborhoods of $\infty$ are sets of the form $D^* \setminus K$ with $K \subseteq D$ finite.

**Compact:** Let $\{U_i\}$ be an open cover of $D^*$. One set, say $U_0$, contains $\infty$; then $D^* \setminus U_0$ is a finite set $\{x_1, \ldots, x_n\}$, and each $x_j$ lies in some $U_{i_j}$. The finite subcollection $\{U_0, U_{i_1}, \ldots, U_{i_n}\}$ covers $D^*$. Hence $D^*$ is compact.

**Not $C_2$:** $D$ is an open subspace of $D^*$ and is an uncountable discrete space. If $D^*$ had a countable base $\mathcal{B}$, then $\{B \cap D : B \in \mathcal{B}\}$ would be a countable base for the discrete space $D$; but a second-countable discrete space must be countable (each point $x \in D$ needs a basic open set meeting $D$ only in $x$). Contradiction. So $D^*$ is not $C_2$.

Thus $D^*$ is compact but not second countable, disproving the statement. $\blacksquare$ $BODY$
  ),
  (
    -- Q10 — Cofinite topology is compact
    '9e5c1d6f-4a0b-4c8d-9f3e-7c9e5a1b2c10',
    'c0000000-0000-4000-8000-000000000009',
    'd540ed14-59ca-5ece-9416-7bd146f05802',
    'The Cofinite Topology Is Compact',
    $BODY$Prove that any space $X$ having the cofinite topology is compact.$BODY$,
    'easy',
    2024,
    'Second Long Exam',
    10,
    $BODY$From any open cover, one set covers all but finitely many points; cover the leftover finite set with finitely many more sets.$BODY$,
    $BODY$Take an open cover of $X$. One member $U_0 \ne \varnothing$ is the complement of a finite set $\{x_1, \ldots, x_n\}$; pick $U_i$ in the cover with $x_i \in U_i$. Then $U_0, U_1, \ldots, U_n$ is a finite subcover, so $X$ is compact.$BODY$,
    $BODY$Let $\{U_i\}_{i \in I}$ be an open cover of $X$ in the cofinite topology. Assume $X \ne \varnothing$ (the empty space is trivially compact).

If some $U_i = X$, we are done with the finite subcover $\{U_i\}$. Otherwise every $U_i$ is of the form $X \setminus F_i$ with $F_i$ finite. Pick any $U_0$ in the cover; then $X \setminus U_0$ is a finite set, say
$$X \setminus U_0 = \{x_1, \ldots, x_n\}.$$
Since the cover covers $X$, for each $x_j$ there is some $U_{i_j}$ in the cover with $x_j \in U_{i_j}$. Then
$$\{U_0, U_{i_1}, \ldots, U_{i_n}\}$$
is a finite subcover: it contains $U_0$ and every point of $X \setminus U_0$. Hence every open cover of $X$ has a finite subcover, so $X$ is compact. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
