-- ============================================================================
-- Math 110.1 Exercise 10 — rings, fields, subrings, subfields
-- 10 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — R+ with new operations
    'cc63b76d-8e53-419c-8bcb-2386e3742270',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'A Ring on $\\mathbb{R}^{+}$ with New Operations',
    $BODY$Let $\mathbb{R}^{+}$ be the set of all positive real numbers. Define a new addition $\oplus$ and multiplication $\odot$ on $\mathbb{R}^{+}$ as $a \oplus b = ab$ (ordinary multiplication) and $a \odot b = a^{\ln b}$.

**(a)** Prove that $\langle \mathbb{R}^{+}, \oplus, \odot \rangle$ is a ring.

**(b)** Show that $\langle \mathbb{R}^{+}, \oplus, \odot \rangle$ is commutative and has unity.

**(c)** Is $\langle \mathbb{R}^{+}, \oplus, \odot \rangle$ a field?$BODY$,
    'hard',
    2026,
    'Exercise 10',
    1,
    $BODY$The additive identity is $1$ and the additive inverse of $a$ is $1/a$. For distributivity, use $a^{\ln(bc)} = a^{\ln b + \ln c}$. The unity is $e$; inverses for field elements $a \neq 1$ are $e^{1/\ln a}$.$BODY$,
    $BODY$**(a)** Ring. **(b)** Commutative with unity $e$. **(c)** Yes — a field.$BODY$,
    $BODY$**(a)** $\mathcal{R}_1$: $\langle \mathbb{R}^{+}, \oplus \rangle$ is an abelian group (by previous results in class).

$\mathcal{R}_2$: Let $a, b, c \in \mathbb{R}^{+}$. Then,

$$
\begin{aligned}
a \odot (b \odot c) &= a \odot b^{\ln c} \\
                    &= a^{\ln b^{\ln c}} \\
                    &= a^{\ln c \cdot \ln b} \\
                    &= (a^{\ln b})^{\ln c} \\
                    &= (a \odot b) \odot c.
\end{aligned}
$$

$\therefore$ $\odot$ is associative.

$\mathcal{R}_3$: Let $a, b, c \in \mathbb{R}^{+}$. Then,

$$
\begin{aligned}
a \odot (b \oplus c) &= a^{\ln(bc)} \\
                     &= a^{\ln b + \ln c} \\
                     &= a^{\ln b} a^{\ln c} \\
                     &= a \odot b \oplus a \odot c,
\end{aligned}
$$

and

$$
\begin{aligned}
(a \oplus b) \odot c &= (ab)^{\ln c} \\
                     &= a^{\ln c} b^{\ln c} \\
                     &= a \odot c \oplus b \odot c.
\end{aligned}
$$

$\therefore$ The left and right distributive laws hold.

Hence, $\langle \mathbb{R}^{+}, \oplus, \odot \rangle$ is a ring. $\blacksquare$

---

**(b)** Let $a, b \in \mathbb{R}^{+}$. Then,

$$
\begin{aligned}
a \odot b &= a^{\ln b} \\
          &= (e^{\ln a})^{\ln b} = e^{\ln a \ln b} = (e^{\ln b})^{\ln a} \\
          &= b^{\ln a} = b \odot a.
\end{aligned}
$$

$\therefore$ $\odot$ is commutative.

Let $c \in \mathbb{R}^{+}$. Consider $e \in \mathbb{R}^{+}$. Then,

$$
\begin{equation*}c \odot e = c^{\ln e} = c^1 = c = e^{\ln c} = e \odot c.\end{equation*}
$$

$\therefore$ $e$ is the unity.

$\therefore$ $\langle \mathbb{R}^{+}, \oplus, \odot \rangle$ is a commutative ring with unity. $\blacksquare$

---

**(c)** Let $1 \neq a \in \mathbb{R}^{+}$. Consider $x = e^{1/\ln a} \in \mathbb{R}^{+}$. Then,

$$
\begin{equation*}a \odot x = a^{\ln\left(e^{1/\ln a}\right)} = a^{1/\ln a} = \left(e^{\ln a}\right)^{1/\ln a} = e.\end{equation*}
$$

