-- ============================================================================
-- Math 110.1 Exercise 1 — Division Algorithm, Congruences, Equivalence Relations
-- 5 problems with solutions from a typed homework set, converted from
-- Typst to the app's Markdown + LaTeX format.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. New topic for divisibility / congruence / equivalence-relation content
-- ---------------------------------------------------------------------------
insert into public.topics (id, course_id, name, description)
values
  (
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'Equivalence Relations and Congruence',
    'Division algorithm, congruence modulo n, and equivalence relations on Z and R.'
  )
on conflict (course_id, name) do nothing;

-- ---------------------------------------------------------------------------
-- 2. Questions — uses $BODY$ dollar-quoting to avoid conflict with $q$
--    appearing inline in LaTeX content (e.g., "the quotient is $q$").
-- ---------------------------------------------------------------------------
insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Scaling the Division Algorithm by n
    'fb389828-11b4-4797-9c9c-5ad50167622a',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'Scaling the Division Algorithm by $n$',
    $BODY$Let $a, m, n \in \mathbb{Z}$ with $m, n > 0$. Suppose $q$ and $r$ are the quotient and remainder, respectively, when $a$ is divided by $m$. Show that the quotient and remainder when $an$ is divided by $mn$ are $q$ and $rn$, respectively. (Do not forget to justify why $rn$ satisfies the necessary restrictions for a remainder.)$BODY$,
    'medium',
    2026,
    'Exercise 1',
    1,
    $BODY$Use the Division Algorithm to write $a = mq + r$ with $0 \le r < m$, then multiply both sides by $n$.$BODY$,
    $BODY$The quotient is $q$ and the remainder is $rn$. Since $0 \le r < m$ and $n > 0$, we have $0 \le rn < mn$.$BODY$,
    $BODY$By the Division Algorithm in $\mathbb{Z}$, we can express $a$ as

$$
\begin{equation*}a = mq + r, \qquad 0 \le r < m.\end{equation*}
$$

Multiply both sides by $n$:

$$
\begin{equation*}an = (mq + r)n = (mn)q + rn.\end{equation*}
$$

Since $n > 0$, the inequality $0 \le r < m$ gives

$$
\begin{equation*}0 \le rn < mn,\end{equation*}
$$

so $rn$ satisfies the necessary restrictions for a remainder when $an$ is divided by $mn$.

$\therefore$ $q$ and $rn$ are the quotient and remainder when $an$ is divided by $mn$, respectively. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Extended Division Algorithm for Negative Divisors
    '407cba62-eb95-4787-bf02-f6b7a09633ee',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'Extended Division Algorithm with $n < 0$',
    $BODY$Prove the extended division algorithm: Let $m, n \in \mathbb{Z}$ with $n \neq 0$. Then there exist unique integers $q, r$ such that $m = nq + r$ with $0 \le r < |n|$.$BODY$,
    'hard',
    2026,
    'Exercise 1',
    2,
    $BODY$Split into the cases $n > 0$ and $n < 0$; in the second case, apply the Division Algorithm with $|n|$ and relabel.$BODY$,
    $BODY$There exist unique integers $q, r$ with $m = nq + r$ and $0 \le r < |n|$.$BODY$,
    $BODY$Since $n \neq 0$, either $n > 0$ or $n < 0$. The case $n > 0$ is already given by the Division Algorithm in $\mathbb{Z}$, so it suffices to show that the statement also holds when $n < 0$.

Suppose $n < 0$. Then $|n| = -n > 0$. By the Division Algorithm in $\mathbb{Z}$, there exist unique $q', r \in \mathbb{Z}$ such that

$$
\begin{aligned}
m &= |n|\,q' + r \\
  &= (-n)\,q' + r \\
  &= -nq' + r, \qquad 0 \le r < |n|.
\end{aligned}
$$

Consider $q = -q' \in \mathbb{Z}$. Then,

$$
\begin{equation*}m = -nq' + r = n(-q') + r = nq + r.\end{equation*}
$$

Since the existence of $q'$ and $r$ is unique, it follows that $q$ and $r$ are also the unique integers satisfying $m = nq + r$ with $0 \le r < |n|$.

Hence, there exist unique integers $q, r$ such that $m = nq + r$ with $0 \le r < |n|$, proving the extended division algorithm. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Congruence Modulo n Respects Addition
    'a24742e9-03c6-4787-b25d-274875a26219',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'Congruence Modulo $n$ Respects Addition',
    $BODY$Let $n \in \mathbb{Z}$ and $n > 0$ and let $\sim$ denote the equivalence relation congruence modulo $n$ on $\mathbb{Z}$. Prove that if $a_1 \sim a_2$ and $b_1 \sim b_2$, then $(a_1 + b_1) \sim (a_2 + b_2)$.$BODY$,
    'medium',
    2026,
    'Exercise 1',
    3,
    $BODY$Rewrite the hypotheses as congruences modulo $n$, then add the two congruences.$BODY$,
    $BODY$$(a_1 + b_1) \equiv (a_2 + b_2) \pmod{n}$$

so $(a_1 + b_1) \sim (a_2 + b_2)$.$BODY$,
    $BODY$Suppose $a_1 \sim a_2$ and $b_1 \sim b_2$. It follows that

