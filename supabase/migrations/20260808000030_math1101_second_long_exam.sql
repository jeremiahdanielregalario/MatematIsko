-- ============================================================================
-- Math 110.1 Second Long Exam — 1st Sem A.Y. 2023-2024
-- 14 problems (theorems, fill-in-the-blanks, permutation/factor-group
-- computations, homomorphism proofs).
--
-- One item from the original exam was SKIPPED because an identical question
-- already exists in the bank (verified against live data):
--   • "Commutators and Abelian Quotients" (Exercise 8):
--     "G/N is abelian iff b^{-1}a^{-1}ba ∈ N for all a, b ∈ G."
--
-- New topics introduced for this exam's content areas:
--   • Homomorphisms and Kernels
--   • Permutation Groups
--   • Factor Groups and Isomorphism Theorems
--   • Direct Products and Abelian Groups
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a01',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'Homomorphisms and Kernels',
    'Group homomorphisms, kernels, and their properties.'
  ),
  (
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a02',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'Permutation Groups',
    'Symmetric and alternating groups, cycle decompositions.'
  ),
  (
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a03',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'Factor Groups and Isomorphism Theorems',
    'Quotient groups, normal subgroups, and the isomorphism theorems.'
  ),
  (
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a04',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'Direct Products and Abelian Groups',
    'Direct products and the classification of finite abelian groups.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — State Cayley's Theorem
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d01',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a03',
    'Cayley\u2019s Theorem',
    $BODY$State Cayley's Theorem precisely.$BODY$,
    'easy',
    2023,
    'Second Long Exam',
    1,
    $BODY$Every group embeds into a symmetric group via the left regular representation.$BODY$,
    $BODY$**Cayley's Theorem.** Every group $G$ is isomorphic to a subgroup of the symmetric group on $G$. In particular, if $G$ is a finite group of order $n$, then $G$ is isomorphic to a subgroup of $S_n$.$BODY$,
    $BODY$**Cayley's Theorem.** Every group $G$ is isomorphic to a subgroup of the symmetric group $S_G$ acting on the set $G$.

*Proof sketch.* For each $g \in G$, define the left-translation map $L_g : G \to G$ by $L_g(x) = gx$. Each $L_g$ is a bijection of $G$, so $L_g \in S_G$. The map
$$\Phi : G \to S_G, \qquad \Phi(g) = L_g$$
is a homomorphism because $L_{gh}(x) = (gh)x = g(hx) = L_g \circ L_h(x)$, so $\Phi(gh) = \Phi(g)\Phi(h)$. It is one-to-one since $L_g = L_h$ implies $g = L_g(e) = L_h(e) = h$. Hence $G \cong \Phi(G) \le S_G$. For $|G| = n$, identifying $S_G$ with $S_n$ gives $G \lesssim S_n$. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — State the First Isomorphism Theorem
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d02',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a03',
    'First Isomorphism Theorem for Groups',
    $BODY$State the First Isomorphism Theorem for groups.$BODY$,
    'easy',
    2023,
    'Second Long Exam',
    2,
    $BODY$The theorem relates $G/\ker \varphi$ to the image of $\varphi$.$BODY$,
    $BODY$**First Isomorphism Theorem.** If $\varphi : G \to G'$ is a group homomorphism with kernel $\ker \varphi$, then
$$G / \ker \varphi \cong \varphi(G).$$
Equivalently, $G/\ker \varphi \cong \operatorname{Im}\varphi$.$BODY$,
    $BODY$**First Isomorphism Theorem.** Let $\varphi : G \to G'$ be a group homomorphism. Then $\ker \varphi$ is a normal subgroup of $G$ and
$$G / \ker \varphi \cong \varphi(G).$$

*Proof sketch.* Define $\overline{\varphi} : G/\ker \varphi \to \varphi(G)$ by $\overline{\varphi}(g\ker\varphi) = \varphi(g)$. This is well-defined: if $g_1\ker\varphi = g_2\ker\varphi$, then $g_2^{-1}g_1 \in \ker\varphi$, so $\varphi(g_2)^{-1}\varphi(g_1) = e'$, giving $\varphi(g_1) = \varphi(g_2)$. It is a homomorphism, onto $\varphi(G)$, and injective because $\overline{\varphi}(g\ker\varphi) = e'$ forces $g \in \ker\varphi$. Hence it is an isomorphism. $\blacksquare$ $BODY$
  ),
  (
    -- Q3 — Fill in the blank: permutation definition
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d03',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a02',
    'Fill in the Blank: A Permutation of a Set',
    $BODY$Fill in the blank with the word, phrase, number, or symbol that best completes the statement.

> A permutation of a set $A$ is a function on $A$ that is \_\_\_\_\_\_\_\_.$BODY$,
    'easy',
    2023,
    'Second Long Exam',
    3,
    $BODY$Which two properties does a function need to be invertible as a map $A \to A$?$BODY$,
    $BODY$A permutation of a set $A$ is a function on $A$ that is **one-to-one and onto** (that is, a bijection from $A$ to $A$).$BODY$,
    $BODY$A **permutation** of a set $A$ is a function $f : A \to A$ that is both **one-to-one** (injective) and **onto** (surjective) — in other words, a bijection. A bijection $A \to A$ always has an inverse, so the permutations of $A$ form the symmetric group $S_A$ under composition. $\blacksquare$ $BODY$
  ),
  (
    -- Q4 — Fill in the blank: order of A_n
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d04',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a02',
    'Fill in the Blank: Order of the Alternating Group $A_n$',
    $BODY$Fill in the blank with the word, phrase, number, or symbol that best completes the statement.

> For any integer $n > 1$, the order of the alternating group $A_n$ is \_\_\_\_\_\_\_\_.$BODY$,
    'easy',
    2023,
    'Second Long Exam',
    4,
    $BODY$Exactly half of the $n!$ permutations in $S_n$ are even.$BODY$,
    $BODY$For $n > 1$, the order of $A_n$ is $n!/2$.$BODY$,
    $BODY$The sign map $\operatorname{sgn} : S_n \to \{+1, -1\}$ is a surjective homomorphism with kernel $A_n$. By the First Isomorphism Theorem, $|S_n| = |A_n| \cdot |\{+1, -1\}|$, so
$$|A_n| = \frac{|S_n|}{2} = \frac{n!}{2}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — Fill in the blank: abelian groups of order 8
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d05',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a04',
    'Fill in the Blank: Abelian Groups of Order $8$',
    $BODY$Fill in the blank with the word, phrase, number, or symbol that best completes the statement.

> The number of abelian groups (up to isomorphism) of order $8$ is \_\_\_\_\_\_\_\_.$BODY$,
    'medium',
    2023,
    'Second Long Exam',
    5,
    $BODY$Since $8 = 2^3$, count the partitions of $3$ (the exponents of the prime-power cyclic factors).$BODY$,
    $BODY$There are **3** abelian groups of order $8$ up to isomorphism: $\mathbb{Z}_8$, $\mathbb{Z}_4 \times \mathbb{Z}_2$, and $\mathbb{Z}_2 \times \mathbb{Z}_2 \times \mathbb{Z}_2$.$BODY$,
    $BODY$By the Fundamental Theorem of Finite Abelian Groups, a finite abelian group of order $p_1^{e_1} \cdots p_k^{e_k}$ is a product of cyclic groups of prime-power order, and the number of choices is the product of the partition numbers $p(e_i)$.

For $8 = 2^3$, the partitions of $3$ are $3$, $2 + 1$, $1 + 1 + 1$, giving
$$\mathbb{Z}_8, \qquad \mathbb{Z}_4 \times \mathbb{Z}_2, \qquad \mathbb{Z}_2 \times \mathbb{Z}_2 \times \mathbb{Z}_2.$$
So the number is $p(3) = 3$. $\blacksquare$ $BODY$
  ),
  (
    -- Q6 — Fill in the blank: order of D_4 / <R_90>
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d06',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a03',
    'Fill in the Blank: Order of $D_4 / \langle R_{90^{\circ}} \rangle$',
    $BODY$Fill in the blank with the word, phrase, number, or symbol that best completes the statement.

> The order of the factor group $D_4 / \langle R_{90^{\circ}} \rangle$ is \_\_\_\_\_\_\_\_.$BODY$,
    'easy',
    2023,
    'Second Long Exam',
    6,
    $BODY$Use Lagrange: the order of the quotient is $|D_4|$ divided by $|\langle R_{90^{\circ}} \rangle|$.$BODY$,
    $BODY$The order is **2**. $|D_4| = 8$ and $\langle R_{90^{\circ}} \rangle$ consists of the $4$ rotations, so $|D_4 / \langle R_{90^{\circ}} \rangle| = 8/4 = 2$.$BODY$,
    $BODY$The dihedral group $D_4$ has order $8$. The cyclic subgroup generated by the $90^\circ$ rotation is
$$\langle R_{90^{\circ}} \rangle = \{R_0, R_{90}, R_{180}, R_{270}\},$$
which has order $4$. By Lagrange's Theorem,
$$|D_4 / \langle R_{90^{\circ}} \rangle| = \frac{|D_4|}{|\langle R_{90^{\circ}} \rangle|} = \frac{8}{4} = 2. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q7 — Fill in the blank: injective homomorphism iff trivial kernel
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d07',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a01',
    'Fill in the Blank: One-to-One Homomorphisms and the Kernel',
    $BODY$Fill in the blank with the word, phrase, number, or symbol that best completes the statement.

> A homomorphism $\varphi : S_n \to S_n$ is one-to-one whenever $\ker \varphi =$ \_\_\_\_\_\_\_\_.$BODY$,
    'easy',
    2023,
    'Second Long Exam',
    7,
    $BODY$The kernel of an injective homomorphism must be as small as possible.$BODY$,
    $BODY$A homomorphism $\varphi : S_n \to S_n$ is one-to-one whenever $\ker \varphi = \{e\}$ (the trivial subgroup containing only the identity permutation).$BODY$,
    $BODY$In general, a group homomorphism $\varphi : G \to G'$ is one-to-one if and only if $\ker \varphi = \{e\}$:
- If $\varphi$ is one-to-one, then $\varphi(g) = e'$ only for $g = e$, so $\ker\varphi = \{e\}$.
- Conversely, if $\ker\varphi = \{e\}$ and $\varphi(a) = \varphi(b)$, then $\varphi(b^{-1}a) = \varphi(b)^{-1}\varphi(a) = e'$, so $b^{-1}a \in \ker\varphi = \{e\}$, forcing $a = b$.

For the symmetric group the identity element is the identity permutation, so the kernel must be $\{(1)\}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q8 — Permutations alpha, beta in S_8
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d08',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a02',
    'Orders, Parity, and Solving $\sigma\alpha = \beta$ in $S_8$',
    $BODY$Let
$$\alpha = \begin{pmatrix} 1 & 2 & 3 & 4 & 5 & 6 & 7 & 8 \\ 3 & 5 & 4 & 2 & 1 & 7 & 8 & 6 \end{pmatrix} \quad \text{and} \quad \beta = (1\ 3\ 2)(5\ 4\ 6\ 8) \in S_8.$$

**(a)** Determine the order of $\alpha$.

**(b)** Identify whether $\beta$ is an even or an odd permutation.

**(c)** Solve for $\sigma$ such that $\sigma\alpha = \beta$ and write $\sigma$ as a product of disjoint cycles.$BODY$,
    'medium',
    2023,
    'Second Long Exam',
    8,
    $BODY$For (a), decompose $\alpha$ into disjoint cycles; the order is the lcm of the cycle lengths. For (b), count the number of 2-cycles in each factor. For (c), multiply both sides on the right by $\alpha^{-1}$: $\sigma = \beta\alpha^{-1}$.$BODY$,
    $BODY$**(a)** $\alpha = (1\ 3\ 4\ 2\ 5)(6\ 7\ 8)$, so $|\alpha| = \operatorname{lcm}(5, 3) = 15$.

**(b)** $\beta$ is **odd**: a 3-cycle is even and a 4-cycle is odd, and even $\times$ odd $=$ odd.

**(c)** $\sigma = \beta\alpha^{-1} = (1\ 4\ 2\ 6\ 5)(7\ 8)$.$BODY$,
    $BODY$**(a)** Decompose $\alpha$ into disjoint cycles:
$$1 \to 3 \to 4 \to 2 \to 5 \to 1, \qquad 6 \to 7 \to 8 \to 6,$$
so $\alpha = (1\ 3\ 4\ 2\ 5)(6\ 7\ 8)$. The order is the least common multiple of the cycle lengths: $|\alpha| = \operatorname{lcm}(5, 3) = 15$. $\blacksquare$

**(b)** A cycle of length $k$ is even iff $k$ is odd (it factors as $k-1$ transpositions). Thus $(1\ 3\ 2)$ is a 3-cycle $\Rightarrow$ even, and $(5\ 4\ 6\ 8)$ is a 4-cycle $\Rightarrow$ odd. Their product is **odd**:
$$\operatorname{sgn}(\beta) = (+1)(-1) = -1. \;\blacksquare$$

**(c)** From $\sigma\alpha = \beta$, right-multiply by $\alpha^{-1}$:
$$\sigma = \beta\alpha^{-1}.$$
Since $\alpha = (1\ 3\ 4\ 2\ 5)(6\ 7\ 8)$, we have $\alpha^{-1} = (1\ 5\ 2\ 4\ 3)(6\ 8\ 7)$. Now $\sigma(x) = \beta(\alpha^{-1}(x))$:
$$\sigma(1) = \beta(5) = 4, \quad \sigma(4) = \beta(3) = 2, \quad \sigma(2) = \beta(4) = 6, \quad \sigma(6) = \beta(8) = 5, \quad \sigma(5) = \beta(2) = 1,$$
so $1 \to 4 \to 2 \to 6 \to 5 \to 1$, giving the cycle $(1\ 4\ 2\ 6\ 5)$; and
$$\sigma(3) = \beta(1) = 3 \text{ (fixed)}, \qquad \sigma(7) = \beta(6) = 8, \quad \sigma(8) = \beta(7) = 7,$$
giving $(7\ 8)$. Therefore
$$\sigma = (1\ 4\ 2\ 6\ 5)(7\ 8). \;\blacksquare$$ $BODY$
  ),
  (
    -- Q9 — Abelian groups of order 72
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d09',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a04',
    'Abelian Groups of Order $72$ and $\mathbb{Z}_4 \times \mathbb{Z}_{18}$',
    $BODY$Enumerate all possible non-isomorphic abelian groups of order $72$ and identify which among your list is isomorphic to $\mathbb{Z}_4 \times \mathbb{Z}_{18}$.$BODY$,
    'hard',
    2023,
    'Second Long Exam',
    9,
    $BODY$Write $72 = 2^3 \cdot 3^2$ and combine the prime-power pieces; then use the Chinese Remainder Theorem on $\mathbb{Z}_{18}$ to recognize $\mathbb{Z}_4 \times \mathbb{Z}_{18}$ in the list.$BODY$,
    $BODY$The abelian groups of order $72 = 2^3 \cdot 3^2$ are:
1. $\mathbb{Z}_8 \times \mathbb{Z}_9$
2. $\mathbb{Z}_8 \times \mathbb{Z}_3 \times \mathbb{Z}_3$
3. $\mathbb{Z}_4 \times \mathbb{Z}_2 \times \mathbb{Z}_9$
4. $\mathbb{Z}_4 \times \mathbb{Z}_2 \times \mathbb{Z}_3 \times \mathbb{Z}_3$
5. $\mathbb{Z}_2 \times \mathbb{Z}_2 \times \mathbb{Z}_2 \times \mathbb{Z}_9$
6. $\mathbb{Z}_2 \times \mathbb{Z}_2 \times \mathbb{Z}_2 \times \mathbb{Z}_3 \times \mathbb{Z}_3$

Since $\mathbb{Z}_{18} \cong \mathbb{Z}_2 \times \mathbb{Z}_9$, we get $\mathbb{Z}_4 \times \mathbb{Z}_{18} \cong \mathbb{Z}_4 \times \mathbb{Z}_2 \times \mathbb{Z}_9$, which is **#3** in the list.$BODY$,
    $BODY$**Step 1.** Since $72 = 8 \cdot 9 = 2^3 \cdot 3^2$ and $\gcd(8, 9) = 1$, every abelian group of order $72$ is a direct product of an abelian group of order $8$ and one of order $9$.

- Abelian groups of order $8 = 2^3$ (partitions of $3$): $\mathbb{Z}_8$, $\mathbb{Z}_4 \times \mathbb{Z}_2$, $\mathbb{Z}_2^3$.
- Abelian groups of order $9 = 3^2$ (partitions of $2$): $\mathbb{Z}_9$, $\mathbb{Z}_3 \times \mathbb{Z}_3$.

**Step 2.** Combining each pair gives $3 \times 2 = 6$ groups:
$$\mathbb{Z}_8 \times \mathbb{Z}_9, \quad \mathbb{Z}_8 \times \mathbb{Z}_3 \times \mathbb{Z}_3, \quad \mathbb{Z}_4 \times \mathbb{Z}_2 \times \mathbb{Z}_9, \quad \mathbb{Z}_4 \times \mathbb{Z}_2 \times \mathbb{Z}_3 \times \mathbb{Z}_3, \quad \mathbb{Z}_2^3 \times \mathbb{Z}_9, \quad \mathbb{Z}_2^3 \times \mathbb{Z}_3 \times \mathbb{Z}_3.$$

**Step 3.** By the Chinese Remainder Theorem, $\mathbb{Z}_{18} \cong \mathbb{Z}_2 \times \mathbb{Z}_9$ because $\gcd(2, 9) = 1$. Hence
$$\mathbb{Z}_4 \times \mathbb{Z}_{18} \cong \mathbb{Z}_4 \times \mathbb{Z}_2 \times \mathbb{Z}_9,$$
which is the third group in the list. $\blacksquare$ $BODY$
  ),
  (
    -- Q10 — D_4 x A_4 x Z_12
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d10',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a04',
    'Order and Index in $D_4 \times A_4 \times \mathbb{Z}_{12}$',
    $BODY$Consider the group $D_4 \times A_4 \times \mathbb{Z}_{12}$.

**(a)** Find the order of $D_4 \times A_4 \times \mathbb{Z}_{12}$.

**(b)** Determine the order of the element $(R_{180^{\circ}}, (1\ 2\ 4), 3)$.

**(c)** Compute the index of $\langle (R_{180^{\circ}}, (1\ 2\ 4), 3) \rangle$ in $D_4 \times A_4 \times \mathbb{Z}_{12}$.$BODY$,
    'medium',
    2023,
    'Second Long Exam',
    10,
    $BODY$The order of a direct product is the product of the orders. The order of a triple is the lcm of the component orders. The index of a cyclic subgroup $\langle x \rangle$ is $|G| / |x|$.$BODY$,
    $BODY$**(a)** $|D_4 \times A_4 \times \mathbb{Z}_{12}| = 8 \cdot 12 \cdot 12 = 1152$.

**(b)** $|R_{180}| = 2$, $|(1\ 2\ 4)| = 3$, $|3|$ in $\mathbb{Z}_{12}$ is $4$, so the order is $\operatorname{lcm}(2, 3, 4) = 12$.

**(c)** The index is $1152 / 12 = 96$.$BODY$,
    $BODY$**(a)** The order of a direct product is the product of the orders of the factors:
$$|D_4 \times A_4 \times \mathbb{Z}_{12}| = |D_4| \cdot |A_4| \cdot |\mathbb{Z}_{12}| = 8 \cdot 12 \cdot 12 = 1152.$$

**(b)** The order of an element $(g_1, g_2, g_3)$ in a direct product is the lcm of the orders of its components:
- In $D_4$, $R_{180^{\circ}}$ has order $2$.
- In $A_4$, the 3-cycle $(1\ 2\ 4)$ has order $3$.
- In $\mathbb{Z}_{12}$, the element $3$ has order $\frac{12}{\gcd(3, 12)} = \frac{12}{3} = 4$.

Hence $|(R_{180^{\circ}}, (1\ 2\ 4), 3)| = \operatorname{lcm}(2, 3, 4) = 12$. $\blacksquare$

**(c)** Since $\langle x \rangle$ is cyclic of order $|x| = 12$, by Lagrange
$$[D_4 \times A_4 \times \mathbb{Z}_{12} : \langle (R_{180^{\circ}}, (1\ 2\ 4), 3) \rangle] = \frac{1152}{12} = 96. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q11 — Z_12 / <4>
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d11',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a03',
    'The Factor Group $\mathbb{Z}_{12} / \langle 4 \rangle$',
    $BODY$Consider the group $G = \mathbb{Z}_{12}$.

**(a)** Explain why $H = \langle 4 \rangle$ is a normal subgroup of $\mathbb{Z}_{12}$.

**(b)** List all the elements of $G / H$.

**(c)** Enumerate all the cyclic subgroups of $G / H$.

**(d)** To which known group is $G / H$ isomorphic? Justify your answer.$BODY$,
    'medium',
    2023,
    'Second Long Exam',
    11,
    $BODY$Every subgroup of an abelian group is normal. Then $|G/H| = 12/3 = 4$; check whether $1 + H$ generates it.$BODY$,
    $BODY$**(a)** $\mathbb{Z}_{12}$ is abelian and every subgroup of an abelian group is normal, so $\langle 4 \rangle \trianglelefteq \mathbb{Z}_{12}$.

**(b)** $G/H = \{0 + H,\ 1 + H,\ 2 + H,\ 3 + H\}$, where $H = \{0, 4, 8\}$.

**(c)** The cyclic subgroups of $G/H$ (a cyclic group of order $4$) are $\{0 + H\}$, $\{0 + H, 2 + H\}$, and $G/H$ itself.

**(d)** $G/H \cong \mathbb{Z}_4$, since $G/H$ is cyclic of order $4$ ($1 + H$ has order $4$).$BODY$,
    $BODY$**(a)** $G = \mathbb{Z}_{12}$ is abelian. Since every subgroup of an abelian group is normal (conjugation $x \mapsto gxg^{-1}$ is the identity on an abelian group), $H = \langle 4 \rangle = \{0, 4, 8\}$ is normal in $\mathbb{Z}_{12}$. $\blacksquare$

**(b)** Since $|G/H| = 12/3 = 4$, there are $4$ cosets:
$$0 + H = \{0, 4, 8\}, \quad 1 + H = \{1, 5, 9\}, \quad 2 + H = \{2, 6, 10\}, \quad 3 + H = \{3, 7, 11\}.$$

**(c)** $G/H$ is cyclic of order $4$, generated by $1 + H$ (order $4$). Its cyclic subgroups are the subgroups of $\mathbb{Z}_4$:
$$\{0 + H\}, \qquad \{0 + H,\ 2 + H\}, \qquad G/H \text{ itself}.$$

**(d)** $1 + H$ has order $4$ in $G/H$ (since $1, 2, 3 \notin H$ but $4 \in H$), so $G/H = \langle 1 + H \rangle$ is cyclic of order $4$. Any two cyclic groups of the same order are isomorphic, hence
$$G/H \cong \mathbb{Z}_4. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q12 — x -> 3x from Z_12 to Z_10 is not a homomorphism
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d12',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a01',
    'Why $x \mapsto 3x$ from $\mathbb{Z}_{12}$ to $\mathbb{Z}_{10}$ Is Not a Homomorphism',
    $BODY$Explain why the correspondence $x \mapsto 3x$ from $\mathbb{Z}_{12}$ to $\mathbb{Z}_{10}$ is not a homomorphism.$BODY$,
    'medium',
    2023,
    'Second Long Exam',
    12,
    $BODY$Check whether the rule is even well-defined: in $\mathbb{Z}_{12}$, the element $12$ equals $0$.$BODY$,
    $BODY$The map is not well-defined, hence not a homomorphism: in $\mathbb{Z}_{12}$, $[12] = [0]$, but $3 \cdot 12 = 36 \equiv 6 \pmod{10}$, whereas $3 \cdot 0 = 0 \pmod{10}$, and $6 \ne 0$. Equivalently, $\varphi(1) = 3$ has order $10$ in $\mathbb{Z}_{10}$, which does not divide $|\mathbb{Z}_{12}| = 12$.$BODY$,
    $BODY$A map $\varphi : \mathbb{Z}_{12} \to \mathbb{Z}_{10}$ can only be a function (let alone a homomorphism) if it respects the modulus $12$. In $\mathbb{Z}_{12}$ we have $[12] = [0]$. But
$$\varphi(12) = 3 \cdot 12 = 36 \equiv 6 \pmod{10}, \qquad \varphi(0) = 0,$$
and $6 \ne 0$ in $\mathbb{Z}_{10}$. Since the same input $[12] = [0]$ is sent to two different outputs, $\varphi$ is not well-defined and therefore cannot be a homomorphism.

*Alternative check:* if $\varphi$ were a homomorphism, the order of $\varphi(1) = 3$ in $\mathbb{Z}_{10}$ would have to divide the order of $1$ in $\mathbb{Z}_{12}$, namely $12$. But $\gcd(3, 10) = 1$, so $3$ has order $10$ in $\mathbb{Z}_{10}$, and $10 \nmid 12$ — a contradiction. $\blacksquare$ $BODY$
  ),
  (
    -- Q13 — phi((a,b)) = b - a
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d13',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a01',
    'The Homomorphism $\varphi((a, b)) = b - a$ from $\mathbb{Z} \times \mathbb{Z}$',
    $BODY$Consider the mapping $\varphi : \mathbb{Z} \times \mathbb{Z} \to \mathbb{Z}$ given by $\varphi((a, b)) = b - a$.

**(a)** Show that $\varphi$ is a homomorphism.

**(b)** Compute $\ker \varphi$.

**(c)** Describe the set $\varphi^{-1}(3)$ (that is, the set of all elements that are mapped to $3$).$BODY$,
    'medium',
    2023,
    'Second Long Exam',
    13,
    $BODY$For (a) use the definition of addition in $\mathbb{Z} \times \mathbb{Z}$. For (b) solve $b - a = 0$. For (c) solve $b - a = 3$.$BODY$,
    $BODY$**(a)** $\varphi((a,b) + (a',b')) = (b + b') - (a + a') = (b - a) + (b' - a') = \varphi((a,b)) + \varphi((a',b'))$, so $\varphi$ is a homomorphism.

**(b)** $\ker \varphi = \{(a, b) \mid b - a = 0\} = \{(a, a) \mid a \in \mathbb{Z}\}$, the diagonal subgroup of $\mathbb{Z} \times \mathbb{Z}$.

**(c)** $\varphi^{-1}(3) = \{(a, b) \mid b - a = 3\} = \{(a, a + 3) \mid a \in \mathbb{Z}\}$.$BODY$,
    $BODY$**(a)** For any $(a, b), (a', b') \in \mathbb{Z} \times \mathbb{Z}$:
$$\varphi((a,b) + (a',b')) = \varphi((a + a', b + b')) = (b + b') - (a + a') = (b - a) + (b' - a') = \varphi((a,b)) + \varphi((a',b')).$$
Since $\mathbb{Z} \times \mathbb{Z}$ is abelian (so the operation matches a group homomorphism definition), $\varphi$ is a group homomorphism. $\blacksquare$

**(b)** By definition,
$$\ker \varphi = \{(a, b) \in \mathbb{Z} \times \mathbb{Z} \mid b - a = 0\} = \{(a, a) \mid a \in \mathbb{Z}\},$$
the diagonal subgroup $\{(a, a)\}$ of $\mathbb{Z} \times \mathbb{Z}$, isomorphic to $\mathbb{Z}$. $\blacksquare$

**(c)** The preimage of $3$ is the set of pairs whose difference is $3$:
$$\varphi^{-1}(3) = \{(a, b) \mid b - a = 3\} = \{(a, a + 3) \mid a \in \mathbb{Z}\}.$$
This is the coset $(0, 3) + \ker\varphi$ of the kernel in $\mathbb{Z} \times \mathbb{Z}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q14 — kernel is a subgroup and is normal (exam item IV.3, renumbered)
    '5b6c7d8e-9f0a-4b1c-8d2e-3f4a5b6c7d14',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '2a9f1e3b-4c5d-4e6f-8a9b-0c1d2e3f4a01',
    'The Kernel of a Homomorphism Is a Normal Subgroup',
    $BODY$Suppose $\varphi : G \to G'$ is a homomorphism of groups.

**(a)** Prove that $\ker \varphi \le G$.

**(b)** Prove that $\ker \varphi$ is normal in $G$.$BODY$,
    'medium',
    2023,
    'Second Long Exam',
    14,
    $BODY$For (a) verify the subgroup axioms. For (b) show $gkg^{-1} \in \ker\varphi$ using the homomorphism property.$BODY$,
    $BODY$**(a)** $\ker\varphi \le G$: it contains $e$ (since $\varphi(e) = e'$), is closed under the operation, and is closed under inverses.

**(b)** $\ker\varphi \trianglelefteq G$: for $g \in G$ and $k \in \ker\varphi$, $\varphi(gkg^{-1}) = \varphi(g)\varphi(k)\varphi(g^{-1}) = \varphi(g)e'\varphi(g)^{-1} = e'$, so $gkg^{-1} \in \ker\varphi$.$BODY$,
    $BODY$**(a)** Let $K = \ker\varphi$. We verify the subgroup axioms:
- **Nonempty:** $\varphi(e) = e'$, so $e \in K$.
- **Closure:** if $x, y \in K$, then $\varphi(xy) = \varphi(x)\varphi(y) = e'e' = e'$, so $xy \in K$.
- **Inverses:** if $x \in K$, then $\varphi(x^{-1}) = \varphi(x)^{-1} = e'^{-1} = e'$, so $x^{-1} \in K$.

Therefore $K = \ker\varphi \le G$. $\blacksquare$

**(b)** Let $g \in G$ and $k \in K$. Then
$$\varphi(gkg^{-1}) = \varphi(g)\,\varphi(k)\,\varphi(g^{-1}) = \varphi(g)\,e'\,\varphi(g)^{-1} = e'.$$
Hence $gkg^{-1} \in K$ for all $g \in G$ and $k \in K$, i.e. $gKg^{-1} \subseteq K$. By the definition of a normal subgroup, $\ker\varphi \trianglelefteq G$. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
