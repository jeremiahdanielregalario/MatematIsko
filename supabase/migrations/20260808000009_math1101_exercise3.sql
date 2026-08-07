-- ============================================================================
-- Math 110.1 Exercise 3 — Cayley tables, isomorphisms, GL(2,R), Klein-4
-- 5 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Complete the Cayley table
    '54d8ed7f-2f15-4400-b828-d5386cf7a16e',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Complete the Cayley Table for a Group of Order 5',
    $BODY$Complete the following Cayley table for a group $G$.

|  | $e$ | $a$ | $b$ | $c$ | $d$ |
|---|---|---|---|---|---|
| $e$ | $e$ |  |  |  |  |
| $a$ |  | $b$ |  |  | $e$ |
| $b$ |  | $c$ | $d$ | $e$ |  |
| $c$ |  | $d$ |  | $a$ | $b$ |
| $d$ |  |  |  |  |  |$BODY$,
    'hard',
    2026,
    'Exercise 3',
    1,
    $BODY$Fill in the row and column for the identity element $e$ first. Then use the property that each group element appears exactly once in each row and column.$BODY$,
    $BODY$The completed table is:

|  | $e$ | $a$ | $b$ | $c$ | $d$ |
|---|---|---|---|---|---|
| $e$ | $e$ | $a$ | $b$ | $c$ | $d$ |
| $a$ | $a$ | $b$ | $c$ | $d$ | $e$ |
| $b$ | $b$ | $c$ | $d$ | $e$ | $a$ |
| $c$ | $c$ | $d$ | $e$ | $a$ | $b$ |
| $d$ | $d$ | $e$ | $a$ | $b$ | $c$ |$BODY$,
    $BODY$First, we fill in the row and column for the identity element $e$.

Then, we use the property of a Cayley table where each element of the group appears exactly once in each row and column.

Note that since we are not sure if $G$ is abelian, we cannot apply symmetry for completing this table. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Isomorphism preserves identity and inverse
    '96865758-7d6d-4c60-a142-e5e589759419',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Isomorphism Preserves Identity and Inverse',
    $BODY$Let $\varphi$ be an isomorphism from $\langle G, * \rangle$ to $\langle G', *' \rangle$. Suppose $e$ is the identity element of $G$.

**(a)** Prove that $\varphi(e)$ is the identity element of $G'$.

**(b)** For any $g \in G$, prove that $\varphi(g^{-1}) = \varphi(g)^{-1}$.$BODY$,
    'medium',
    2026,
    'Exercise 3',
    2,
    $BODY$For (a), use surjectivity of $\varphi$ and the homomorphism property to show $\varphi(e) *' g' = g' = g' *' \varphi(e)$ for all $g'$. For (b), use (a) and the homomorphism property to show $\varphi(g^{-1}) *' \varphi(g) = \varphi(e)$.$BODY$,
    $BODY$**(a)** $\varphi(e)$ is the identity element of $G'$.

**(b)** $\varphi(g^{-1}) = \varphi(g)^{-1}$ for all $g \in G$.$BODY$,
    $BODY$**(a)** Let $g' \in G'$. Since $\varphi$ is an isomorphism, it is bijective and therefore onto, so we have $g' = \varphi(g)$ for some $g \in G$. Also, $\varphi$ is a homomorphism of groups, so we have

$$
\begin{aligned}
\varphi(e) \,'*' g' &= \varphi(e) \,'*' \varphi(g) = \varphi(e * g) = \varphi(g) = g', \\
g' \,'*' \varphi(e) &= \varphi(g) \,'*' \varphi(e) = \varphi(g * e) = \varphi(g) = g'.
\end{aligned}
$$

$\therefore$ $\varphi(e)$ is the identity element of $G'$. $\blacksquare$

---

**(b)** Let $g \in G$. Then $g^{-1} \in G$. By the previous item, $\varphi(e)$ is the identity element in $G'$ where $e$ is the identity element in $G$. It follows that

$$
\begin{aligned}
\varphi(g^{-1}) &= \varphi(g^{-1}) \,'*' \varphi(e) \\
                &= \varphi(g^{-1}) \,'*' \varphi(g) \,'*' \varphi(g)^{-1} \\
                &= \varphi(g^{-1} * g) \,'*' \varphi(g)^{-1} \\
                &= \varphi(e) \,'*' \varphi(g)^{-1} \\
                &= \varphi(g)^{-1}.
\end{aligned}
$$

