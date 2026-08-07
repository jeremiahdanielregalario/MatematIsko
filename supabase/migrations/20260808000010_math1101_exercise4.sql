-- ============================================================================
-- Math 110.1 Exercise 4 — subgroups, center, centralizer
-- 5 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'a4445f19-10b9-4d4c-aa62-cb15ef2ac4e9',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Subgroups of $\\mathbb{Z}_8$',
    $BODY$Which of the following subsets are subgroups of $\mathbb{Z}_8$ under addition modulo $8$? If the subset is not a subgroup, identify at least one condition that is not satisfied.

**(a)** $\{0, 2\}$

**(b)** $\{0, 2, 4, 6\}$

**(c)** $\{1, 3, 5, 7\}$

**(d)** $\{0, 4\}$ $BODY$,
    'medium',
    2026,
    'Exercise 4',
    1,
    $BODY$For each subset, check: (1) closure under addition mod 8, (2) identity $0 \in H$, and (3) every element has an inverse in $H$. If any fails, the subset is not a subgroup.$BODY$,
    $BODY$**(a)** Not a subgroup. **(b)** Yes, subgroup. **(c)** Not a subgroup. **(d)** Yes, subgroup.$BODY$,
    $BODY$**(a)** $\{0, 2\}$ — **Not a subgroup.**

Consider $2 \in \{0, 2\}$. Since $0 +_8 2 = 2 \neq 0$ and $2 +_8 2 = 4 \neq 0$, the element $2$ has no inverse in $\{0, 2\}$.

$\therefore$ $\{0, 2\} \not\leq \mathbb{Z}_8$. $\blacksquare$

---

**(b)** $\{0, 2, 4, 6\}$ — **Subgroup.**

*Claim*: $\{0, 2, 4, 6\} \leq \mathbb{Z}_8$.

*Proof*.

| $+_8$ | $0$ | $2$ | $4$ | $6$ |
|---|---|---|---|---|
| $0$ | $0$ | $2$ | $4$ | $6$ |
| $2$ | $2$ | $4$ | $6$ | $0$ |
| $4$ | $4$ | $6$ | $0$ | $2$ |
| $6$ | $6$ | $0$ | $2$ | $4$ |

(i.) By the constructed Cayley table, $\{0, 2, 4, 6\}$ is closed under $+_8$.

(ii.) The identity $0$ of $\mathbb{Z}_8$ is in $\{0, 2, 4, 6\}$.

(iii.) Every element has an inverse, i.e. $-0 = 0$, $-2 = 6$, $-4 = 4$, $-6 = 2$.

$\therefore$ $\{0, 2, 4, 6\} \leq \mathbb{Z}_8$. $\blacksquare$

---

**(c)** $\{1, 3, 5, 7\}$ — **Not a subgroup.**

The identity element $0$ of $\mathbb{Z}_8$ is not in $\{1, 3, 5, 7\}$.

$\therefore$ $\{1, 3, 5, 7\} \not\leq \mathbb{Z}_8$. $\blacksquare$

---

**(d)** $\{0, 4\}$ — **Subgroup.**

*Claim*: $\{0, 4\} \leq \mathbb{Z}_8$.

*Proof*.

| $+_8$ | $0$ | $4$ |
|---|---|---|
| $0$ | $0$ | $4$ |
| $4$ | $4$ | $0$ |

(i.) By the constructed Cayley table, $\{0, 4\}$ is closed under $+_8$.

(ii.) The identity $0$ of $\mathbb{Z}_8$ is in $\{0, 4\}$.

(iii.) Every element has an inverse, i.e. $-0 = 0$, $-4 = 4$.

