-- ============================================================================
-- Math 110.1 — Third Long Exam (A.Y. 2023-2024)
-- Rings, Ideals, Fields, and Homomorphisms
-- Run AFTER schema.sql. Safe to re-run (uses ON CONFLICT DO NOTHING).
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Course
-- ---------------------------------------------------------------------------
insert into public.courses (id, code, name, description) values
  ('cd574181-02fb-4093-9e23-f268fea6baff', 'MATH 110.1', 'Abstract Algebra I',
   'Groups, rings, fields, ideals, homomorphisms, and fields of quotients.')
on conflict (code) do update set name = excluded.name, description = excluded.description;

-- ---------------------------------------------------------------------------
-- Topic (all questions fall under Rings and Ideals)
-- ---------------------------------------------------------------------------
insert into public.topics (id, course_id, name, description) values
  ('5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae', 'cd574181-02fb-4093-9e23-f268fea6baff', 'Rings, Ideals, and Fields', null)
on conflict (course_id, name) do nothing;

-- ---------------------------------------------------------------------------
-- Questions — Third Long Exam, 2023-2024
-- ---------------------------------------------------------------------------

-- Q1: Definitions (6 pts — 3 parts × 2 pts each)
insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '40da8bc6-d7c7-4255-a1c2-bb19cf54400b',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Definitions: Division Ring, Zero Divisor, Prime Ideal',
    $q$Define the following precisely:

**(a)** Division ring
**(b)** Zero divisor
**(c)** Prime ideal$q$,
    'medium',
    2023,
    'Third Long Exam',
    1,
    $q$Recall the exact algebraic conditions that each definition requires — do not state partial definitions.$q$,
    $q$**(a)** A *division ring* (or *skew field*) is a ring $R$ with unity $1 \neq 0$ in which every nonzero element has a multiplicative inverse. (Multiplication need not be commutative.)

**(b)** A *zero divisor* in a ring $R$ is a nonzero element $a \in R$ such that there exists a nonzero $b \in R$ with $ab = 0$ or $ba = 0$.

**(c)** A *prime ideal* of a commutative ring $R$ is a proper ideal $P$ such that whenever $ab \in P$ for $a, b \in R$, then $a \in P$ or $b \in P$.$q$,
    $q$**(a)** A **division ring** (skew field) is a ring $(R, +, \cdot)$ with unity $1 \neq 0$ such that every nonzero element $a \in R$ has a multiplicative inverse $a^{-1} \in R$. Note: multiplication is not required to be commutative.

**(b)** A **zero divisor** in a ring $R$ is a nonzero element $a \in R$ for which there exists a nonzero $b \in R$ with $ab = 0$ (left zero divisor) or $ba = 0$ (right zero divisor).

