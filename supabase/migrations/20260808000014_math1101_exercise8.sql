-- ============================================================================
-- Math 110.1 Exercise 8 — normal subgroups and quotient groups
-- 8 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'd2dd11ff-4390-4c25-9339-4509a308b9dc',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Diagonal Matrices in $\\mathrm{GL}(2, \\mathbb{R})$',
    $BODY$Let $H = \left\{ \begin{bmatrix} r & 0 \\ 0 & s \end{bmatrix} \;\middle|\; r, s \in \mathbb{R},\ rs \neq 0 \right\}$.

**(a)** Show that $H \leq \mathrm{GL}(2, \mathbb{R})$.

**(b)** Determine whether or not $H$ is normal in $\mathrm{GL}(2, \mathbb{R})$.$BODY$,
    'hard',
    2026,
    'Exercise 8',
    1,
    $BODY$For (a), show $H \subseteq \mathrm{GL}(2,\mathbb{R})$ and use the one-step subgroup test with the inverse of a diagonal matrix. For (b), conjugate $h = \mathrm{diag}(r, s)$ by a general $x = \begin{bmatrix} a & b \\ c & d \end{bmatrix}$ and check the off-diagonal entries.$BODY$,
    $BODY$**(a)** $H \leq \mathrm{GL}(2, \mathbb{R})$. **(b)** No — $H$ is not normal in $\mathrm{GL}(2, \mathbb{R})$; e.g. $\begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix} \begin{bmatrix} 2 & 0 \\ 0 & 1 \end{bmatrix} \begin{bmatrix} 1 & 1 \\ 0 & 1 \end{bmatrix}^{-1} = \begin{bmatrix} 2 & 1 \\ 0 & 1 \end{bmatrix} \notin H$.$BODY$,
    $BODY$**(a)** Recall the definition of the general linear group:

$$
\begin{equation*}\mathrm{GL}(2, \mathbb{R}) = \left\{ \begin{bmatrix} a & b \\ c & d \end{bmatrix} \;\middle|\; a, b, c, d \in \mathbb{R},\ ad - bc \neq 0 \right\}.\end{equation*}
$$

**Inclusion.** Let $x = \begin{bmatrix} r & 0 \\ 0 & s \end{bmatrix} \in H$ for some $r, s \in \mathbb{R}$ with $rs \neq 0$. Since $r, s, 0 \in \mathbb{R}$ and $r \cdot s - 0 \cdot 0 = rs \neq 0$, we have $x \in \mathrm{GL}(2, \mathbb{R})$, and therefore $H \subseteq \mathrm{GL}(2, \mathbb{R})$.

**One-step subgroup test.** Clearly, $H \neq \varnothing$. Let $x = \begin{bmatrix} p & 0 \\ 0 & q \end{bmatrix}$, $y = \begin{bmatrix} r & 0 \\ 0 & s \end{bmatrix} \in H$ for some $p, q, r, s \in \mathbb{R}$ with $pq, rs \neq 0$. Then,

$$
\begin{aligned}
xy^{-1} &= \begin{bmatrix} p & 0 \\ 0 & q \end{bmatrix} \begin{bmatrix} r & 0 \\ 0 & s \end{bmatrix}^{-1} \\
        &= \begin{bmatrix} p & 0 \\ 0 & q \end{bmatrix} \begin{bmatrix} 1/r & 0 \\ 0 & 1/s \end{bmatrix} \\
        &= \begin{bmatrix} p/r & 0 \\ 0 & q/s \end{bmatrix},
\end{aligned}
$$

where $p/r, q/s \in \mathbb{R}$ and $pq/(rs) \neq 0$, so $xy^{-1} \in H$.

Hence, by the one-step subgroup test, $H \leq \mathrm{GL}(2, \mathbb{R})$. $\blacksquare$

---

**(b)** By (a), $H \leq \mathrm{GL}(2, \mathbb{R})$. Let $x = \begin{bmatrix} a & b \\ c & d \end{bmatrix} \in \mathrm{GL}(2, \mathbb{R})$, and let $h = \begin{bmatrix} r & 0 \\ 0 & s \end{bmatrix} \in H$. Then

