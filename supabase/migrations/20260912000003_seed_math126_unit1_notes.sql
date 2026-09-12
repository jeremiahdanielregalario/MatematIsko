-- ============================================================================
-- Seed: MATH 126 Real Analysis - Unit I notes (Lebesgue measure and
-- measurable functions), matching the stored course-note Markdown format.
-- ============================================================================

insert into public.course_notes
  (id, course_id, title, content, sort_order)
values
  (
    'd8a0f9b6-2c4e-4a1d-9b3f-7e5c6d8a0b2e',
    'c0000000-0000-4000-8000-000000000004',
    'Unit I: Lebesgue Measure and Measurable Functions',
$BODY$# Math 126: Real Analysis — Unit I

---

*All sets considered below are subsets of* $\mathbb{R}$.

---

# 1. Lebesgue Measure

---

## 1.1 Lebesgue Outer Measure

### Definition: Length of an Interval

Let $I$ be a nonempty interval. We define the **length of $I$**, denoted by $\ell(I)$, as

$$\ell(I) = \begin{cases} +\infty & \text{if } I \text{ is unbounded,} \\ |b - a| & \text{if } I \text{ is bounded with endpoints } a \text{ and } b. \end{cases}$$

### Definition: Lebesgue Outer Measure

Let $A \subseteq \mathbb{R}$. The (Lebesgue) **outer measure** of $A$, denoted $m^{*}(A)$, is

$$m^{*}(A) = \inf \Sigma_A = \inf \left\{ \sum_{k=1}^{\infty} \ell(I_k) : A \subseteq \bigcup_{k=1}^{\infty} I_k,\ I_k \text{ is an open and bounded interval} \right\},$$

where we write $\Sigma_A$ for the set appearing in the infimum.

### Remark

$m^{*}(\varnothing) = 0$.

**Proof.** We want to show that $0 \leq m^{*}(\varnothing) < \varepsilon$, for every $\varepsilon > 0$.

Let $\varepsilon > 0$. We claim that $\dfrac{\varepsilon}{2} \in \Sigma_{\varnothing}$. Once we show this, it follows that

$$m^{*}(\varnothing) \leq \frac{\varepsilon}{2} < \varepsilon.$$

So we need to find a collection of open and bounded intervals $I_k$ such that

$$\sum_{k=1}^{\infty} \ell(I_k) = \frac{\varepsilon}{2}.$$

We can choose the $I_k$ such that

$$\ell(I_k) = \frac{\varepsilon}{2^{k+1}},$$

for example

$$I_k = \left(-\frac{\varepsilon}{2^{k+2}}, \frac{\varepsilon}{2^{k+2}}\right).$$

Thus

$$\sum_{k=1}^{\infty} \ell(I_k) = \sum_{k=1}^{\infty} \frac{\varepsilon}{2^{k+1}} = \frac{\varepsilon}{2}.$$

Trivially, $\varnothing \subseteq \bigcup_{k=1}^{\infty} I_k$. This proves the claim and the desired result. ∎

### Remark: Monotonicity

If $A \subseteq B$, then $m^{*}(A) \leq m^{*}(B)$.

**Proof.** Note that

$$\{ \{I_k\} : A \subseteq \bigcup_{k=1}^{\infty} I_k,\ I_k \text{ is an open and bounded interval} \} \supseteq \{ \{I_k\} : B \subseteq \bigcup_{k=1}^{\infty} I_k,\ I_k \text{ is an open and bounded interval} \},$$

so $\Sigma_A \supseteq \Sigma_B$.

**Recall.** If $E \subseteq F$, both bounded, then $\sup E \leq \sup F$ and $\inf E \geq \inf F$.

Thus $m^{*}(A) = \inf \Sigma_A \leq \inf \Sigma_B = m^{*}(B)$. ∎

### Example: The Outer Measure of a Countable Set Is 0

**Proof.** Let $A = \{a_1, a_2, a_3, \ldots\}$ be a countable (infinite) set. Claim: $\dfrac{\varepsilon}{2} \in \Sigma_A$.

Similar to the proof of $m^{*}(\varnothing) = 0$, we need a collection $\{I_k\}$ of open and bounded intervals such that

$$\sum_{k=1}^{\infty} \ell(I_k) = \frac{\varepsilon}{2} \quad \text{and} \quad A \subseteq \bigcup_{k=1}^{\infty} I_k.$$

We want the $I_k$ to satisfy

$$\ell(I_k) = \frac{\varepsilon}{2^{k+1}},$$

so we define

$$I_k = \left(a_k - \frac{\varepsilon}{2^{k+2}},\ a_k + \frac{\varepsilon}{2^{k+2}}\right).$$

Then for every $n \in \mathbb{N}$,

$$a_n \in \bigcup_{k=1}^{\infty} I_k \quad \Longrightarrow \quad A \subseteq \bigcup_{k=1}^{\infty} I_k,$$

and

$$\sum_{k=1}^{\infty} \ell(I_k) = \sum_{k=1}^{\infty} \frac{\varepsilon}{2^{k+1}} = \frac{\varepsilon}{2}.$$

Hence $\dfrac{\varepsilon}{2} \in \Sigma_A$, which implies $m^{*}(A) = 0$.

If $A$ is finite, construct an infinite countable set $B$ with $A \subseteq B$ (e.g. $B = A \cup \mathbb{N}$). Then

$$0 \leq m^{*}(A) \leq m^{*}(B) = 0 \quad \Longrightarrow \quad m^{*}(A) = 0. \quad \blacksquare$$

**Some consequences:**

- $m^{*}(\mathbb{N}) = m^{*}(\mathbb{Q}) = m^{*}(\mathbb{Z}) = 0$.
- If $m^{*}(A) > 0$, then $A$ is uncountable. (The converse is false: the Cantor set.)

### Example: The Outer Measure of Any Interval Is Its Length

**Proof.** We divide the proof into three cases:

1. $I$ is a closed and bounded interval.
2. $I$ is any bounded interval.
3. $I$ is an unbounded interval.

**Case 1.** Let $I = [a, b]$ be a closed and bounded interval. Main goal: $m^{*}(I) = \ell(I) = b - a$.

To show that $m^{*}(I) \leq b - a$, it is enough to prove that

$$b - a + \varepsilon \in \Sigma_I, \quad \text{for every } \varepsilon > 0.$$

Let us find a collection $\{I_k\}$ of open and bounded intervals such that

$$\sum_{k=1}^{\infty} \ell(I_k) = b - a + \varepsilon \quad \text{and} \quad I \subseteq \bigcup_{k=1}^{\infty} I_k.$$

Consider $I_1 = \left(a - \dfrac{\varepsilon}{4},\ b + \dfrac{\varepsilon}{4}\right)$, which has length $\ell(I_1) = b - a + \dfrac{\varepsilon}{2}$. Now, for $k \geq 2$, take

$$I_k = \left(-\frac{\varepsilon}{2^{k+1}},\ \frac{\varepsilon}{2^{k+1}}\right).$$

Then $I \subseteq I_1 \subseteq \bigcup_{k=1}^{\infty} I_k$, and

$$\sum_{k=1}^{\infty} \ell(I_k) = \left(b - a + \frac{\varepsilon}{2}\right) + \underbrace{\sum_{k=2}^{\infty} \frac{\varepsilon}{2^{k}}}_{=\ \frac{\varepsilon}{2}} = b - a + \varepsilon.$$

Thus $b - a + \varepsilon \in \Sigma_I$, which implies $m^{*}(I) \leq b - a$.

To prove the reverse inequality, it is enough to show that $b - a$ is a lower bound of $\Sigma_I$; that is, $b - a \leq r$ for every $r \in \Sigma_I$.

Let $r \in \Sigma_I$. Then there exists a collection $\{I_k\}$ of open and bounded intervals such that

$$\underset{(1)}{I \subseteq \bigcup_{k=1}^{\infty} I_k} \quad \text{and} \quad r = \sum_{k=1}^{\infty} \ell(I_k).$$

Since $\{I_k\}$ satisfies (1), it is an open cover of $I$.

**Recall.**

- (Heine–Borel Theorem) A set is compact if and only if it is closed and bounded.
- A set $K$ is *compact* if every open cover of $K$ has a finite subcover.

Then $\{I_k\}$ has a finite subcover, say $\{I_k\}_{k=1}^{N}$. Focus on $\{I_k\}_{k=1}^{N}$, say $(a_1, b_1)$ such that

$$a \in (a_1, b_1) \quad \Longrightarrow \quad a_1 < a < b_1.$$

If $b \leq b_1$, then

$$b - a \leq b_1 - a_1 \leq \sum_{k=1}^{N} \ell(I_k) \leq \sum_{k=1}^{\infty} \ell(I_k) = r.$$

If $b_1 < b$, then $a < b_1 < b$, so $b_1 \in [a, b]$, hence $b_1 \in I \subseteq \bigcup_{k=1}^{N} I_k$, and $b_1 \notin (a_1, b_1)$. Then we can find another interval in $\{I_k\}_{k=1}^{N}$, say $(a_2, b_2)$, such that

$$b_1 \in (a_2, b_2) \quad \Longrightarrow \quad a_2 < b_1 < b_2.$$

If $b \leq b_2$,

$$b - a \leq b_2 - a_1 \leq (b_2 - a_1) + (b_1 - a_1) \leq \sum_{k=1}^{N} \ell(I_k) \leq \sum_{k=1}^{\infty} \ell(I_k) = r.$$

Otherwise, we continue the process until it terminates (as it must, since the collection $\{I_k\}_{k=1}^{N}$ is finite).

At the end, we obtain a subcollection $\{(a_n, b_n)\}_{n=1}^{m}$ of $\{I_k\}_{k=1}^{N}$ satisfying:

$$a \in (a_1, b_1) \quad \Longrightarrow \quad a_1 < a < b_1,$$

$$b_n \in (a_{n+1}, b_{n+1}) \quad \Longrightarrow \quad \underbrace{a_{n+1} < b_n < b_{n+1}}_{-a_{n+1} + b_n > 0}, \quad 1 \leq n \leq m - 1,$$

and $b_m \geq b$.

Thus

$$b - a \leq b_m - a_1 \leq (b_m - a_m) + (b_{m-1} - a_{m-1}) + \cdots + (b_2 - a_2) + (b_1 - a_1) = \sum_{n=1}^{m} (b_n - a_n) \leq \sum_{k=1}^{N} \ell(I_k) \leq \sum_{k=1}^{\infty} \ell(I_k) = r.$$

Therefore $b - a$ is a lower bound of $\Sigma_I$, and hence $m^{*}(I) \geq b - a$.

This now proves $m^{*}(I) = b - a$.

**Case 2.** $I$ is any bounded interval. Let $a$ be its left endpoint and $b$ its right endpoint.

Goal: $|m^{*}(I) - (b - a)| < \varepsilon$, for every $\varepsilon > 0$:

$$\underset{m^{*}(J_1)}{b - a - \varepsilon} < m^{*}(I) < \underset{m^{*}(J_2)}{b - a + \varepsilon}.$$

We want closed and bounded intervals $J_1, J_2$ such that $J_1 \subseteq I \subseteq J_2$ and

$$m^{*}(J_1) > b - a - \varepsilon \quad \text{and} \quad m^{*}(J_2) < b - a + \varepsilon.$$

This implies

$$b - a - \varepsilon < m^{*}(J_1) \leq m^{*}(I) \leq m^{*}(J_2) < b - a + \varepsilon.$$

So take

$$J_1 = \left[a + \frac{\varepsilon}{4},\ b - \frac{\varepsilon}{4}\right] \quad \text{and} \quad J_2 = \left[a - \frac{\varepsilon}{4},\ b + \frac{\varepsilon}{4}\right].$$

By Case 1,

$$m^{*}(J_1) = \underbrace{b - a - \frac{\varepsilon}{2}}_{>\, b - a - \varepsilon} \quad \text{and} \quad m^{*}(J_2) = \underbrace{b - a + \frac{\varepsilon}{2}}_{<\, b - a + \varepsilon}.$$

Then

$$b - a - \varepsilon < m^{*}(I) < b - a + \varepsilon \quad \Longrightarrow \quad |m^{*}(I) - (b - a)| < \varepsilon \quad \Longrightarrow \quad m^{*}(I) = b - a.$$

**Case 3.** $I$ is an unbounded interval. Then $I$ has a subset of length $n$ for every $n \in \mathbb{N}$. (For example, if $I = (a, +\infty)$, take $(a, a + n)$, which has length $n$.) Then

$$m^{*}(I) \geq n, \quad \text{for every } n \in \mathbb{N}.$$

Taking the limit as $n \to \infty$, we have $m^{*}(I) = +\infty$. ∎

---

## 1.2 Properties of the Lebesgue Outer Measure

### Proposition: Translation Invariance

The outer measure $m^{*}$ is **translation invariant**; that is, for every $A \subseteq \mathbb{R}$ and $y \in \mathbb{R}$,

$$m^{*}(A + y) = m^{*}(A).$$

*Note:* $A + y = \{a + y : a \in A\}$.

**Proof.** Let $A \subseteq \mathbb{R}$ and $y \in \mathbb{R}$. If $\{I_k\}_{k=1}^{\infty}$ is a countable collection of open and bounded intervals, then

$$A \subseteq \bigcup_{k=1}^{\infty} I_k \quad \Longleftrightarrow \quad A + y \subseteq \bigcup_{k=1}^{\infty} (I_k + y),$$

and $\ell(I_k) = \ell(I_k + y)$ for every $k \in \mathbb{N}$. So

$$\sum_{k=1}^{\infty} \ell(I_k) \in \Sigma_A \;\Longleftrightarrow\; \sum_{k=1}^{\infty} \ell(I_k + y) \in \Sigma_{A + y} \;\Longleftrightarrow\; \sum_{k=1}^{\infty} \ell(I_k) \in \Sigma_{A + y}.$$

It follows that

$$\Sigma_A = \Sigma_{A + y} \quad \Longrightarrow \quad \inf \Sigma_A = \inf \Sigma_{A + y} \quad \Longrightarrow \quad m^{*}(A) = m^{*}(A + y). \quad \blacksquare$$

### Proposition: Countable Subadditivity

The outer measure $m^{*}$ is **countably subadditive**; that is, for any countable collection $\{E_k\}_{k=1}^{\infty}$ of subsets of $\mathbb{R}$ (the $E_k$'s may or may not be pairwise disjoint), we have

$$m^{*}\!\left(\bigcup_{k=1}^{\infty} E_k\right) \leq \sum_{k=1}^{\infty} m^{*}(E_k).$$

**Proof.** Let $\{E_k\}_{k=1}^{\infty}$ be a countable collection of subsets of $\mathbb{R}$.

- **Case 1.** There is a $k \in \mathbb{N}$ such that $m^{*}(E_k) = +\infty$. Then

$$m^{*}\!\left(\bigcup_{k=1}^{\infty} E_k\right) \leq \infty = \sum_{k=1}^{\infty} m^{*}(E_k).$$

- **Case 2.** For all $k \in \mathbb{N}$, $m^{*}(E_k) < \infty$, so $m^{*}(E_k) \in \mathbb{R}$.

**Recall.** (Characterization of infimum) Let $A$ be a set that is bounded below. Then

$$\ell = \inf A \quad \Longleftrightarrow \quad \forall \varepsilon > 0,\ \exists t \in A \text{ such that } \ell + \varepsilon > t.$$

Goal: for every $\varepsilon > 0$,

$$m^{*}\!\left(\bigcup_{k=1}^{\infty} E_k\right) \leq \sum_{k=1}^{\infty} m^{*}(E_k) + \varepsilon.$$

Let $\varepsilon > 0$. For any $k \in \mathbb{N}$, by the characterization of the infimum $m^{*}(E_k) = \inf \Sigma_{E_k}$, there exists $t_{\varepsilon}^{k} \in \Sigma_{E_k}$ such that

$$m^{*}(E_k) + \frac{\varepsilon}{2^{k}} > t_{\varepsilon}^{k}.$$

Since $t_{\varepsilon}^{k} \in \Sigma_{E_k}$, there is a collection $\{I_n\}_{n=1}^{\infty}$ of open and bounded intervals such that

$$E_k \subseteq \bigcup_{n=1}^{\infty} I_n^{k} \quad \text{and} \quad t_{\varepsilon}^{k} = \sum_{n=1}^{\infty} \ell\left(I_n^{k}\right) < m^{*}(E_k) + \frac{\varepsilon}{2^{k}}.$$

Then

$$\bigcup_{k=1}^{\infty} E_k \subseteq \bigcup_{k=1}^{\infty} \left(\bigcup_{n=1}^{\infty} I_n^{k}\right),$$

that is, $\{I_n^{k}\}_{n, k \in \mathbb{N}}$ is an open cover of $\bigcup_{k=1}^{\infty} E_k$. It follows that

$$\sum_{k=1}^{\infty} \sum_{n=1}^{\infty} \ell\left(I_n^{k}\right) \in \Sigma_{\bigcup_{k=1}^{\infty} E_k} \quad \Longrightarrow \quad \sum_{k=1}^{\infty} \sum_{n=1}^{\infty} \ell\left(I_n^{k}\right) \geq \inf \Sigma_{\bigcup_{k=1}^{\infty} E_k} = m^{*}\!\left(\bigcup_{k=1}^{\infty} E_k\right).$$

Then

$$m^{*}\!\left(\bigcup_{k=1}^{\infty} E_k\right) \leq \sum_{k=1}^{\infty} \sum_{n=1}^{\infty} \ell\left(I_n^{k}\right) < \sum_{k=1}^{\infty} \left(m^{*}(E_k) + \frac{\varepsilon}{2^{k}}\right) = \sum_{k=1}^{\infty} m^{*}(E_k) + \varepsilon. \quad \blacksquare$$

---

Now, we want the measure to be **countably additive**: if $\{E_k\}$ is a pairwise disjoint collection of subsets of $\mathbb{R}$, then

$$m^{*}\!\left(\bigcup_{k=1}^{\infty} E_k\right) = \sum_{k=1}^{\infty} m^{*}(E_k).$$

To achieve this, we restrict the domain of $m^{*}$ to the set of "measurable sets."

---

# 2. Measurable Sets

---

### Definition: Measurable Set

A set $E$ is **measurable** if for any $A \subseteq \mathbb{R}$,

$$m^{*}(A) = m^{*}(A \cap E) + m^{*}(A \cap E^{c}),$$

where $E^{c} = \mathbb{R} \setminus E$.

---

### Remark

Let $E$ and $F$ be disjoint sets such that $E$ is measurable. Then

$$m^{*}(E \cup F) = m^{*}(E) + m^{*}(F).$$

**Proof.** Let $E$ and $F$ be disjoint sets and suppose $E$ is measurable. For every $A \subseteq \mathbb{R}$,

$$m^{*}(A) = m^{*}(A \cap E) + m^{*}(A \cap E^{c}).$$

Taking $A = E \cup F$, we have

$$m^{*}(E \cup F) = m^{*}\big((E \cup F) \cap E\big) + m^{*}\big(\underset{=\ F,\ \text{since } E \cap F = \varnothing}{(E \cup F) \cap E^{c}}\big) = m^{*}(E) + m^{*}(F). \quad \blacksquare$$

### Remark

To show that $E$ is measurable, it is enough to show that

$$m^{*}(A) \geq m^{*}(A \cap E) + m^{*}(A \cap E^{c}), \quad \text{for all } A \subseteq \mathbb{R}.$$

Indeed, note that $A = (A \cap E) \cup (A \cap E^{c})$. Then, by countable subadditivity of $m^{*}$,

$$m^{*}(A) = m^{*}\big((A \cap E) \cup (A \cap E^{c})\big) \leq m^{*}(A \cap E) + m^{*}(A \cap E^{c}).$$

### Corollary to Countable Subadditivity (Finite Subadditivity)

Let $\{E_k\}_{k=1}^{n}$ be a finite collection of subsets of $\mathbb{R}$. Then

$$m^{*}\!\left(\bigcup_{k=1}^{n} E_k\right) \leq \sum_{k=1}^{n} m^{*}(E_k).$$

**Proof.** For $k > n$, take $E_k = \varnothing$. Then

$$m^{*}\!\left(\bigcup_{k=1}^{n} E_k\right) = m^{*}\!\left(\bigcup_{k=1}^{\infty} E_k\right) \leq \sum_{k=1}^{\infty} m^{*}(E_k) = \sum_{k=1}^{n} m^{*}(E_k). \quad \blacksquare$$

### Remark

A set $E$ is measurable if and only if $E^{c}$ is measurable.

**Proof.** Follows from the definition and the fact that $(E^{c})^{c} = E$. ∎

### Remark: Excision Property

Let $A$ and $B$ be subsets of $\mathbb{R}$ such that $B \subseteq A$. If $B$ is measurable with finite outer measure, then

$$m^{*}(A \setminus B) = m^{*}(A) - m^{*}(B).$$

**Proof.** Let $B \subseteq A$ with $m^{*}(B) < \infty$, and suppose $B$ is measurable. Then for every $C \subseteq \mathbb{R}$,

$$m^{*}(C) = m^{*}(C \cap B) + m^{*}(C \cap B^{c}).$$

Taking $C = A$, we get

$$m^{*}(A) = m^{*}(A \cap B) + m^{*}(A \cap B^{c}) = m^{*}(B) + m^{*}(A \setminus B),$$

so $m^{*}(A \setminus B) = m^{*}(A) - m^{*}(B)$.

*Note:* the subtraction is legitimate because we use the fact that $m^{*}(B) < \infty$. ∎

**Homework:** Find an example of $A$ and $B$ such that $B \subseteq A$ and $m^{*}(B) = +\infty$, but

$$m^{*}(A \setminus B) \neq m^{*}(A) - m^{*}(B).$$

---

### Proposition: Finite Additivity

Let $A$ be any subset of $\mathbb{R}$ and $\{E_k\}_{k=1}^{n}$ a finite collection of pairwise disjoint measurable sets. Then

$$m^{*}\!\left(\bigcup_{k=1}^{n} (A \cap E_k)\right) = \sum_{k=1}^{n} m^{*}(A \cap E_k).$$

In particular, taking $A = \mathbb{R}$, we get

$$m^{*}\!\left(\bigcup_{k=1}^{n} E_k\right) = \sum_{k=1}^{n} m^{*}(E_k).$$

**Proof.** We proceed by induction. If $n = 1$, the result is obvious.

Suppose the claim holds for some $n \in \mathbb{N}$:

$$m^{*}\!\left(\bigcup_{k=1}^{n} (A \cap E_k)\right) = \sum_{k=1}^{n} m^{*}(A \cap E_k).$$

We want to show it holds for $n + 1$. Since $E_{n+1}$ is measurable, for every $B \subseteq \mathbb{R}$,

$$m^{*}(B) = m^{*}(B \cap E_{n+1}) + m^{*}(B \cap E_{n+1}^{c}).$$

Choosing $B = \bigcup_{k=1}^{n+1} (A \cap E_k)$, we have

$$m^{*}\!\left(\bigcup_{k=1}^{n+1} (A \cap E_k)\right) = m^{*}\!\left(\bigcup_{k=1}^{n+1} (A \cap E_k) \cap E_{n+1}\right) + m^{*}\!\left(\bigcup_{k=1}^{n+1} (A \cap E_k) \cap E_{n+1}^{c}\right).$$

Note 1: $E_k \cap E_{n+1} = \varnothing$ for every $k \neq n + 1$. Hence

$$= m^{*}(A \cap E_{n+1}) + m^{*}\!\left(\bigcup_{k=1}^{n+1} (A \cap E_k) \cap E_{n+1}^{c}\right).$$

Note 2: $E_k \cap E_{n+1}^{c} = E_k$ for $k \neq n + 1$, while $E_{n+1} \cap E_{n+1}^{c} = \varnothing$. Thus

$$= m^{*}(A \cap E_{n+1}) + \sum_{k=1}^{n} m^{*}(A \cap E_k) = \sum_{k=1}^{n+1} m^{*}(A \cap E_k).$$

By PMI, finite additivity holds. ∎

### Proposition

Any set of outer measure zero is measurable. In particular, every countable set is measurable.

**Proof.** Let $E$ be a set of outer measure zero. By an earlier remark, to prove $E$ is measurable it is enough to prove that, for every $A \subseteq \mathbb{R}$,

$$m^{*}(A) \geq m^{*}(A \cap E) + m^{*}(A \cap E^{c}).$$

Let $A \subseteq \mathbb{R}$. Then

$$0 \leq m^{*}(A \cap E) \leq m^{*}(E) = 0,$$

so $m^{*}(A \cap E) = 0$, and by monotonicity $m^{*}(A \cap E^{c}) \leq m^{*}(A)$. Therefore

$$m^{*}(A \cap E) + m^{*}(A \cap E^{c}) \leq 0 + m^{*}(A) = m^{*}(A). \quad \blacksquare$$

### Proposition

The union and intersection of a finite collection of measurable sets is measurable.

**Proof.** It is enough to prove that the finite union of measurable sets is measurable, since we can then use De Morgan's law:

$$\left(\bigcup_{k=1}^{n} E_k^{c}\right)^{c} = \bigcap_{k=1}^{n} E_k.$$

Claim: If $E_1$ and $E_2$ are measurable, then $E_1 \cup E_2$ is measurable.

Goal: for every $A \subseteq \mathbb{R}$,

$$m^{*}(A) \geq m^{*}\big(A \cap (E_1 \cup E_2)\big) + m^{*}\big(A \cap (E_1 \cup E_2)^{c}\big).$$

Let $A \subseteq \mathbb{R}$. Since $E_1$ and $E_2$ are measurable, for every $B \subseteq \mathbb{R}$,

$$m^{*}(B) = m^{*}(B \cap E_1) + m^{*}(B \cap E_1^{c}) \tag{1}$$

$$m^{*}(B) = m^{*}(B \cap E_2) + m^{*}(B \cap E_2^{c}) \tag{2}$$

By (1) with $B = A$, we get

$$m^{*}(A) = m^{*}(A \cap E_1) + m^{*}(A \cap E_1^{c}) \tag{3}$$

Now we write (2) with $B = A \cap E_1^{c}$:

$$m^{*}(A \cap E_1^{c}) = m^{*}(A \cap E_1^{c} \cap E_2) + m^{*}\big(A \cap (E_1^{c} \cap E_2^{c})\big) = m^{*}(A \cap E_1^{c} \cap E_2) + m^{*}\big(A \cap (E_1 \cup E_2)^{c}\big).$$

Substituting this into (3), we obtain

$$m^{*}(A) = \underbrace{m^{*}(A \cap E_1) + m^{*}(A \cap E_1^{c} \cap E_2)}_{\geq\ m^{*}(A \cap (E_1 \cup E_2))} + m^{*}\big(A \cap (E_1 \cup E_2)^{c}\big),$$

because

$$(A \cap E_1) \cup (A \cap E_1^{c} \cap E_2) = A \cap (E_1 \cup E_2),$$

and by finite subadditivity,

$$m^{*}\big(A \cap (E_1 \cup E_2)\big) \leq m^{*}(A \cap E_1) + m^{*}(A \cap E_1^{c} \cap E_2).$$

Hence

$$m^{*}(A) \geq m^{*}\big(A \cap (E_1 \cup E_2)\big) + m^{*}\big(A \cap (E_1 \cup E_2)^{c}\big).$$

For a general $n$, use induction: for a collection of $n + 1$ measurable sets,

$$\bigcup_{k=1}^{n+1} E_k = \underbrace{\bigcup_{k=1}^{n} E_k}_{\text{measurable}} \cup \underbrace{E_{n+1}}_{\text{measurable}},$$

which is measurable by the two-set result. By PMI, we have the desired conclusion. ∎

### Proposition

The union and intersection of a countable collection of measurable sets is measurable.

**Proof.** Similar to the previous proof; we only prove that the union is measurable.

Let $\{A_k\}_{k=1}^{\infty}$ be a countable collection of measurable sets and set

$$E = \bigcup_{k=1}^{\infty} A_k.$$

We construct a disjoint collection $\{E_k\}_{k=1}^{\infty}$ of measurable sets such that $E = \bigcup_{k=1}^{\infty} E_k$:

$$E_1 = A_1, \qquad E_2 = A_2 \setminus A_1, \qquad E_3 = A_3 \setminus (A_1 \cup A_2), \qquad \ldots,$$

$$E_k = A_k \setminus \left(\bigcup_{j=1}^{k-1} A_j\right), \quad k \geq 2.$$

For every $k \in \mathbb{N}$, $E_k$ is a difference of measurable sets, hence measurable.

Goal: for every $A \subseteq \mathbb{R}$,

$$m^{*}(A) \geq m^{*}(A \cap E) + m^{*}(A \cap E^{c}).$$

Let $A \subseteq \mathbb{R}$ and define, for each $n \in \mathbb{N}$, $F_n = \bigcup_{k=1}^{n} E_k$. Since $F_n$ is a finite union of measurable sets, $F_n$ is measurable. Then

$$m^{*}(A) = m^{*}(A \cap F_n) + m^{*}(A \cap F_n^{c}) \tag{4}$$

with $m^{*}(A \cap F_n^{c}) \geq m^{*}(A \cap E^{c})$, because $F_n \subseteq E$ implies $F_n^{c} \supseteq E^{c}$. By (4),

$$m^{*}(A) \geq m^{*}(A \cap F_n) + m^{*}(A \cap E^{c}).$$

By finite additivity,

$$m^{*}(A \cap F_n) = m^{*}\!\left(A \cap \bigcup_{k=1}^{n} E_k\right) = m^{*}\!\left(\bigcup_{k=1}^{n} (A \cap E_k)\right) = \sum_{k=1}^{n} m^{*}(A \cap E_k).$$

It follows that

$$m^{*}(A) \geq \sum_{k=1}^{n} m^{*}(A \cap E_k) + m^{*}(A \cap E^{c}).$$

The limit of the sequence of partial sums as $n \to \infty$ exists by the Monotone Convergence Theorem (or its analog for properly divergent sequences). Taking the limit,

$$m^{*}(A) \geq \sum_{k=1}^{\infty} m^{*}(A \cap E_k) + m^{*}(A \cap E^{c}). \tag{5}$$

Moreover, by countable subadditivity,

$$m^{*}(A \cap E) = m^{*}\!\left(A \cap \bigcup_{k=1}^{\infty} E_k\right) = m^{*}\!\left(\bigcup_{k=1}^{\infty} (A \cap E_k)\right) \leq \sum_{k=1}^{\infty} m^{*}(A \cap E_k).$$

Finally, by (5),

$$m^{*}(A) \geq m^{*}(A \cap E) + m^{*}(A \cap E^{c}). \quad \blacksquare$$

---

### Definition: Lebesgue Measure

The restriction of the outer measure $m^{*}$ to the class of measurable sets is called the **(Lebesgue) measure**. It is denoted by $m$; that is, if $E$ is measurable, then

$$m(E) = m^{*}(E).$$

### Notes

- $m$ is translation invariant.
- $m([0,1]) = 1$.

### Proposition: Countable Additivity of the Lebesgue Measure

The Lebesgue measure is countably additive: if $\{E_k\}_{k=1}^{\infty}$ is a countable collection of pairwise disjoint measurable sets, then its union is measurable and

$$m\!\left(\bigcup_{k=1}^{\infty} E_k\right) = \sum_{k=1}^{\infty} m(E_k).$$

**Proof.** The union of the $E_k$'s is measurable by the previous proposition.

By countable subadditivity,

$$m\!\left(\bigcup_{k=1}^{\infty} E_k\right) \leq \sum_{k=1}^{\infty} m(E_k).$$

It remains to show the reverse inequality. Let $n \in \mathbb{N}$. Then

$$\bigcup_{k=1}^{n} E_k \subseteq \bigcup_{k=1}^{\infty} E_k \quad \Longrightarrow \quad m\!\left(\bigcup_{k=1}^{n} E_k\right) \leq m\!\left(\bigcup_{k=1}^{\infty} E_k\right)$$

$$\overset{\text{finite additivity}}{\Longrightarrow} \quad \sum_{k=1}^{n} m(E_k) \leq m\!\left(\bigcup_{k=1}^{\infty} E_k\right).$$

Taking the limit as $n \to \infty$, we get

$$\sum_{k=1}^{\infty} m(E_k) \leq m\!\left(\bigcup_{k=1}^{\infty} E_k\right).$$

This proves the countable additivity of $m$. ∎

### Proposition

The interval $(a, +\infty)$ is measurable, for every $a \in \mathbb{R}$.

**Proof.** Let $a \in \mathbb{R}$. We want to show that, for every $A \subseteq \mathbb{R}$,

$$m^{*}(A) \geq m^{*}\big(A \cap (a, +\infty)\big) + m^{*}\big(A \cap (a, +\infty)^{c}\big).$$

Let $A_1 = A \cap (a, +\infty)$ and $A_2 = A \cap (a, +\infty)^{c}$. Our goal is to prove

$$m^{*}(A) = \inf \Sigma_A \geq m^{*}(A_1) + m^{*}(A_2).$$

It suffices to show that $m^{*}(A_1) + m^{*}(A_2)$ is a lower bound of $\Sigma_A$; that is,

$$r \geq m^{*}(A_1) + m^{*}(A_2), \quad \text{for all } r \in \Sigma_A.$$

Let $r \in \Sigma_A$. Then there exists a collection of open and bounded intervals $\{I_k\}$ such that

$$A \subseteq \bigcup_{k=1}^{\infty} I_k \quad \text{and} \quad \sum_{k=1}^{\infty} \ell(I_k) = r.$$

Let $I'\_{k} = I_k \cap (a, +\infty)$ and $I''\_{k} = I_k \cap (-\infty, a]$. Then $I'\_{k}$ and $I''\_{k}$ are disjoint bounded intervals such that

$$I_k = I'\_{k} \cup I''\_{k} \quad \text{and} \quad \ell(I_k) = \ell(I'\_{k}) + \ell(I''\_{k}).$$

So

$$A_1 = A \cap (a, +\infty) \subseteq \left(\bigcup_{k=1}^{\infty} I_k\right) \cap (a, +\infty) = \bigcup_{k=1}^{\infty} I'\_{k},$$

$$A_2 = A \cap (-\infty, a] \subseteq \left(\bigcup_{k=1}^{\infty} I_k\right) \cap (-\infty, a] = \bigcup_{k=1}^{\infty} I''\_{k}.$$

By monotonicity and countable subadditivity of $m^{*}$,

$$m^{*}(A_1) \leq m^{*}\!\left(\bigcup_{k=1}^{\infty} I'\_{k}\right) \leq \sum_{k=1}^{\infty} m^{*}(I'\_{k}) = \sum_{k=1}^{\infty} \ell(I'\_{k}).$$

Similarly,

$$m^{*}(A_2) \leq \sum_{k=1}^{\infty} \ell(I''\_{k}).$$

Then

$$m^{*}(A_1) + m^{*}(A_2) \leq \sum_{k=1}^{\infty} \ell(I'\_{k}) + \sum_{k=1}^{\infty} \ell(I''\_{k}) = \sum_{k=1}^{\infty} \ell(I_k) = r. \quad \blacksquare$$

**Seatwork:** Use all the stated results in class to prove that, for all $a, b \in \mathbb{R}$ with $a < b$, the interval $(a, b]$ is measurable.

### Remarks

- Every interval is measurable.
- Since every open set is a disjoint countable union of open intervals, every open set is measurable.
- Note that a closed set is the complement of an open set, so every closed set is measurable.
- These imply that every countable intersection of open sets (called **$G_{\delta}$ sets**) and every countable union of closed sets (called **$F_{\sigma}$ sets**) are measurable.
- The excision property still holds for the measure $m$: for any measurable sets $A, B$ such that $B \subseteq A$ with $m(B) < \infty$,

$$m(A \setminus B) = m(A) - m(B).$$

**Exercise:** The translate of a measurable set is also measurable.

---

## 2.1 Nonmeasurable Sets

### Lemma

Let $E$ be a bounded measurable set. Suppose there is a bounded countably infinite set of real numbers $\Lambda$ for which the collection of translates $\{\lambda + E\}_{\lambda \in \Lambda}$ is disjoint. Then $m(E) = 0$.

**Proof.** Let $E$ be a measurable, bounded set, and let $\Lambda$ be a bounded countably infinite set of real numbers such that $\{\lambda + E\}_{\lambda \in \Lambda}$ is disjoint.

By the exercise, $\lambda + E$ is measurable for every $\lambda \in \Lambda$, with $m(\lambda + E) = m(E)$.

Claim: $\bigcup_{\lambda \in \Lambda} (\lambda + E)$ is bounded; that is, there exists $M > 0$ such that

$$|\lambda + x| \leq M, \quad \text{for all } \lambda \in \Lambda \text{ and all } x \in E.$$

Indeed, since $E$ and $\Lambda$ are bounded, there exist $M_E, M_{\Lambda} > 0$ such that $|\lambda| \leq M_{\Lambda}$ and $|x| \leq M_E$. Then

$$|\lambda + x| \leq |\lambda| + |x| \leq M_{\Lambda} + M_E.$$

Taking $M = M_{\Lambda} + M_E$ proves the claim. Hence

$$\bigcup_{\lambda \in \Lambda} (\lambda + E) \subseteq [-M, M] \quad \overset{\text{monotonicity}}{\Longrightarrow} \quad m\!\left(\bigcup_{\lambda \in \Lambda} (\lambda + E)\right) \leq m([-M, M]) = 2M < \infty.$$

By countable additivity of $m$,

$$m\!\left(\bigcup_{\lambda \in \Lambda} (\lambda + E)\right) = \sum_{\lambda \in \Lambda} m(\lambda + E) = \sum_{\lambda \in \Lambda} m(E) < \infty.$$

If $m(E) > 0$, this is impossible. Therefore $m(E) = 0$. ∎

### Rational Equivalence on $E$

Let $E \subseteq \mathbb{R}$, $E \neq \varnothing$. Define the equivalence relation $\sim$ on $E$ by

$$x \sim y \quad \Longleftrightarrow \quad x - y \in \mathbb{Q}, \qquad \forall x, y \in E.$$

(One can show that $\sim$ is indeed an equivalence relation on $E$.) We can then form the set of equivalence classes $E / {\sim}$. By the axiom of choice, we can form the choice set $C_E$ containing exactly one element of each equivalence class.

### Properties of the Choice Set $C_E$

- If $a, b \in C_E$ with $a \neq b$, then $a - b \notin \mathbb{Q}$, and hence $\{q + C_E\}_{q \in \mathbb{Q}}$ is a disjoint collection.
- For any $x \in E$, there exist $c \in C_E$ and $q \in \mathbb{Q}$ such that $x = c + q$.

### Theorem: Vitali

Any bounded set $E$ of real numbers with positive measure contains a subset that fails to be measurable.

**Proof.** Let $E$ be a bounded measurable set and form its choice set $C_E$. We proceed by contradiction and suppose $C_E$ is measurable.

Since $C_E \subseteq E$ and $E$ is bounded, $C_E$ is bounded. By the previous lemma, for any bounded subset $\Lambda$ of $\mathbb{Q}$, since $\{\lambda + C_E\}_{\lambda \in \Lambda}$ is disjoint, we conclude that $m(C_E) = 0$.

To arrive at a contradiction, we need to choose $\Lambda \subseteq \mathbb{Q}$ such that

$$E \subseteq \bigcup_{\lambda \in \Lambda} (\lambda + C_E).$$

If such a $\Lambda$ exists, then

$$0 < m(E) \leq m\!\left(\bigcup_{\lambda \in \Lambda} (\lambda + C_E)\right) = \sum_{\lambda \in \Lambda} m(\lambda + C_E) = \sum_{\lambda \in \Lambda} m(C_E) = 0,$$

a contradiction.

Take $\Lambda = \mathbb{Q} \cap [-2b, 2b]$. Let $x \in E$. By the second property of $C_E$, there exist $c \in C_E \subseteq E$ and $q \in \mathbb{Q}$ such that $x = c + q$. Then $q = x - c$. Since $E$ is bounded, there exists $b > 0$ such that $|x| \leq b$ and $|c| \leq b$, so

$$|q| = |x - c| \leq |x| + |c| \leq b + b = 2b.$$

Thus for every $x \in E$ there exist $\lambda \in \Lambda$ and $c \in C_E$ such that $x = \lambda + c$, so

$$E \subseteq \bigcup_{\lambda \in \Lambda} (\lambda + C_E).$$

This yields the contradiction. Therefore $C_E$ is not measurable. ∎

**Q:** Does a set of measure zero have a nonmeasurable subset?

**A:** No.

**R:** Since every subset of a set of measure zero has outer measure zero, every subset of a set of measure zero is measurable.

**Q:** Does an unbounded set have a nonmeasurable subset?

**A:** Yes.

**R:** Take a bounded subset of the unbounded set with positive measure. That bounded set has a nonmeasurable subset.

### Theorem: Continuity of Measure

1. If $\{A_k\}_{k=1}^{\infty}$ is an ascending collection of measurable sets, i.e.

$$A_k \subseteq A_{k+1}, \quad \forall k \in \mathbb{N},$$

then

$$m\!\left(\bigcup_{k=1}^{\infty} A_k\right) = \lim_{n \to \infty} m(A_n).$$

2. If $\{B_k\}_{k=1}^{\infty}$ is a descending collection of measurable sets, i.e.

$$B_{k+1} \subseteq B_k, \quad \forall k \in \mathbb{N},$$

and $m(B_1) < \infty$, then

$$m\!\left(\bigcap_{k=1}^{\infty} B_k\right) = \lim_{n \to \infty} m(B_n).$$

**Proof.** (1) Let $\{A_k\}_{k=1}^{\infty}$ be an ascending collection of measurable sets.

*Case 1.* There exists $k_0 \in \mathbb{N}$ with $m(A_{k_0}) = +\infty$. Then $m(A_k) = +\infty$ for all $k \geq k_0$, since $A_{k_0} \subseteq A_k$. Thus the $k_0$-tail of $\{m(A_k)\}_{k=1}^{\infty}$ is constantly $+\infty$, so

$$\lim_{n \to \infty} m(A_n) = +\infty.$$

Moreover,

$$m\!\left(\bigcup_{k=1}^{\infty} A_k\right) \geq m(A_{k_0}) = +\infty,$$

so

$$m\!\left(\bigcup_{k=1}^{\infty} A_k\right) = +\infty = \lim_{n \to \infty} m(A_n).$$

*Case 2.* Suppose $m(A_k) < \infty$ for all $k \in \mathbb{N}$. Let $A_0 = \varnothing$ and set $C_k = A_k \setminus A_{k-1}$ for all $k \in \mathbb{N}$. Then

$$\bigcup_{k=1}^{\infty} A_k = \bigcup_{k=1}^{\infty} C_k,$$

where $\{C_k\}$ is a disjoint collection of measurable sets. By countable subadditivity,

$$m\!\left(\bigcup_{k=1}^{\infty} A_k\right) = m\!\left(\bigcup_{k=1}^{\infty} C_k\right) = \sum_{k=1}^{\infty} m(C_k).$$

By the excision property,

$$m(C_k) = m(A_k) - m(A_{k-1}), \quad \forall k \in \mathbb{N}.$$

Thus

$$m\!\left(\bigcup_{k=1}^{\infty} A_k\right) = \sum_{k=1}^{\infty} \big(m(A_k) - m(A_{k-1})\big) = \lim_{n \to \infty} \sum_{k=1}^{n} \big(m(A_k) - m(A_{k-1})\big) = \lim_{n \to \infty} \big(m(A_n) - \underbrace{m(A_0)}_{= 0}\big) = \lim_{n \to \infty} m(A_n).$$

(2) Let $\{B_k\}$ be a descending collection of measurable sets with $m(B_1) < \infty$. Define $D_k = B_1 \setminus B_k$ for all $k \in \mathbb{N}$.

Claim: $\{D_k\}$ is an ascending collection of measurable sets. Each $D_k$ is measurable since $B_1$ and $B_k$ are measurable. Moreover, since

$$B_{k+1} \subseteq B_k,$$

$$B_{k+1}^{c} \supseteq B_k^{c},$$

$$B_1 \cap B_{k+1}^{c} \supseteq B_1 \cap B_k^{c},$$

we have $D_{k+1} \supseteq D_k$ for all $k \in \mathbb{N}$.

By part (1),

$$m\!\left(\bigcup_{k=1}^{\infty} D_k\right) = \lim_{n \to \infty} m(D_n).$$

Observe that

$$m\!\left(\bigcup_{k=1}^{\infty} D_k\right) = m\!\left(\bigcup_{k=1}^{\infty} (B_1 \cap B_k^{c})\right) = m\!\left(B_1 \cap \bigcup_{k=1}^{\infty} B_k^{c}\right) = m\!\left(B_1 \setminus \bigcap_{k=1}^{\infty} B_k\right) = m(B_1) - m\!\left(\bigcap_{k=1}^{\infty} B_k\right),$$

by the excision property, since $m(B_1) < \infty$ and $\bigcap_{k=1}^{\infty} B_k \subseteq B_1$.

Also, $B_k \subseteq B_1$ implies $m(B_k) < \infty$ for all $k \in \mathbb{N}$. Then

$$\lim_{n \to \infty} m(D_n) = \lim_{n \to \infty} m(B_1 \setminus B_n) = \lim_{n \to \infty} \big(m(B_1) - m(B_n)\big) = m(B_1) - \lim_{n \to \infty} m(B_n).$$

Thus

$$m(B_1) - m\!\left(\bigcap_{k=1}^{\infty} B_k\right) = m(B_1) - \lim_{n \to \infty} m(B_n),$$

so

$$m\!\left(\bigcap_{k=1}^{\infty} B_k\right) = \lim_{n \to \infty} m(B_n). \quad \blacksquare$$

**Exercise:** Find a descending collection $\{B_k\}$ of measurable sets with $m(B_1) = +\infty$ such that

$$m\!\left(\bigcap_{k=1}^{\infty} B_k\right) \neq \lim_{n \to \infty} m(B_n).$$

---

## 2.2 The Cantor Set

Consider $I = [0, 1]$. To construct $C_1$, decompose $I$ into

$$[0, \tfrac{1}{3}], \qquad \left(\tfrac{1}{3}, \tfrac{2}{3}\right), \qquad [\tfrac{2}{3}, 1],$$

and let $C_1 = [0, \frac{1}{3}] \cup [\frac{2}{3}, 1]$. Note that $C_1$ is a disjoint union of two closed intervals of length $\frac{1}{3}$. Moreover, $C_1$ is closed and hence measurable.

We construct $C_2$ by dividing the two intervals into thirds:

$$[0, \tfrac{1}{9}], \quad \left(\tfrac{1}{9}, \tfrac{2}{9}\right), \quad [\tfrac{2}{9}, \tfrac{1}{3}] \qquad \text{and} \qquad [\tfrac{2}{3}, \tfrac{7}{9}], \quad \left(\tfrac{7}{9}, \tfrac{8}{9}\right), \quad [\tfrac{8}{9}, 1].$$

Let $C_2 = [0, \frac{1}{9}] \cup [\frac{2}{9}, \frac{1}{3}] \cup [\frac{2}{3}, \frac{7}{9}] \cup [\frac{8}{9}, 1]$. Then $C_2$ is closed and measurable, and it is the disjoint union of $2^2$ intervals of length $\frac{1}{3^2}$.

Continuing the process, we obtain a collection $\{C_n\}$ of closed, measurable sets such that $C_n$ is a disjoint union of $2^n$ intervals of length $\frac{1}{3^n}$. Furthermore, $\{C_n\}$ is a descending collection of measurable sets.

The **Cantor set** is

$$C = \bigcap_{n=1}^{\infty} C_n.$$

### Proposition: The Cantor Set

The Cantor set $C$ is measurable with measure zero, and it is uncountable.

**Proof.** Since $C$ is a countable intersection of measurable sets, $C$ is measurable.

To prove that it has measure zero, note that

$$m(C_1) = \frac{2}{3} < \infty,$$

and so, by continuity of measure,

$$m(C) = m\!\left(\bigcap_{n=1}^{\infty} C_n\right) = \lim_{n \to \infty} m(C_n) = \lim_{n \to \infty} 2^{n} \cdot \frac{1}{3^{n}} = \lim_{n \to \infty} \left(\frac{2}{3}\right)^{n} = 0.$$

To show that $C$ is uncountable, we establish a bijection from $C$ to an uncountable set $M$. Let $M$ be the set of all sequences of 0's and 1's:

$$M = \{\{a_n\} : a_n = 0 \text{ or } a_n = 1\}.$$

We interpret elements of $M$ as "locations" of elements of $C$, assigning left to 0 and right to 1. By the Nested Interval Property, each such sequence determines a unique element of $C$:

$$\{0, 0, 0, 0, 0, \ldots\} \mapsto 0 \qquad \{1, 1, 1, 1, 1, \ldots\} \mapsto 1.$$

One can show that this is a bijection from $M$ to $C$.

To show that $M$ is uncountable, suppose for contradiction that $M$ is countable:

$$M = \{\{a_n^{k}\}_{n=1}^{\infty} : k \in \mathbb{N}\}.$$

Consider the sequence $\{b_n\}$ with

$$b_n = \begin{cases} 1, & \text{if } a_n^{n} = 0, \\ 0, & \text{if } a_n^{n} = 1. \end{cases}$$

Then $\{b_n\}_{n=1}^{\infty} \neq \{a_n^{k}\}_{n=1}^{\infty}$ for every $k \in \mathbb{N}$, yet $\{b_n\} \in M$, a contradiction. Therefore $M$ is uncountable. ∎

---

# 3. Measurable Functions

---

### Proposition: Equivalent Descriptions of Measurability

Let $f$ be a function with a measurable domain $E$. Then the following are equivalent:

1. $\{x \in E : f(x) < a\}$ is measurable for every $a \in \mathbb{R}$.
2. $\{x \in E : f(x) \leq b\}$ is measurable for every $b \in \mathbb{R}$.
3. $\{x \in E : f(x) > c\}$ is measurable for every $c \in \mathbb{R}$.
4. $\{x \in E : f(x) \geq d\}$ is measurable for every $d \in \mathbb{R}$.

Furthermore, each of the statements above implies that, for any $z \in [-\infty, +\infty]$,

$$\{x \in E : f(x) = z\} \text{ is measurable}.$$

**Proof.** We know that (1) $\iff$ (4) and (2) $\iff$ (3), since these pairs are complements of each other. It remains to prove (3) $\iff$ (4).

**(3) $\Rightarrow$ (4).** Suppose $\{x \in E : f(x) > c\}$ is measurable for every $c \in \mathbb{R}$. Let $d \in \mathbb{R}$. We want to express

$$\{x \in E : f(x) \geq d\}$$

as a countable union or intersection of sets of the form $\{x \in E : f(x) > c\}$.

Claim:

$$\underset{A}{\{x \in E : f(x) \geq d\}} = \bigcap_{k=1}^{\infty} \underset{B_k}{\{x \in E : f(x) > d - \frac{1}{k}\}}.$$

Let $x \in A$. Then $f(x) \geq d > d - \frac{1}{k}$ for every $k \in \mathbb{N}$, so $x \in B_k$ for all $k$, i.e. $x \in \bigcap_{k=1}^{\infty} B_k$.

Conversely, let $x \in \bigcap_{k=1}^{\infty} B_k$. Then for every $k \in \mathbb{N}$,

$$f(x) > d - \frac{1}{k}. \tag{1}$$

We show $f(x) \geq d$ by contradiction. Suppose $f(x) < d$; then $d - f(x) > 0$. By the Archimedean property there exists $n \in \mathbb{N}$ such that $\frac{1}{n} < d - f(x)$, i.e. $f(x) < d - \frac{1}{n}$, contradicting (1). Hence $f(x) \geq d$, so $x \in A$.

Thus $A = \bigcap_{k=1}^{\infty} B_k$ is a countable intersection of measurable sets, hence measurable.

**(4) $\Rightarrow$ (3).** Suppose $\{x \in E : f(x) \geq d\}$ is measurable for every $d \in \mathbb{R}$. We write

$$\{x \in E : f(x) > c\}, \qquad c \in \mathbb{R},$$

as a countable union of sets of the form $\{x \in E : f(x) \geq d\}$.

Claim:

$$\underset{C}{\{x \in E : f(x) > c\}} = \bigcup_{k=1}^{\infty} \underset{D_k}{\{x \in E : f(x) \geq c + \frac{1}{k}\}}.$$

Let $x \in C$. Then $f(x) > c$. Since $f(x) - c > 0$, by the Archimedean property there exists $n \in \mathbb{N}$ with $\frac{1}{n} < f(x) - c$. Then $f(x) > c + \frac{1}{n}$, so $x \in D_n \subseteq \bigcup_{k=1}^{\infty} D_k$.

Conversely, let $x \in \bigcup_{k=1}^{\infty} D_k$. Then $x \in D_m$ for some $m$, so $f(x) \geq c + \frac{1}{m} > c$, giving $x \in C$.

Hence $C = \bigcup_{k=1}^{\infty} D_k$ is a countable union of measurable sets, so $C$ is measurable.

This proves (3) $\iff$ (4), and therefore all four statements are equivalent.

To prove the additional assertion, let $z \in [-\infty, +\infty]$.

*Case 1: $z \in \mathbb{R}$.*

$$\{x \in E : f(x) = z\} = \underset{\text{measurable}}{\{x \in E : f(x) \geq z\}} \cap \underset{\text{measurable}}{\{x \in E : f(x) \leq z\}}.$$

*Case 2: $z = +\infty$.*

$$\underset{\mathcal{E}}{\{x \in E : f(x) = +\infty\}} = \bigcap_{k=1}^{\infty} \underset{F_k}{\{x \in E : f(x) > k\}}.$$

If $x \in \mathcal{E}$, then $f(x) = +\infty > k$ for every $k \in \mathbb{N}$, so $x \in \bigcap_{k=1}^{\infty} F_k$. Conversely, let $x \in \bigcap_{k=1}^{\infty} F_k$. Then $f(x) > k$ for every $k \in \mathbb{N}$. If $f(x) < \infty$, then $f(x) \in \mathbb{R}$, and by the Archimedean property there exists $n \in \mathbb{N}$ with $f(x) < n$, a contradiction. Hence $f(x) = +\infty$. (It is impossible that $f(x) = -\infty$, since $f(x) > k$ for every $k$.)

*Case 3: $z = -\infty$.*

$$\underset{G}{\{x \in E : f(x) = -\infty\}} = \bigcap_{k=1}^{\infty} \underset{H_k}{\{x \in E : f(x) < -k\}}.$$

If $x \in G$, then $f(x) = -\infty < -k$ for every $k \in \mathbb{N}$, so $x \in \bigcap_{k=1}^{\infty} H_k$. Conversely, let $x \in \bigcap_{k=1}^{\infty} H_k$. Then $f(x) < -k$ for every $k \in \mathbb{N}$. If $f(x) \neq -\infty$, then $f(x) \in \mathbb{R}$, so $-f(x) \in \mathbb{R}$. By the Archimedean property there exists $n \in \mathbb{N}$ with $-f(x) < n$, i.e. $f(x) > -n$, a contradiction. Hence $f(x) = -\infty$.

In all cases we expressed $\{x \in E : f(x) = z\}$ as a countable intersection of measurable sets, so it is measurable. ∎

### Definition: Measurable Function

A function $f : E \to [-\infty, +\infty]$ is said to be **Lebesgue measurable**, or simply **measurable**, provided its domain is measurable and it satisfies one of the four statements in the previous proposition.

### Proposition: Measurability and Open Sets

Let the function $f$ be defined on a measurable set $E$. Then $f$ is measurable if and only if, for each open set $O$, its inverse image under $f$,

$$f^{-1}(O) = \{x \in E : f(x) \in O\},$$

is measurable.

**Proof.** **($\Rightarrow$)** Suppose $f$ is measurable. Let $O$ be an open set. Every open set in $\mathbb{R}$ is a countable union of disjoint open intervals, so write

$$O = \bigcup_{k=1}^{\infty} (a_k, b_k),$$

where $a_k < b_k$ for every $k \in \mathbb{N}$. Then

$$f^{-1}(O) = f^{-1}\left(\bigcup_{k=1}^{\infty} (a_k, b_k)\right) = \bigcup_{k=1}^{\infty} f^{-1}\big((a_k, b_k)\big) = \bigcup_{k=1}^{\infty} \{x \in E : a_k < f(x) < b_k\}$$

$$= \bigcup_{k=1}^{\infty} \left(\underset{\text{measurable}}{\{x \in E : a_k < f(x)\}} \cap \underset{\text{measurable}}{\{x \in E : f(x) < b_k\}}\right).$$

Since each set in the union is measurable, $f^{-1}(O)$ is measurable.

**($\Leftarrow$)** Suppose that for every open set $O$, $f^{-1}(O)$ is measurable. We show that $\{x \in E : f(x) > c\}$ is measurable for every $c \in \mathbb{R}$. Take $O = (c, +\infty)$, which is open. Then

$$f^{-1}(O) = \{x \in E : f(x) \in (c, +\infty)\} = \{x \in E : f(x) > c\}$$

is measurable by hypothesis. Therefore $f$ is measurable. ∎

### Lemma

Let $f$ be a real-valued function defined on a set $E$ of real numbers. Then $f$ is continuous on $E$ if and only if, for any open set $O$, there is an open set $U$ such that

$$f^{-1}(O) = E \cap U.$$

### Proposition

A real-valued function $f$ that is continuous on its measurable domain is measurable.

**Proof.** Follows from the previous proposition and lemma. ∎

### Theorem: Absolute Value of a Measurable Function

If $f : E \to [-\infty, +\infty]$ is measurable, then $|f|$ is measurable with domain $E$.

**Proof.** Let $f$ be measurable with domain $E$. Let $c \in \mathbb{R}$. If $c \geq 0$,

$$\{x \in E : |f(x)| > c\} = \{x \in E : f(x) > c\} \cup \{x \in E : f(x) < -c\}.$$

Since $f$ is measurable, the two sets on the right are measurable, so their union is measurable.

If $c < 0$, then

$$\{x \in E : |f(x)| > c\} = E,$$

which is measurable.

Therefore $|f|$ is measurable. ∎

### Definition: Limit Superior and Limit Inferior

Let $\{c_n\}$ be a sequence of real numbers, and define

$$a_n = \inf\{c_k : k \geq n\}, \qquad b_n = \sup\{c_k : k \geq n\}.$$

- The **limit inferior** of $\{c_n\}$ is

$$\liminf_{n \to \infty} c_n = \lim_{n \to \infty} a_n = \lim_{n \to \infty} \big(\inf\{c_k : k \geq n\}\big).$$

- The **limit superior** of $\{c_n\}$ is

$$\limsup_{n \to \infty} c_n = \lim_{n \to \infty} b_n = \lim_{n \to \infty} \big(\sup\{c_k : k \geq n\}\big).$$

### Remarks

- If $\{c_n\}$ is unbounded, then $\{a_n\}$ or $\{b_n\}$ is a sequence in the extended real numbers.
- For every $n \in \mathbb{N}$,

$$\{c_k : k \geq n\} \supseteq \{c_k : k \geq n + 1\}$$

$$\Longrightarrow a_n \leq a_{n+1} \quad \text{and} \quad b_n \geq b_{n+1}.$$

So $\{a_n\}$ is increasing and $\{b_n\}$ is decreasing. By the Monotone Convergence Theorem,

$$\liminf_{n \to \infty} c_n = \lim_{n \to \infty} a_n = \sup_{n \in \mathbb{N}} \big(\inf_{k \geq n} c_k\big),$$

$$\limsup_{n \to \infty} c_n = \lim_{n \to \infty} b_n = \inf_{n \in \mathbb{N}} \big(\sup_{k \geq n} c_k\big).$$

- $\liminf_{n \to \infty} c_n$ and $\limsup_{n \to \infty} c_n$ always exist in the extended real numbers.
- $\lim_{n \to \infty} c_n$ exists $\iff$ $\limsup_{n \to \infty} c_n = \liminf_{n \to \infty} c_n$.

### Theorem: Sup, Inf, Limsup, Liminf of Measurable Functions

Let $\{f_n\}$ be a sequence of measurable functions on a domain $E$. For $x \in E$, set

$$g_1(x) = \sup_{n \in \mathbb{N}} f_n(x), \qquad g_2(x) = \inf_{n \in \mathbb{N}} f_n(x),$$

$$h_1(x) = \limsup_{n \to \infty} f_n(x), \qquad h_2(x) = \liminf_{n \to \infty} f_n(x).$$

Then $g_1, g_2, h_1,$ and $h_2$ are measurable functions.

**Proof.** By the definitions of $\liminf$ and $\limsup$, it is enough to show that $g_1$ and $g_2$ are measurable.

Let $c \in \mathbb{R}$. We show that

$$\{x \in E : g_1(x) > c\} \quad \text{and} \quad \{x \in E : g_2(x) < c\}$$

are measurable.

Claim:

$$\underset{A}{\{x \in E : g_1(x) > c\}} = \bigcup_{n=1}^{\infty} \underset{B_n}{\{x \in E : f_n(x) > c\}}, \qquad \{x \in E : g_2(x) < c\} = \bigcup_{n=1}^{\infty} \{x \in E : f_n(x) < c\}.$$

For every $n \in \mathbb{N}$, $B_n$ is measurable since $f_n$ is measurable.

Let $x \in A$. Then $g_1(x) = \sup_{n \in \mathbb{N}} f_n(x) > c$. Since the supremum is the least upper bound, $c$ is *not* an upper bound of $\{f_n(x) : n \in \mathbb{N}\}$, so there exists $m \in \mathbb{N}$ with $f_m(x) > c$, i.e. $x \in B_m \subseteq \bigcup_{n=1}^{\infty} B_n$.

Conversely, let $x \in \bigcup_{n=1}^{\infty} B_n$. Then $x \in B_k$ for some $k$, so $f_k(x) > c$. Hence

$$c < f_k(x) \leq \sup_{n \in \mathbb{N}} f_n(x) = g_1(x),$$

so $x \in A$.

Thus $A = \bigcup_{n=1}^{\infty} B_n$ is a countable union of measurable sets, hence measurable, so $g_1$ is measurable. By similar arguments, $g_2$ is also measurable. ∎

### Corollary

If $f$ and $g$ are measurable functions, then $\max\{f, g\}$ and $\min\{f, g\}$ are measurable. In particular,

$$f^{+} = \max\{f, 0\} \quad \text{and} \quad f^{-} = \min\{f, 0\}$$

are measurable.

### Theorem: Sum and Product of Measurable Functions

Let $f$ and $g$ be measurable real-valued functions defined on a domain $E$.

1. For any $\alpha, \beta \in \mathbb{R}$, $\alpha f + \beta g$ is measurable.
2. The product $fg$ is measurable.

**Proof.** (1) Let $f$ and $g$ be measurable real-valued functions on $E$, and let $\alpha \in \mathbb{R}$. We first show that $\alpha f$ is measurable.

- *Case 1: $\alpha = 0$.* Then $\alpha f \equiv 0$ on $E$, which is continuous on $E$, hence measurable.
- *Case 2: $\alpha > 0$.* Let $c \in \mathbb{R}$. Then

$$\{x \in E : \alpha f(x) > c\} = \underset{\text{measurable, since } f \text{ measurable}}{\{x \in E : f(x) > \tfrac{c}{\alpha}\}},$$

so $\alpha f$ is measurable.
- *Case 3: $\alpha < 0$.*

$$\{x \in E : \alpha f(x) > c\} = \{x \in E : f(x) < \tfrac{c}{\alpha}\},$$

which is measurable by measurability of $f$.

Thus $\alpha f$ is measurable for every $\alpha \in \mathbb{R}$ and every measurable $f$. To prove that $\alpha f + \beta g$ is measurable, it suffices to show that the sum of two measurable functions is measurable.

Let $c \in \mathbb{R}$. We show $\{x \in E : f(x) + g(x) < c\}$ is measurable. Claim:

$$\underset{C}{\{x \in E : f(x) + g(x) < c\}} = \bigcup_{q \in \mathbb{Q}} \underset{D_q}{\left(\{x \in E : f(x) < q\} \cap \{x \in E : g(x) < c - q\}\right)}.$$

Once the claim is proved we are done, since $\{x \in E : f(x) < q\}$ and $\{x \in E : g(x) < c - q\}$ are measurable for every $q \in \mathbb{Q}$, and the countable union (over $\mathbb{Q}$) of measurable sets is measurable.

Let $x \in C$. Then $f(x) + g(x) < c$, so $f(x) < c - g(x)$. By the density of $\mathbb{Q}$ in $\mathbb{R}$ there exists $q \in \mathbb{Q}$ such that

$$f(x) < q < c - g(x).$$

Then $f(x) < q$ and $g(x) < c - q$, so $x \in D_q \subseteq \bigcup_{q \in \mathbb{Q}} D_q$.

Conversely, let $x \in \bigcup_{q \in \mathbb{Q}} D_q$. Then $x \in D_q$ for some $q \in \mathbb{Q}$, so $f(x) < q$ and $g(x) < c - q$. Hence $f(x) < q < c - g(x)$, so $f(x) + g(x) < c$, giving $x \in C$.

Thus the claim holds, and $f + g$ is measurable.

(2) Observe that

$$fg = \tfrac{1}{2}\left[(f + g)^{2} - f^{2} - g^{2}\right].$$

By part (1) and what follows, it is enough to show that the square of a measurable function is measurable.

Let $c \in \mathbb{R}$. We show $\{x \in E : (f(x))^{2} > c\}$ is measurable.

- *Case 1: $c \geq 0$.*

$$\{x \in E : (f(x))^{2} > c\} = \{x \in E : f(x) > \sqrt{c}\} \cup \{x \in E : f(x) < -\sqrt{c}\},$$

which is a union of measurable sets, hence measurable.
- *Case 2: $c < 0$.*

$$\{x \in E : (f(x))^{2} > c\} = E,$$

which is measurable.

Thus $f^{2}$ is measurable for any measurable $f$, and therefore $fg$ is measurable. ∎

---

## 3.1 Littlewood's Principles

### Principle 1: Every finite measurable set is nearly a finite union of intervals.

### Theorem

Let $E$ be a measurable set of finite measure. Then, for every $\varepsilon > 0$, there exists a finite collection of disjoint open intervals $\{I_k\}_{k=1}^{n}$ such that, putting

$$\mathcal{O} = \bigcup_{k=1}^{n} I_k,$$

we have

$$m^{*}(E \setminus \mathcal{O}) + m^{*}(\mathcal{O} \setminus E) < \varepsilon \qquad \big(\text{equivalently } m(E \setminus \mathcal{O}) + m(\mathcal{O} \setminus E) < \varepsilon\big).$$

### Principle 2: Every measurable function is nearly continuous.

### Theorem: Lusin's Theorem

Let $f : E \to \mathbb{R}$ be a measurable function. Then, for every $\varepsilon > 0$, there exists a continuous function $g_{\varepsilon}$ on $\mathbb{R}$ and a closed set $F_{\varepsilon} \subseteq E$ such that

$$f = g_{\varepsilon} \ \text{ on } F_{\varepsilon} \quad \text{and} \quad m(E \setminus F_{\varepsilon}) < \varepsilon.$$

### Principle 3: Every pointwise convergent sequence of measurable functions is nearly uniformly convergent.

### Theorem: Egoroff's Theorem

Assume $E$ has finite measure. Let $\{f_n\}$ be a sequence of measurable functions on $E$ that converges pointwise on $E$ to a function $f : E \to \mathbb{R}$. Then, for every $\varepsilon > 0$, there exists a closed set $F_{\varepsilon} \subseteq E$ such that

$$f_n \to f \text{ uniformly on } F_{\varepsilon} \quad \text{and} \quad m(E \setminus F_{\varepsilon}) < \varepsilon.$$$BODY$,
    1
  )
on conflict (id) do nothing;