-- ============================================================================
-- Math 110.1 Exercise 2 — Group axioms, abelian groups
-- 5 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Which of the following are groups?
    'a1b4d83e-6712-4589-a961-34823ae4d87d',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Which of the Following Are Groups?',
    $BODY$Which of the following are groups?

**(a)** $\{1, 2, 3, 4, 5\}$ under multiplication modulo $6$.

**(b)** $\{1, 2, 3, 4\}$ under multiplication modulo $5$.

**(c)** $\{1, 3, 5, 7\}$ under multiplication modulo $8$.$BODY$,
    'medium',
    2026,
    'Exercise 2',
    1,
    $BODY$For each part, check closure first (is the set closed under the operation?), then verify the remaining axioms.$BODY$,
    $BODY$**(a)** No — not a group. **(b)** Yes — a group. **(c)** Yes — a group.$BODY$,
    $BODY$**(a)** $\{1, 2, 3, 4, 5\}$ under multiplication modulo $6$.

Consider $2, 3 \in \{1, 2, 3, 4, 5\}$ and notice that $2 \cdot_6 3 = 0 \notin \{1, 2, 3, 4, 5\}$.

$\therefore$ $\langle \{1, 2, 3, 4, 5\},\, \cdot_6 \rangle$ is **not** a group, since $\cdot_6$ fails to be a binary operation. $\blacksquare$

---

**(b)** $\{1, 2, 3, 4\}$ under multiplication modulo $5$.

| $\cdot_5$ | $1$ | $2$ | $3$ | $4$ |
|---|---|---|---|---|
| $1$ | $1$ | $2$ | $3$ | $4$ |
| $2$ | $2$ | $4$ | $1$ | $3$ |
| $3$ | $3$ | $1$ | $4$ | $2$ |
| $4$ | $4$ | $3$ | $2$ | $1$ |

By the constructed Cayley table, $\{1, 2, 3, 4\}$ is closed under $\cdot_5$.

$\mathcal{G}_1$: Clearly, $\cdot_5$ is associative.

$\mathcal{G}_2$: Consider $1 \in \{1, 2, 3, 4\}$. By the constructed Cayley table, for all $g \in \{1, 2, 3, 4\}$, $1 \cdot_5 g = g \cdot_5 1 = g$. Hence, $1$ is the identity in $\{1, 2, 3, 4\}$.

$\mathcal{G}_3$: By the constructed Cayley table, every element has an inverse, i.e.

$$
\begin{equation*}1^{-1} = 1, \qquad 2^{-1} = 3, \qquad 3^{-1} = 2, \qquad 4^{-1} = 4.\end{equation*}
$$

$\therefore$ $\langle \{1, 2, 3, 4\},\, \cdot_5 \rangle$ is a group. $\blacksquare$

---

**(c)** $\{1, 3, 5, 7\}$ under multiplication modulo $8$.

| $\cdot_8$ | $1$ | $3$ | $5$ | $7$ |
|---|---|---|---|---|
| $1$ | $1$ | $3$ | $5$ | $7$ |
| $3$ | $3$ | $1$ | $7$ | $5$ |
| $5$ | $5$ | $7$ | $1$ | $3$ |
| $7$ | $7$ | $5$ | $3$ | $1$ |

By the constructed Cayley table, $\{1, 3, 5, 7\}$ is closed under $\cdot_8$.

$\mathcal{G}_1$: Clearly, $\cdot_8$ is associative.

$\mathcal{G}_2$: Consider $1 \in \{1, 3, 5, 7\}$. By the constructed Cayley table, for all $g \in \{1, 3, 5, 7\}$, $1 \cdot_8 g = g \cdot_8 1 = g$. Hence, $1$ is the identity in $\{1, 3, 5, 7\}$.

$\mathcal{G}_3$: By the constructed Cayley table, every element has an inverse, i.e.

