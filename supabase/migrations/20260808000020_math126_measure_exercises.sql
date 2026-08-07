-- ============================================================================
-- Math 126 Exercises — Outer Measure and Measurability (A.Y. 2025-2026)
-- 15 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '1d369c69-173d-401f-88d3-b32769638d73',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Using Outer Measure to Show $[0,1]$ is Uncountable',
    $BODY$Using the properties of outer measure, show that the interval $[0, 1]$ is uncountable.$BODY$,
    'easy',
    2025,
    'Exercises',
    1,
    $BODY$Countable sets have outer measure zero; use the contrapositive with $m^*([0,1]) = \ell([0,1]) = 1$.$BODY$,
    $BODY$Since $m^*([0,1]) = 1 > 0$, $[0,1]$ is uncountable.$BODY$,
    $BODY$Recall that $A$ countable $\implies m^*(A) = 0$, so $m^*(A) > 0 \implies A$ uncountable.

Note that $m^*([0, 1]) = \ell([0, 1]) = 1 > 0$. It follows that $[0, 1]$ is uncountable. $\blacksquare$$BODY$
  ),
  (
    '06fbbf06-491b-459a-84eb-6c911ebcf98c',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Adding a Null Set Does Not Change Outer Measure',
    $BODY$Let $A$ and $B$ be subsets of $\mathbb{R}$. Without using the excision property, show that if $m^*(A) = 0$, then $m^*(A \cup B) = m^*(B)$.$BODY$,
    'medium',
    2025,
    'Exercises',
    2,
    $BODY$One inequality is monotonicity ($B \subseteq A \cup B$); the other is finite subadditivity applied to $A \cup B$ with $m^*(A) = 0$.$BODY$,
    $BODY$$m^*(A \cup B) = m^*(B)$.$BODY$,
    $BODY$Suppose $m^*(A) = 0$. Since $B \subseteq A \cup B$, by monotonicity of $m^*$,

$$
\begin{equation*}m^*(B) \le m^*(A \cup B).\end{equation*}
$$

Also, by finite subadditivity,

$$
\begin{aligned}
m^*(A \cup B) &\le m^*(A) + m^*(B) \\
              &= 0 + m^*(B) \\
              &= m^*(B).
\end{aligned}
$$

Therefore, $m^*(A \cup B) = m^*(B)$. $\blacksquare$$BODY$
  ),
  (
    'd0669c91-ab88-4ce5-895f-1e0f1ca54f6a',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    '$m^*(\\mathbb{Q}'' \\cap (0,1)) = 1$',
    $BODY$Let $E = \mathbb{Q}' \cap (0, 1)$. Use the previous item to show that $m^*(E) = 1$.$BODY$,
    'medium',
    2025,
    'Exercises',
    3,
    $BODY$Set $A = \mathbb{Q}$ and $B = E$ in the previous result, so $A \cup B = (0,1)$ and $m^*((0,1)) = 1$.$BODY$,
    $BODY$$m^*(E) = 1$.$BODY$,
    $BODY$Recall that $m^*(\mathbb{Q}) = 0$. Hence, setting $A = \mathbb{Q}$ and $B = E$ in the previous result, we have

$$
\begin{aligned}
m^*(E) = m^*(B) &= m^*(A \cup B) \\
                 &= m^*(\mathbb{Q} \cup E) \\
                 &= m^*((0, 1)) \\
                 &= \ell((0, 1)) = 1.
\end{aligned}
$$

$\blacksquare$$BODY$
  ),
  (
    '33d60932-4ca7-4401-9964-e6631aa51ead',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    '$E$ is Measurable iff $E^c$ is Measurable',
    $BODY$Show that $E$ is measurable if and only if $E^c$ is measurable.$BODY$,
    'easy',
    2025,
    'Exercises',
    4,
    $BODY$The Carathéodory condition is symmetric in $E$ and $E^c$: swap the two terms in $m^*(A) = m^*(A \cap E) + m^*(A \cap E^c)$.$BODY$,
    $BODY$Yes — the definition is symmetric, and $(E^c)^c = E$.$BODY$,
    $BODY$($\Rightarrow$) Suppose $E$ is measurable. Then, for any $A \subseteq \mathbb{R}$,

$$
\begin{aligned}
m^*(A) &= m^*(A \cap E) + m^*(A \cap E^c) \\
       &\implies m^*(A) = m^*(A \cap (E^c)^c) + m^*(A \cap E^c) \\
       &\implies m^*(A) = m^*(A \cap E^c) + m^*(A \cap (E^c)^c).
\end{aligned}
$$

Therefore, $E^c$ is measurable.

($\Leftarrow$) Suppose $E^c$ is measurable. Then $(E^c)^c = E$ is measurable. $\blacksquare$$BODY$
  ),
  (
    '87967d84-9be4-40f4-b15b-4c2fe159bd28',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'The Measure Algebra Identity for Measurable Sets',
    $BODY$Show that if $E_1$ and $E_2$ are measurable sets, then

$$m^*(E_1 \cup E_2) + m^*(E_1 \cap E_2) = m^*(E_1) + m^*(E_2).$$$BODY$,
    'hard',
    2025,
    'Exercises',
    5,
    $BODY$Apply the measurability of $E_1$ first with $A = E_1 \cup E_2$, then with $A = E_2$ (using the measurability of $E_1$). Handle the infinite case separately.$BODY$,
    $BODY$The identity holds by combining the two Carathéodory decompositions (with the infinite case trivial).$BODY$,
    $BODY$Suppose $E_1$ and $E_2$ are measurable sets. Then, for any $A \subseteq \mathbb{R}$,

$$
\begin{equation*}m^*(A) = m^*(A \cap E_1) + m^*(A \cap E_1^c).\end{equation*}
$$

Set $A = E_1 \cup E_2$:

$$
\begin{equation*}m^*(E_1 \cup E_2) = m^*(E_1) + m^*(E_2 \cap E_1^c) \tag{1}\end{equation*}
$$

Set $A = E_2$:

$$
\begin{equation*}m^*(E_2) = m^*(E_2 \cap E_1) + m^*(E_2 \cap E_1^c) \tag{2}\end{equation*}
$$

If either $E_1$ or $E_2$ has infinite outer measure, the equation holds trivially, since then $m^*(E_1 \cup E_2) = \infty$ and $m^*(E_1) + m^*(E_2) = \infty$.

Now, if $m^*(E_1), m^*(E_2) < \infty$, then (2) gives

$$
\begin{equation*}m^*(E_1 \cap E_2) = m^*(E_2) - m^*(E_2 \cap E_1^c).\end{equation*}
$$

Adding this to (1):

$$
\begin{aligned}
m^*(E_1 \cup E_2) + m^*(E_1 \cap E_2) &= m^*(E_1) + m^*(E_2 \cap E_1^c) + m^*(E_2) - m^*(E_2 \cap E_1^c) \\
                                       &= m^*(E_1) + m^*(E_2).
\end{aligned}
$$

This proves the equation, as desired. $\blacksquare$$BODY$
  ),
  (
    '914db4dd-c53d-44a5-8870-b93b81d62993',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Translation Invariance of Measurability',
    $BODY$Show that if $E$ is measurable, then for any $y \in \mathbb{R}$, its translate $E + y = \{x + y : x \in E\}$ is also measurable.$BODY$,
    'hard',
    2025,
    'Exercises',
    6,
    $BODY$Use the translational invariance of outer measure $m^*(X + y) = m^*(X)$, along with $(E + y)^c = E^c + y$, to verify the Carathéodory condition for $E + y$.$BODY$,
    $BODY$The translate $E + y$ satisfies the Carathéodory condition because $m^*$ is translation-invariant.$BODY$,
    $BODY$Suppose $E$ is measurable. Then, for any $A \subseteq \mathbb{R}$,

$$
\begin{equation*}m^*(A) = m^*(A \cap E) + m^*(A \cap E^c).\end{equation*}
$$

Let $y \in \mathbb{R}$. Note that $m^*(X + y) = m^*(X)$ for all $X$ (translational invariance of $m^*$).

Observe that $(E + y)^c = \{x + y : x \notin E\} = E^c + y$. Then,

$$
\begin{aligned}
m^*((A + y) \cap (E + y)) + m^*((A + y) \cap (E + y)^c) &= m^*((A \cap E) + y) + m^*((A \cap E^c) + y) \\
                                                          &= m^*(A \cap E) + m^*(A \cap E^c) \\
                                                          &= m^*(A).
\end{aligned}
$$

It follows that for any $X \subseteq \mathbb{R}$,

$$
\begin{aligned}
m^*(X \cap (E + y)) + m^*(X \cap (E + y)^c) &= m^*((X - y) \cap E) + m^*((X - y) \cap E^c) \\
                                             &= m^*(X - y) \\
                                             &= m^*(X).
\end{aligned}
$$

Therefore, $E + y$ is measurable. $\blacksquare$$BODY$
  ),
  (
    '247b4e9e-ac36-485b-b559-23005825d9a4',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Every Interval is Measurable',
    $BODY$Using the measurability of the interval $(a, \infty)$, show that every interval is measurable.$BODY$,
    'hard',
    2025,
    'Exercises',
    7,
    $BODY$Complements and intersections of measurable sets are measurable, and singletons have measure zero (hence are measurable). Combine these to build every interval type.$BODY$,
    $BODY$Every interval can be built from $(a, \infty)$, its complements, intersections, and null singletons — hence all are measurable.$BODY$,
    $BODY$Let $a, b \in \mathbb{R}$ with $a \le b$. By hypothesis, $(a, \infty)$ and $(b, \infty)$ are measurable. It follows that their complements $(-\infty, b]$ and $(-\infty, a]$ are both measurable.

- $(a, b]$ is measurable since
  $$(a, b] = (a, \infty) \cap (-\infty, b].$$
- $(a, b)$ is measurable since $(a, b) = (a, b] \cap \{b\}^c$, and $m^*(\{b\}) = 0$, so $\{b\}$ is measurable.
- $[a, b)$ is measurable since $[a, b) = (a, b) \cup \{a\}$, and $m^*(\{a\}) = 0$.
- $(-\infty, a)$ is measurable since $(-\infty, a) = (-\infty, a] \cap \{a\}^c$.
- $(-\infty, \infty) = \mathbb{R}$ is measurable since its complement $\varnothing$ is measurable.

Therefore, all intervals are measurable. $\blacksquare$$BODY$
  ),
  (
    '1e85ac9e-3164-4832-b5e8-85deca99ead2',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Measure Version of the Algebra Identity',
    $BODY$If $A$ and $B$ are measurable sets, then

$$m(A \cup B) + m(A \cap B) = m(A) + m(B).$$$BODY$,
    'medium',
    2025,
    'Exercises',
    8,
    $BODY$Apply the previous identity for $m^*$ and use that $A \cup B$ and $A \cap B$ are measurable for measurable $A, B$ (so $m^*$ coincides with $m$ on them).$BODY$,
    $BODY$Follows immediately from the $m^*$ version since all four sets involved are measurable.$BODY$,
    $BODY$Suppose $A$ and $B$ are measurable sets. From the previous result,

$$
\begin{equation*}m^*(A \cup B) + m^*(A \cap B) = m^*(A) + m^*(B).\end{equation*}
$$

Since $A, B$ measurable implies $A \cup B$ and $A \cap B$ are both measurable, the outer measure equals the measure on all four sets. Therefore,

$$
\begin{equation*}m(A \cup B) + m(A \cap B) = m(A) + m(B).\end{equation*}
$$

i.e., the equation holds for measure. $\blacksquare$$BODY$
  ),
  (
    'c3de38c2-19ec-4f21-b978-6e4f153ed04e',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'True or False: Measurability Statements II',
    $BODY$Determine whether each statement is true or false. If the statement is true, provide a proof. Otherwise, give a counterexample.

**(a)** Every subset of a set with outer measure zero is measurable.

**(b)** Every subset of a measurable set is measurable.

**(c)** All uncountable subsets of $\mathbb{R}$ have a positive measure.

**(d)** All subsets of $\mathbb{R}$ that have a positive measure are uncountable.

**(e)** If $E$ is a measurable set such that $\mathbb{Q}$ is a proper subset of $E$, then $m(E) > 0$.

**(f)** If $F$ is a measurable set containing all the irrational numbers, then $m(F) = \infty$.

**(g)** All bounded sets have finite measure.

**(h)** All unbounded sets have infinite measure.

**(i)** Every function defined on a set of measure zero is measurable.

**(j)** Let $f$ and $g$ be functions defined on a measurable set $E$. If $f + g$ and $f$ are measurable on $E$, then $g$ is also measurable.$BODY$,
    'hard',
    2025,
    'Exercises',
    9,
    $BODY$Zero-measure sets are measurable (monotonicity). A subset of a measurable set need not be measurable (Vitali). Uncountable null sets exist (Cantor). Countable sets have measure zero. For (j), write $g = (f + g) + (-1)f$ and use closure under linear combinations.$BODY$,
    $BODY$**(a)** TRUE. **(b)** FALSE. **(c)** FALSE. **(d)** TRUE. **(e)** FALSE. **(f)** TRUE. **(g)** TRUE. **(h)** FALSE. **(i)** TRUE. **(j)** TRUE.$BODY$,
    $BODY$**(a)** **TRUE.** By monotonicity of outer measure, if $m^*(E) = 0$ and $A \subseteq E$, then

$$
\begin{equation*}0 \le m^*(A) \le m^*(E) = 0 \implies m^*(A) = 0.\end{equation*}
$$

Since $A$ has zero outer measure, it is measurable. $\blacksquare$

---

**(b)** **FALSE.** For a nonempty measurable set $E$, we can take a choice set $C_E \subseteq E$ which fails to be measurable (a Vitali-type set). $\blacksquare$

---

**(c)** **FALSE.** The Cantor set $\mathcal{C}$ is uncountable but has zero measure. $\blacksquare$

---

**(d)** **TRUE.** We know that if a set is countable, then it has measure zero. The contrapositive says that a set with positive measure cannot be countable, i.e. it is uncountable. $\blacksquare$

---

**(e)** **FALSE.** Take $E = \mathbb{Q} \cup \{\pi\}$, which is measurable with $\mathbb{Q} \subsetneq E$. However, $m(E) = 0$ since $E$ is countable. $\blacksquare$

---

**(f)** **TRUE.** Note that $m(\mathbb{Q}) = 0$, and since $\mathbb{Q}$ is measurable,

$$
\begin{aligned}
m^*(\mathbb{R}) &= m^*(\mathbb{Q}) + m^*(\mathbb{Q}') \\
\infty &= 0 + m^*(\mathbb{Q}') = m^*(\mathbb{Q}').
\end{aligned}
$$

Now, since $F \supseteq \mathbb{Q}'$, monotonicity of outer measure gives $m^*(F) \ge m^*(\mathbb{Q}') = \infty$. $\blacksquare$

---

**(g)** **TRUE.** $A$ is bounded $\iff$ there exists $M > 0$ such that $|x| \le M$ for all $x \in A$. It follows that

$$
\begin{equation*}A \subseteq [-M, M] \implies m^*(A) \le 2M < \infty.\end{equation*}
$$

$\blacksquare$

---

**(h)** **FALSE.** Consider $\mathbb{Z}$, which is unbounded, but since it is countable, $m^*(\mathbb{Z}) = 0$ (and $m(\mathbb{Z}) = 0$ since $\mathbb{Z}$ is measurable). $\blacksquare$

---

**(i)** **TRUE.** Let $f$ be defined on a measurable set $E$ with $m(E) = 0$. For any $c \in \mathbb{R}$, $\{x \in E : f(x) > c\} \subseteq E$, so by monotonicity of $m^*$,

$$
\begin{equation*}0 \le m^*(\{x \in E : f(x) > c\}) \le m^*(E) = 0 \implies m^*(\{x \in E : f(x) > c\}) = 0.\end{equation*}
$$

So $\{x \in E : f(x) > c\}$ is measurable for any $c \in \mathbb{R}$. Hence, $f$ is measurable. $\blacksquare$

---

**(j)** **TRUE.** Since $g = 1 \cdot (f + g) + (-1) \cdot f$, and the measurable functions on $E$ are closed under linear combinations, $g$ is also measurable. $\blacksquare$$BODY$
  ),
  (
    'e2cc0229-8a28-4fa7-ab6f-d76be4d35d21',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'The Union $\\bigcup_{k=1}^{\\infty} I_k = (0,1)$',
    $BODY$Define $I_k = \left( \frac{1}{k+1}, \frac{1}{k} \right]$, for any $k \in \mathbb{N}$. Determine the infinite union $\displaystyle\bigcup_{k=1}^{\infty} I_k$ and its measure.$BODY$,
    'medium',
    2025,
    'Exercises',
    10,
    $BODY$The intervals $\left(\frac{1}{k+1}, \frac{1}{k}\right]$ are pairwise disjoint and their union is $(0, 1]$; use countable additivity with $\ell(I_k) = \frac{1}{k} - \frac{1}{k+1}$ (telescoping sum).$BODY$,
    $BODY$The union is $(0, 1]$, and $m\left(\bigcup_k I_k\right) = 1$.$BODY$,
    $BODY$Notice that each $I_k$ is measurable, so the union is also measurable, and $\{I_k\}$ is pairwise disjoint.

$$
\begin{equation*}\bigcup_{k=1}^{\infty} I_k = \left(\frac{1}{2}, 1\right] \cup \left(\frac{1}{3}, \frac{1}{2}\right] \cup \left(\frac{1}{4}, \frac{1}{3}\right] \cup \cdots = (0, 1].\end{equation*}
$$

Therefore, by countable additivity,

$$
\begin{equation*}m\left( \bigcup_{k=1}^{\infty} I_k \right) = \sum_{k=1}^{\infty} \left( \frac{1}{k} - \frac{1}{k+1} \right) = \lim_{n \to \infty} \left( 1 - \frac{1}{n+1} \right) = 1 = m((0, 1]).\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '16ae003d-de37-491a-a02d-3f441f408053',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'An Open Set of Arbitrarily Small Measure Containing $\\mathbb{Q}$',
    $BODY$Let $\varepsilon > 0$. Show that there exists an open set $E$ such that $\mathbb{Q} \subset E$ and $m(E) < \varepsilon$.$BODY$,
    'hard',
    2025,
    'Exercises',
    11,
    $BODY$Enumerate $\mathbb{Q} = \{q_1, q_2, \ldots\}$ and cover each $q_k$ by an open interval of length $\varepsilon / 2^{k+1}$; take $E$ to be the union (open).$BODY$,
    $BODY$Cover the countable set $\mathbb{Q}$ by intervals of total length $< \varepsilon$; the union is open, contains $\mathbb{Q}$, and has measure $< \varepsilon$.$BODY$,
    $BODY$Since $\mathbb{Q}$ is countable, write $\mathbb{Q} = \{q_1, q_2, \ldots\}$. Consider the intervals

$$
\begin{equation*}I_k = \left( q_k - \frac{\varepsilon}{2^{k+2}},\ q_k + \frac{\varepsilon}{2^{k+2}} \right),\end{equation*}
$$

with $\ell(I_k) = \varepsilon / 2^{k+1}$. Take $E = \displaystyle\bigcup_{k=1}^{\infty} I_k$, which is open (a countable union of open sets). By subadditivity,

$$
\begin{equation*}m^*(E) \le \sum_{k=1}^{\infty} \ell(I_k) = \sum_{k=1}^{\infty} \frac{\varepsilon}{2^{k+1}} = \frac{\varepsilon}{2} < \varepsilon.\end{equation*}
$$

Also, since $E$ is open, it is measurable, so $m(E) < \varepsilon$. $\blacksquare$$BODY$
  ),
  (
    '64b0fa64-9afe-4de8-ab59-e6ff7ba83772',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Excision Fails for Infinite Measure',
    $BODY$Show through a counterexample that the excision property fails to hold if the measure of the "smaller set" is infinite.$BODY$,
    'medium',
    2025,
    'Exercises',
    12,
    $BODY$The excision property is $m^*(A \setminus B) = m^*(A) - m^*(B)$ for $B \subseteq A$ with $m^*(B) < \infty$. Take $B = [1, \infty)$ and $A = (0, \infty)$: both have infinite measure, but the difference has measure $1$.$BODY$,
    $BODY$For $B = [1,\infty) \subseteq A = (0,\infty)$, $m^*(A) = m^*(B) = \infty$ but $m^*(A \setminus B) = 1 \neq \infty - \infty$.$BODY$,
    $BODY$Recall that the excision property states

$$
\begin{equation*}m^*(A \setminus B) = m^*(A) - m^*(B)\end{equation*}
$$

where $B \subseteq A$ and $m^*(B) < \infty$.

Now take $B = [1, \infty)$ and $A = (0, \infty)$, so that $B \subseteq A$. Then

$$
\begin{equation*}m^*(B) = \ell([1, \infty)) = \infty = \ell((0, \infty)) = m^*(A).\end{equation*}
$$

However, $A \setminus B = (0, 1)$, so

$$
\begin{equation*}m^*(A \setminus B) = m^*((0, 1)) = \ell((0, 1)) = 1.\end{equation*}
$$

Clearly, $1 \neq \infty - \infty$.

Hence, the excision property fails to hold when $m^*(B) = \infty$. $\blacksquare$$BODY$
  ),
  (
    'e0a0deb6-7ebc-406d-b4bd-120f5c2bddaa',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Why Subadditivity Can Be Strict',
    $BODY$Justify why there should exist two disjoint sets $A$ and $B$ such that

$$m^*(A \cup B) < m^*(A) + m^*(B).$$$BODY$,
    'hard',
    2025,
    'Exercises',
    13,
    $BODY$If equality always held for disjoint sets, outer measure would be finitely additive, contradicting the existence of nonmeasurable sets. Take $A = X \cap E$ and $B = X \cap E^c$ for a nonmeasurable $E$.$BODY$,
    $BODY$For a nonmeasurable set $E$ and $X$ witnessing the failure, $A = X \cap E$ and $B = X \cap E^c$ are disjoint with $m^*(A \cup B) < m^*(A) + m^*(B)$.$BODY$,
    $BODY$Recall that by finite subadditivity of outer measure,

$$
\begin{equation*}m^*(A \cup B) \le m^*(A) + m^*(B).\end{equation*}
$$

We know that $E$ is measurable iff for all $X \subseteq \mathbb{R}$,

$$
\begin{equation*}m^*(X) = m^*(X \cap E) + m^*(X \cap E^c).\end{equation*}
$$

It follows that $E$ is **not** measurable iff there exists $X \subseteq \mathbb{R}$ such that

$$
\begin{equation*}m^*(X) \neq m^*(X \cap E) + m^*(X \cap E^c).\end{equation*}
$$

Therefore we can take $A = X \cap E$ and $B = X \cap E^c$, so that $A$ and $B$ are disjoint and

$$
\begin{aligned}
A \cup B &= (X \cap E) \cup (X \cap E^c) = X \\
&\implies m^*(A \cup B) \neq m^*(A) + m^*(B) \\
&\implies m^*(A \cup B) < m^*(A) + m^*(B).
\end{aligned}
$$

Therefore, by the existence of nonmeasurable sets, such $A$ and $B$ must exist. $\blacksquare$$BODY$
  ),
  (
    '654f39ee-9359-4326-a5e7-68ca1370d80e',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Characteristic Functions and Measurability',
    $BODY$For any subset $A$ of $\mathbb{R}$, define the function $\chi_A : \mathbb{R} \to \mathbb{R}$ by

$$\chi_A(x) = \begin{cases} 1, & \text{if } x \in A, \\ 0, & \text{if } x \notin A. \end{cases}$$

**(a)** Let $A$ and $B$ be two subsets of $\mathbb{R}$. Show that

$$\chi_{A \cap B} = \chi_A \cdot \chi_B \quad \text{and} \quad \chi_{A^c} = 1 - \chi_A.$$

**(b)** Show that $A$ is measurable if and only if $\chi_A$ is a measurable function.$BODY$,
    'hard',
    2025,
    'Exercises',
    14,
    $BODY$For (a), check the two identities pointwise: $\chi_A(x)\chi_B(x) = 1$ iff $x \in A \cap B$, and $1 - \chi_A(x) = 1$ iff $x \notin A$. For (b), use the cases $c < 0$, $0 \le c < 1$, $c \ge 1$, and $\{x : \chi_A(x) \ge 1\} = A$.$BODY$,
    $BODY$**(a)** Both identities hold pointwise. **(b)** $A$ measurable $\iff \chi_A$ measurable.$BODY$,
    $BODY$**(a)** Clearly, $\operatorname{dom}(\chi_{A \cap B}) = \operatorname{dom}(\chi_A \cdot \chi_B) = \mathbb{R}$.

Let $x \in \mathbb{R}$. If $x \in A \cap B$, then $x \in A$ and $x \in B$, so $\chi_{A \cap B}(x) = 1$ and $\chi_A(x) = \chi_B(x) = 1$. Hence,

$$
\begin{equation*}\chi_{A \cap B}(x) = 1 = 1 \cdot 1 = \chi_A(x) \cdot \chi_B(x) = (\chi_A \cdot \chi_B)(x).\end{equation*}
$$

If $x \notin A \cap B$, then $x \notin A$ or $x \notin B$, so $\chi_{A \cap B}(x) = 0$ and at least one of $\chi_A(x), \chi_B(x)$ is $0$. Hence,

$$
\begin{equation*}\chi_{A \cap B}(x) = 0 = \chi_A(x) \cdot \chi_B(x) = (\chi_A \cdot \chi_B)(x).\end{equation*}
$$

Therefore, $\chi_{A \cap B} = \chi_A \cdot \chi_B$.

Clearly, $\operatorname{dom}(\chi_{A^c}) = \operatorname{dom}(1 - \chi_A) = \mathbb{R}$. Let $x \in \mathbb{R}$. If $x \in A^c$, i.e. $x \notin A$, then $\chi_{A^c}(x) = 1$ and $\chi_A(x) = 0$, so

$$
\begin{equation*}\chi_{A^c}(x) = 1 = 1 - 0 = 1 - \chi_A(x) = (1 - \chi_A)(x).\end{equation*}
$$

If $x \notin A^c$, i.e. $x \in A$, then $\chi_{A^c}(x) = 0$ and $\chi_A(x) = 1$, so

$$
\begin{equation*}\chi_{A^c}(x) = 0 = 1 - 1 = 1 - \chi_A(x) = (1 - \chi_A)(x).\end{equation*}
$$

Therefore, $\chi_{A^c} = 1 - \chi_A$. $\blacksquare$

---

**(b)** $(\Rightarrow)$ Suppose $A$ is measurable. Note that $\operatorname{dom}(\chi_A) = \mathbb{R}$ is measurable. Let $c \in \mathbb{R}$.

- If $c < 0$, then $\{x \in \mathbb{R} : \chi_A(x) \le c\} = \varnothing$, which is measurable.
- If $0 \le c < 1$, then $\{x \in \mathbb{R} : \chi_A(x) \le c\} = A^c$, which is measurable.
- If $c \ge 1$, then $\{x \in \mathbb{R} : \chi_A(x) \le c\} = \mathbb{R}$, which is measurable.

Hence, for any $c \in \mathbb{R}$, the set $\{x \in \mathbb{R} : \chi_A(x) < c\}$ is measurable. So $\chi_A$ is measurable.

$(\Leftarrow)$ Suppose $\chi_A$ is measurable. Then, for any $c \in \mathbb{R}$, the set $\{x \in \mathbb{R} : \chi_A(x) \ge c\}$ is measurable. Therefore, the set $\{x \in \mathbb{R} : \chi_A(x) \ge 1\} = A$ is measurable. $\blacksquare$$BODY$
  ),
  (
    'a6c29d4c-2cb4-4f9b-8be9-a55ecc01485c',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'A Nonmeasurable Function on a Measurable Set',
    $BODY$Give an example of a nonmeasurable function defined on a measurable set $E$.$BODY$,
    'hard',
    2025,
    'Exercises',
    15,
    $BODY$Take $E \neq \varnothing$ measurable and a choice set $C_E \subseteq E$ (nonmeasurable). Define $f = \chi_{C_E}$ on $E$; then $\{x \in E : f(x) \ge 1\} = C_E$ is not measurable.$BODY$,
    $BODY$The characteristic function $\chi_{C_E}$ of a nonmeasurable choice set $C_E \subseteq E$ is nonmeasurable even though its domain $E$ is measurable.$BODY$,
    $BODY$Suppose $E \neq \varnothing$ is a measurable set, and let $C_E \subseteq E$ be a choice set, which is not measurable. Define $f : E \to \mathbb{R}$ by

$$
\begin{equation*}f(x) = \begin{cases} 1, & \text{if } x \in C_E, \\ 0, & \text{if } x \in E \setminus C_E. \end{cases}\end{equation*}
$$

Although its domain $E$ is measurable, taking $c = 1$, the set

$$
\begin{equation*}\{x \in E : f(x) \ge 1\} = C_E\end{equation*}
$$

fails to be measurable.

Therefore $f$ is a nonmeasurable function defined on a measurable set $E$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