$\therefore$ $\langle \mathbb{R}^{+}, \oplus, \odot \rangle$ is a commutative division ring and is therefore a field. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Ring {0,1,a,b}
    '679a7053-f880-4c3c-9eb8-a65c8b926156',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'A Field on $\\{0, 1, a, b\\}$',
    $BODY$Let $R$ be the ring $\{0, 1, a, b\}$ together with binary operations $+$ and $\cdot$ given by the following tables:

| $+$ | $0$ | $1$ | $a$ | $b$ |
|---|---|---|---|---|
| $0$ | $0$ | $1$ | $a$ | $b$ |
| $1$ | $1$ | $0$ | $b$ | $a$ |
| $a$ | $a$ | $b$ | $0$ | $1$ |
| $b$ | $b$ | $a$ | $1$ | $0$ |

| $\cdot$ | $0$ | $1$ | $a$ | $b$ |
|---|---|---|---|---|
| $0$ | $0$ | $0$ | $0$ | $0$ |
| $1$ | $0$ | $1$ | $a$ | $b$ |
| $a$ | $0$ | $a$ | $b$ | $1$ |
| $b$ | $0$ | $b$ | $1$ | $a$ |

**(a)** Prove that $R$ is a field.

**(b)** Compute the following elements: (i) $(a + 1)^2$, (ii) $\dfrac{(a + b)(a + 1)}{a}$.

**(c)** Determine the characteristic of $R$.$BODY$,
    'medium',
    2026,
    'Exercise 10',
    2,
    $BODY$The addition table is the Klein-4 group, and the multiplication table is symmetric with $1^{-1} = 1$, $a^{-1} = b$, $b^{-1} = a$. For the characteristic, add the unity to itself.$BODY$,
    $BODY$**(a)** $R$ is a field (this is $\mathbb{F}_4$). **(b)** (i) $(a+1)^2 = a$; (ii) $\dfrac{(a+b)(a+1)}{a} = a$. **(c)** $\mathrm{char}(R) = 2$.$BODY$,
    $BODY$**(a)** By the symmetry of the multiplication table above across the diagonal, $\cdot$ is commutative.

Every nonzero element has a multiplicative inverse:

$$
\begin{equation*}1^{-1} = 1, \qquad a^{-1} = b, \qquad b^{-1} = a.\end{equation*}
$$

Therefore $R$ is a division ring, and since it is commutative, $R$ is a field. $\blacksquare$

---

**(b)** (i) From the addition table, $a + 1 = b$, so

$$
\begin{equation*}(a + 1)^2 = b^2 = b \cdot b = \boxed{a}.\end{equation*}
$$

(ii) From the addition table, $a + b = 1$ and $a + 1 = b$, so

$$
\begin{aligned}
\frac{(a + b)(a + 1)}{a} &= \frac{1 \cdot b}{a} = \frac{b}{a} = b \cdot a^{-1} = b \cdot b = \boxed{a}.
\end{aligned}
$$

---

**(c)** Since $1 \cdot 1 = 1 \neq 0$ and

$$
\begin{equation*}2 \cdot 1 = 1 + 1 = 0,\end{equation*}
$$

with $2 \in \mathbb{Z}^{+}$, we get $\mathrm{char}(R) = \boxed{2}$. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Z3 x Z2
    '01d37ef5-762a-4131-9df7-642fbaa07d61',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'The Ring $\\mathbb{Z}_3 \\times \\mathbb{Z}_2$',
    $BODY$Consider the ring $R = \mathbb{Z}_3 \times \mathbb{Z}_2$ under component-wise addition and multiplication.

**(a)** Construct the addition and multiplication tables for $R$.

**(b)** What is the unity in $R$?

**(c)** Determine $U(R)$, the group of units of $R$.

**(d)** Determine the characteristic of $R$.

**(e)** Is $R$ an integral domain? Justify your answer.$BODY$,
    'hard',
    2026,
    'Exercise 10',
    3,
    $BODY$For (c), a component is invertible iff each coordinate is. For (d), the characteristic is $\mathrm{lcm}(3, 2) = 6$. For (e), find two nonzero elements that multiply to zero, e.g. $(1, 0) \cdot (0, 1)$.$BODY$,
    $BODY$**(b)** Unity is $(1, 1)$. **(c)** $U(R) = \{(1, 1), (2, 1)\}$. **(d)** $\mathrm{char}(R) = 6$. **(e)** Not an integral domain — zero divisors $(1, 0)$ and $(0, 1)$.$BODY$,
    $BODY$**(a)** Addition table:

