-- ============================================================================
-- Math 158 Problem Set 3 — binomial/multinomial identities (A.Y. 2024-2025)
-- 4 problems (numbered 9-12) with solutions.
-- Converted from Typst to Markdown + LaTeX. Fixed source typos (100 -> 1000).
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '97f54810-946a-4985-83e5-a5ce6a29dc46',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Coefficient Extraction From Multinomial Expansions',
    $BODY$**(a)** Determine the coefficient of $x^{29}$ in the expansion of $(1 + x^5 + x^7 + x^9)^{1000}$.

**(b)** Find a simplified form of the coefficient of $x^{79}$ in the expansion of

$$(1 + x)^{158} + x(1 + x)^{157} + x^2(1 + x)^{156} + \cdots + x^{79}(1 + x)^{79}.$$$BODY$,
    'hard',
    2024,
    'Problem Set 3',
    9,
    $BODY$For (a), solve $5r_2 + 7r_3 + 9r_4 = 29$ in nonnegative integers. For (b), the coefficient of $x^{79}$ in $x^j(1+x)^{158-j}$ is $\binom{158-j}{79-j}$; sum and use the hockey-stick (Chu Shih-Chieh) identity.$BODY$,
    $BODY$**(a)** $\dfrac{1000!}{995!\,3!\,2!} + \dfrac{1000!}{995!\,4!\,1!} = 123{,}754{,}368{,}753{,}000$. **(b)** $\binom{159}{79}$.$BODY$,
    $BODY$**(a)** By the multinomial theorem,

$$
\begin{aligned}
(1 + x^5 + x^7 + x^9)^{1000} &= \sum_{\substack{r_1 + r_2 + r_3 + r_4 = 1000 \\ r_1, r_2, r_3, r_4 \ge 0}} \binom{1000}{r_1\ r_2\ r_3\ r_4} 1^{r_1} (x^5)^{r_2} (x^7)^{r_3} (x^9)^{r_4} \\
&= \sum_{\substack{r_1 + r_2 + r_3 + r_4 = 1000 \\ r_1, r_2, r_3, r_4 \ge 0}} \binom{1000}{r_1\ r_2\ r_3\ r_4} x^{5r_2 + 7r_3 + 9r_4}.
\end{aligned}
$$

We find nonnegative integer triples $(r_2, r_3, r_4)$ with $5r_2 + 7r_3 + 9r_4 = 29$.

- $r_2 = 0$: $7r_3 + 9r_4 = 29$. No integer solutions.
- $r_2 = 1$: $7r_3 + 9r_4 = 24$. No integer solutions.
- $r_2 = 2$: $7r_3 + 9r_4 = 19$. No integer solutions.
- $r_2 = 3$: $7r_3 + 9r_4 = 14$. Here $r_3 = 2$, $r_4 = 0$.
- $r_2 = 4$: $7r_3 + 9r_4 = 9$. Here $r_3 = 0$, $r_4 = 1$.

So $(r_2, r_3, r_4) \in \{(3, 2, 0), (4, 0, 1)\}$, and $r_1 = 1000 - 3 - 2 - 0 = 1000 - 4 - 0 - 1 = 995$. Therefore, the coefficient of $x^{29}$ is

$$
\begin{aligned}
\binom{1000}{995\ 3\ 2\ 0} + \binom{1000}{995\ 4\ 0\ 1} &= \frac{1000!}{995!\, 3!\, 2!\, 0!} + \frac{1000!}{995!\, 4!\, 0!\, 1!} \\
&= \frac{1000 \cdot 999 \cdot 998 \cdot 997 \cdot 996}{12} + \frac{1000 \cdot 999 \cdot 998 \cdot 997 \cdot 996}{24} \\
&= \boxed{123{,}754{,}368{,}753{,}000}.
\end{aligned}
$$

---

**(b)** For each $j$ with $0 \le j \le 79$, by the Binomial Theorem,

$$
\begin{aligned}
x^j (1 + x)^{158 - j} &= x^j \sum_{i=0}^{158-j} \binom{158-j}{i} x^i \\
&= \sum_{i=0}^{158-j} \binom{158-j}{i} x^{i + j}.
\end{aligned}
$$

The coefficient of $x^{79}$ corresponds to $i + j = 79$, i.e. $i = 79 - j$. Hence, the coefficient of $x^{79}$ is

