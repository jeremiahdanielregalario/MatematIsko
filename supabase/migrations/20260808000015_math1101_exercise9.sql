-- ============================================================================
-- Math 110.1 Exercise 9 — group homomorphisms and their kernels/images
-- 6 problems with solutions, converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'd2c35ee8-5d45-4bb3-b8e5-acd951c84e54',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Modulus Map $\\varphi : \\mathbb{C}^{\\times} \\to \\mathbb{R}^{\\times}$',
    $BODY$Let $\varphi : \mathbb{C}^{\times} \to \mathbb{R}^{\times}$ be the map given by $\varphi(z) = |z|$.

**(a)** Show that $\varphi$ is a homomorphism.

**(b)** Determine $\ker \varphi$.$BODY$,
    'easy',
    2026,
    'Exercise 9',
    1,
    $BODY$For (a), use the multiplicativity of the modulus $|z_1 z_2| = |z_1||z_2|$. For (b), solve $\varphi(z) = 1$ — these are the complex numbers of unit modulus, the unit circle.$BODY$,
    $BODY$**(a)** $\varphi$ is a homomorphism since $|z_1 z_2| = |z_1||z_2|$. **(b)** $\ker \varphi = \{z \in \mathbb{C}^{\times} \mid |z| = 1\}$, the unit circle in the complex plane.$BODY$,
    $BODY$**(a)** Let $z_1, z_2 \in \mathbb{C}^{\times}$. Then,

$$
\begin{equation*}\varphi(z_1 z_2) = |z_1 z_2| = |z_1||z_2| = \varphi(z_1)\varphi(z_2).\end{equation*}
$$

Hence, $\varphi$ is a homomorphism. $\blacksquare$

---

**(b)** Using the definition,

$$
\begin{aligned}
\ker \varphi &= \{z \in \mathbb{C}^{\times} \mid \varphi(z) = 1\} \\
             &= \{z \in \mathbb{C}^{\times} \mid |z| = 1\} \\
             &= \{a + bi \in \mathbb{C}^{\times} \mid a, b \in \mathbb{R},\ a^2 + b^2 = 1\} \\
             &= \{\cos\theta + i\sin\theta \in \mathbb{C}^{\times} \mid \theta \in \mathbb{R}\}.
\end{aligned}
$$