| $\oplus$ | $(0,0)$ | $(1,0)$ | $(0,1)$ | $(1,1)$ | $(2,0)$ | $(2,1)$ |
|---|---|---|---|---|---|---|
| $(0,0)$ | $(0,0)$ | $(1,0)$ | $(0,1)$ | $(1,1)$ | $(2,0)$ | $(2,1)$ |
| $(1,0)$ | $(1,0)$ | $(2,0)$ | $(1,1)$ | $(2,1)$ | $(0,0)$ | $(0,1)$ |
| $(0,1)$ | $(0,1)$ | $(1,1)$ | $(0,0)$ | $(1,0)$ | $(2,1)$ | $(2,0)$ |
| $(1,1)$ | $(1,1)$ | $(2,1)$ | $(1,0)$ | $(2,0)$ | $(0,1)$ | $(0,0)$ |
| $(2,0)$ | $(2,0)$ | $(0,0)$ | $(2,1)$ | $(0,1)$ | $(1,0)$ | $(1,1)$ |
| $(2,1)$ | $(2,1)$ | $(0,1)$ | $(2,0)$ | $(0,0)$ | $(1,1)$ | $(1,0)$ |

Multiplication table:

| $\odot$ | $(0,0)$ | $(1,0)$ | $(0,1)$ | $(1,1)$ | $(2,0)$ | $(2,1)$ |
|---|---|---|---|---|---|---|
| $(0,0)$ | $(0,0)$ | $(0,0)$ | $(0,0)$ | $(0,0)$ | $(0,0)$ | $(0,0)$ |
| $(1,0)$ | $(0,0)$ | $(1,0)$ | $(0,0)$ | $(1,0)$ | $(2,0)$ | $(2,0)$ |
| $(0,1)$ | $(0,0)$ | $(0,0)$ | $(0,1)$ | $(0,1)$ | $(0,0)$ | $(0,1)$ |
| $(1,1)$ | $(0,0)$ | $(1,0)$ | $(0,1)$ | $(1,1)$ | $(2,0)$ | $(2,1)$ |
| $(2,0)$ | $(0,0)$ | $(2,0)$ | $(0,0)$ | $(2,0)$ | $(1,0)$ | $(1,0)$ |
| $(2,1)$ | $(0,0)$ | $(2,0)$ | $(0,1)$ | $(2,1)$ | $(1,0)$ | $(1,1)$ |

---

**(b)** We can see in the column and row for $(1, 1)$ that for every $a \in R$, $(1, 1) \odot a = a = a \odot (1, 1)$. Hence, the unity is $\boxed{(1, 1)}$.

**(c)**

$$
\begin{aligned}
U(R) &= \{(a, b) \in \mathbb{Z}_3 \times \mathbb{Z}_2 \mid \exists\, (a, b)^{-1} \in \mathbb{Z}_3 \times \mathbb{Z}_2 \text{ s.t. } (a, b) \odot (a, b)^{-1} = (1, 1)\} \\
     &= \{(a, b) \in \mathbb{Z}_3 \times \mathbb{Z}_2 \mid a \in U(\mathbb{Z}_3) \text{ and } b \in U(\mathbb{Z}_2)\} \\
     &= \boxed{\{(1, 1), (2, 1)\}}.
\end{aligned}
$$

**(d)** Since $|(1, 1)| = \mathrm{lcm}(|1|_{\mathbb{Z}_3}, |1|_{\mathbb{Z}_2}) = \mathrm{lcm}(3, 2) = 6$, we get $\mathrm{char}(R) = \boxed{6}$.

**(e)** By the symmetry of the multiplication table across the diagonal, $R$ is commutative with unity $(1, 1) \neq (0, 0)$. However,

$$
\begin{equation*}(1, 0) \cdot (0, 1) = (0, 0)\end{equation*}
$$

with $(1, 0), (0, 1) \neq (0, 0)$. Therefore $R$ has zero divisors.

$\therefore$ $R$ is **not** an integral domain. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — F = {0,2,4,6,8}
    'bf852879-91e9-4e43-ab09-b026cec97007',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    '$\\{0, 2, 4, 6, 8\\}$ as a Subfield of $\\mathbb{Z}_{10}$',
    $BODY$Consider the set $F = \{0, 2, 4, 6, 8\}$.