$$
\begin{equation*}\sum_{j=0}^{79} \binom{158 - j}{79 - j} = \binom{158}{79} + \binom{157}{78} + \cdots + \binom{79}{0}.\end{equation*}
$$

Reindexing with $m = 79 - j$ and applying Chu Shih-Chieh's identity,

$$
\begin{aligned}
\binom{158}{79} + \cdots + \binom{79}{0} &= \binom{79}{0} + \binom{80}{1} + \cdots + \binom{158}{79} \\
&= \binom{79 + 79 + 1}{79} = \boxed{\binom{159}{79}}.
\end{aligned}
$$

$\blacksquare$$BODY$
  ),
  (
    '73e7825e-d7f8-44b7-9d51-e9b78b8537a1',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Three Binomial Identities',
    $BODY$Prove the following identities.

**(a)** $\displaystyle\sum_{r=0}^{m} (-1)^{m-r} \binom{n}{r} = \binom{n-1}{m}$

**(b)** $\displaystyle\sum_{r=0}^{n} \frac{1}{r+1} \binom{n}{r} = \frac{1}{n+1} \left( 2^{n+1} - 1 \right)$

**(c)** $\displaystyle\sum_{\substack{r_1 + r_2 + \cdots + r_m = n \\ r_1, r_2, \dots, r_m \ge 0}} \binom{n}{r_1\ r_2\ \cdots\ r_m} r_1 r_2 \cdots r_m = P(n, m) \cdot m^{n - m}$ $BODY$,
    'hard',
    2024,
    'Problem Set 3',
    10,
    $BODY$For (a), apply Pascal's identity $\binom{n-1}{m} = \binom{n}{m} - \binom{n-1}{m-1}$ recursively. For (b), use $\frac{n+1}{r+1}\binom{n}{r} = \binom{n+1}{r+1}$. For (c), partially differentiate $(x_1 + \cdots + x_m)^n$ once with respect to each $x_i$ and set all $x_i = 1$.$BODY$,
    $BODY$All three identities follow from Pascal's identity, the binomial theorem, and partial differentiation of the multinomial expansion.$BODY$,
    $BODY$**(a)** By Pascal's identity,

$$
\begin{equation*}\binom{n}{m} = \binom{n-1}{m} + \binom{n-1}{m-1} \iff \binom{n-1}{m} = \binom{n}{m} - \binom{n-1}{m-1}.\end{equation*}
$$

Applying this recursively:

$$
\begin{aligned}
\binom{n-1}{m} &= \binom{n}{m} - \left[ \binom{n}{m-1} - \binom{n-1}{m-2} \right] \\
\binom{n-1}{m} &= \binom{n}{m} - \binom{n}{m-1} + \left[ \binom{n}{m-2} - \binom{n-1}{m-3} \right] \\
\binom{n-1}{m} &= \binom{n}{m} - \binom{n}{m-1} + \binom{n}{m-2} - \left[ \binom{n}{m-3} - \binom{n-1}{m-4} \right] \\
&\vdots
\end{aligned}
$$

Continuing the process,

$$
\begin{equation*}\binom{n-1}{m} = \binom{n}{m} - \binom{n}{m-1} + \cdots + (-1)^m \binom{n}{0} + (-1)^{m+1} \underbrace{\binom{n-1}{-1}}_{= 0}.\end{equation*}
$$

For indexing purposes, at $r = 0$ the sign is $(-1)^m$, so the alternating factor is $(-1)^{m-r}$. Therefore,

$$
\begin{equation*}\boxed{\binom{n-1}{m} = \sum_{r=0}^{m} (-1)^{m-r} \binom{n}{r}}.\end{equation*}
$$

---

**(b)** Recall the combinatorial identity

$$
\begin{equation*}\frac{n+1}{r+1} \binom{n}{r} = \binom{n+1}{r+1}.\end{equation*}
$$

Summing from $r = 0$ to $n$ and reindexing with $k = r + 1$,

$$
\begin{aligned}
\sum_{r=0}^{n} \frac{n+1}{r+1} \binom{n}{r} &= \sum_{r=0}^{n} \binom{n+1}{r+1} \\
&= \sum_{k=1}^{n+1} \binom{n+1}{k}.
\end{aligned}
$$

By the Binomial Theorem,

$$
\begin{aligned}
\sum_{r=0}^{n} \frac{n+1}{r+1} \binom{n}{r} &= \sum_{k=0}^{n+1} \binom{n+1}{k} 1^k 1^{n+1-k} - \binom{n+1}{0} \\
&= (1 + 1)^{n+1} - 1 = 2^{n+1} - 1.
\end{aligned}
$$

Since $n+1$ does not depend on the index $r$, dividing both sides by $n+1$ gives

$$
\begin{equation*}\boxed{\sum_{r=0}^{n} \frac{1}{r+1} \binom{n}{r} = \frac{1}{n+1} \left( 2^{n+1} - 1 \right)}.\end{equation*}
$$

---

**(c)** By the Multinomial Theorem,

$$
\begin{equation*}(x_1 + x_2 + \cdots + x_m)^n = \sum_{\substack{r_1 + \cdots + r_m = n \\ r_i \ge 0}} \binom{n}{r_1\ r_2\ \cdots\ r_m} x_1^{r_1} x_2^{r_2} \cdots x_m^{r_m}.\end{equation*}
$$

We want a product of the $r_i$'s, so we partially differentiate once with respect to each $x_i$. For $i = 1$,

$$
\begin{equation*}n(x_1 + \cdots + x_m)^{n-1} = \sum \binom{n}{r_1\ r_2\ \cdots\ r_m} r_1 x_1^{r_1 - 1} x_2^{r_2} \cdots x_m^{r_m}.\end{equation*}
$$

For $i = 2$,

$$
\begin{equation*}n(n-1)(x_1 + \cdots + x_m)^{n-2} = \sum \binom{n}{r_1\ r_2\ \cdots\ r_m} r_1 r_2 x_1^{r_1 - 1} x_2^{r_2 - 1} \cdots x_m^{r_m}.\end{equation*}
$$

Continuing up to $i = m$,

$$
\begin{equation*}\frac{\partial^m}{\partial x_m \cdots \partial x_2 \partial x_1}(x_1 + \cdots + x_m)^n = \sum \binom{n}{r_1\ r_2\ \cdots\ r_m} r_1 r_2 \cdots r_m x_1^{r_1 - 1} x_2^{r_2 - 1} \cdots x_m^{r_m - 1}.\end{equation*}
$$

The left-hand side is

$$
\begin{equation*}n(n-1)\cdots(n - m + 1)(x_1 + \cdots + x_m)^{n-m} = P(n, m)(x_1 + \cdots + x_m)^{n-m}.\end{equation*}
$$

Finally, setting $x_i = 1$ for all $i \in \{1, \dots, m\}$,

$$
\begin{equation*}P(n, m) \cdot m^{n-m} = \sum_{\substack{r_1 + \cdots + r_m = n \\ r_i \ge 0}} \binom{n}{r_1\ r_2\ \cdots\ r_m} r_1 r_2 \cdots r_m.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    'c6a5c873-f449-4b06-8060-df772c581fd8',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'A Combinatorial Proof and Two Computations',
    $BODY$**(a)** Give a combinatorial proof for the identity $\displaystyle\binom{n}{r}\binom{r}{m} = \binom{n}{m}\binom{n-m}{r-m}$, where $m, n, r \in \mathbb{N}$ with $n \ge r \ge m$.

**(b)** Compute the value of $\displaystyle\sum_{k=100}^{201} \sum_{j=100}^{k} \binom{201}{k+1} \binom{j}{100}$.

**(c)** Show that $\displaystyle\sum_{r=0}^{n} \binom{n}{r}^2 \binom{r}{n-k} = \binom{n}{k} \binom{n+k}{k}$.$BODY$,
    'hard',
    2024,
    'Problem Set 3',
    11,
    $BODY$For (a), biject pairs $(R, M)$ (an $r$-subset $R$ and an $m$-subset $M \subseteq R$) with pairs $(N, T)$ via $(R, M) \mapsto (M, R \setminus M)$. For (b), use Chu Shih-Chieh, the identity from (a), and the binomial theorem. For (c), apply (a) and Vandermonde's identity.$BODY$,
    $BODY$**(a)** Bijection $(R, M) \mapsto (M, R \setminus M)$. **(b)** $\binom{201}{101} \cdot 2^{100}$. **(c)** By identity (a) and Vandermonde.$BODY$,
    $BODY$**(a)** Let $S = \{1, 2, \dots, n\}$. The LHS counts the number of ways to choose an $r$-subset $R$ of $S$ and then choose an $m$-subset $M$ of $R$. The RHS counts the number of ways to choose an $m$-subset $N$ of $S$ and then choose an $(r-m)$-subset $T$ of $N^c$. We use the Bijection Principle.

Define $X$ as the set of all pairs $(R, M)$ where $R$ is an $r$-subset of $S$ and $M$ is an $m$-subset of $R$. Define $Y$ as the set of all pairs $(N, T)$ where $N$ is an $m$-subset of $S$ and $T$ is an $(r-m)$-subset of $N^c$.

For every $(R, M) \in X$, we claim $(M, R \setminus M) \in Y$:

- $M$ is an $m$-subset of $R$, hence an $m$-subset of $S$ since $R \subseteq S$;
- $M \subseteq R$, so $R \cap M = M$ and $|R \setminus M| = |R| - |M| = r - m$. Also, since $R \subseteq S$, $R \setminus M \subseteq S \setminus M = M^c$. Hence, $R \setminus M$ is an $(r-m)$-subset of $M^c$.

Define $f : X \to Y$ by $f(R, M) = (M, R \setminus M)$.

**(1-1)** Let $(R_1, M_1), (R_2, M_2) \in X$ with $(R_1, M_1) \neq (R_2, M_2)$. Then $(M_1, R_1 \setminus M_1) \neq (M_2, R_2 \setminus M_2)$, so $f(R_1, M_1) \neq f(R_2, M_2)$.

**(onto)** Let $(N, T) \in Y$. Consider $(N \cup T, N)$. Since $T \subseteq N^c$, $N \cap T = \varnothing$, so $|N \cup T| = |N| + |T| = m + (r - m) = r$. Hence, $N \cup T$ is an $r$-subset of $S$, and $N \subseteq N \cup T$, so $N$ is an $m$-subset of $N \cup T$. Thus, $(N \cup T, N) \in X$, and

$$
\begin{equation*}f(N \cup T, N) = (N, (N \cup T) \setminus N) = (N, T).\end{equation*}
$$

Indeed, $f$ is a bijection, so $|X| = |Y|$:

$$
\begin{equation*}\boxed{\binom{n}{r}\binom{r}{m} = \binom{n}{m}\binom{n-m}{r-m}}.\end{equation*}
$$

---

**(b)** By Chu Shih-Chieh's identity,

$$
\begin{equation*}\sum_{j=100}^{k} \binom{j}{100} = \binom{100}{100} + \binom{101}{100} + \cdots + \binom{k}{100} = \binom{k+1}{101}.\end{equation*}
$$

Then,

$$
\begin{aligned}
\sum_{k=100}^{201} \sum_{j=100}^{k} \binom{201}{k+1}\binom{j}{100}
&= \sum_{k=100}^{201} \binom{201}{k+1} \sum_{j=100}^{k} \binom{j}{100} \\
&= \sum_{k=100}^{201} \binom{201}{k+1}\binom{k+1}{101}.
\end{aligned}
$$

Setting $m = k + 1$,

$$
\begin{aligned}
\sum_{m=101}^{202} \binom{201}{m}\binom{m}{101}
&= \sum_{m=101}^{201} \binom{201}{m}\binom{m}{101} + \underbrace{\binom{201}{202}}_{=0}\binom{202}{101}.
\end{aligned}
$$

Using the identity in (a) with $n = 201$, $r = m$, $m' = 101$,

$$
\begin{aligned}
\sum_{m=101}^{201} \binom{201}{m}\binom{m}{101}
&= \sum_{m=101}^{201} \binom{201}{101}\binom{201 - 101}{m - 101} \\
&= \binom{201}{101} \sum_{m=101}^{201} \binom{100}{m - 101}.
\end{aligned}
$$

Setting $n = m - 101$ and applying the Binomial Theorem,

$$
\begin{aligned}
\binom{201}{101} \sum_{n=0}^{100} \binom{100}{n} 1^n 1^{100-n}
&= \binom{201}{101}(1 + 1)^{100} \\
&= \boxed{\binom{201}{101} \cdot 2^{100}}.
\end{aligned}
$$

---

**(c)** Using the identity from (a),

$$
\begin{aligned}
\binom{n}{r}\binom{r}{n-k} &= \binom{n}{n-k}\binom{n - (n-k)}{r - (n-k)} \\
&= \binom{n}{n-k}\binom{k}{r - (n-k)} = \binom{n}{k}\binom{k}{r - (n-k)},
\end{aligned}
$$

where the last equality uses the reflection identity. Note that for $r < n - k$, $\binom{r}{n-k} = 0$. Hence,

$$
\begin{aligned}
\sum_{r=0}^{n} \binom{n}{r}^2 \binom{r}{n-k}
&= \sum_{r=n-k}^{n} \binom{n}{r}\binom{n}{r}\binom{r}{n-k} \\
&= \sum_{r=n-k}^{n} \binom{n}{r}\binom{n}{k}\binom{k}{r - (n-k)}.
\end{aligned}
$$

Reindexing with $m = r - (n-k)$ (so $r = m + n - k$) and using the reflection identity $\binom{n}{m + n - k} = \binom{n}{k - m}$,

$$
\begin{aligned}
\sum_{r=0}^{n} \binom{n}{r}^2 \binom{r}{n-k}
&= \binom{n}{k} \sum_{m=0}^{k} \binom{n}{k - m}\binom{k}{m}.
\end{aligned}
$$

Finally, applying Vandermonde's identity,

$$
\begin{equation*}\boxed{\sum_{r=0}^{n} \binom{n}{r}^2 \binom{r}{n-k} = \binom{n}{k} \binom{n+k}{k}}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '73a903df-d85d-48e5-9c0d-2449880a0ac7',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'The Trinomial Vandermonde Identity',
    $BODY$Use a combinatorial argument to establish the following analogue of Vandermonde's Identity for trinomial coefficients: If $m$ and $n$ are non-negative integers, and $s_1 + s_2 + s_3 = m + n$, then

$$\sum_{\substack{r_1 + r_2 + r_3 = m \\ r_1, r_2, r_3 \ge 0}} \binom{m}{r_1\ r_2\ r_3} \binom{n}{s_1 - r_1\ s_2 - r_2\ s_3 - r_3} = \binom{m+n}{s_1\ s_2\ s_3}.$$$BODY$,
    'hard',
    2024,
    'Problem Set 3',
    12,
    $BODY$Double count the ways to distribute $m$ red balls and $n$ blue balls into $3$ distinct boxes with $s_1, s_2, s_3$ balls in boxes $1, 2, 3$. First count directly; then count by first choosing $r_i$ red balls for box $i$ and then $s_i - r_i$ blue balls.$BODY$,
    $BODY$Both sides count the distributions of $m$ red and $n$ blue balls into $3$ distinct boxes with box sizes $s_1, s_2, s_3$.$BODY$,
    $BODY$We proceed by double counting. Consider the following scenario.

**Given:** $m$ red balls and $n$ blue balls.

**Problem:** How many ways are there to distribute the balls into $3$ distinct boxes so that box $1$ has $s_1$ balls, box $2$ has $s_2$ balls, and box $3$ has $s_3$ balls?

This is precisely given by

$$
\begin{equation*}\binom{m + n}{s_1\ s_2\ s_3}.\end{equation*}
$$

We may also count it as follows. Let $r_1, r_2, r_3 \ge 0$ with $r_1 + r_2 + r_3 = m$. Take $r_i$ red balls to be placed in box $i$ (for $i \in \{1, 2, 3\}$): the number of ways is $\binom{m}{r_1\ r_2\ r_3}$. Then take $s_i - r_i$ blue balls to be placed in box $i$ (for $i \in \{1, 2, 3\}$): the number of ways is $\binom{n}{s_1 - r_1\ s_2 - r_2\ s_3 - r_3}$.

By the Multiplication Principle, the number of ways for this case is

$$
\begin{equation*}\binom{m}{r_1\ r_2\ r_3}\binom{n}{s_1 - r_1\ s_2 - r_2\ s_3 - r_3}.\end{equation*}
$$

Accounting for all cases, by the Addition Principle, the total number of ways is

$$
\begin{equation*}\sum_{\substack{r_1 + r_2 + r_3 = m \\ r_1, r_2, r_3 \ge 0}} \binom{m}{r_1\ r_2\ r_3}\binom{n}{s_1 - r_1\ s_2 - r_2\ s_3 - r_3}.\end{equation*}
$$

Since we are counting the same collection of distributions,

$$
\begin{equation*}\boxed{\sum_{\substack{r_1 + r_2 + r_3 = m \\ r_1, r_2, r_3 \ge 0}} \binom{m}{r_1\ r_2\ r_3} \binom{n}{s_1 - r_1\ s_2 - r_2\ s_3 - r_3} = \binom{m+n}{s_1\ s_2\ s_3}}.\end{equation*}
$$

$\blacksquare$$BODY$
  )
on conflict (id) do nothing;