**(c)** A **prime ideal** of a commutative ring $R$ is an ideal $P \subsetneq R$ with $P \neq R$ such that for all $a, b \in R$, if $ab \in P$ then $a \in P$ or $b \in P$. Equivalently, $R/P$ is an integral domain.$q$
  ),

  -- Q2: Fill in the blanks (7 pts — 7 items × 1 pt each)
  (
    'fc5c2b8a-16cc-450f-a24c-c86553483b28',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Fill in the Blanks: Rings and Ideals',
    $q$Fill in the blanks with the word, phrase, number, or symbol that best completes the statement.

**(a)** If $M$ is a maximal ideal of a commutative ring with unity, then $R/M$ is a \_\_\_\_\_\_.

**(b)** The group of units of $\mathbb{Z}_9$ is $U(\mathbb{Z}_9) = $ \_\_\_\_\_\_.

**(c)** An example of an integral domain that is not a field is \_\_\_\_\_\_.

**(d)** If $I$ is a proper ideal of a field $F$, then $F/I$ is isomorphic to \_\_\_\_\_\_.

**(e)** If an ideal $I$ of the ring $\mathbb{Z}[i] = \{a + bi \mid a, b \in \mathbb{Z}\}$ contains the element $i$, then $I =$ \_\_\_\_\_\_.

**(f)** The only possible characteristics of an integral domain are \_\_\_\_\_\_.

**(g)** The prime subfield of a field with $81$ elements is \_\_\_\_\_\_.$q$,
    'medium',
    2023,
    'Third Long Exam',
    2,
    $q$For (a), recall the correspondence theorem. For (b), list the elements coprime to 9. For (f), remember that the characteristic of an integral domain is always prime or zero.$q$,
    $q$**(a)** a field
**(b)** $\{1, 2, 4, 5, 7, 8\}$
**(c)** $\mathbb{Z}$
**(d)** $F$ itself (the zero ring)
**(e)** $\mathbb{Z}[i]$ (the whole ring)
**(f)** $0$ or a prime number
**(g)** $\mathbb{Z}_3$ (the field with 3 elements)$q$,
    $q$**(a)** By the correspondence theorem, if $M$ is maximal in $R$ then $R/M$ is a **field**.

**(b)** $U(\mathbb{Z}_9)$ consists of elements coprime to $9$: $\{1, 2, 4, 5, 7, 8\}$. These form a group under multiplication mod $9$.

**(c)** $\mathbb{Z}$ is an integral domain (no zero divisors) but not a field (only $\pm 1$ are units).

**(d)** Since $F$ is a field, its only proper ideal is $\{0\}$. So $F/I \cong F/\{0\} \cong F$.

**(e)** Since $i \in I$ and $\mathbb{Z}[i]$ is a Euclidean domain, the ideal generated by $i$ is all of $\mathbb{Z}[i]$ because $1 = -i \cdot i \in I$, so $I = \mathbb{Z}[i]$.

**(f)** The characteristic of an integral domain is always **$0$ or a prime number**. (If the characteristic were $n = ab$ with $a, b > 1$, then $1 \cdot 1 = (1 \cdot a)(1 \cdot b) = 0$ would give zero divisors.)

**(g)** Since $|F| = 81 = 3^4$, the characteristic of $F$ is $3$, so the prime subfield is $\mathbb{Z}_3$.$q$
  ),

  -- Q3a: Z[sqrt(2)] — subring, ideal, subfield (7 pts)
  (
    '5db13bab-d471-42d5-957f-0ccaf2f618fc',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    '$\mathbb{Z}[\sqrt{2}]$: Subring, Ideal, or Subfield of $\mathbb{R}$?',
    $q$Let $\mathbb{Z}[\sqrt{2}] = \{a + b\sqrt{2} \mid a, b \in \mathbb{Z}\}$.

**(a)** Show that $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$.

**(b)** Is $\mathbb{Z}[\sqrt{2}]$ an ideal of $\mathbb{R}$? Justify your answer.

**(c)** Is $\mathbb{Z}[\sqrt{2}]$ a subfield of $\mathbb{R}$? Justify your answer.$q$,
    'hard',
    2023,
    'Third Long Exam',
    3,
    $q$For (a), verify the subring test: nonempty, closed under subtraction and multiplication. For (b), check whether $\mathbb{R} \cdot \mathbb{Z}[\sqrt{2}] \subseteq \mathbb{Z}[\sqrt{2}]$. For (c), check whether every nonzero element has a multiplicative inverse in $\mathbb{Z}[\sqrt{2}]$.$q$,
    $q$**(a)** $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$. It contains $0$, is closed under subtraction and multiplication.

**(b)** No — $\mathbb{Z}[\sqrt{2}]$ is not an ideal of $\mathbb{R}$.

**(c)** No — $\mathbb{Z}[\sqrt{2}]$ is not a subfield of $\mathbb{R}$.$q$,
    $q$**(a)** To show $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$:

- $0 = 0 + 0\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$, so it is nonempty.
- If $x = a + b\sqrt{2}$ and $y = c + d\sqrt{2}$, then $x - y = (a - c) + (b - d)\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$.
- $xy = (ac + 2bd) + (ad + bc)\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$.

By the subring test, $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$.

**(b)** No. For $\mathbb{Z}[\sqrt{2}]$ to be an ideal of $\mathbb{R}$, we would need $r \cdot x \in \mathbb{Z}[\sqrt{2}]$ for all $r \in \mathbb{R}$ and $x \in \mathbb{Z}[\sqrt{2}]$. But $\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$ and $\frac{1}{2} \in \mathbb{R}$, yet $\frac{1}{2} \cdot \sqrt{2} = \frac{\sqrt{2}}{2} \notin \mathbb{Z}[\sqrt{2}]$ (since $\frac{1}{2} \notin \mathbb{Z}$). So $\mathbb{Z}[\sqrt{2}]$ fails the absorption property.

**(c)** No. For $\mathbb{Z}[\sqrt{2}]$ to be a subfield, every nonzero element would need a multiplicative inverse in $\mathbb{Z}[\sqrt{2}]$. But $2 = 2 + 0\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$, and its inverse in $\mathbb{R}$ is $\frac{1}{2}$, which is not in $\mathbb{Z}[\sqrt{2}]$. So $\mathbb{Z}[\sqrt{2}]$ is not a subfield.$q$
  ),

  -- Q3b: Ring homomorphism check (2 pts)
  (
    '7b8ad2d0-c40f-4b29-a96a-d194f9953904',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Ring Homomorphism from $\mathbb{Z}_4$ to $\mathbb{Z}_{12}$',
    $q$Determine if the map $\varphi: \mathbb{Z}_4 \to \mathbb{Z}_{12}$ given by $\varphi(x) = 3x \pmod{12}$ is a ring homomorphism.$q$,
    'medium',
    2023,
    'Third Long Exam',
    4,
    $q$Check whether $\varphi$ preserves addition and multiplication, and whether $\varphi(1) = 1$.$q$,
    $q$**No**, $\varphi$ is not a ring homomorphism.$q$,
    $q$For $\varphi$ to be a ring homomorphism, we need $\varphi(1) = 1$. But $\varphi(1) = 3 \pmod{12}$, and $3 \neq 1$ in $\mathbb{Z}_{12}$. So $\varphi$ does not preserve the multiplicative identity.

Alternatively, check multiplication: $\varphi(1 \cdot 1) = 3$ but $\varphi(1) \cdot \varphi(1) = 3 \cdot 3 = 9 \neq 3$ in $\mathbb{Z}_{12}$. So $\varphi$ does not preserve multiplication.$q$
  ),

  -- Q3c: Quotient ring R/I (7 pts — 4 sub-parts)
  (
    'f8d6c809-788f-46b1-bbb2-981db4b62e36',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Quotient Ring 5Z / 30Z',
    $q$Consider the ring $R = 5\mathbb{Z}$ under the usual addition and multiplication. Let $I$ be the ideal $30\mathbb{Z}$.

**(a)** List all six elements of the quotient ring $R/I$.

**(b)** Construct the multiplication table for $R/I$.

**(c)** Does $R/I$ have unity? If yes, identify the unity.

**(d)** Identify all the zero divisors of $R/I$.$q$,
    'medium',
    2023,
    'Third Long Exam',
    5,
    $q$The cosets of $30\mathbb{Z}$ in $5\mathbb{Z}$ are $5k + 30\mathbb{Z}$ for $k = 0, 1, 2, 3, 4, 5$. Think of $R/I \cong \mathbb{Z}_6$ under the natural isomorphism.$q$,
    $q$**(a)** The six elements are $5\mathbb{Z}/30\mathbb{Z}$: $\{0 + 30\mathbb{Z},\; 5 + 30\mathbb{Z},\; 10 + 30\mathbb{Z},\; 15 + 30\mathbb{Z},\; 20 + 30\mathbb{Z},\; 25 + 30\mathbb{Z}\}$.

**(c)** Yes, the unity is $25 + 30\mathbb{Z}$.

**(d)** The zero divisors are $10 + 30\mathbb{Z}$, $15 + 30\mathbb{Z}$, and $20 + 30\mathbb{Z}$.$q$,
    $q$Note: $R/I = 5\mathbb{Z}/30\mathbb{Z}$ is isomorphic to $\mathbb{Z}_6$ as a ring (the correspondence is $\overline{5}\leftrightarrow\bar{5}$, $\overline{10}\leftrightarrow\bar{4}$, $\overline{15}\leftrightarrow\bar{3}$, $\overline{20}\leftrightarrow\bar{2}$, $\overline{25}\leftrightarrow\bar{1}$, $\overline{0}\leftrightarrow\bar{0}$; in particular the unity $\overline{25}$ maps to $\bar{1}$). The table below is computed directly in $R/I$.

**(a)** The six cosets are:
- $\overline{0} = 0 + 30\mathbb{Z}$
- $\overline{5} = 5 + 30\mathbb{Z}$
- $\overline{10} = 10 + 30\mathbb{Z}$
- $\overline{15} = 15 + 30\mathbb{Z}$
- $\overline{20} = 20 + 30\mathbb{Z}$
- $\overline{25} = 25 + 30\mathbb{Z}$

**(b)** Under the isomorphism $R/I \cong \mathbb{Z}_6$ (where $\overline{5k} \leftrightarrow \bar{k}$), the multiplication table mirrors $\mathbb{Z}_6$:

| $\cdot$ | $\overline{0}$ | $\overline{5}$ | $\overline{10}$ | $\overline{15}$ | $\overline{20}$ | $\overline{25}$ |
|---|---|---|---|---|---|---|
| $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ |
| $\overline{5}$ | $\overline{0}$ | $\overline{25}$ | $\overline{20}$ | $\overline{15}$ | $\overline{10}$ | $\overline{5}$ |
| $\overline{10}$ | $\overline{0}$ | $\overline{20}$ | $\overline{10}$ | $\overline{0}$ | $\overline{20}$ | $\overline{10}$ |
| $\overline{15}$ | $\overline{0}$ | $\overline{15}$ | $\overline{0}$ | $\overline{15}$ | $\overline{0}$ | $\overline{15}$ |
| $\overline{20}$ | $\overline{0}$ | $\overline{10}$ | $\overline{20}$ | $\overline{0}$ | $\overline{10}$ | $\overline{20}$ |
| $\overline{25}$ | $\overline{0}$ | $\overline{5}$ | $\overline{10}$ | $\overline{15}$ | $\overline{20}$ | $\overline{25}$ |

**(c)** The unity is $\overline{25}$ (corresponding to $\bar{1}$ in $\mathbb{Z}_6$, since $25 \equiv 1 \pmod{6}$). The row for $\overline{25}$ reproduces each column, confirming it acts as the identity.

**(d)** The zero divisors are $\overline{10}$, $\overline{15}$, and $\overline{20}$ (corresponding to $\bar{2}$, $\bar{3}$, $\bar{4}$ in $\mathbb{Z}_6$). They multiply to $\overline{0}$ with at least one other nonzero element: $\overline{10} \cdot \overline{15} = \overline{0}$ and $\overline{20} \cdot \overline{15} = \overline{0}$. The elements $\overline{5}$ and $\overline{25}$ are not zero divisors since their rows are permutations of all six cosets.$q$
  ),

  -- Q4a: Proof — homomorphism image of ideal (3 pts)
  (
    '823c05f6-6e51-4758-ad65-53f1593c4daa',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Proof: Image of an Ideal Under a Ring Homomorphism',
    $q$Let $\varphi: R \to R'$ be a ring homomorphism. Show that if $I$ is an ideal of $R$, then $\varphi(I)$ is an ideal of $\varphi(R)$.$q$,
    'hard',
    2023,
    'Third Long Exam',
    6,
    $q$To show $\varphi(I)$ is an ideal of $\varphi(R)$: (1) show it is an additive subgroup, (2) show it absorbs multiplication by arbitrary elements of $\varphi(R)$. Use the fact that every element of $\varphi(R)$ is $\varphi(r)$ for some $r \in R$.$q$,
    $q$Proof: We verify the ideal conditions for $\varphi(I)$ in $\varphi(R)$.$q$,
    $q$We verify that $\varphi(I)$ is an ideal of $\varphi(R)$ by checking the two conditions.

**$\varphi(I)$ is an additive subgroup of $\varphi(R)$:**
- $0 = \varphi(0) \in \varphi(I)$ since $0 \in I$.
- If $\varphi(a), \varphi(b) \in \varphi(I)$ with $a, b \in I$, then $\varphi(a) - \varphi(b) = \varphi(a - b) \in \varphi(I)$ since $a - b \in I$ (ideals are additive subgroups).

**Absorption:** Let $\varphi(r) \in \varphi(R)$ (with $r \in R$) and $\varphi(a) \in \varphi(I)$ (with $a \in I$).
- $\varphi(r) \cdot \varphi(a) = \varphi(ra) \in \varphi(I)$ since $ra \in I$ ($I$ is an ideal of $R$).
- $\varphi(a) \cdot \varphi(r) = \varphi(ar) \in \varphi(I)$ since $ar \in I$ ($I$ is an ideal of $R$).

Therefore $\varphi(I)$ is an ideal of $\varphi(R)$. $\blacksquare$$q$
  ),

  -- Q4b: Proof — kernel of epimorphism is prime ideal (4 pts)
  (
    'f5346797-b42c-4737-bf62-9f2ac9534593',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Proof: Kernel of Epimorphism onto an Integral Domain',
    $q$Let $R$ and $R'$ be rings and $\varphi: R \to R'$ a ring epimorphism. Prove that if $R$ is a commutative ring with unity and $R'$ is an integral domain, then $\ker \varphi$ is a prime ideal of $R$.$q$,
    'hard',
    2023,
    'Third Long Exam',
    7,
    $q$Use the first isomorphism theorem: $R/\ker\varphi \cong R'$. Since $R'$ is an integral domain, $R/\ker\varphi$ is an integral domain, which characterizes prime ideals.$q$,
    $q$Proof: By the First Isomorphism Theorem, $R/\ker\varphi \cong R'$. Since $R'$ is an integral domain, $R/\ker\varphi$ is an integral domain. A proper ideal of a commutative ring is prime if and only if the quotient ring is an integral domain. Since $R'$ is an integral domain (hence $R' \neq \{0\}$), $\ker\varphi \neq R$, so $\ker\varphi$ is a proper ideal. Thus $\ker\varphi$ is a prime ideal of $R$. $\blacksquare$$q$,
    $q$By the First Isomorphism Theorem for rings, since $\varphi$ is an epimorphism (surjective):

