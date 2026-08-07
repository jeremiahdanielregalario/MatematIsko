-- ============================================================================
-- Math 110.1 Exercise 7 — A_n, parity of permutations, direct products
-- 6 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'b50a971c-ec12-42a5-9240-d497e5b2b2ba',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Cyclic and Noncyclic Subgroups of Order 4 in $A_8$',
    $BODY$Give a cyclic and a noncyclic subgroup of order $4$ of the alternating group $A_8$.$BODY$,
    'medium',
    2026,
    'Exercise 7',
    1,
    $BODY$A subgroup of $A_8$ must consist of even permutations. Use a product of a 4-cycle and a 2-cycle (both odd, so the product is even) for the cyclic one, and the Klein-4 subgroup for the noncyclic one.$BODY$,
    $BODY$Cyclic: $\langle (1\ 2\ 3\ 4)(5\ 6) \rangle$. Noncyclic: $\{(1), (1\ 2)(3\ 4), (1\ 3)(2\ 4), (1\ 4)(2\ 3)\}$.$BODY$,
    $BODY$Consider the cyclic subgroup of order $4$:

$$
\begin{equation*}\left\langle (1\ 2\ 3\ 4)(5\ 6) \right\rangle = \{(1), (1\ 2\ 3\ 4)(5\ 6), (1\ 3)(2\ 4), (1\ 4\ 3\ 2)(5\ 6)\}.\end{equation*}
$$

Every element is even (a $4$-cycle and a $2$-cycle are both odd, so their product is even), hence this is a subgroup of $A_8$ of order $4$, and it is cyclic.

Consider the group

$$
\begin{equation*}\{(1), (1\ 2)(3\ 4), (1\ 3)(2\ 4), (1\ 4)(2\ 3)\},\end{equation*}
$$

