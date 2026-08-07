-- ============================================================================
-- Math 110.1 Named Theorems — seed data
-- 6 theorems from a typed homework set, converted from Typst to LaTeX.
-- ============================================================================

insert into public.theorems
  (id, course_id, topic_id, name, reference, statement, formal_notation)
values
  (
    '17bec670-d29b-4875-ab86-9a977191192c',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'The Division Algorithm in $\\mathbb{Z}$',
    'Theorem 1.1',
    $BODY$Let $n \in \mathbb{N}$ and $m \in \mathbb{Z}$. Then, there exist unique $q, r \in \mathbb{Z}$ with the property $m = nq + r$ where $0 \le r < n$.$BODY$,
    $BODY$$(\forall\, n \in \mathbb{N})(\forall\, m \in \mathbb{Z})(\exists!\, q, r \in \mathbb{Z} \mid m = nq + r \text{ and } 0 \le r < n)$$
    $BODY$
  ),
  (
    '7b88f6dd-3068-4e66-a2c3-4d0d2a262507',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Lagrange''s Theorem',
    'Theorem 1.17',
    $BODY$If $G$ is a finite group and $H$ is a subgroup of $G$, then the order of $H$ divides the order of $G$ (i.e., $|H|$ divides $|G|$).$BODY$,
    null
  ),
  (
    '5940503a-baa0-4929-b52f-af90c33395b2',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Cayley''s Theorem',
    'Theorem 1.23',
    $BODY$Every group is isomorphic to a permutation group.$BODY$,
    null
  ),
  (
    '7b046972-f638-4d49-bb3c-e8b8e7078fe2',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Fundamental Theorem of Finite Abelian Groups',
    'Theorem 1.36',
    $BODY$Every finite abelian group $G$ is isomorphic to a group of the form:

$$
\begin{equation*}\mathbb{Z}_{p_1^{r_1}} \times \mathbb{Z}_{p_2^{r_2}} \times \cdots \times \mathbb{Z}_{p_n^{r_n}}\end{equation*}
$$

where the $p_i$ are primes that are not necessarily distinct and the prime powers $p_1^{r_1}, p_2^{r_2}, \ldots, p_n^{r_n}$ are uniquely determined by $G$ (except possibly for the arrangement in which they appear).$BODY$,
    null
  ),
  (
    'c0b05930-0ee1-44de-b74b-f1b6713a6567',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'First Isomorphism Theorem',
    'Theorem 2.11',
    $BODY$Let $\varphi : G \to G'$ be a group homomorphism. Then

$$
\begin{equation*}\mu : G / \ker\varphi \to \varphi(G)\end{equation*}
$$

given by $\mu(g + \ker\varphi) = \varphi(g)$ is a group isomorphism.

In particular, $G / \ker\varphi \cong \varphi(G)$.$BODY$,
    $BODY$$G / \ker\varphi \cong \varphi(G)$$
    $BODY$
  ),
  (
    '659c07d4-5094-47e2-ae59-2b56e834976d',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'First Isomorphism Theorem for Rings',
    'Theorem 2.28',
    $BODY$Let $\varphi : R \to R'$ be a ring homomorphism. Then

$$
\begin{equation*}\mu : R / \ker\varphi \to \varphi(R)\end{equation*}
$$

given by $\mu(a + \ker\varphi) = \varphi(a)$ is a ring isomorphism.

In particular, $R / \ker\varphi \cong \varphi(R)$ (as rings).$BODY$,
    $BODY$$R / \ker\varphi \cong \varphi(R)$$
    $BODY$
  )
on conflict (id) do nothing;