$$
\begin{aligned}
xhx^{-1} &= \begin{bmatrix} a & b \\ c & d \end{bmatrix} \begin{bmatrix} r & 0 \\ 0 & s \end{bmatrix} \begin{bmatrix} d & -b \\ -c & a \end{bmatrix} \frac{1}{ad - bc} \\
         &= \frac{1}{ad - bc} \begin{bmatrix} adr - bcs & ab(s - r) \\ cd(r - s) & ads - bcr \end{bmatrix}.
\end{aligned}
$$

For this matrix to lie in $H$, both off-diagonal entries must be zero. But for $r \neq s$ with $a, b, c, d \neq 0$, we get $ab(s - r) \neq 0$ and $cd(r - s) \neq 0$, so $xhx^{-1} \notin H$.

Therefore, $xHx^{-1} \nsubseteq H$ for some $x \in \mathrm{GL}(2, \mathbb{R})$, and hence $H \ntriangleleft \mathrm{GL}(2, \mathbb{R})$. $\blacksquare$$BODY$
  ),
  (
    '6341abbe-0743-466d-9106-1f40908800dd',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Intersection of Normal Subgroups is Normal',
    $BODY$Prove that if $N_1$ and $N_2$ are normal subgroups of a group $G$, then $N_1 \cap N_2 \triangleleft G$. (Hint: First show that $N_1 \cap N_2 \leq G$. Then use the normal subgroup test.)$BODY$,
    'medium',
    2026,
    'Exercise 8',
    2,
    $BODY$First use the one-step subgroup test to show $N_1 \cap N_2 \leq G$. Then, for $g \in G$ and $n \in N_1 \cap N_2$, use normality of $N_1$ and $N_2$ separately.$BODY$,
    $BODY$$N_1 \cap N_2 \triangleleft G$.$BODY$,
    $BODY$Suppose $N_1, N_2 \triangleleft G$.

**One-step subgroup test.** Clearly, $N_1 \cap N_2 \neq \varnothing$ since the identity element $e \in N_1 \cap N_2$. Let $a, b \in N_1 \cap N_2$. It follows that $a, b \in N_1$ and $a, b \in N_2$. Since $N_1$ and $N_2$ are subgroups, $ab^{-1} \in N_1$ and $ab^{-1} \in N_2$. It follows that $ab^{-1} \in N_1 \cap N_2$.

Hence, by the one-step subgroup test, $N_1 \cap N_2 \leq G$.

**Normal subgroup test.** From the result above, $N_1 \cap N_2 \leq G$. Let $g \in G$ and let $gng^{-1} \in g(N_1 \cap N_2)g^{-1}$. It follows that $n \in N_1 \cap N_2$, so $n \in N_1$ and $n \in N_2$. Since $N_1, N_2 \triangleleft G$, we have $gng^{-1} \in N_1$ and $gng^{-1} \in N_2$, so $gng^{-1} \in N_1 \cap N_2$.

Hence, $N_1 \cap N_2 \triangleleft G$. $\blacksquare$$BODY$
  ),
  (
    '59bf2c18-8b61-4643-aba8-92ee9f694067',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Normal Subgroups of $A_4$ and the Factor Group $A_4 / H$',
    $BODY$Determine which of the following subgroups of the alternating group $A_4$ are normal in $A_4$.

**(a)** $H = \{(1), (1\ 2)(3\ 4), (1\ 3)(2\ 4), (1\ 4)(2\ 3)\}$

**(b)** $K = \langle (2\ 3\ 4) \rangle$

If the subgroup given above is a normal subgroup of $A_4$, do the following.

**(c)** Compute the order of the factor group $A_4$ modulo the normal subgroup.

**(d)** Construct the Cayley table for the factor group.

**(e)** Identify to which known group the factor group is isomorphic.$BODY$,
    'hard',
    2026,
    'Exercise 8',
    3,
    $BODY$List $A_4$ explicitly. For each subgroup, compare the left and right cosets. $H$ is normal (index 3); $K$ is not (compare $(1\ 2\ 3)K$ and $K(1\ 2\ 3)$).$BODY$,
    $BODY$**(a)** $H \triangleleft A_4$. **(b)** $K \not\triangleleft A_4$. **(c)** $|A_4 / H| = 3$. **(e)** $A_4 / H \cong \mathbb{Z}_3$.$BODY$,
    $BODY$The alternating group $A_4$ is the subgroup of $S_4$ of all even permutations:

$$
\begin{equation*}A_4 = \{(1), (1\ 2)(3\ 4), (1\ 3)(2\ 4), (1\ 4)(2\ 3), (1\ 2\ 3), (1\ 2\ 4), (2\ 3\ 4), (1\ 3\ 4), (1\ 3\ 2), (1\ 4\ 2), (2\ 4\ 3), (1\ 4\ 3)\}.\end{equation*}
$$

**(a)** Clearly, $H \leq A_4$. The index is $[A_4 : H] = |A_4|/|H| = 12/4 = 3$.

Left cosets:

$$
\begin{aligned}
(1)H &= \{(1), (1\ 2)(3\ 4), (1\ 3)(2\ 4), (1\ 4)(2\ 3)\} \\
(1\ 2\ 3)H &= \{(1\ 2\ 3), (1\ 3\ 4), (2\ 4\ 3), (1\ 4\ 2)\} \\
(1\ 3\ 2)H &= \{(1\ 3\ 2), (2\ 3\ 4), (1\ 2\ 4), (1\ 4\ 3)\}.
\end{aligned}
$$

Right cosets:

$$
\begin{aligned}
H(1) &= \{(1), (1\ 2)(3\ 4), (1\ 3)(2\ 4), (1\ 4)(2\ 3)\} \\
H(1\ 2\ 3) &= \{(1\ 2\ 3), (2\ 4\ 3), (1\ 4\ 2), (1\ 3\ 4)\} \\
H(1\ 3\ 2) &= \{(1\ 3\ 2), (1\ 4\ 3), (2\ 3\ 4), (1\ 2\ 4)\}.
\end{aligned}
$$

Notice that for any $a \in A_4$, $aH = Ha$. Hence, $H \triangleleft A_4$. $\blacksquare$

---

**(b)** The cyclic subgroup generated by $(2\ 3\ 4)$ is

$$
\begin{equation*}K = \langle (2\ 3\ 4) \rangle = \{(1), (2\ 3\ 4), (2\ 4\ 3)\}.\end{equation*}
$$

Clearly, $K \leq A_4$. The index is $[A_4 : K] = 12/3 = 4$.

Left cosets:

$$
\begin{aligned}
(1)K &= \{(1), (2\ 3\ 4), (2\ 4\ 3)\} \\
(1\ 2\ 3)K &= \{(1\ 2\ 3), (1\ 2)(3\ 4), (1\ 2\ 4)\} \\
(1\ 3\ 2)K &= \{(1\ 3\ 2), (1\ 3\ 4), (1\ 3)(2\ 4)\} \\
(1\ 4)(2\ 3)K &= \{(1\ 4)(2\ 3), (1\ 4\ 3), (1\ 4\ 2)\}.
\end{aligned}
$$

Right cosets:

$$
\begin{aligned}
K(1) &= \{(1), (2\ 3\ 4), (2\ 4\ 3)\} \\
K(1\ 2\ 3) &= \{(1\ 2\ 3), (1\ 3)(2\ 4), (1\ 4\ 3)\} \\
K(1\ 3\ 2) &= \{(1\ 3\ 2), (1\ 4\ 2), (1\ 2)(3\ 4)\} \\
K(1\ 4)(2\ 3) &= \{(1\ 4)(2\ 3), (1\ 2\ 4), (1\ 3\ 4)\}.
\end{aligned}
$$

Notice that for some $a \in A_4$, $aK \neq Ka$ (e.g. $(1\ 2\ 3)K \neq K(1\ 2\ 3)$). Hence, $K \ntriangleleft A_4$. $\blacksquare$

---

Among the subgroups above, only $H$ is normal in $A_4$.

**(c)**

$$
\begin{equation*}\left| A_4 / H \right| = [A_4 : H] = \boxed{3}.\end{equation*}
$$

**(d)** Using the cosets above, the Cayley table for the factor group $A_4 / H$ is:

| $\cdot$ | $H$ | $(1\ 2\ 3)H$ | $(1\ 3\ 2)H$ |
|---|---|---|---|
| $H$ | $H$ | $(1\ 2\ 3)H$ | $(1\ 3\ 2)H$ |
| $(1\ 2\ 3)H$ | $(1\ 2\ 3)H$ | $(1\ 3\ 2)H$ | $H$ |
| $(1\ 3\ 2)H$ | $(1\ 3\ 2)H$ | $H$ | $(1\ 2\ 3)H$ |

**(e)** Since $|A_4 / H| = 3$, the factor group is cyclic of order $3$, so $A_4 / H \cong \boxed{\mathbb{Z}_3}$. $\blacksquare$$BODY$
  ),
  (
    '888d358c-f89e-471f-9df9-0b8a2d54b445',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Why $A_n \\triangleleft S_n$',
    $BODY$Consider the group $S_n$. Explain why $A_n$ is a normal subgroup of $S_n$. To which group is the factor group $S_n / A_n$ isomorphic?$BODY$,
    'easy',
    2026,
    'Exercise 8',
    4,
    $BODY$Show $[S_n : A_n] = 2$, which implies $A_n \triangleleft S_n$ and $|S_n / A_n| = 2$.$BODY$,
    $BODY$$A_n \triangleleft S_n$ because $[S_n : A_n] = 2$, and $S_n / A_n \cong \mathbb{Z}_2$.$BODY$,
    $BODY$Clearly, by definition, $A_n \leq S_n$. Note that $[S_n : A_n] = 2$. This implies $A_n \triangleleft S_n$; alternatively, since $(1)A_n = A_n(1)$ and $(1\ 2)A_n = A_n(1\ 2)$, which are the two cosets of $S_n / A_n$, every coset satisfies $aA_n = A_na$.

Since $|S_n / A_n| = [S_n : A_n] = 2$, therefore $S_n / A_n \cong \boxed{\mathbb{Z}_2}$. $\blacksquare$$BODY$
  ),
  (
    '079a4892-255b-4a46-9565-90f58a37adae',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Quotients of Abelian and Cyclic Groups',
    $BODY$Let $H$ be a subgroup of a group $G$. Prove the following statements.

**(a)** If $G$ is abelian, then $H \triangleleft G$ and $G / H$ is abelian.

**(b)** If $G$ is cyclic, then $H \triangleleft G$ and $G / H$ is cyclic.

**(c)** Using the results above, to which known group is $\mathbb{Z}_{18} / \langle 6 \rangle$ isomorphic?$BODY$,
    'medium',
    2026,
    'Exercise 8',
    5,
    $BODY$For (a), show $aH = Ha$ because $G$ is abelian, and use it to show $(aH)(bH) = (bH)(aH)$. For (b), use that cyclic groups are abelian and that the image of a generator generates the quotient. For (c), use the order of the quotient.$BODY$,
    $BODY$**(a)** $H \triangleleft G$ and $G/H$ abelian. **(b)** $H \triangleleft G$ and $G/H$ cyclic. **(c)** $\mathbb{Z}_{18} / \langle 6 \rangle \cong \mathbb{Z}_6$.$BODY$,
    $BODY$**(a)** Suppose $G$ is abelian. From the given, $H \leq G$.

$(\subseteq)$ Let $ah \in aH$ for some $h \in H$. Since $G$ is abelian, $ah = ha \in Ha$.  
$(\supseteq)$ Let $ha \in Ha$ for some $h \in H$. Since $G$ is abelian, $ha = ah \in aH$.

Hence, $aH = Ha$ for every $a \in G$, so $H \triangleleft G$.

Let $aH, bH \in G/H$ for some $a, b \in G$. Then $ab = ba$, so

$$
\begin{equation*}aH \cdot bH = abH = baH = bH \cdot aH.\end{equation*}
$$

Therefore, $H \triangleleft G$ and $G/H$ is abelian. $\blacksquare$

---

**(b)** Suppose $G$ is cyclic. Then $G$ is abelian, and by (a), $H \triangleleft G$.

Since $G$ is cyclic, $G = \langle g \rangle$ for some $g \in G$. Since $g$ generates $G$, then $\langle gH \rangle = G/H$ where $gH \in G/H$.

Hence, $H \triangleleft G$ and $G/H$ is cyclic. $\blacksquare$

---

**(c)** First, we take the order of the given factor group:

$$
\begin{equation*}\left| \mathbb{Z}_{18} / \langle 6 \rangle \right| = [\mathbb{Z}_{18} : \langle 6 \rangle] = \frac{|\mathbb{Z}_{18}|}{|\langle 6 \rangle|} = \frac{18}{3} = 6.\end{equation*}
$$

Note that $\mathbb{Z}_{18}$ is cyclic. Hence, by (b), $\langle 6 \rangle \triangleleft \mathbb{Z}_{18}$ and $\mathbb{Z}_{18} / \langle 6 \rangle$ is cyclic of order $6$. Hence, $\mathbb{Z}_{18} / \langle 6 \rangle \cong \boxed{\mathbb{Z}_6}$. $\blacksquare$$BODY$
  ),
  (
    '849ce08f-0555-4195-a723-e15281c66a50',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Quotient of $D_4$ by $\\langle R_{180^{\\circ}} \\rangle$',
    $BODY$Consider the dihedral group $D_4$.

**(a)** Show that $\langle R_{180^{\circ}} \rangle \triangleleft D_4$.

**(b)** What is the order of $D_4 / \langle R_{180^{\circ}} \rangle$?

**(c)** List down the elements of $D_4 / \langle R_{180^{\circ}} \rangle$.

**(d)** Determine the inverse of every element in $D_4 / \langle R_{180^{\circ}} \rangle$.

**(e)** To which known group is $D_4 / \langle R_{180^{\circ}} \rangle$ isomorphic?$BODY$,
    'hard',
    2026,
    'Exercise 8',
    6,
    $BODY$Compute the left and right cosets of $\langle R_{180^{\circ}} \rangle$; they coincide. Use the cosets to build the factor group — all four elements have order 2, so it is the Klein-4 group.$BODY$,
    $BODY$**(a)** $\langle R_{180^{\circ}} \rangle \triangleleft D_4$. **(b)** Order $4$. **(c)** Four cosets listed below. **(d)** Every element is self-inverse. **(e)** $D_4 / \langle R_{180^{\circ}} \rangle \cong V$ (Klein-4 group).$BODY$,
    $BODY$**(a)** The cyclic subgroup generated by $R_{180^{\circ}}$ is

$$
\begin{equation*}\langle R_{180^{\circ}} \rangle = \{R_{0^{\circ}}, R_{180^{\circ}}\}.\end{equation*}
$$

The index is $[D_4 : \langle R_{180^{\circ}} \rangle] = |D_4|/|\langle R_{180^{\circ}} \rangle| = 8/2 = 4$.

Left cosets:

$$
\begin{aligned}
R_{0^{\circ}} \circ \langle R_{180^{\circ}} \rangle &= \{R_{0^{\circ}}, R_{180^{\circ}}\} \\
R_{90^{\circ}} \circ \langle R_{180^{\circ}} \rangle &= \{R_{90^{\circ}}, R_{270^{\circ}}\} \\
h \circ \langle R_{180^{\circ}} \rangle &= \{h, v\} \\
d_1 \circ \langle R_{180^{\circ}} \rangle &= \{d_1, d_2\}.
\end{aligned}
$$

Right cosets:

$$
\begin{aligned}
\langle R_{180^{\circ}} \rangle \circ R_{0^{\circ}} &= \{R_{0^{\circ}}, R_{180^{\circ}}\} \\
\langle R_{180^{\circ}} \rangle \circ R_{90^{\circ}} &= \{R_{90^{\circ}}, R_{270^{\circ}}\} \\
\langle R_{180^{\circ}} \rangle \circ h &= \{h, v\} \\
\langle R_{180^{\circ}} \rangle \circ d_1 &= \{d_1, d_2\}.
\end{aligned}
$$

We get that for any $a \in D_4$, $a \circ \langle R_{180^{\circ}} \rangle = \langle R_{180^{\circ}} \rangle \circ a$.

Hence, $\langle R_{180^{\circ}} \rangle \triangleleft D_4$. $\blacksquare$

---

**(b)**

$$
\begin{equation*}\left| D_4 / \langle R_{180^{\circ}} \rangle \right| = [D_4 : \langle R_{180^{\circ}} \rangle] = \frac{8}{2} = \boxed{4}.\end{equation*}
$$

**(c)** Using the results in (a), the elements of $D_4 / \langle R_{180^{\circ}} \rangle$ are

$$
\begin{equation*}\boxed{\{R_{0^{\circ}}, R_{180^{\circ}}\}, \; \{R_{90^{\circ}}, R_{270^{\circ}}\}, \; \{h, v\}, \; \{d_1, d_2\}}.\end{equation*}
$$

**(d)** Every element of $D_4 / \langle R_{180^{\circ}} \rangle$ is its own inverse:

$$
\begin{aligned}
\langle R_{180^{\circ}} \rangle^{-1} &= \langle R_{180^{\circ}} \rangle, \\
\{R_{90^{\circ}}, R_{270^{\circ}}\}^{-1} &= \{R_{90^{\circ}}, R_{270^{\circ}}\}, \\
\{h, v\}^{-1} &= \{h, v\}, \\
\{d_1, d_2\}^{-1} &= \{d_1, d_2\}.
\end{aligned}
$$

**(e)** Since $|D_4 / \langle R_{180^{\circ}} \rangle| = 4$ and it is not cyclic (every non-identity element has order $2$), therefore $D_4 / \langle R_{180^{\circ}} \rangle \cong \boxed{V}$ (the Klein-4 group). $\blacksquare$$BODY$
  ),
  (
    'e13feed5-129e-4a6e-bf10-bad548cc16f6',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Commutators and Abelian Quotients',
    $BODY$Suppose $N$ is a normal subgroup of a group $G$. Show that $G / N$ is abelian if and only if $b^{-1}a^{-1}ba \in N$ for all $a, b \in G$.$BODY$,
    'hard',
    2026,
    'Exercise 8',
    7,
    $BODY$For $(\Rightarrow)$, show $(b^{-1}a^{-1}ba)N = N$ using the commutativity of $G/N$. For $(\Leftarrow)$, show $(ab)N = (ba)N$ using the fact that $(b^{-1}a^{-1}ba)N = N$.$BODY$,
    $BODY$$G/N$ abelian $\iff b^{-1}a^{-1}ba \in N$ for all $a, b \in G$.$BODY$,
    $BODY$($\Rightarrow$) Suppose $G/N$ is abelian. Let $a, b \in G$. Then $a^{-1}, b^{-1} \in G$. It follows that

$$
\begin{aligned}
(b^{-1}a^{-1}ba)N &= b^{-1}N \cdot a^{-1}N \cdot bN \cdot aN \\
                  &= b^{-1}N \cdot bN \cdot a^{-1}N \cdot aN \\
                  &= (b^{-1}b)N \cdot (a^{-1}a)N \\
                  &= eN \cdot eN \\
                  &= N.
\end{aligned}
$$

Hence, $b^{-1}a^{-1}ba \in N$.

($\Leftarrow$) Suppose $b^{-1}a^{-1}ba \in N$ for all $a, b \in G$. Let $aN, bN \in G/N$ for some $a, b \in G$. Then,

$$
\begin{aligned}
N = (b^{-1}a^{-1}ba)N
    &\implies N = ((ab)^{-1}ba)N \\
    &\implies (ab)N \cdot N = (ab)N \cdot ((ab)^{-1}ba)N \\
    &\implies (ab)N = ((ab)(ab)^{-1}ba)N \\
    &\implies (ab)N = (ba)N \\
    &\implies aN \cdot bN = bN \cdot aN.
\end{aligned}
$$

Hence, $G/N$ is abelian.

$\therefore$ $G/N$ is abelian if and only if $b^{-1}a^{-1}ba \in N$ for all $a, b \in G$. $\blacksquare$$BODY$
  ),
  (
    '833d9349-f386-4ce1-b675-03452f0a229f',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'If $[G : N] = m$ Then $a^m \\in N$',
    $BODY$Let $N$ be a normal subgroup of a group $G$ such that $[G : N] = m$. Show that $a^m \in N$ for every $a \in G$.$BODY$,
    'medium',
    2026,
    'Exercise 8',
    8,
    $BODY$Use the fact that $|G/N| = [G : N] = m$ and that the order of any element divides the order of the group (Lagrange's theorem).$BODY$,
    $BODY$Since $(aN)^m = N$, we get $a^m N = N$, hence $a^m \in N$ for every $a \in G$.$BODY$,
    $BODY$Since $N \triangleleft G$, then $G/N$ is a group. Let $a \in G$. Since $[G : N] = m$, the order of the factor group is $|G/N| = m$. It follows that $(aN)^m = eN = N$.

Then,

$$
\begin{aligned}
(aN)^m = N &\implies a^m N = N \\
           &\implies a^m \in N.
\end{aligned}
$$

Indeed, $a^m \in N$ for every $a \in G$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