which is closed under products of permutations, contains the identity $(1)$, and every element is self-inverse. Hence, it is a subgroup of $A_8$ isomorphic to the Klein-4 group, which is noncyclic. $\blacksquare$$BODY$
  ),
  (
    'ad7a7fde-5442-46fa-a15e-c9d09974ecf4',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    '$\\beta^{-1}\\alpha\\beta^{-1}$ and $\\alpha$ Have the Same Parity',
    $BODY$Let $\alpha, \beta \in S_n$. Show that $\beta^{-1}\alpha\beta^{-1}$ and $\alpha$ are either both even or both odd.$BODY$,
    'hard',
    2026,
    'Exercise 7',
    2,
    $BODY$Express $\alpha$ and $\beta$ as products of transpositions and count them. Note that $\beta^{-1}$ is a product of the same transpositions in reverse order, so it has the same number of transpositions as $\beta$.$BODY$,
    $BODY$Yes — in every case $\beta^{-1}\alpha\beta^{-1}$ has the same parity as $\alpha$, since the two copies of $\beta^{-1}$ contribute an even number of transpositions in total.$BODY$,
    $BODY$**Case 1: $\alpha$ and $\beta$ are both even.**

Since $\alpha, \beta$ are even, we can express them as products of $2k$ and $2\ell$ transpositions, respectively. It follows that $\beta^{-1}$ can also be expressed with the same transpositions in reverse order, and therefore is also a product of $2\ell$ transpositions. Therefore $\beta^{-1}\alpha\beta^{-1}$ is a product of

$$2\ell + 2k + 2\ell = 2(2\ell + k)$$

transpositions, so $\beta^{-1}\alpha\beta^{-1}$ is also even.

**Case 2: $\alpha$ and $\beta$ are both odd.**

Then $\alpha, \beta$ are products of $2k + 1$ and $2\ell + 1$ transpositions, respectively, and so is $\beta^{-1}$ (with $2\ell + 1$). Therefore $\beta^{-1}\alpha\beta^{-1}$ is a product of

$$(2\ell + 1) + (2k + 1) + (2\ell + 1) = 2(2\ell + k + 1) + 1$$

transpositions, so $\beta^{-1}\alpha\beta^{-1}$ is odd.

**Case 3: $\alpha$ is odd and $\beta$ is even.**

Then $\alpha$ is a product of $2k + 1$ transpositions and $\beta$ (hence $\beta^{-1}$) is a product of $2\ell$ transpositions. Therefore $\beta^{-1}\alpha\beta^{-1}$ is a product of

$$2\ell + (2k + 1) + 2\ell = 2(2\ell + k) + 1$$

transpositions, so $\beta^{-1}\alpha\beta^{-1}$ is odd.

**Case 4: $\alpha$ is even and $\beta$ is odd.**

Then $\alpha$ is a product of $2k$ transpositions and $\beta$ (hence $\beta^{-1}$) is a product of $2\ell + 1$ transpositions. Therefore $\beta^{-1}\alpha\beta^{-1}$ is a product of

$$(2\ell + 1) + 2k + (2\ell + 1) = 2(2\ell + k + 1)$$

transpositions, so $\beta^{-1}\alpha\beta^{-1}$ is even.

$\therefore$ $\beta^{-1}\alpha\beta^{-1}$ and $\alpha$ are either both even or both odd, as desired. $\blacksquare$$BODY$
  ),
  (
    'c2df507c-8049-41c4-85d5-36daca72246a',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Elements of Order 5 in $A_6$',
    $BODY$How many elements of order $5$ are there in $A_6$?$BODY$,
    'easy',
    2026,
    'Exercise 7',
    3,
    $BODY$Since $5$ is prime, the elements of order $5$ are exactly the 5-cycles. Count them and use the fact that 5-cycles are even permutations (a cycle of odd length is even).$BODY$,
    $BODY$There are $\boxed{144}$ elements of order $5$ in $A_6$.$BODY$,
    $BODY$Since $5$ is prime, the elements of order $5$ are exactly the $5$-cycles. Every $5$-cycle is an even permutation (a cycle of odd length is even), so all of them lie in $A_6$.

The number of $5$-cycles in $S_6$ is

$$
\begin{equation*}(6 \cdot 5 \cdot 4 \cdot 3 \cdot 2) \cdot \frac{1}{5} = \boxed{144} \text{ elements}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '29913374-70b3-4f35-8523-3e6d195f1035',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Direct Products and Abelian/Cyclic Groups',
    $BODY$Let $G_1$ and $G_2$ be groups.

**(a)** Prove that $G_1 \times G_2$ is abelian if and only if $G_1$ and $G_2$ are abelian.

**(b)** Prove that if $G_1 \times G_2$ is cyclic then $G_1$ and $G_2$ are cyclic.

**(c)** If $G_1$ and $G_2$ are cyclic, is $G_1 \times G_2$ cyclic?$BODY$,
    'hard',
    2026,
    'Exercise 7',
    4,
    $BODY$For (a), use the coordinate-wise definition of the product operation. For (b), use the generator of the product. For (c), give a counterexample — e.g. $\langle 2 \rangle \times \langle 4 \rangle$ inside $\mathbb{Z}_8 \times \mathbb{Z}_8$ has no element of order 8.$BODY$,
    $BODY$**(a)** $G_1 \times G_2$ abelian $\iff G_1, G_2$ abelian. **(b)** $G_1 \times G_2$ cyclic $\implies G_1, G_2$ cyclic. **(c)** No — counterexample below.$BODY$,
    $BODY$**(a)**

$(\Rightarrow)$ Suppose $G_1 \times G_2$ is abelian. Let $g_1, h_1 \in G_1$ and $g_2, h_2 \in G_2$. Then $(g_1, g_2), (h_1, h_2) \in G_1 \times G_2$, and

$$
\begin{aligned}
(g_1, g_2)(h_1, h_2) &= (h_1, h_2)(g_1, g_2) \\
&\implies (g_1 h_1, g_2 h_2) = (h_1 g_1, h_2 g_2) \\
&\implies g_1 h_1 = h_1 g_1 \text{ and } g_2 h_2 = h_2 g_2.
\end{aligned}
$$

$\therefore$ $G_1$ and $G_2$ are abelian.

$(\Leftarrow)$ Suppose that $G_1, G_2$ are abelian. Let $(g_1, g_2), (h_1, h_2) \in G_1 \times G_2$. Then,

$$
\begin{aligned}
(g_1, g_2)(h_1, h_2) &= (g_1 h_1, g_2 h_2) \\
                      &= (h_1 g_1, h_2 g_2) \\
                      &= (h_1, h_2)(g_1, g_2).
\end{aligned}
$$

$\therefore$ $G_1 \times G_2$ is abelian.

$\therefore$ $G_1 \times G_2$ is abelian $\iff G_1, G_2$ are abelian. $\blacksquare$

---

**(b)** Suppose $G_1 \times G_2$ is cyclic. Then it has a generator $(a_1, a_2)$ for some $a_1 \in G_1$ and $a_2 \in G_2$. It follows that $a_1$ and $a_2$ generate $G_1$ and $G_2$, respectively, i.e. $\langle a_1 \rangle = G_1$ and $\langle a_2 \rangle = G_2$.

$\therefore$ $G_1, G_2$ are cyclic. $\blacksquare$

---

**(c)** Consider the cyclic subgroups of $\mathbb{Z}_8$: $\langle 2 \rangle = \{0, 2, 4, 6\}$ and $\langle 4 \rangle = \{0, 4\}$.

Then,

$$
\begin{equation*}\langle 2 \rangle \times \langle 4 \rangle = \{(0, 0), (0, 4), (2, 0), (2, 4), (4, 0), (4, 4), (6, 0), (6, 4)\}.\end{equation*}
$$

Note that none of its elements have order $8$, which implies it has no generator.

$\therefore$ $G_1, G_2$ cyclic $\not\Rightarrow G_1 \times G_2$ cyclic. $\blacksquare$$BODY$
  ),
  (
    'a2593bfe-2a00-4f45-b5bf-5a8ac40ee093',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Subgroups of Order 4 of $\\mathbb{Z}_2 \\times \\mathbb{Z}_4$',
    $BODY$Identify all the subgroups of order $4$ of $\mathbb{Z}_2 \times \mathbb{Z}_4$.$BODY$,
    'medium',
    2026,
    'Exercise 7',
    5,
    $BODY$List $\mathbb{Z}_2 \times \mathbb{Z}_4$ explicitly, then for each element of order 4 compute its cyclic subgroup. There are exactly three subgroups of order 4.$BODY$,
    $BODY$There are three: $\langle (0, 1) \rangle = \langle (0, 3) \rangle$, $\langle (1, 1) \rangle = \langle (1, 3) \rangle$, and $\{(0, 0), (1, 0), (0, 2), (1, 2)\}$.$BODY$,
    $BODY$

$$
\begin{equation*}\mathbb{Z}_2 \times \mathbb{Z}_4 = \{(0, 0), (0, 1), (0, 2), (0, 3), (1, 0), (1, 1), (1, 2), (1, 3)\}.\end{equation*}
$$

- $\langle (0, 1) \rangle = \langle (0, 3) \rangle = \{(0, 0), (0, 1), (0, 2), (0, 3)\}$
- $\langle (1, 1) \rangle = \langle (1, 3) \rangle = \{(0, 0), (1, 1), (0, 2), (1, 3)\}$
- $\{(0, 0), (1, 0), (0, 2), (1, 2)\}$

These are all the subgroups of order $4$ of $\mathbb{Z}_2 \times \mathbb{Z}_4$. $\blacksquare$$BODY$
  ),
  (
    '06428ef8-4b7e-4ad0-93d0-53b9292dcbf1',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Isomorphism of $\\mathbb{Z}_{10} \\times \\mathbb{Z}_{12} \\times \\mathbb{Z}_6$',
    $BODY$Given $G = \mathbb{Z}_{10} \times \mathbb{Z}_{12} \times \mathbb{Z}_6$.

**(a)** Is $G \cong \mathbb{Z}_{15} \times \mathbb{Z}_4 \times \mathbb{Z}_{12}$?

**(b)** Give two elements of $G$ of order $15$.$BODY$,
    'hard',
    2026,
    'Exercise 7',
    6,
    $BODY$For (a), decompose each group into prime-power factors using $\mathbb{Z}_{ab} \cong \mathbb{Z}_a \times \mathbb{Z}_b$ for coprime $a, b$, and compare. For (b), find elements whose orders have lcm $15$.$BODY$,
    $BODY$**(a)** No — $G$ has a $\mathbb{Z}_2$ factor but $\mathbb{Z}_{15} \times \mathbb{Z}_4 \times \mathbb{Z}_{12}$ does not. **(b)** $(2, 4, 2)$ and $(2, 4, 0)$ both have order $15$.$BODY$,
    $BODY$**(a)** No, they are not isomorphic.

*Proof*. Using $\mathbb{Z}_{ab} \cong \mathbb{Z}_a \times \mathbb{Z}_b$ for coprime $a, b$,

$$
\begin{aligned}
G &= \mathbb{Z}_{10} \times \mathbb{Z}_{12} \times \mathbb{Z}_6 \\
  &\cong \mathbb{Z}_2 \times \mathbb{Z}_5 \times \mathbb{Z}_3 \times \mathbb{Z}_4 \times \mathbb{Z}_2 \times \mathbb{Z}_3,
\end{aligned}
$$

which contains a factor of $\mathbb{Z}_2$ (two, in fact). On the other hand,

$$
\begin{equation*}\mathbb{Z}_{15} \times \mathbb{Z}_4 \times \mathbb{Z}_{12} \cong \mathbb{Z}_3 \times \mathbb{Z}_5 \times \mathbb{Z}_4 \times \mathbb{Z}_3 \times \mathbb{Z}_4,\end{equation*}
$$

which has no $\mathbb{Z}_2$ factor. Since the prime-power decompositions differ, $G \not\cong \mathbb{Z}_{15} \times \mathbb{Z}_4 \times \mathbb{Z}_{12}$, as desired. $\blacksquare$

---

**(b)** Consider $(2, 4, 2), (2, 4, 0) \in G$. Then,

$$
\begin{aligned}
|(2, 4, 2)| &= \mathrm{lcm}(|2|, |4|, |2|) = \mathrm{lcm}(5, 3, 3) = 15, \\
|(2, 4, 0)| &= \mathrm{lcm}(|2|, |4|, |0|) = \mathrm{lcm}(5, 3, 1) = 15.
\end{aligned}
$$

Hence, $\boxed{(2, 4, 2)}$ and $\boxed{(2, 4, 0)}$ are two elements of $G$ of order $15$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