$$
\begin{equation*}1^{-1} = 1, \qquad 3^{-1} = 3, \qquad 5^{-1} = 5, \qquad 7^{-1} = 7.\end{equation*}
$$

$\therefore$ $\langle \{1, 3, 5, 7\},\, \cdot_8 \rangle$ is a group. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — <R \ {-1}, *> abelian group
    '56edfd24-30b2-4843-a6bb-6caa22884078',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Abelian Group: $a * b = a + b + ab$ on $\\mathbb{R} \\setminus \\{-1\\}$',
    $BODY$Let $G = \mathbb{R} \setminus \{-1\}$ and define $*$ on $G$ by $a * b = a + b + ab$. Prove that $\langle G, * \rangle$ is an abelian group.$BODY$,
    'hard',
    2026,
    'Exercise 2',
    2,
    $BODY$Verify all four group axioms. For closure, note that $a * b + 1 = (1 + a)(1 + b)$, and use this to check $a * b \neq -1$. The identity is $0$.$BODY$,
    $BODY$$\langle G, * \rangle$ is an abelian group with identity $0$.$BODY$,
    $BODY$**(closure)** Let $a, b \in G$. Then $a, b \in \mathbb{R}$ and $a, b \neq -1$. It follows that

$$
\begin{equation*}a * b = a + b + ab = (1 + a)(1 + b) - 1 \in \mathbb{R}.\end{equation*}
$$

Also, since $a, b \neq -1$,

$$
\begin{equation*}a * b = (1 + a)(1 + b) - 1 \neq 0 - 1 = -1.\end{equation*}
$$

Hence, $a * b \in \mathbb{R} \setminus \{-1\} = G$.

**(G₁)** Let $a, b, c \in G$. Then $a, b, c \in \mathbb{R}$ and $a, b, c \neq -1$. It follows that

$$
\begin{aligned}
a * (b * c) &= a * (b + c + bc) \\
            &= a + (b + c + bc) + a(b + c + bc) \\
            &= a + b + c + bc + ab + ac + abc \\
            &= a + b + ab + c + ac + bc + abc \\
            &= (a + b + ab) + c + (a + b + ab)c \\
            &= (a * b) * c.
\end{aligned}
$$

**(G₂)** Consider $0 \in G$. Let $g \in G$. Then $g \in \mathbb{R}$ and $g \neq -1$. Then,

$$
\begin{equation*}0 * g = 0 + g + 0 \cdot g = g = g + 0 + g \cdot 0 = g * 0.\end{equation*}
$$

Therefore, $0$ is the identity in $G$.

**(G₃)** Let $g \in G$. Then $g \in \mathbb{R}$ and $g \neq -1$. Consider $g' = \dfrac{-g}{1 + g} \in \mathbb{R}$ since $g \neq -1$. Also, $g' \neq -1$ since otherwise,

$$
\begin{equation*}-1 = \frac{-g}{1 + g} \implies 1 + g = g \implies 1 = 0 \quad \bot.\end{equation*}
$$

So $g' \in G$ and

$$
\begin{aligned}
g * g' &= g + \frac{-g}{1 + g} + \frac{-g^2}{1 + g} = \frac{g(1 + g) - g - g^2}{1 + g} = \frac{0}{1 + g} = 0, \\
g' * g &= \frac{-g}{1 + g} + g + \frac{-g^2}{1 + g} = \frac{-g + g(1 + g) - g^2}{1 + g} = \frac{0}{1 + g} = 0.
\end{aligned}
$$

Hence, $g'$ is the inverse of $g$.

**(comm.)** Let $g, h \in G$. Then,

$$
\begin{equation*}g * h = g + h + gh = h + g + hg = h * g.\end{equation*}
$$