**(a)** Show that $F$ is a subring of $\mathbb{Z}_{10}$.

**(b)** Show that $F$ is a field under addition and multiplication modulo $10$.

**(c)** What is the unity in $F$? What is the characteristic of $F$?$BODY$,
    'hard',
    2026,
    'Exercise 10',
    4,
    $BODY$Construct the addition and multiplication tables for $F$ modulo $10$. The unity is $6$, and every nonzero element of $F$ has a multiplicative inverse.$BODY$,
    $BODY$**(a)** $F \leq \mathbb{Z}_{10}$. **(b)** $F$ is a field. **(c)** Unity is $6$; $\mathrm{char}(F) = 5$.$BODY$,
    $BODY$**(a)** Clearly, $F = \{0, 2, 4, 6, 8\} \subseteq \mathbb{Z}_{10}$.

Addition table (mod $10$):

| $+_{10}$ | $0$ | $2$ | $4$ | $6$ | $8$ |
|---|---|---|---|---|---|
| $0$ | $0$ | $2$ | $4$ | $6$ | $8$ |
| $2$ | $2$ | $4$ | $6$ | $8$ | $0$ |
| $4$ | $4$ | $6$ | $8$ | $0$ | $2$ |
| $6$ | $6$ | $8$ | $0$ | $2$ | $4$ |
| $8$ | $8$ | $0$ | $2$ | $4$ | $6$ |

Multiplication table (mod $10$):

| $\cdot_{10}$ | $0$ | $2$ | $4$ | $6$ | $8$ |
|---|---|---|---|---|---|
| $0$ | $0$ | $0$ | $0$ | $0$ | $0$ |
| $2$ | $0$ | $4$ | $8$ | $2$ | $6$ |
| $4$ | $0$ | $8$ | $6$ | $4$ | $2$ |
| $6$ | $0$ | $2$ | $4$ | $6$ | $8$ |
| $8$ | $0$ | $6$ | $2$ | $8$ | $4$ |

By the constructed addition and multiplication tables, $F$ is a subring of $\mathbb{Z}_{10}$. $\blacksquare$

---

**(b)** By the symmetry of the multiplication table across the diagonal, $F$ is commutative.

By the multiplication table, for every $a \in F$, $6 \cdot_{10} a = a = a \cdot_{10} 6$, so $6$ is the unity, and every nonzero element has a multiplicative inverse.

$\therefore$ $F$ is a field under addition and multiplication modulo $10$. $\blacksquare$

---

**(c)** From (b), the unity in $F$ is $\boxed{6}$. Since $|6| = 5$ (as $6 \cdot 5 = 30 \equiv 0$ and $6^k \not\equiv 0$ for $k < 5$), we get $\mathrm{char}(F) = \boxed{5}$. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Gaussian integers
    'dd4128ee-1bb1-483a-b8be-223002a06312',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'The Gaussian Integers $\\mathbb{Z}[i]$',
    $BODY$Consider $\mathbb{Z}[i] := \{a + bi \in \mathbb{C} \mid a, b \in \mathbb{Z}\}$.

**(a)** Show that $\mathbb{Z}[i]$ is a subring of $\mathbb{C}$. ($\mathbb{Z}[i]$ is called the ring of Gaussian integers.)

**(b)** Find $U(\mathbb{Z}[i])$.

**(c)** Is $\mathbb{Z}[i]$ a field? Is $\mathbb{Z}[i]$ an integral domain? Justify your answers.$BODY$,
    'hard',
    2026,
    'Exercise 10',
    5,
    $BODY$For (a), check closure under subtraction and multiplication. For (b), solve $(a + bi)^{-1} = \dfrac{a - bi}{a^2 + b^2} \in \mathbb{Z}[i]$. For (c), $1 + i$ has no inverse, but $\mathbb{Z}[i] \subseteq \mathbb{C}$, a field, has no zero divisors.$BODY$,
    $BODY$**(a)** Subring of $\mathbb{C}$. **(b)** $U(\mathbb{Z}[i]) = \{1, -1, i, -i\} = U_4$. **(c)** Not a field (e.g. $1 + i$ has no inverse); yes, an integral domain.$BODY$,
    $BODY$**(a)** Clearly, $\mathbb{Z}[i] \subseteq \mathbb{C}$.