$\therefore$ $\forall\, g \in G$, $\varphi(g^{-1}) = \varphi(g)^{-1}$. $\blacksquare$$BODY$
  ),
  (
    -- Q3 — Symmetric difference on power set
    '9d10c236-0f06-4e33-aacc-e19b0ed4a219',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Symmetric Difference on the Power Set: $\\langle \\mathcal{P}(\\{a,b\\}), \\triangle \\rangle$',
    $BODY$Let $U = \{a, b\}$. Let $G = \mathcal{P}(U)$, the power set of $U$ (the set of all subsets of $U$). For $A, B \in \mathcal{P}(U)$, define the symmetric difference of $A$ and $B$ as $A \mathbin{\triangle} B = (A \cup B) \setminus (A \cap B)$.

**(a)** Construct the Cayley table for $\langle G, \mathbin{\triangle} \rangle$.

**(b)** Show that $\langle G, \mathbin{\triangle} \rangle$ is a group.

**(c)** Is $G$ abelian?

**(d)** What is the order of $G$?

**(e)** To which known group is $\langle G, \mathbin{\triangle} \rangle$ isomorphic?$BODY$,
    'medium',
    2026,
    'Exercise 3',
    3,
    $BODY$For (a), compute $\varnothing \triangle A = A$ for all $A$, and use the definition $A \mathbin{\triangle} B = (A \cup B) \setminus (A \cap B)$ for the remaining entries. For (e), note that every non-identity element is self-inverse.$BODY$,
    $BODY$**(a)** Cayley table constructed below. **(b)** It is a group. **(c)** Yes, abelian. **(d)** Order 4. **(e)** Isomorphic to the Klein-4 group $V$.$BODY$,
    $BODY$**(a)** $G = \mathcal{P}(U) = \{\varnothing, \{a\}, \{b\}, \{a, b\}\}$.

| $\mathbin{\triangle}$ | $\varnothing$ | $\{a\}$ | $\{b\}$ | $\{a, b\}$ |
|---|---|---|---|---|
| $\varnothing$ | $\varnothing$ | $\{a\}$ | $\{b\}$ | $\{a, b\}$ |
| $\{a\}$ | $\{a\}$ | $\varnothing$ | $\{a, b\}$ | $\{b\}$ |
| $\{b\}$ | $\{b\}$ | $\{a, b\}$ | $\varnothing$ | $\{a\}$ |
| $\{a, b\}$ | $\{a, b\}$ | $\{b\}$ | $\{a\}$ | $\varnothing$ |

---

**(b)** By the constructed Cayley table, $\mathbin{\triangle}$ is a binary operation on $G$.

$\mathcal{G}_1$: Let $A, B, C \in G$. By the symmetry of the constructed Cayley table, $\mathbin{\triangle}$ is commutative. Then, one verifies $(A \mathbin{\triangle} B) \mathbin{\triangle} C = A \mathbin{\triangle} (B \mathbin{\triangle} C)$ using the set-theoretic definition. Therefore $\mathbin{\triangle}$ is associative.

$\mathcal{G}_2$: Based on the Cayley table, for all $g \in G$, $\varnothing \mathbin{\triangle} g = g \mathbin{\triangle} \varnothing = g$. Hence, $\varnothing$ is the identity in $G$.

$\mathcal{G}_3$: Based on the Cayley table, every element in $G$ has an inverse. In particular,

$$
\begin{equation*}\varnothing^{-1} = \varnothing, \qquad \{a\}^{-1} = \{a\}, \qquad \{b\}^{-1} = \{b\}, \qquad \{a, b\}^{-1} = \{a, b\}.\end{equation*}
$$

$\therefore$ $\langle G, \mathbin{\triangle} \rangle$ is a group. $\blacksquare$

---

**(c)** $G$ is a group and $\mathbin{\triangle}$ is commutative as shown in (a). Hence, $G$ is abelian. $\blacksquare$

---

**(d)** Since $G$ has four elements, namely $\varnothing, \{a\}, \{b\}, \{a, b\}$, then $G$ is of order $4$.

---

**(e)** Since every non-identity element is self-inverse, $G \cong V$ where $V$ is the Klein-4 group. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — GL(2,R) counterexample
    '587d29d5-72e9-4286-8ae2-cf4e8b82e5eb',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    '$(AB)^2 \\neq A^2 B^2$ in $\\mathrm{GL}(2, \\mathbb{R})$',
    $BODY$Consider the group $\mathrm{GL}(2, \mathbb{R})$ under matrix multiplication. Find two elements $A$ and $B$ in $\mathrm{GL}(2, \mathbb{R})$ such that $(AB)^2 \neq A^2 B^2$.

(This shows that for some elements $a$ and $b$ of a non-abelian group $G$ and some $n \in \mathbb{Z}$, $(ab)^n$ need not be equal to $a^n b^n$.)$BODY$,
    'medium',
    2026,
    'Exercise 3',
    4,
    $BODY$Try simple $2 \times 2$ integer matrices with small entries. The key is that matrix multiplication is not commutative, so $AB \neq BA$ leads to $(AB)^2 \neq A^2 B^2$.$BODY$,
    $BODY$$A = \begin{bmatrix} 1 & 2 \\ -2 & -1 \end{bmatrix}$, $B = \begin{bmatrix} -1 & 2 \\ 2 & -1 \end{bmatrix}$ give $(AB)^2 = 9I \neq A^2 B^2$.$BODY$,
    $BODY$Consider

$$
\begin{equation*}A = \begin{bmatrix} 1 & 2 \\ -2 & -1 \end{bmatrix}, \qquad B = \begin{bmatrix} -1 & 2 \\ 2 & -1 \end{bmatrix} \in \mathrm{GL}(2, \mathbb{R}).\end{equation*}
$$

Then,

$$
\begin{aligned}
(AB)^2 &= \left(\begin{bmatrix} 1 & 2 \\ -2 & -1 \end{bmatrix} \begin{bmatrix} -1 & 2 \\ 2 & -1 \end{bmatrix}\right)^2
= \begin{bmatrix} 3 & 0 \\ 0 & -3 \end{bmatrix}^2
= \begin{bmatrix} 9 & 0 \\ 0 & 9 \end{bmatrix}.
\end{aligned}
$$

$$
\begin{aligned}
A^2 B^2 &= \begin{bmatrix} 1 & 2 \\ -2 & -1 \end{bmatrix}^2 \begin{bmatrix} -1 & 2 \\ 2 & -1 \end{bmatrix}^2 \\
        &= \begin{bmatrix} 1 & 2 \\ -2 & -1 \end{bmatrix} \begin{bmatrix} 1 & 2 \\ -2 & -1 \end{bmatrix} \begin{bmatrix} -1 & 2 \\ 2 & -1 \end{bmatrix} \begin{bmatrix} -1 & 2 \\ 2 & -1 \end{bmatrix} \\
        &= \begin{bmatrix} -3 & 0 \\ 0 & -3 \end{bmatrix} \begin{bmatrix} 5 & -4 \\ -4 & 5 \end{bmatrix} \\
        &= \begin{bmatrix} -15 & 12 \\ 12 & -15 \end{bmatrix}.
\end{aligned}
$$

$\therefore$ $(AB)^2 \neq A^2 B^2$, as desired. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Which pairs of groups are isomorphic?
    'f7bbd56c-387f-43ed-8b57-b7147270955a',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Isomorphism or Not: $\\langle \\mathbb{Z}, + \\rangle$ vs. $\\langle 2\\mathbb{Z}, + \\rangle$ and $\\langle \\mathbb{R}, + \\rangle$ vs. $\\langle \\mathbb{Q}, + \\rangle$',
    $BODY$Determine which of the following pairs of groups are isomorphic. If they are isomorphic, give the function $\varphi$ giving the isomorphism and show that $\varphi$ is bijective and that it preserves operations. If they are not isomorphic, give a reason why no isomorphism can be established between the two groups.

**(a)** $\langle \mathbb{Z}, + \rangle$ and $\langle 2\mathbb{Z}, + \rangle$ where $2\mathbb{Z} = \{2k \mid k \in \mathbb{Z}\}$.

**(b)** $\langle \mathbb{R}, + \rangle$ and $\langle \mathbb{Q}, + \rangle$.$BODY$,
    'medium',
    2026,
    'Exercise 3',
    5,
    $BODY$For (a), try $\varphi(k) = 2k$ and verify bijectivity and the homomorphism property. For (b), compare the cardinalities of $\mathbb{R}$ and $\mathbb{Q}$.$BODY$,
    $BODY$**(a)** $\langle \mathbb{Z}, + \rangle \cong \langle 2\mathbb{Z}, + \rangle$ via $\varphi(k) = 2k$.

**(b)** $\langle \mathbb{R}, + \rangle \not\cong \langle \mathbb{Q}, + \rangle$ — they have different cardinalities.$BODY$,
    $BODY$**(a)**

*Claim*: $\langle \mathbb{Z}, + \rangle \cong \langle 2\mathbb{Z}, + \rangle$.

*Proof*. Consider $\varphi: \mathbb{Z} \to 2\mathbb{Z}$ given by $\varphi(k) = 2k$.

*(well-defined)* Let $k, \ell \in \mathbb{Z}$. Suppose $k = \ell$. Then, $\varphi(k) = 2k = 2\ell = \varphi(\ell)$.

*(1-1)* Let $k, \ell \in \mathbb{Z}$. Suppose $\varphi(k) = \varphi(\ell)$. Then, $2k = 2\ell \implies k = \ell$.

*(onto)* Let $m \in 2\mathbb{Z}$. Then, $m = 2n$ for some $n \in \mathbb{Z}$. Consider $n \in \mathbb{Z}$. Then, $\varphi(n) = 2n = m$.

$\therefore$ $\varphi$ is bijective.

Let $k, \ell \in \mathbb{Z}$. Then,

$$
\begin{equation*}\varphi(k + \ell) = 2(k + \ell) = 2k + 2\ell = \varphi(k) + \varphi(\ell).\end{equation*}
$$

$\therefore$ $\varphi$ is a group isomorphism from $\mathbb{Z}$ to $2\mathbb{Z}$.

$\therefore$ $\langle \mathbb{Z}, + \rangle \cong \langle 2\mathbb{Z}, + \rangle$. $\blacksquare$

---

**(b)** Since the cardinalities of $\mathbb{R}$ and $\mathbb{Q}$ are not equal, we cannot construct a bijection between them.

$\therefore$ $\langle \mathbb{R}, + \rangle \not\cong \langle \mathbb{Q}, + \rangle$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