$\therefore$ $\langle G, * \rangle$ is an abelian group. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — If x² = e for all x, then G is abelian
    'bab873fc-c323-48a1-a78c-012cd54caa28',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    '$x^2 = e$ for All $x$ Implies Abelian',
    $BODY$Let $G$ be a group with identity $e$. Prove that if $x^2 = e$ for all $x \in G$, then $G$ is abelian.$BODY$,
    'medium',
    2026,
    'Exercise 2',
    3,
    $BODY$Note that $x^2 = e$ means $x \cdot x = e$, so $x = x^{-1}$ for every $x$. Then show $ab = ba$ using the identity $(ab)^{-1} = b^{-1} a^{-1}$.$BODY$,
    $BODY$$G$ is abelian because $x = x^{-1}$ for every $x \in G$, so $ab = (ab)^{-1} = b^{-1} a^{-1} = ba$.$BODY$,
    $BODY$Since $G$ is a group, it suffices to show that the operation in $G$ is commutative.

Suppose that for all $x \in G$, $x^2 = e$. Let $a, b \in G$. Then $ab \in G$ and $a^2 = b^2 = e$. It follows that

$$
\begin{equation*}a^2 = e \implies a \cdot a^{-1} \implies \text{C.L. } a = a^{-1},\end{equation*}
$$

so similarly, $b = b^{-1}$, and $ab = (ab)^{-1}$.

Then it follows that

$$
\begin{equation*}ab = (ab)^{-1} = b^{-1} a^{-1} = ba.\end{equation*}
$$

$\therefore$ $G$ is abelian. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — ab = ca implies b = c, then G is abelian
    '061d247d-c615-4e1a-93ca-4a07772b9880',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    '$ab = ca$ Implies $b = c$, Then $G$ is Abelian',
    $BODY$Suppose $G$ is a group with the property that for any $a, b, c \in G$, $ab = ca$ implies $b = c$. Prove that $G$ is abelian.$BODY$,
    'hard',
    2026,
    'Exercise 2',
    4,
    $BODY$Use the given property with carefully chosen values for $a$, $b$, and $c$ — for instance, take $c = a^{-1}$ and $b = ab$.$BODY$,
    $BODY$$G$ is abelian. Applying the property to $(a \cdot ab) = (ab) \cdot a$ gives $ab = ba$.$BODY$,
    $BODY$Let $a, b \in G$. Then, $a^{-1}, b^{-1}, ab, (ab)^{-1} \in G$. It follows that

$$
\begin{aligned}
e &= e \\
  &\implies (ab)^{-1}(ab) = (b^{-1} b)(a a^{-1}) \\
  &\implies b^{-1} a^{-1} a b = b^{-1} b a a^{-1} \\
  &\implies \text{C.L. } (a^{-1}) ab = ba(a^{-1}) \\
  &\implies ab = ba.
\end{aligned}
$$

$\therefore$ $G$ is abelian. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Center is closed under *
    '61d91651-8212-4040-a13d-330e16f45d9d',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Center of a Group is Closed Under $*$',
    $BODY$Suppose $\langle G, * \rangle$ is a group. Show that the set $H = \{a \in G \mid a * g = g * a \text{ for all } g \in G\}$ is closed under $*$.$BODY$,
    'medium',
    2026,
    'Exercise 2',
    5,
    $BODY$Let $a, b \in H$ and use associativity along with the definition of $H$ to show $(a * b) * g = g * (a * b)$ for all $g \in G$.$BODY$,
    $BODY$$H$ is closed under $*$. For any $a, b \in H$, $(a * b) * g = g * (a * b)$ for all $g$, so $a * b \in H$.$BODY$,
    $BODY$Let $a, b \in H$. Then, $a, b \in G$ and for any $g \in G$, $a * g = g * a$ and $b * g = g * b$.

Then, for any $g \in G$, we have:

$$
\begin{aligned}
(a * b) * g &= a * (b * g) \\
            &= a * (g * b) \\
            &= (a * g) * b \\
            &= (g * a) * b \\
            &= g * (a * b).
\end{aligned}
$$

Hence, $a * b \in H$.

$\therefore$ $H$ is closed under $*$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
