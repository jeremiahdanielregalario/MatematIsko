-- ============================================================================
-- Math 110.1 First Long Exam — 1st Sem A.Y. 2023-2024
-- 10 problems (definitions, true/false, cyclic group computations, proofs).
--
-- Three items from the original exam were SKIPPED because identical questions
-- already exist in the bank (verified against live data):
--   • "$a$ and $bab^{-1}$ Have the Same Order"     (Exercise 5)
--   • "Universal Squaring to Identity Implies Abelian" (Exercise 2)
--   • "The Centralizer $C_a$ is a Subgroup"          (Exercise 4)
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Definition of a group
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c1',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Definition of a Group',
    $BODY$State precisely the definition of a group.$BODY$,
    'easy',
    2023,
    'First Long Exam',
    1,
    $BODY$Recall the four axioms that characterize a group.$BODY$,
    $BODY$A **group** is a nonempty set $G$ together with a binary operation $\ast$ on $G$ such that:
1. **Closure**: $a \ast b \in G$ for all $a, b \in G$.
2. **Associativity**: $(a \ast b) \ast c = a \ast (b \ast c)$ for all $a, b, c \in G$.
3. **Identity**: there exists $e \in G$ such that $a \ast e = e \ast a = a$ for all $a \in G$.
4. **Inverses**: for each $a \in G$ there exists $a^{-1} \in G$ such that $a \ast a^{-1} = a^{-1} \ast a = e$.$BODY$,
    $BODY$A **group** is a nonempty set $G$ together with a binary operation $\ast$ on $G$ such that:
- **(Closure)** for all $a, b \in G$, $a \ast b \in G$;
- **(Associativity)** for all $a, b, c \in G$, $(a \ast b) \ast c = a \ast (b \ast c)$;
- **(Identity)** there exists an element $e \in G$ such that $a \ast e = e \ast a = a$ for all $a \in G$;
- **(Inverses)** for every $a \in G$ there exists an element $a^{-1} \in G$ such that $a \ast a^{-1} = a^{-1} \ast a = e$. $\blacksquare$ $BODY$
  ),
  (
    -- Q2 — Division Algorithm for Z
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c2',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'a035ee21-0cde-4ad6-a83c-fbb6a8287e73',
    'The Division Algorithm for $\mathbb{Z}$',
    $BODY$State the Division Algorithm for $\mathbb{Z}$.$BODY$,
    'easy',
    2023,
    'First Long Exam',
    2,
    $BODY$The statement involves unique integers $q$ and $r$ with a condition on the remainder $r$.$BODY$,
    $BODY$Given integers $a$ and $b$ with $b > 0$, there exist unique integers $q$ and $r$ such that $$a = bq + r \quad \text{and} \quad 0 \le r < b.$$ The integer $q$ is the quotient and $r$ is the remainder.$BODY$,
    $BODY$**The Division Algorithm.** For any integers $a$ and $b$ with $b > 0$, there exist unique integers $q$ and $r$ such that
$$a = bq + r, \qquad 0 \le r < b.$$

*Existence:* The set $S = \{a - bk \mid k \in \mathbb{Z}\} \cap \mathbb{Z}_{\ge 0}$ is nonempty; let $r$ be its smallest element. Then $r \ge 0$ and $r < b$ (otherwise $r - b \in S$, contradicting minimality), so $a = bq + r$.

*Uniqueness:* If $a = bq + r = bq' + r'$ with $0 \le r, r' < b$, then $b(q - q') = r' - r$, so $b$ divides $|r' - r| < b$, forcing $r = r'$ and hence $q = q'$. $\blacksquare$ $BODY$
  ),
  (
    -- Q3 — True/False: group of order n contains element of order n
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c3',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'True or False: A Group of Order $n$ Has an Element of Order $n$',
    $BODY$Indicate whether the statement is **true** or **false**. If it is true, provide a short explanation. If it is false, give a counterexample.

> A group of order $n$ contains an element of order $n$.$BODY$,
    'medium',
    2023,
    'First Long Exam',
    3,
    $BODY$Look for a group whose order exceeds the order of every element (e.g., a non-cyclic abelian group).$BODY$,
    $BODY$**False.** Counterexample: $\mathbb{Z}_2 \times \mathbb{Z}_2$ has order $4$ but every non-identity element has order $2$, so it contains no element of order $4$.$BODY$,
    $BODY$The statement is **false**. Consider $G = \mathbb{Z}_2 \times \mathbb{Z}_2$, which has order $|G| = 4$. Every element satisfies $x^2 = e$:
$$(1,0)^2 = (1+1, 0) = (0,0) = e, \qquad (0,1)^2 = e, \qquad (1,1)^2 = e.$$
Hence no element of $G$ has order $4$, even though $|G| = 4$. $\blacksquare$ $BODY$
  ),
  (
    -- Q4 — True/False: abelian implies cyclic
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c4',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'True or False: Abelian Groups are Cyclic',
    $BODY$Indicate whether the statement is **true** or **false**. If it is true, provide a short explanation. If it is false, give a counterexample.

> If a group $G$ is abelian, then $G$ is cyclic.$BODY$,
    'medium',
    2023,
    'First Long Exam',
    4,
    $BODY$The converse of "cyclic implies abelian" is not true — find an abelian group that no single element generates.$BODY$,
    $BODY$**False.** Counterexample: $\mathbb{Z}_2 \times \mathbb{Z}_2$ is abelian (as a product of abelian groups) but is not cyclic, since every non-identity element has order $2 < 4$.$BODY$,
    $BODY$The statement is **false**. The group $G = \mathbb{Z}_2 \times \mathbb{Z}_2$ is abelian because each factor is abelian, but $G$ is **not** cyclic:
- If $(1,0)$ generated $G$, then $G = \{e, (1,0)\}$ has only two elements, contradiction.
- Every non-identity element has order $2$, while $|G| = 4$, so no single element generates all of $G$.

Thus abelian does not imply cyclic. $\blacksquare$ $BODY$
  ),
  (
    -- Q5 — True/False: proper subgroups cyclic implies G cyclic
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c5',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'True or False: Proper Subgroups Cyclic Implies $G$ Cyclic',
    $BODY$Indicate whether the statement is **true** or **false**. If it is true, provide a short explanation. If it is false, give a counterexample.

> If every proper subgroup of a group $G$ is cyclic, then $G$ is cyclic.$BODY$,
    'medium',
    2023,
    'First Long Exam',
    5,
    $BODY$Consider a small abelian group whose proper subgroups are all small (hence cyclic), but which is itself not cyclic.$BODY$,
    $BODY$**False.** Counterexample: $\mathbb{Z}_2 \times \mathbb{Z}_2$ has proper subgroups $\{e\}$ and the three subgroups of order $2$, all cyclic, but $\mathbb{Z}_2 \times \mathbb{Z}_2$ is not cyclic.$BODY$,
    $BODY$The statement is **false**. In $G = \mathbb{Z}_2 \times \mathbb{Z}_2$:
- The proper subgroups are $\{e\}$, $\langle (1,0) \rangle$, $\langle (0,1) \rangle$, and $\langle (1,1) \rangle$.
- Each is of order $1$ or $2$, hence cyclic.
- But $G$ itself has order $4$ with no element of order $4$, so $G$ is **not** cyclic.

Hence the hypothesis can hold while $G$ is not cyclic. $\blacksquare$ $BODY$
  ),
  (
    -- Q6 — True/False: cyclic group has unique generator
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c6',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'True or False: A Cyclic Group Has a Unique Generator',
    $BODY$Indicate whether the statement is **true** or **false**. If it is true, provide a short explanation. If it is false, give a counterexample.

> A cyclic group has a unique generator.$BODY$,
    'easy',
    2023,
    'First Long Exam',
    6,
    $BODY$Test with $\mathbb{Z}_4$: which elements generate it?$BODY$,
    $BODY$**False.** Counterexample: $\mathbb{Z}_4 = \langle 1 \rangle$ is also generated by $3$, since $\langle 3 \rangle = \{0, 3, 2, 1\} = \mathbb{Z}_4$.$BODY$,
    $BODY$The statement is **false**. The cyclic group $\mathbb{Z}_4$ has more than one generator:
$$\mathbb{Z}_4 = \langle 1 \rangle = \langle 3 \rangle.$$
Indeed, $\langle 3 \rangle = \{3^1, 3^2, 3^3, 3^4\} = \{3, 2, 1, 0\}$. In general, an element $a^k$ generates a cyclic group of order $n$ exactly when $\gcd(k, n) = 1$, so there are $\phi(n)$ generators. $\blacksquare$ $BODY$
  ),
  (
    -- Q7 — True/False: aH = bH implies a = b
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c7',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'True or False: $aH = bH$ Implies $a = b$',
    $BODY$Indicate whether the statement is **true** or **false**. If it is true, provide a short explanation. If it is false, give a counterexample.

> Consider a subgroup $H$ of a group $G$. If $aH = bH$, then $a = b$.$BODY$,
    'easy',
    2023,
    'First Long Exam',
    7,
    $BODY$Two cosets of $H$ coincide exactly when the representatives differ by an element of $H$.$BODY$,
    $BODY$**False.** Counterexample: in $G = \mathbb{Z}_6$ with $H = \langle 3 \rangle = \{0, 3\}$, we have $0 + H = \{0, 3\} = 3 + H$, yet $0 \ne 3$.$BODY$,
    $BODY$The statement is **false**. Let $G = \mathbb{Z}_6$ and $H = \langle 3 \rangle = \{0, 3\}$. Then
$$0 + H = \{0, 3\} = 3 + H,$$
but $0 \ne 3$. In general $aH = bH$ if and only if $b^{-1}a \in H$, i.e. the representatives may differ by any element of $H$. $\blacksquare$ $BODY$
  ),
  (
    -- Q8 — U(7) is cyclic
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c8',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'The Multiplicative Group $U(7)$',
    $BODY$Consider the group $U(7) = \{1, 2, 3, 4, 5, 6\}$ with multiplication modulo $7$.

**(a)** Show that $U(7)$ is cyclic.

**(b)** Give the inverse of every element of $U(7)$.

**(c)** To which known group is $U(7)$ isomorphic? Justify your answer.$BODY$,
    'medium',
    2023,
    'First Long Exam',
    8,
    $BODY$For (a), find a generator by computing successive powers. For (b), use the generator's powers or trial. For (c), recall that cyclic groups of the same order are isomorphic.$BODY$,
    $BODY$**(a)** $U(7)$ is cyclic with generator $3$: the powers $3^1, \ldots, 3^6$ give $3, 2, 6, 4, 5, 1$.

**(b)** Inverses: $1^{-1} = 1$, $2^{-1} = 4$, $3^{-1} = 5$, $4^{-1} = 2$, $5^{-1} = 3$, $6^{-1} = 6$.

**(c)** Since $U(7)$ is cyclic of order $6$, it is isomorphic to $\mathbb{Z}_6$.$BODY$,
    $BODY$**(a)** Compute the powers of $3$ modulo $7$:
$$3^1 = 3, \quad 3^2 = 9 \equiv 2, \quad 3^3 \equiv 6, \quad 3^4 \equiv 4, \quad 3^5 \equiv 5, \quad 3^6 \equiv 1.$$
The set $\{3^1, 3^2, \ldots, 3^6\} = \{3, 2, 6, 4, 5, 1\} = U(7)$. Hence $U(7) = \langle 3 \rangle$ is cyclic. $\blacksquare$

**(b)** Inverses modulo $7$, computed so that each product is $\equiv 1$:
| $x$ | $x^{-1}$ | check |
|---|---|---|
| $1$ | $1$ | $1 \cdot 1 \equiv 1$ |
| $2$ | $4$ | $2 \cdot 4 = 8 \equiv 1$ |
| $3$ | $5$ | $3 \cdot 5 = 15 \equiv 1$ |
| $4$ | $2$ | $4 \cdot 2 \equiv 1$ |
| $5$ | $3$ | $5 \cdot 3 \equiv 1$ |
| $6$ | $6$ | $6 \cdot 6 = 36 \equiv 1$ |

**(c)** $U(7) = \langle 3 \rangle$ is cyclic of order $6$. Since any two cyclic groups of the same order are isomorphic (by sending a generator to a generator), $U(7) \cong \mathbb{Z}_6$. $\blacksquare$ $BODY$
  ),
  (
    -- Q9 — Subgroups and cosets of Z_12
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1b9c9',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Subgroups and Cosets of $\mathbb{Z}_{12}$',
    $BODY$Consider the group $G = \mathbb{Z}_{12}$ under addition modulo $12$.

**(a)** List all the subgroups of $\mathbb{Z}_{12}$ and identify all the generators of each subgroup.

**(b)** Sketch the lattice diagram of $\mathbb{Z}_{12}$.

**(c)** Let $H = \langle 3 \rangle$. Compute $[\mathbb{Z}_{12} : H]$.

**(d)** Find all the left cosets of $H = \langle 3 \rangle$ in $\mathbb{Z}_{12}$.$BODY$,
    'medium',
    2023,
    'First Long Exam',
    9,
    $BODY$The subgroups of $\mathbb{Z}_n$ correspond to divisors $d \mid n$, namely $\langle d \rangle$. Use $\langle a \rangle = \langle \gcd(a, n) \rangle$ to find generators.$BODY$,
    $BODY$**(a)** Subgroups: $\langle 0 \rangle$, $\langle 1 \rangle = \mathbb{Z}_{12}$, $\langle 2 \rangle$, $\langle 3 \rangle$, $\langle 4 \rangle$, $\langle 6 \rangle$.

**(c)** $H = \{0, 3, 6, 9\}$ has order $4$, so $[\mathbb{Z}_{12} : H] = 12/4 = 3$.

**(d)** Left cosets: $0 + H = \{0,3,6,9\}$, $1 + H = \{1,4,7,10\}$, $2 + H = \{2,5,8,11\}$.$BODY$,
    $BODY$**(a)** The subgroups of $\mathbb{Z}_{12}$ correspond to the divisors of $12$, each generated by that divisor:
| subgroup | elements | generators |
|---|---|---|
| $\langle 0 \rangle$ | $\{0\}$ | $0$ |
| $\langle 1 \rangle$ | $\mathbb{Z}_{12}$ | $1, 5, 7, 11$ |
| $\langle 2 \rangle$ | $\{0, 2, 4, 6, 8, 10\}$ | $2, 10$ |
| $\langle 3 \rangle$ | $\{0, 3, 6, 9\}$ | $3, 9$ |
| $\langle 4 \rangle$ | $\{0, 4, 8\}$ | $4, 8$ |
| $\langle 6 \rangle$ | $\{0, 6\}$ | $6$ |

**(b)** The subgroup lattice (by inclusion, top to bottom):
$$\mathbb{Z}_{12} \longrightarrow \langle 2 \rangle \longrightarrow \langle 4 \rangle \longrightarrow \langle 0 \rangle,$$
$$\mathbb{Z}_{12} \longrightarrow \langle 3 \rangle \longrightarrow \langle 0 \rangle,$$
$$\mathbb{Z}_{12} \longrightarrow \langle 6 \rangle \longrightarrow \langle 0 \rangle,$$
with the full lattice recording inclusions among $\langle 2 \rangle, \langle 3 \rangle, \langle 6 \rangle, \langle 4 \rangle$.

**(c)** $H = \langle 3 \rangle = \{0, 3, 6, 9\}$ has $|H| = 4$. By Lagrange, $[\mathbb{Z}_{12} : H] = \frac{12}{4} = 3$. $\blacksquare$

**(d)** The left cosets of $H$ partition $\mathbb{Z}_{12}$ into $3$ classes:
$$0 + H = \{0, 3, 6, 9\}, \qquad 1 + H = \{1, 4, 7, 10\}, \qquad 2 + H = \{2, 5, 8, 11\}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q10 — Group of order 35 has cyclic proper subgroups
    '3f4a1b2c-9d8e-4f7a-b6c5-d4e3f2a1ba10',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Every Group of Order $35$ Has Cyclic Proper Subgroups',
    $BODY$Prove the following statement.

> If $G$ is a group of order $35$, then every proper subgroup of $G$ is cyclic.$BODY$,
    'hard',
    2023,
    'First Long Exam',
    10,
    $BODY$By Lagrange's Theorem the order of a subgroup divides $35$. Recall that every group of prime order is cyclic.$BODY$,
    $BODY$The possible orders of a proper subgroup are $1$, $5$, or $7$; the trivial group is cyclic, and groups of order $5$ or $7$ are cyclic since those orders are prime.$BODY$,
    $BODY$Let $H \le G$. Since $G$ is finite of order $35$, Lagrange's Theorem gives $|H| \mid 35$. The positive divisors of $35$ are $1, 5, 7, 35$. Since $H$ is proper, $H \ne G$, so
$$|H| \in \{1, 5, 7\}.$$

- If $|H| = 1$, then $H = \{e\}$, which is trivially cyclic.
- If $|H| = 5$ or $|H| = 7$, then $|H|$ is a prime number. A group of prime order is cyclic: for any $x \ne e$ in $H$, the subgroup $\langle x \rangle$ is nontrivial, so by Lagrange $|\langle x \rangle| = |H|$, forcing $\langle x \rangle = H$.

In every case $H$ is cyclic. Since $H$ was an arbitrary proper subgroup of $G$, every proper subgroup of $G$ is cyclic. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