Let $a + bi, c + di \in \mathbb{Z}[i]$. Then $a, b, c, d \in \mathbb{Z}$. It follows that

$$
\begin{aligned}
(a + bi) - (c + di) &= a + bi - c - di \\
                    &= \underbrace{(a - c)}_{\in \mathbb{Z}} + \underbrace{(b - d)}_{\in \mathbb{Z}} i \in \mathbb{Z}[i],
\end{aligned}
$$

and

$$
\begin{aligned}
(a + bi)(c + di) &= a(c + di) + bi(c + di) \\
                 &= ac + adi + bci - bd \\
                 &= \underbrace{(ac - bd)}_{\in \mathbb{Z}} + \underbrace{(ad + bc)}_{\in \mathbb{Z}} i \in \mathbb{Z}[i].
\end{aligned}
$$

Hence, $\mathbb{Z}[i]$ is a subring of $\mathbb{C}$. $\blacksquare$

---

**(b)**

$$
\begin{aligned}
U(\mathbb{Z}[i]) &= \{a + bi \in \mathbb{Z}[i] \mid \exists\, (a + bi)^{-1} \in \mathbb{Z}[i] \text{ s.t. } (a + bi)(a + bi)^{-1} = 1\} \\
                 &= \left\{ a + bi \in \mathbb{Z}[i] \;\middle|\; \exists\, \frac{a}{a^2 + b^2} - \frac{b}{a^2 + b^2}i \in \mathbb{Z}[i] \right\} \\
                 &= \left\{ a + bi \in \mathbb{Z}[i] \;\middle|\; \frac{a}{a^2 + b^2},\ \frac{b}{a^2 + b^2} \in \mathbb{Z} \right\} \\
                 &= \boxed{\{1, -1, i, -i\}} = U_4.
\end{aligned}
$$

---

**(c)** Let $a + bi, c + di \in \mathbb{Z}[i]$. Then,

$$
\begin{aligned}
(a + bi)(c + di) &= ac + adi + bci - bd \\
                 &= ac + bci + adi - bd \\
                 &= c(a + bi) + di(a + bi) \\
                 &= (c + di)(a + bi),
\end{aligned}
$$

so $\mathbb{Z}[i]$ is commutative.

Consider $0 \neq 1 + i \in \mathbb{Z}[i]$. Since $1 + i$ has no multiplicative inverse in $\mathbb{Z}[i]$, it is not a unit.

$\therefore$ $\mathbb{Z}[i]$ is **not** a field.

Since $\mathbb{Z}[i]$ is a subring of $\mathbb{C}$, and $\mathbb{C}$ has no zero divisors, $\mathbb{Z}[i]$ has no zero divisors.