$\therefore$ $\{0, 4\} \leq \mathbb{Z}_8$. $\blacksquare$$BODY$
  ),
  (
    '9eb4971d-7ad7-4796-8ca8-9bef20c04710',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'All Subgroups of $\\mathbb{Z}_4$',
    $BODY$Consider the group $\mathbb{Z}_4 = \{0, 1, 2, 3\}$ under addition modulo $4$. Among all the possible subsets of $\mathbb{Z}_4$, identify which of them are subgroups of $\mathbb{Z}_4$. Determine how many subgroups of $\mathbb{Z}_4$ have order $1$, $2$, $3$, and $4$.$BODY$,
    'medium',
    2026,
    'Exercise 4',
    2,
    $BODY$List all $2^4 = 16$ subsets and check the subgroup conditions for each. Apply Lagrange's theorem to rule out subgroups of order 3.$BODY$,
    $BODY$Order 1: $\{0\}$ (1 subgroup). Order 2: $\{0, 2\}$ (1 subgroup). Order 3: none. Order 4: $\mathbb{Z}_4$ (1 subgroup). Total: 3 subgroups.$BODY$,
    $BODY$Subsets of $\mathbb{Z}_4$:

$$\varnothing, \{0\}, \{1\}, \{2\}, \{3\}, \{1, 2\}, \{2, 3\}, \{0, 3\}, \{1, 3\}, \{0, 2\}, \{0, 1\}, \{1, 2, 3\}, \{0, 2, 3\}, \{0, 1, 3\}, \{0, 1, 2\}, \mathbb{Z}_4$$

Subgroups:

- **Order 1:** $\{0\}$ (count: $1$)
- **Order 2:** $\{0, 2\}$ (count: $1$)
- **Order 3:** none (by Lagrange's theorem, $3 \nmid 4$, so no subgroup of order $3$ exists)
- **Order 4:** $\mathbb{Z}_4$ (count: $1$)

$\therefore$ $\mathbb{Z}_4$ has exactly **3 subgroups**. $\blacksquare$$BODY$
  ),
  (
    '5cb8ff00-2a92-424b-a39b-562c6c92cd61',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'All Subgroups of $U(8)$',
    $BODY$Consider the group $U(8) = \{1, 3, 5, 7\}$ under multiplication modulo $8$. Among all the possible subsets of $U(8)$, identify which of them are subgroups of $U(8)$. Determine how many subgroups of $U(8)$ have order $1$, $2$, $3$, and $4$.$BODY$,
    'medium',
    2026,
    'Exercise 4',
    3,
    $BODY$List all $2^4 = 16$ subsets and check the subgroup conditions for each. Use the Cayley table from Exercise 3 part (c) to verify closure.$BODY$,
    $BODY$Order 1: $\{1\}$ (1 subgroup). Order 2: $\{1, 3\}, \{1, 5\}, \{1, 7\}$ (3 subgroups). Order 3: none. Order 4: $U(8)$ (1 subgroup). Total: 5 subgroups.$BODY$,
    $BODY$Subsets of $U(8)$:

$$\varnothing, \{1\}, \{3\}, \{5\}, \{7\}, \{1, 3\}, \{3, 5\}, \{5, 7\}, \{1, 7\}, \{1, 5\}, \{3, 7\}, \{1, 3, 5\}, \{1, 5, 7\}, \{3, 5, 7\}, \{1, 3, 7\}, U(8)$$

Subgroups:

- **Order 1:** $\{1\}$ (count: $1$)
- **Order 2:** $\{1, 3\},\, \{1, 5\},\, \{1, 7\}$ (count: $3$)
- **Order 3:** none (by Lagrange's theorem, $3 \nmid 4$)
- **Order 4:** $U(8)$ (count: $1$)

$\therefore$ $U(8)$ has exactly **5 subgroups**. $\blacksquare$$BODY$
  ),
  (
    '9cb9e69b-74d1-4e86-8f8f-fe2152ca91d6',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Center $C(G)$ is a Subgroup',
    $BODY$Suppose $G$ is a group. Show that the set

$$C(G) = \{x \in G \mid xg = gx \text{ for all } g \in G\}$$

is a subgroup of $G$ which is abelian. (This subgroup is called the center of the group $G$.)$BODY$,
    'hard',
    2026,
    'Exercise 4',
    4,
    $BODY$Use the one-step subgroup test: show that for any $a, b \in C(G)$, the element $ab^{-1}$ commutes with every $g \in G$. Then show $C(G)$ is abelian by noting its elements all commute with each other.$BODY$,
    $BODY$$C(G) \leq G$ by the one-step subgroup test, and $C(G)$ is abelian since all its elements commute with every element of $G$.$BODY$,
    $BODY$Clearly, $C(G) \subseteq G$ by definition.

**One-Step Subgroup Test**

Let $a, b \in C(G)$. Then, $a, b \in G$ and for any $g \in G$, $ag = ga$ and $bg = gb$. It follows that $b^{-1} \in G$ and $b = gbg^{-1}$, so

$$
\begin{equation*}b^{-1} = (gbg^{-1})^{-1} = gb^{-1}g^{-1}.\end{equation*}
$$

Let $g \in G$. Then,

$$
\begin{aligned}
(ab^{-1})g &= ab^{-1}g = b^{-1}ag = b^{-1}ga = (gb^{-1}g^{-1})ga = gb^{-1}a = g(ab^{-1}).
\end{aligned}
$$

Hence, $ab^{-1} \in C(G)$. $\therefore$ $C(G) \leq G$.

Let $a, b \in C(G)$. Then, $a, b \in G$ and $ab = ba$.

$\therefore$ $C(G)$ is a subgroup of $G$ which is abelian. $\blacksquare$$BODY$
  ),
  (
    'f26e7cfd-4856-4c8a-96b7-dcc7682d44c1',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Centralizer $C_a$ is a Subgroup',
    $BODY$Let $G$ be a group. Fix an element $a \in G$. Show that the set

$$C_a = \{g \in G \mid ag = ga\}$$

is a subgroup of $G$. (This subgroup is called the centralizer of $a$ in $G$.)$BODY$,
    'hard',
    2026,
    'Exercise 4',
    5,
    $BODY$Use the three-step subgroup test: check closure, identity, and inverses directly. For closure, if $ag = ga$ and $ah = ha$, show $a(gh) = (gh)a$. For inverses, show $a h^{-1} = h^{-1} a$ from $ah = ha$.$BODY$,
    $BODY$$C_a \leq G$. Closure: $ag = ga$ and $ah = ha$ imply $a(gh) = (gh)a$. Identity: $ae = ea$. Inverses: $ah = ha$ implies $ah^{-1} = h^{-1}a$.$BODY$,
    $BODY$$\subseteq$): Clearly, by definition, $C_a \subseteq G$.

Let $g, h \in C_a$. Then, $ag = ga$ and $ah = ha$. Then,

$$
\begin{equation*}agh = ag(h) = g(a h) = g(ha) = (gh)a.\end{equation*}
$$

Hence $gh \in C_a$.

Let $e$ be the identity in $G$. Clearly, $ae = ea$. Hence, $e \in C_a$.

Let $h \in C_a$. Then,

$$
\begin{equation*}ah = ha \implies h^{-1}a = ah^{-1} \implies ah^{-1} = h^{-1}a \implies h^{-1} \in C_a.\end{equation*}
$$

$\therefore$ $C_a \leq G$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