$$
\begin{equation*}a_1 \equiv a_2 \pmod{n} \qquad \text{and} \qquad b_1 \equiv b_2 \pmod{n}.\end{equation*}
$$

By the additive property of congruence, we have

$$
\begin{equation*}a_1 + b_1 \equiv a_2 + b_2 \pmod{n}.\end{equation*}
$$

$\therefore$ $(a_1 + b_1) \sim (a_2 + b_2)$. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — Equivalence Classes of Parity
    '94565809-4103-44b3-b6f9-10a16c47a44f',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'Equivalence Classes of Parity ($a + b$ even)',
    $BODY$Define the relation $\sim$ on $\mathbb{Z}$ by $a \sim b$ if and only if $a + b$ is even.

**(a)** Show that $\sim$ is an equivalence relation on $\mathbb{Z}$.

**(b)** Identify and describe all the equivalence classes of $\mathbb{Z}$ determined by this equivalence relation.$BODY$,
    'medium',
    2026,
    'Exercise 1',
    4,
    $BODY$For (a), verify reflexivity, symmetry, and transitivity for parity. For (b), consider $[0]$ and $[1]$ and show they are the only two distinct classes.$BODY$,
    $BODY$**(a)** $\sim$ is an equivalence relation on $\mathbb{Z}$.

**(b)** There are exactly two equivalence classes: $2\mathbb{Z}$ (the even integers) and $1 + 2\mathbb{Z}$ (the odd integers).$BODY$,
    $BODY$**(a)**

*(reflexive)* Let $a \in \mathbb{Z}$. Since $a + a = 2a$ is even, then $a \sim a$.

*(symmetric)* Let $a, b \in \mathbb{Z}$. Suppose $a \sim b$. Then, $a + b = 2k$ for some $k \in \mathbb{Z}$. It follows that $b + a = 2k$ is even as well. Hence, $b \sim a$.

*(transitive)* Let $a, b, c \in \mathbb{Z}$. Suppose $a \sim b$ and $b \sim c$. Then, $a + b = 2k$ and $b + c = 2\ell$ for some $k, \ell \in \mathbb{Z}$. It follows that

$$
\begin{aligned}
(a + b) + (b + c) = 2k + 2\ell
    &\implies a + 2b + c = 2k + 2\ell \\
    &\implies a + c = 2k + 2\ell - 2b \\
    &\implies a + c = 2\underbrace{(k + \ell - b)}_{\in\,\mathbb{Z}}.
\end{aligned}
$$

Therefore $a \sim c$.

Hence, $\sim$ is an equivalence relation on $\mathbb{Z}$. $\blacksquare$

---

**(b)**

$$
\begin{aligned}
[0] &= \{ k \in \mathbb{Z} \mid k \text{ is even} \} = 2\mathbb{Z} \\[6pt]
[1] &= \{ k \in \mathbb{Z} \mid 1 + k \text{ is even} \} \\
    &= \{ k \in \mathbb{Z} \mid k \text{ is odd} \} \\
    &= 1 + 2\mathbb{Z}.
\end{aligned}
$$

Since every integer is either even or odd, $[0] \cup [1] = \mathbb{Z}$, and the two classes are disjoint. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Equivalence Relation: Powers of Two on R
    '5ba6d719-80bb-40c4-9fbe-6530b319ad02',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'Equivalence Relation: $a = 2^k b$ on $\mathbb{R}$',
    $BODY$Define the relation $\sim$ on $\mathbb{R}$ by $a \sim b$ if and only if $a = 2^k b$ for some integer $k$. Determine whether $\sim$ is an equivalence relation.$BODY$,
    'medium',
    2026,
    'Exercise 1',
    5,
    $BODY$Check transitivity carefully: powers of $2$ compose via $2^k \cdot 2^{\ell} = 2^{k + \ell}$.$BODY$,
    $BODY$Yes — $\sim$ is an equivalence relation on $\mathbb{R}$.$BODY$,
    $BODY$\underline{Claim}: $\sim$ is an equivalence relation on $\mathbb{R}$.

*Proof.*

*(reflexive)* Let $a \in \mathbb{R}$. Then, $a = 1 \cdot a = 2^0 a$, where $0 \in \mathbb{Z}$. Hence, $a \sim a$.

*(symmetric)* Let $a, b \in \mathbb{R}$. Suppose $a \sim b$. Then, $a = 2^k b$ for some $k \in \mathbb{Z}$. Consider $-k \in \mathbb{Z}$. Then,

$$
\begin{aligned}
a = 2^k b
    &\implies (2^{-k})a = (2^{-k})2^k b \\
    &\implies 2^{-k} a = 2^{k-k} b \\
    &\implies b = 2^{-k} a.
\end{aligned}
$$

Therefore, $b \sim a$.

*(transitive)* Let $a, b, c \in \mathbb{R}$. Suppose that $a \sim b$ and $b \sim c$. Then, $a = 2^k b$ and $b = 2^{\ell} c$ for some $k, \ell \in \mathbb{Z}$. Then,

$$
\begin{equation*}a = 2^k (2^{\ell} c) = 2^{k + \ell} c,\end{equation*}
$$

where $k + \ell \in \mathbb{Z}$. Therefore, $a \sim c$.

Hence, $\sim$ is an equivalence relation on $\mathbb{R}$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