$$R / \ker \varphi \cong R'.$$

Since $R'$ is an integral domain, the quotient $R/\ker\varphi$ is also an integral domain (isomorphic rings share algebraic properties).

We need to verify that $\ker \varphi$ is a **proper** ideal. Since $R'$ is an integral domain, $R' \neq \{0\}$ (integral domains must have $1 \neq 0$). Since $\varphi$ is surjective and $1_{R'} \neq 0_{R'}$, there exists $r \in R$ with $\varphi(r) = 1_{R'} \neq 0$, so $r \notin \ker\varphi$, hence $\ker\varphi \neq R$.

For a commutative ring $R$ with unity, an ideal $P$ is prime if and only if $R/P$ is an integral domain (and $P$ is proper). Since $R/\ker\varphi$ is an integral domain and $\ker\varphi$ is proper, $\ker\varphi$ is a prime ideal of $R$. $\blacksquare$$q$
  ),

  -- Q4c: Proof — prime ideal element factorization (4 pts)
  (
    '1d3fa77b-bce2-46af-b765-7136783a686e',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Proof: Prime Element in an Integral Domain',
    $q$Let $D$ be an integral domain and $0 \neq p \in D$. Suppose the principal ideal $\langle p \rangle$ is a prime ideal of $D$. Prove that if $p = ab$, then either $a$ is a unit of $D$ or $b$ is a unit of $D$.$q$,
    'hard',
    2023,
    'Third Long Exam',
    8,
    $q$Since $\langle p \rangle$ is prime, $p \mid ab$ implies $p \mid a$ or $p \mid b$. Consider what $p = ab$ then forces.$q$,
    $q$Proof: Since $p = ab$, we have $ab = p \in \langle p \rangle$. Since $\langle p \rangle$ is a prime ideal, $a \in \langle p \rangle$ or $b \in \langle p \rangle$.

Without loss of generality, suppose $a \in \langle p \rangle$. Then $a = pc$ for some $c \in D$. Substituting, $p = ab = pcb$, so $p(1 - cb) = 0$. Since $D$ is an integral domain and $p \neq 0$, we get $cb = 1$. Thus $b$ is a unit of $D$. $\blacksquare$$q$,
    $q$Since $p = ab$, we have $ab \in \langle p \rangle$. Because $\langle p \rangle$ is a prime ideal, $a \in \langle p \rangle$ or $b \in \langle p \rangle$.

**Case 1:** Suppose $a \in \langle p \rangle$. Then $a = pc$ for some $c \in D$. Substituting into $p = ab$:

$$p = (pc)b = p(cb).$$

Since $D$ is an integral domain and $p \neq 0$, we may cancel $p$:

$$1 = cb.$$

This shows $b$ is a unit (with $c$ as its inverse).

**Case 2:** Suppose $b \in \langle p \rangle$. Then $b = pd$ for some $d \in D$. Similarly, $p = a(pd) = (ap)d$, and canceling $p$ gives $ad = 1$, so $a$ is a unit.

In either case, $a$ or $b$ is a unit. $\blacksquare$$q$
  )
on conflict (id) do nothing;
