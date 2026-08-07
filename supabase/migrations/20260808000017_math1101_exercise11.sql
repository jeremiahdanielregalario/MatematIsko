-- ============================================================================
-- Math 110.1 Exercise 11 — ideals, factor rings, ring homomorphisms
-- 9 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Freshman's dream
    'a25b4c5a-a185-48d8-9fa2-c0abf3cfdf94',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'Freshman''s Dream in a Ring of Characteristic 2',
    $BODY$Let $R$ be a commutative ring. Suppose that $R$ has characteristic $2$. Prove that for any $a, b \in R$, $(a + b)^2 = a^2 + b^2$.

[Remark: In general, if $a$ and $b$ are elements of a commutative ring with prime characteristic $p$, then $(a + b)^p = a^p + b^p$. (Freshman's Dream)]$BODY$,
    'easy',
    2026,
    'Exercise 11',
    1,
    $BODY$Expand $(a + b)^2 = a^2 + ab + ba + b^2$ and use commutativity plus characteristic 2 to see $2ab = 0$.$BODY$,
    $BODY$(a + b)^2 = a^2 + b^2$ whenever $\mathrm{char}(R) = 2$.$BODY$,
    $BODY$Let $a, b \in R$. Then $a + b \in R$. Since $R$ has characteristic $2$, we have $2r = r + r = 0$ for every $r \in R$. In particular,

$$
\begin{aligned}
(a + b)^2 &= (a + b)(a + b) \\
          &= a^2 + ab + ba + b^2 \\
          &= a^2 + 2ab + b^2 \\
          &= a^2 + 0 + b^2 \\
          &= a^2 + b^2.
\end{aligned}
$$

$\therefore$ $\mathrm{char}(R) = 2 \implies \forall\, a, b \in R,\ (a + b)^2 = a^2 + b^2$. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — ideals of M2(Z)
    'd944bd65-6748-40b3-bb5b-a998e39d9637',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'Ideals of $M_2(\\mathbb{Z})$',
    $BODY$Consider the ring $M_2(\mathbb{Z}) = \left\{ \begin{bmatrix} a & b \\ c & d \end{bmatrix} \;\middle|\; a, b, c, d \in \mathbb{Z} \right\}$. Determine which of the following sets are ideals of $M_2(\mathbb{Z})$. (Note: $M_2(\mathbb{Z})$ is not commutative, so $ra$ and $ar$ may not be equal.)

**(a)** $S_1 = \left\{ \begin{bmatrix} a & b \\ c & d \end{bmatrix} \;\middle|\; a, b, c, d \in 2\mathbb{Z} \right\}$

**(b)** $S_2 = \left\{ \begin{bmatrix} a & 0 \\ 0 & 0 \end{bmatrix} \;\middle|\; a \in \mathbb{Z} \right\}$

**(c)** $S_3 = \left\{ \begin{bmatrix} a & 0 \\ b & 0 \end{bmatrix} \;\middle|\; a, b \in \mathbb{Z} \right\}$ $BODY$,
    'hard',
    2026,
    'Exercise 11',
    2,
    $BODY$Use the ideal test: closed under subtraction, and closed under left and right multiplication by arbitrary matrices. Since $M_2(\mathbb{Z})$ is noncommutative, both $ra$ and $ar$ must be checked.$BODY$,
    $BODY$**(a)** $S_1$ is an ideal. **(b)** $S_2$ is not an ideal (not closed under left multiplication). **(c)** $S_3$ is not an ideal (not closed under right multiplication).$BODY$,
    $BODY$**(a)** $S_1 = \{ \begin{bmatrix} a & b \\ c & d \end{bmatrix} \mid a, b, c, d \in 2\mathbb{Z} \}$. Clearly, $\varnothing \neq S_1 \subseteq M_2(\mathbb{Z})$.

(i) Let $\begin{bmatrix} 2a & 2b \\ 2c & 2d \end{bmatrix}, \begin{bmatrix} 2e & 2f \\ 2g & 2h \end{bmatrix} \in S_1$. Then,

$$
\begin{bmatrix} 2a & 2b \\ 2c & 2d \end{bmatrix} - \begin{bmatrix} 2e & 2f \\ 2g & 2h \end{bmatrix}
= \begin{bmatrix} 2(a - e) & 2(b - f) \\ 2(c - g) & 2(d - h) \end{bmatrix} \in S_1.
$$

(ii) Let $\begin{bmatrix} r & s \\ t & u \end{bmatrix} \in M_2(\mathbb{Z})$ and $\begin{bmatrix} 2a & 2b \\ 2c & 2d \end{bmatrix} \in S_1$. Then,

$$
\begin{bmatrix} r & s \\ t & u \end{bmatrix} \begin{bmatrix} 2a & 2b \\ 2c & 2d \end{bmatrix}
= \begin{bmatrix} 2(ar - cs) & 2(br - ds) \\ 2(at - cu) & 2(bt - du) \end{bmatrix} \in S_1,
$$

and

$$
\begin{bmatrix} 2a & 2b \\ 2c & 2d \end{bmatrix} \begin{bmatrix} r & s \\ t & u \end{bmatrix}
= \begin{bmatrix} 2(ar - bt) & 2(as - bu) \\ 2(cr - dt) & 2(cs - du) \end{bmatrix} \in S_1.
$$

$\therefore$ $S_1$ is an ideal of $M_2(\mathbb{Z})$. $\blacksquare$

---

**(b)** $S_2 = \{ \begin{bmatrix} a & 0 \\ 0 & 0 \end{bmatrix} \mid a \in \mathbb{Z} \}$. Clearly, $\varnothing \neq S_2 \subseteq M_2(\mathbb{Z})$.

(i) Let $\begin{bmatrix} a & 0 \\ 0 & 0 \end{bmatrix}, \begin{bmatrix} b & 0 \\ 0 & 0 \end{bmatrix} \in S_2$. Then,

$$
\begin{bmatrix} a & 0 \\ 0 & 0 \end{bmatrix} - \begin{bmatrix} b & 0 \\ 0 & 0 \end{bmatrix} = \begin{bmatrix} a - b & 0 \\ 0 & 0 \end{bmatrix} \in S_2.
$$

(ii) Let $\begin{bmatrix} r & s \\ t & u \end{bmatrix} \in M_2(\mathbb{Z})$ and $\begin{bmatrix} a & 0 \\ 0 & 0 \end{bmatrix} \in S_2$. Then,

$$
\begin{bmatrix} r & s \\ t & u \end{bmatrix} \begin{bmatrix} a & 0 \\ 0 & 0 \end{bmatrix}
= \begin{bmatrix} ar & 0 \\ at & 0 \end{bmatrix} \notin S_2
$$

whenever $at \neq 0$.

$\therefore$ $S_2$ is **not** an ideal of $M_2(\mathbb{Z})$. $\blacksquare$

---

**(c)** $S_3 = \{ \begin{bmatrix} a & 0 \\ b & 0 \end{bmatrix} \mid a, b \in \mathbb{Z} \}$. Clearly, $\varnothing \neq S_3 \subseteq M_2(\mathbb{Z})$.

(i) Let $\begin{bmatrix} a & 0 \\ b & 0 \end{bmatrix}, \begin{bmatrix} c & 0 \\ d & 0 \end{bmatrix} \in S_3$. Then,

$$
\begin{bmatrix} a & 0 \\ b & 0 \end{bmatrix} - \begin{bmatrix} c & 0 \\ d & 0 \end{bmatrix} = \begin{bmatrix} a - c & 0 \\ b - d & 0 \end{bmatrix} \in S_3.
$$

(ii) Let $\begin{bmatrix} r & s \\ t & u \end{bmatrix} \in M_2(\mathbb{Z})$ and $\begin{bmatrix} a & 0 \\ b & 0 \end{bmatrix} \in S_3$. Then,

$$
\begin{bmatrix} r & s \\ t & u \end{bmatrix} \begin{bmatrix} a & 0 \\ b & 0 \end{bmatrix}
= \begin{bmatrix} ar + bs & 0 \\ at + bu & 0 \end{bmatrix} \in S_3,
$$

but

$$
\begin{bmatrix} a & 0 \\ b & 0 \end{bmatrix} \begin{bmatrix} r & s \\ t & u \end{bmatrix}
= \begin{bmatrix} ar & as \\ br & bs \end{bmatrix} \notin S_3
$$

whenever $as \neq 0$.

$\therefore$ $S_3$ is **not** an ideal of $M_2(\mathbb{Z})$. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Z6 / <2>
    '6a34cc7d-55e0-4c66-89fb-2aa3c82ec741',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'The Factor Ring $\\mathbb{Z}_6 / \\langle 2 \\rangle$',
    $BODY$Consider the ring $\mathbb{Z}_6$ under addition and multiplication modulo $6$.

**(a)** Determine the elements of $\langle 2 \rangle$, the principal ideal generated by $2$.

**(b)** Give the elements of the factor ring $\mathbb{Z}_6 / \langle 2 \rangle$.

**(c)** Is $\mathbb{Z}_6 / \langle 2 \rangle$ a field? Justify your answer.$BODY$,
    'medium',
    2026,
    'Exercise 11',
    3,
    $BODY$Compute $\langle 2 \rangle = \{2r \mid r \in \mathbb{Z}_6\} = \{0, 2, 4\}$. The factor ring has two cosets; build its multiplication table to check it is $\mathbb{Z}_2 \cong$ a field.$BODY$,
    $BODY$**(a)** $\langle 2 \rangle = \{0, 2, 4\}$. **(b)** $\mathbb{Z}_6 / \langle 2 \rangle = \{\langle 2 \rangle, 1 + \langle 2 \rangle\}$. **(c)** Yes — a field (isomorphic to $\mathbb{Z}_2$).$BODY$,
    $BODY$**(a)**

$$
\begin{equation*}\langle 2 \rangle = \{2r \mid r \in \mathbb{Z}_6\} = \boxed{\{0, 2, 4\}}.\end{equation*}
$$

**(b)**

$$
\begin{equation*}\mathbb{Z}_6 / \langle 2 \rangle = \boxed{\{\langle 2 \rangle,\ 1 + \langle 2 \rangle\}}.\end{equation*}
$$

**(c)** The multiplication table for $\mathbb{Z}_6 / \langle 2 \rangle$:

| $\cdot$ | $\langle 2 \rangle$ | $1 + \langle 2 \rangle$ |
|---|---|---|
| $\langle 2 \rangle$ | $\langle 2 \rangle$ | $\langle 2 \rangle$ |
| $1 + \langle 2 \rangle$ | $\langle 2 \rangle$ | $1 + \langle 2 \rangle$ |

By the symmetry of the table across the diagonal, $\mathbb{Z}_6 / \langle 2 \rangle$ is commutative, and the only nonzero element is a unit:

$$
\begin{equation*}(1 + \langle 2 \rangle)^{-1} = 1 + \langle 2 \rangle.\end{equation*}
$$

$\therefore$ $\mathbb{Z}_6 / \langle 2 \rangle$ is a field. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — Z x Z / I
    '512c387c-b59e-4dbf-959c-69f34442c3c3',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'The Ideal of Even Pairs in $\\mathbb{Z} \\times \\mathbb{Z}$',
    $BODY$Given $R = \mathbb{Z} \times \mathbb{Z}$.

**(a)** Show that $I = \{(x, y) \in R \mid x \text{ and } y \text{ are even}\}$ is an ideal of $R$.

**(b)** Determine the elements of $R / I$ and construct the addition and multiplication tables for $R / I$.

**(c)** Is $R / I$ an integral domain? Is $R / I$ a field? Justify your answers.$BODY$,
    'hard',
    2026,
    'Exercise 11',
    4,
    $BODY$For (a), use the ideal test. For (b), $I$ has even-even pairs, so the cosets are determined by the parities: $I$, $(0,1) + I$, $(1,0) + I$, $(1,1) + I$. For (c), $(0,1) + I$ and $(1,0) + I$ are zero divisors.$BODY$,
    $BODY$**(a)** $I$ is an ideal. **(b)** $R/I = \{I, (0,1) + I, (1,0) + I, (1,1) + I\}$ (tables below). **(c)** Not an integral domain and not a field — $(0,1) + I$ is a zero divisor.$BODY$,
    $BODY$**(a)** Clearly, $I \subseteq R$ and $I \neq \varnothing$ (e.g. $(0, 0) \in I$).

(i) Let $(2k, 2\ell), (2m, 2n) \in I$ for some $k, \ell, m, n \in \mathbb{Z}$. Then,

$$
\begin{equation*}(2k, 2\ell) - (2m, 2n) = (2(k - m), 2(\ell - n)) \in I.\end{equation*}
$$

(ii) Let $(r, s) \in \mathbb{Z} \times \mathbb{Z}$ and $(2k, 2\ell) \in I$. Then,

$$
\begin{equation*}(r, s)(2k, 2\ell) = (2kr, 2\ell s) = (2k, 2\ell)(r, s) \in I.\end{equation*}
$$

$\therefore$ $I$ is an ideal of $R$. $\blacksquare$

---

**(b)** The elements of $R / I$ are

$$
\begin{equation*}R / I = \{I,\ (0, 1) + I,\ (1, 0) + I,\ (1, 1) + I\}.\end{equation*}
$$

Addition table:

| $+$ | $I$ | $(0,1) + I$ | $(1,0) + I$ | $(1,1) + I$ |
|---|---|---|---|---|
| $I$ | $I$ | $(0,1) + I$ | $(1,0) + I$ | $(1,1) + I$ |
| $(0,1) + I$ | $(0,1) + I$ | $I$ | $(1,1) + I$ | $(1,0) + I$ |
| $(1,0) + I$ | $(1,0) + I$ | $(1,1) + I$ | $I$ | $(0,1) + I$ |
| $(1,1) + I$ | $(1,1) + I$ | $(1,0) + I$ | $(0,1) + I$ | $I$ |

Multiplication table:

| $\cdot$ | $I$ | $(0,1) + I$ | $(1,0) + I$ | $(1,1) + I$ |
|---|---|---|---|---|
| $I$ | $I$ | $I$ | $I$ | $I$ |
| $(0,1) + I$ | $I$ | $(0,1) + I$ | $I$ | $(0,1) + I$ |
| $(1,0) + I$ | $I$ | $I$ | $(1,0) + I$ | $(1,0) + I$ |
| $(1,1) + I$ | $I$ | $(0,1) + I$ | $(1,0) + I$ | $(1,1) + I$ |

---

**(c)** Consider $I \neq (0, 1) + I \in R/I$. Since

$$
\begin{equation*}[(0, 1) + I][(1, 0) + I] = I,\end{equation*}
$$

with $I \neq (1, 0) + I$, the element $(0, 1) + I$ is a zero divisor.

$\therefore$ $R / I$ is **not** an integral domain, and therefore $R / I$ is **not** a field. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — 2Z / 8Z
    '79cf54c4-0eda-471d-aeb2-025fee43133a',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'The Factor Ring $2\\mathbb{Z} / 8\\mathbb{Z}$',
    $BODY$Consider the ring $2\mathbb{Z}$ and its ideal $8\mathbb{Z}$.

**(a)** List down all the elements of $2\mathbb{Z} / 8\mathbb{Z}$.

**(b)** Write down the addition and multiplication tables for $2\mathbb{Z} / 8\mathbb{Z}$.

**(c)** Does $2\mathbb{Z} / 8\mathbb{Z}$ have unity? If yes, find all the units of $2\mathbb{Z} / 8\mathbb{Z}$.

**(d)** Identify all the zero divisors of $2\mathbb{Z} / 8\mathbb{Z}$, if any.$BODY$,
    'medium',
    2026,
    'Exercise 11',
    5,
    $BODY$The cosets are $8\mathbb{Z} + 2k$ for $k = 0, 1, 2, 3$. Build the tables; note there is no unity — the multiplicative identity of $2\mathbb{Z}$ (which has none) does not carry over.$BODY$,
    $BODY$**(a)** $2\mathbb{Z}/8\mathbb{Z} = \{8\mathbb{Z},\ 2 + 8\mathbb{Z},\ 4 + 8\mathbb{Z},\ 6 + 8\mathbb{Z}\}$. **(c)** No unity. **(d)** $2 + 8\mathbb{Z}$, $4 + 8\mathbb{Z}$, $6 + 8\mathbb{Z}$ are zero divisors.$BODY$,
    $BODY$**(a)**

$$
\begin{equation*}2\mathbb{Z} / 8\mathbb{Z} = \{8\mathbb{Z},\ 2 + 8\mathbb{Z},\ 4 + 8\mathbb{Z},\ 6 + 8\mathbb{Z}\}.\end{equation*}
$$

**(b)** Addition table:

| $+$ | $8\mathbb{Z}$ | $2 + 8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ | $6 + 8\mathbb{Z}$ |
|---|---|---|---|---|
| $8\mathbb{Z}$ | $8\mathbb{Z}$ | $2 + 8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ | $6 + 8\mathbb{Z}$ |
| $2 + 8\mathbb{Z}$ | $2 + 8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ | $6 + 8\mathbb{Z}$ | $8\mathbb{Z}$ |
| $4 + 8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ | $6 + 8\mathbb{Z}$ | $8\mathbb{Z}$ | $2 + 8\mathbb{Z}$ |
| $6 + 8\mathbb{Z}$ | $6 + 8\mathbb{Z}$ | $8\mathbb{Z}$ | $2 + 8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ |

Multiplication table:

| $\cdot$ | $8\mathbb{Z}$ | $2 + 8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ | $6 + 8\mathbb{Z}$ |
|---|---|---|---|---|
| $8\mathbb{Z}$ | $8\mathbb{Z}$ | $8\mathbb{Z}$ | $8\mathbb{Z}$ | $8\mathbb{Z}$ |
| $2 + 8\mathbb{Z}$ | $8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ | $8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ |
| $4 + 8\mathbb{Z}$ | $8\mathbb{Z}$ | $8\mathbb{Z}$ | $8\mathbb{Z}$ | $8\mathbb{Z}$ |
| $6 + 8\mathbb{Z}$ | $8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ | $8\mathbb{Z}$ | $4 + 8\mathbb{Z}$ |

---

**(c)** Based on the multiplication table, there is **no unity** in $2\mathbb{Z} / 8\mathbb{Z}$, and therefore there are no units.

**(d)** Based on the table, $2 + 8\mathbb{Z}$, $4 + 8\mathbb{Z}$, and $6 + 8\mathbb{Z}$ are all zero divisors of $2\mathbb{Z} / 8\mathbb{Z}$. $\blacksquare$$BODY$
  ),
  (
    -- Q6 — upper triangular homomorphism
    '450914ce-57a8-4720-a14f-eb40c27e8892',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'A Ring Homomorphism From Upper Triangular Matrices',
    $BODY$Consider the ring $R = \left\{ \begin{bmatrix} a & b \\ 0 & c \end{bmatrix} \;\middle|\; a, b, c \in \mathbb{Z} \right\}$. Determine if the mapping $\varphi : R \to \mathbb{Z}$ given by $\varphi\left(\begin{bmatrix} a & b \\ 0 & c \end{bmatrix}\right) = a$ is a ring homomorphism.$BODY$,
    'medium',
    2026,
    'Exercise 11',
    6,
    $BODY$Check both $\varphi(x + y) = \varphi(x) + \varphi(y)$ and $\varphi(xy) = \varphi(x)\varphi(y)$ using the matrix operations on upper triangular matrices.$BODY$,
    $BODY$Yes — $\varphi$ is a ring homomorphism (the $(1,1)$-entry of a sum/product is the sum/product of the $(1,1)$-entries).$BODY$,
    $BODY$Let $\begin{bmatrix} a & b \\ 0 & c \end{bmatrix}, \begin{bmatrix} d & e \\ 0 & f \end{bmatrix} \in R$. Then,

$$
\begin{aligned}
\varphi\left(\begin{bmatrix} a & b \\ 0 & c \end{bmatrix} + \begin{bmatrix} d & e \\ 0 & f \end{bmatrix}\right)
&= \varphi\left(\begin{bmatrix} a + d & b + e \\ 0 & c + f \end{bmatrix}\right) \\
&= a + d \\
&= \varphi\left(\begin{bmatrix} a & b \\ 0 & c \end{bmatrix}\right) + \varphi\left(\begin{bmatrix} d & e \\ 0 & f \end{bmatrix}\right),
\end{aligned}
$$

and

$$
\begin{aligned}
\varphi\left(\begin{bmatrix} a & b \\ 0 & c \end{bmatrix} \begin{bmatrix} d & e \\ 0 & f \end{bmatrix}\right)
&= \varphi\left(\begin{bmatrix} ad & ae + bf \\ 0 & cf \end{bmatrix}\right) \\
&= ad \\
&= \varphi\left(\begin{bmatrix} a & b \\ 0 & c \end{bmatrix}\right) \varphi\left(\begin{bmatrix} d & e \\ 0 & f \end{bmatrix}\right).
\end{aligned}
$$

$\therefore$ $\varphi$ is a ring homomorphism. $\blacksquare$$BODY$
  ),
  (
    -- Q7 — Z5 -> Z10 doesn't preserve addition
    'b6f8ca37-586c-4a7d-9f31-98a6e4d02629',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    '$x \\mapsto 5x$ Does Not Preserve Addition',
    $BODY$Show that the map $\varphi : \mathbb{Z}_5 \to \mathbb{Z}_{10}$ given by $x \mapsto 5x \bmod 10$ does not preserve addition.$BODY$,
    'easy',
    2026,
    'Exercise 11',
    7,
    $BODY$Find $x, y \in \mathbb{Z}_5$ with $\varphi(x +_5 y) \neq \varphi(x) +_{10} \varphi(y)$; e.g. $x = 1$, $y = 4$.$BODY$,
    $BODY$Not additive: $\varphi(1 +_5 4) = \varphi(0) = 0$ but $\varphi(1) +_{10} \varphi(4) = 5 +_{10} 0 = 5$.$BODY$,
    $BODY$Consider $1, 4 \in \mathbb{Z}_5$. Then,

$$
\begin{equation*}\varphi(1 +_5 4) = \varphi(0) = 0 \neq 5 = 5 +_{10} 0 = \varphi(1) +_{10} \varphi(4).\end{equation*}
$$

$\therefore$ $\varphi$ does not preserve addition. $\blacksquare$$BODY$
  ),
  (
    -- Q8 — Z4 -> Z12 doesn't preserve multiplication
    'ee4580ea-dc40-4703-a1be-75339e664e29',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    '$x \\mapsto 3x$ Does Not Preserve Multiplication',
    $BODY$Show that the map $\varphi : \mathbb{Z}_4 \to \mathbb{Z}_{12}$ given by $x \mapsto 3x \bmod 12$ does not preserve multiplication.$BODY$,
    'easy',
    2026,
    'Exercise 11',
    8,
    $BODY$Find $x, y \in \mathbb{Z}_4$ with $\varphi(x \cdot_4 y) \neq \varphi(x) \cdot_{12} \varphi(y)$; e.g. $x = 1$, $y = 3$.$BODY$,
    $BODY$Not multiplicative: $\varphi(1 \cdot_4 3) = \varphi(3) = 9$ but $\varphi(1) \cdot_{12} \varphi(3) = 3 \cdot_{12} 9 = 3$.$BODY$,
    $BODY$Consider $1, 3 \in \mathbb{Z}_4$. Then,

$$
\begin{equation*}\varphi(1 \cdot_4 3) = \varphi(3) = 9 \neq 3 = 3 \cdot_{12} 9 = \varphi(1) \cdot_{12} \varphi(3).\end{equation*}
$$

$\therefore$ $\varphi$ does not preserve multiplication. $\blacksquare$$BODY$
  ),
  (
    -- Q9 — image of ideal
    '94c5385d-39a9-4982-89b0-e2c993249c80',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'The Image of an Ideal Under a Ring Homomorphism',
    $BODY$Let $\varphi : R \to R'$ be a ring homomorphism. Prove that if $I$ is an ideal of $R$, then $\varphi(I)$ is an ideal of $\varphi(R)$.$BODY$,
    'hard',
    2026,
    'Exercise 11',
    9,
    $BODY$Use the ideal test on $\varphi(I) \subseteq \varphi(R)$. Closure under subtraction uses the homomorphism property; for the absorption property, use $\varphi(r)\varphi(a) = \varphi(ra)$ and $\varphi(a)\varphi(r) = \varphi(ar)$.$BODY$,
    $BODY$$\varphi(I)$ is an ideal of $\varphi(R)$.$BODY$,
    $BODY$Suppose $I$ is an ideal of $R$. Then $\varnothing \neq I \subseteq R$, so $\varnothing \neq \varphi(I) \subseteq \varphi(R)$.

(i) Let $\varphi(a), \varphi(b) \in \varphi(I)$ for some $a, b \in I$. Then,

$$
\begin{equation*}\varphi(a) - \varphi(b) = \varphi(\underbrace{a - b}_{\in I}) \in \varphi(I).\end{equation*}
$$

(ii) Let $\varphi(r) \in \varphi(R)$ and $\varphi(a) \in \varphi(I)$ for some $r \in R$ and $a \in I$. Since $I$ is an ideal, $ra, ar \in I$. Then,

$$
\begin{equation*}\varphi(r)\varphi(a) = \varphi(\underbrace{ra}_{\in I}) \in \varphi(I),\end{equation*}
$$

$$
\begin{equation*}\varphi(a)\varphi(r) = \varphi(\underbrace{ar}_{\in I}) \in \varphi(I).\end{equation*}
$$

$\therefore$ $\varphi(I)$ is an ideal of $\varphi(R)$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