Graphically, $\ker \varphi$ is the circle in the complex plane with radius $1$ centered at the origin. $\blacksquare$$BODY$
  ),
  (
    '10c293ee-b94b-483c-8a23-f831c1411535',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'A Non-Homomorphism from $\\mathbb{Z}_9$ to $\\mathbb{Z}_2$',
    $BODY$Consider $\varphi : \mathbb{Z}_9 \to \mathbb{Z}_2$ where $\varphi(x) = r$, the remainder when $x$ is divided by $2$. Show that $\varphi$ is not a homomorphism.$BODY$,
    'easy',
    2026,
    'Exercise 9',
    2,
    $BODY$Find two elements whose images do not behave like a homomorphism — e.g. $7$ and $8$: $\varphi(7 +_9 8) \neq \varphi(7) +_2 \varphi(8)$.$BODY$,
    $BODY$Not a homomorphism: $\varphi(7 +_9 8) = 0$ but $\varphi(7) +_2 \varphi(8) = 1$.$BODY$,
    $BODY$Consider $7, 8 \in \mathbb{Z}_9$. Then,

$$
\begin{equation*}\varphi(7 +_9 8) = \varphi(6) = 0 \neq 1 = 1 +_2 0 = \varphi(7) +_2 \varphi(8).\end{equation*}
$$

Hence, $\varphi$ is not a homomorphism. $\blacksquare$$BODY$
  ),
  (
    '75a71f11-c4f5-43d8-8b09-f56f1f106f85',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Sign Homomorphism $\\varphi : S_n \\to \\mathbb{Z}_2$',
    $BODY$Let $\varphi : S_n \to \mathbb{Z}_2$ be defined by

$$\varphi(\sigma) = \begin{cases} 0, & \sigma \text{ is an even permutation}, \\ 1, & \sigma \text{ is an odd permutation}. \end{cases}$$

**(a)** Show that $\varphi$ is a homomorphism.

**(b)** Determine $\ker \varphi$.$BODY$,
    'medium',
    2026,
    'Exercise 9',
    3,
    $BODY$For (a), the parity of the product $\sigma\tau$ is the parity of the sum of the parities of $\sigma$ and $\tau$. For (b), solve $\varphi(\sigma) = 0$.$BODY$,
    $BODY$**(a)** $\varphi$ is a homomorphism. **(b)** $\ker \varphi = A_n$.$BODY$,
    $BODY$**(a)** Let $\sigma, \tau \in S_n$. Note that the parity of $\sigma$ is the parity of the number of transpositions when $\sigma$ is expressed as a product of transpositions. Therefore, the parity of the number of transpositions of the product $\sigma\tau$ is the sum (mod $2$) of the numbers of transpositions of $\sigma$ and $\tau$. Hence, $\varphi(\sigma\tau) = \varphi(\sigma) +_2 \varphi(\tau)$.

$\therefore$ $\varphi$ is a homomorphism. $\blacksquare$

---

**(b)** Using the definition,

$$
\begin{aligned}
\ker \varphi &= \{\sigma \in S_n \mid \varphi(\sigma) = 0\} \\
             &= \{\sigma \in S_n \mid \sigma \text{ is an even permutation}\} \\
             &= A_n.
\end{aligned}
$$

$\blacksquare$$BODY$
  ),
  (
    '024d7cb4-1ba9-4184-8aa9-17e4bf1f13f1',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Homomorphism $\\varphi : U(13) \\to \\mathbb{Z}_{12}$',
    $BODY$Consider the group $U(13) = \{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12\}$ under multiplication modulo $13$. Suppose $\varphi : U(13) \to \mathbb{Z}_{12}$ is a homomorphism such that $\varphi(2) = 9$.

**(a)** Compute $\varphi(2^3)$ and $\varphi(2^{-1})$.

**(b)** Suppose $\ker \varphi = \{1, 3, 9\}$. Determine all the elements of $U(13)$ that are mapped to $9 \in \mathbb{Z}_{12}$.$BODY$,
    'hard',
    2026,
    'Exercise 9',
    4,
    $BODY$For (a), use the homomorphism property: $\varphi(2^3) = 3\varphi(2)$ and $\varphi(2^{-1}) = -\varphi(2)$ in $\mathbb{Z}_{12}$ (addition). For (b), the preimage of $9$ is a coset of $\ker \varphi$: $\varphi^{-1}(9) = 2 \ker \varphi$.$BODY$,
    $BODY$**(a)** $\varphi(2^3) = 3$ and $\varphi(2^{-1}) = 3$ (in $\mathbb{Z}_{12}$, $3 \cdot 9 = 27 \equiv 3$ and $-9 \equiv 3$). **(b)** The elements are $2, 6, 5$.$BODY$,
    $BODY$**(a)** Since $\varphi$ is a homomorphism, and $\mathbb{Z}_{12}$ uses addition:

- $\varphi(2^3) = 3\varphi(2) = 3 \cdot 9 = 27 \equiv 3 \pmod{12}$, so $\varphi(2^3) = \boxed{3}$.
- $\varphi(2^{-1}) = \varphi(2)^{-1} = -9 \equiv 3 \pmod{12}$, so $\varphi(2^{-1}) = \boxed{3}$.

---

**(b)** Since $\ker \varphi = \{1, 3, 9\}$, the elements of $U(13)$ mapped to $9 \in \mathbb{Z}_{12}$ form the coset

$$
\begin{equation*}\varphi^{-1}(9) = 2 \ker \varphi = \{2, 6, 18\} \equiv \{2, 6, 5\} \pmod{13}.\end{equation*}
$$

$\therefore$ The elements of $U(13)$ mapped to $9 \in \mathbb{Z}_{12}$ are $\boxed{2, 5, 6}$. $\blacksquare$$BODY$
  ),
  (
    '7087f6fe-14c1-4121-8c8d-1f4aeb76cf3c',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'Kernel and Image of a Homomorphism',
    $BODY$Suppose $\varphi : G \to G'$ is a homomorphism of groups.

**(a)** Prove that $\ker \varphi \leq G$.

**(b)** Prove that if $G$ is abelian, then $\varphi(G)$ is abelian.

**(c)** Prove that if $G$ is cyclic, then $\varphi(G)$ is cyclic.$BODY$,
    'hard',
    2026,
    'Exercise 9',
    5,
    $BODY$For (a), use the one-step subgroup test with $\varphi(ab^{-1}) = \varphi(a)\varphi(b)^{-1}$. For (b), take $a', b' \in \varphi(G)$ as images of commuting elements of $G$. For (c), if $G = \langle a \rangle$, show $\varphi(G) = \langle \varphi(a) \rangle$.$BODY$,
    $BODY$**(a)** $\ker \varphi \leq G$. **(b)** $\varphi(G)$ is abelian. **(c)** $\varphi(G)$ is cyclic.$BODY$,
    $BODY$**(a)** Let $e \in G$ be the identity in $G$ and $e' \in G'$ the identity in $G'$.

**One-step subgroup test.** Clearly, $\ker \varphi \neq \varnothing$ since $e \in \ker \varphi$, and by definition $\ker \varphi \subseteq G$. Let $a, b \in \ker \varphi$. Then,

$$
\begin{aligned}
\varphi(ab^{-1}) &= \varphi(a)\varphi(b^{-1}) \\
                 &= \varphi(a)\varphi(b)^{-1} \\
                 &= e' e'^{-1} \\
                 &= e'.
\end{aligned}
$$

Hence, $ab^{-1} \in \ker \varphi$. Therefore, $\ker \varphi \leq G$. $\blacksquare$

---

**(b)** Suppose $G$ is abelian. Let $a', b' \in \varphi(G) \subseteq G'$. Since $\varphi$ is a homomorphism, $\varphi(a) = a'$ and $\varphi(b) = b'$ for some $a, b \in G$. Since $G$ is abelian, $ab = ba$, so

$$
\begin{aligned}
a' b' &= \varphi(a)\varphi(b) \\
      &= \varphi(ab) \\
      &= \varphi(ba) \\
      &= \varphi(b)\varphi(a) \\
      &= b' a'.
\end{aligned}
$$

$\therefore$ $\varphi(G)$ is abelian. $\blacksquare$

---

**(c)** Suppose $G$ is cyclic. Then $G = \langle a \rangle = \{a^k \mid k \in \mathbb{Z}\}$ for some $a \in G$. Then,

$$
\begin{aligned}
\varphi(G) &= \{\varphi(a^k) \mid k \in \mathbb{Z}\} \\
           &= \{\varphi(a)^k \mid k \in \mathbb{Z}\} \\
           &= \langle \varphi(a) \rangle,
\end{aligned}
$$

where $\varphi(a) \in G'$ is the generator of $\varphi(G)$.

$\therefore$ $\varphi(G)$ is cyclic. $\blacksquare$$BODY$
  ),
  (
    '68555a69-0cc4-4847-9119-d99a30afd1dc',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
    'The Image of a Subgroup Under a Homomorphism',
    $BODY$Suppose $\varphi : G \to G'$ is a homomorphism of groups. If $X \subseteq G$, we define the image of $X$ as $\varphi(X) := \{\varphi(x) \mid x \in X\}$. Note that $\varphi(X) \subseteq G'$. Prove that if $H \leq G$, then $\varphi(H) \leq G'$.$BODY$,
    'medium',
    2026,
    'Exercise 9',
    6,
    $BODY$Use the one-step subgroup test. Since $H \leq G$, pick $a, b \in H$ with $ab^{-1} \in H$, then show $\varphi(a)\varphi(b)^{-1} = \varphi(ab^{-1}) \in \varphi(H)$.$BODY$,
    $BODY$$\varphi(H) \leq G'$ by the one-step subgroup test.$BODY$,
    $BODY$Suppose $H \leq G$. Let $e \in G$ and $e' \in G'$ be the identity elements of $G$ and $G'$, respectively.

**One-step subgroup test.** Clearly, $\varphi(H) \subseteq G'$ by definition. Since $H \leq G$, we have $e \in H$, so $e' = \varphi(e) \in \varphi(H)$; hence $\varphi(H) \neq \varnothing$.

Let $a', b' \in \varphi(H)$. Then $\varphi(a) = a'$ and $\varphi(b) = b'$ for some $a, b \in H$. Since $H \leq G$, we have $ab^{-1} \in H$. It follows that

$$
\begin{aligned}
a'b'^{-1} &= \varphi(a)\varphi(b)^{-1} \\
          &= \varphi(a)\varphi(b^{-1}) \\
          &= \varphi(ab^{-1}) \\
          &\in \varphi(H).
\end{aligned}
$$

$\therefore$ $\varphi(H) \leq G'$. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