$\therefore$ $\mathbb{Z}[i]$ is an integral domain. $\blacksquare$$BODY$
  ),
  (
    -- Q6 — Annihilator
    'ed9176e3-c36a-4c2c-b7de-84c4f5e62632',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'The Right Annihilator is a Subring',
    $BODY$Let $R$ be a ring and let $a \in R$. The set $\mathrm{Ann}_R(a) := \{r \in R \mid ar = 0\}$ is called the right annihilator of $a$. Show that $\mathrm{Ann}_R(a)$ is a subring of $R$.$BODY$,
    'medium',
    2026,
    'Exercise 10',
    6,
    $BODY$Use the subring test: show $\mathrm{Ann}_R(a)$ is nonempty and closed under subtraction and multiplication, using $a(r - s) = ar - as$ and $a(rs) = (ar)s$.$BODY$,
    $BODY$$\mathrm{Ann}_R(a)$ is a subring of $R$.$BODY$,
    $BODY$Clearly, $\mathrm{Ann}_R(a) \subseteq R$ by definition.

Let $r, s \in \mathrm{Ann}_R(a)$. Then $r, s \in R$ and $ar = as = 0$. It follows that $r - s, rs \in R$ and

$$
\begin{equation*}a(r - s) = ar - as = 0 - 0 = 0,\end{equation*}
$$

$$
\begin{equation*}a(rs) = (ar)s = 0 \cdot s = 0.\end{equation*}
$$

Hence, $r - s, rs \in \mathrm{Ann}_R(a)$.

$\therefore$ $\mathrm{Ann}_R(a)$ is a subring of $R$. $\blacksquare$$BODY$
  ),
  (
    -- Q7 — Q(sqrt2)
    '5289d8c9-4c37-45d4-b0ba-fce1b62c9c92',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    '$\\mathbb{Q}(\\sqrt{2})$ is a Subfield of $\\mathbb{R}$',
    $BODY$Prove that $\mathbb{Q}(\sqrt{2}) := \{a + b\sqrt{2} \mid a, b \in \mathbb{Q}\}$ is a subfield of $\mathbb{R}$.$BODY$,
    'hard',
    2026,
    'Exercise 10',
    7,
    $BODY$Check nonemptiness, closure under subtraction and multiplication, and that every nonzero element has an inverse — the inverse of $a + b\sqrt{2}$ is $\dfrac{a - b\sqrt{2}}{a^2 - 2b^2}$.$BODY$,
    $BODY$$\mathbb{Q}(\sqrt{2})$ is a subfield of $\mathbb{R}$.$BODY$,
    $BODY$Clearly, $\mathbb{Q}(\sqrt{2}) \subseteq \mathbb{R}$.

**(i)** Since $1 = 1 + 0\sqrt{2} \in \mathbb{Q}(\sqrt{2})$, we have $\mathbb{Q}(\sqrt{2}) \neq \{0\}$.

**(ii)** Let $a + b\sqrt{2}, c + d\sqrt{2} \in \mathbb{Q}(\sqrt{2})$. Then $a, b, c, d \in \mathbb{Q}$ and

$$
\begin{aligned}
(a + b\sqrt{2}) - (c + d\sqrt{2}) &= \underbrace{(a - c)}_{\in \mathbb{Q}} + \underbrace{(b - d)}_{\in \mathbb{Q}} \sqrt{2} \in \mathbb{Q}(\sqrt{2}),
\end{aligned}
$$

$$
\begin{aligned}
(a + b\sqrt{2})(c + d\sqrt{2}) &= a(c + d\sqrt{2}) + b\sqrt{2}(c + d\sqrt{2}) \\
                               &= \underbrace{(ac + 2bd)}_{\in \mathbb{Q}} + \underbrace{(ad + bc)}_{\in \mathbb{Q}} \sqrt{2} \in \mathbb{Q}(\sqrt{2}).
\end{aligned}
$$

**(iii)** Let $0 \neq a + b\sqrt{2} \in \mathbb{Q}(\sqrt{2})$. Consider $a - b\sqrt{2} \in \mathbb{Q}(\sqrt{2})$. Then $a - b\sqrt{2} \neq 0$ (since $a \neq b\sqrt{2}$), and $a^2 - 2b^2 = (a + b\sqrt{2})(a - b\sqrt{2}) \neq 0$. Hence,

$$
\begin{aligned}
(a + b\sqrt{2})\left((a - b\sqrt{2})(a^2 - 2b^2)^{-1}\right) &= (a^2 - 2b^2)(a^2 - 2b^2)^{-1} = 1.
\end{aligned}
$$

Therefore,

$$
\begin{equation*}(a + b\sqrt{2})^{-1} = \underbrace{a(a^2 - 2b^2)^{-1}}_{\in \mathbb{Q}} - \underbrace{b(a^2 - 2b^2)^{-1}}_{\in \mathbb{Q}} \sqrt{2} \in \mathbb{Q}(\sqrt{2}).\end{equation*}
$$

$\therefore$ $\mathbb{Q}(\sqrt{2})$ is a subfield of $\mathbb{R}$. $\blacksquare$$BODY$
  ),
  (
    -- Q8 — a unit + b²=0
    '7718b9a6-fdec-40ea-b160-c2eb8623c2f8',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'A Unit Plus a Nilpotent is a Unit',
    $BODY$Let $R$ be a commutative ring with unity $1$. If $a, b \in R$ such that $a$ is a unit and $b^2 = 0$, show that $a + b$ is a unit of $R$.$BODY$,
    'hard',
    2026,
    'Exercise 10',
    8,
    $BODY$Show that $(a + b)(a^{-1} - ba^{-2}) = 1$ using $b^2 = 0$ and commutativity. Then $(a + b)^{-1} = a^{-1} - ba^{-2} \in R$.$BODY$,
    $BODY$The inverse of $a + b$ is $a^{-1} - ba^{-2}$, which lies in $R$, so $a + b$ is a unit.$BODY$,
    $BODY$Suppose $a, b \in R$ such that $a$ is a unit and $b^2 = 0$.

Since $a$ is a unit, $a \neq 0$ and $a^{-1} \in R$. Moreover $a + b \neq 0$ (if $b = -a$, then $0 = b^2 = a^2 \neq 0$, a contradiction).

Now consider $a^{-1} - ba^{-2} \in R$. Then,

$$
\begin{aligned}
(a + b)(a^{-1} - ba^{-2}) &= (a + b)a^{-1} - (a + b)ba^{-2} \\
                          &= 1 + ba^{-1} - aba^{-2} - b^2 a^{-2} \\
                          &= 1 + ba^{-1} - ba^{-1} - 0 \\
                          &= 1.
\end{aligned}
$$

Therefore,

$$
\begin{equation*}(a + b)^{-1} = \underbrace{a^{-1}}_{\in R} - \underbrace{ba^{-1}a^{-1}}_{\in R} \in R.\end{equation*}
$$

$\therefore$ $a + b$ is a unit of $R$. $\blacksquare$$BODY$
  ),
  (
    -- Q9 — a²=1, a+1 zero divisor
    '881dbd96-5a33-4031-99ad-8b7a6b9036eb',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'If $a^2 = 1$ Then $a + 1$ is a Zero Divisor',
    $BODY$Let $R$ be a commutative ring with unity $1$. Show that if $a \in R$ such that $a^2 = 1$ and $a \notin \{1, -1\}$, then $a + 1$ is a zero divisor of $R$.$BODY$,
    'medium',
    2026,
    'Exercise 10',
    9,
    $BODY$Multiply $a + 1$ by $a - 1$: $(a + 1)(a - 1) = a^2 - 1 = 0$. Both factors are nonzero because $a \notin \{1, -1\}$.$BODY$,
    $BODY$(a + 1)(a - 1) = 0$ with both factors nonzero, so $a + 1$ is a zero divisor.$BODY$,
    $BODY$Suppose $a \in R$ such that $a^2 = 1$ and $a \notin \{1, -1\}$. Consider $a - 1 \in R$. Then,

$$
\begin{equation*}(a + 1)(a - 1) = a^2 - 1 = 1 - 1 = 0.\end{equation*}
$$

Since $a \notin \{1, -1\}$, both $a + 1 \neq 0$ and $a - 1 \neq 0$.

$\therefore$ $a + 1$ is a zero divisor of $R$. $\blacksquare$$BODY$
  ),
  (
    -- Q10 — a³=b³ and a⁷=b⁷ in domain
    '65265747-5e78-4443-a909-45001c0189be',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'In a Domain, $a^3 = b^3$ and $a^7 = b^7$ Imply $a = b$',
    $BODY$Let $D$ be an integral domain. Show that if $a, b \in D$ such that $a^3 = b^3$ and $a^7 = b^7$, then $a = b$.$BODY$,
    'hard',
    2026,
    'Exercise 10',
    10,
    $BODY$Square $a^3 = b^3$ to get $a^6 = b^6$, then multiply $a^7 = b^7$ to use cancellation: $a \cdot b^6 = b \cdot b^6$.$BODY$,
    $BODY$$a^3 = b^3$ implies $a^6 = b^6$, and $a^7 = b^7$ gives $a \cdot b^6 = b \cdot b^6$, so $(a - b)b^6 = 0$. Since $D$ is a domain, $a = b$.$BODY$,
    $BODY$Suppose $a, b \in D$ such that $a^3 = b^3$ and $a^7 = b^7$. Then,

$$
\begin{aligned}
a^3 = b^3 \text{ and } a^7 = b^7
  &\implies (a^3)^2 = (b^3)^2 \text{ and } a^7 = b^7 \\
  &\implies a^6 = b^6 \text{ and } a \cdot a^6 = b \cdot b^6 \\
  &\implies a \cdot b^6 = b \cdot b^6 \\
  &\implies (a - b)b^6 = 0.
\end{aligned}
$$

Since $D$ is an integral domain, $b^6 = 0$ or $a - b = 0$. If $b = 0$, then $a^3 = 0$ forces $a = 0$, so $a = b$. Otherwise $b^6 \neq 0$, and the cancellation law gives $a = b$.

$\therefore$ $a = b$, as desired. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
