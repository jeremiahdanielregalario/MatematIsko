# Math 126: Real Analysis — Unit I

*A review guide to Lebesgue measure and measurable functions*

## How the unit fits together

The central question is simple: **how can we extend the length of an interval to more complicated sets?** The answer develops in three stages.

1. **Outer measure:** cover a set with intervals and look for the smallest possible total length.
2. **Measurable sets:** identify the sets for which this notion of size behaves additively.
3. **Measurable functions:** study functions whose level sets are measurable, then show that limits and familiar algebraic operations preserve measurability.

Littlewood's principles tie these ideas together: after allowing an exceptional set of very small measure, measurable objects can often be treated like more familiar objects.

**How to review.** First read each definition or theorem and its explanation. Then cover the proof and try to recall its main construction. Finally, check the hypotheses: many mistakes in this unit come from using a correct theorem without the assumption that makes it work.

### Notation and conventions

All sets are subsets of $\mathbb{R}$ unless another ambient space is specified. Write $\mathbb{N}=\{1,2,3,\ldots\}$.

| Notation | Meaning |
|---|---|
| $E^c$ | The complement $\mathbb{R}\setminus E$ |
| $A\setminus B$ | The points of $A$ that are not in $B$ |
| $A+y$ | The translate $\{a+y:a\in A\}$ |
| $m^*(A)$ | Outer measure; defined for every set $A$ |
| $m(E)$ | Lebesgue measure; used when $E$ is measurable |
| $A_n\uparrow A$ | $A_n\subseteq A_{n+1}$ and $A=\bigcup_n A_n$ |
| $B_n\downarrow B$ | $B_{n+1}\subseteq B_n$ and $B=\bigcap_n B_n$ |
| $\{f>c\}$ | The level set $\{x\in E:f(x)>c\}$, with domain $E$ understood |
| Almost everywhere (a.e.) | Except on a measurable set of measure zero |

Measures take values in $[0,+\infty]$. In particular, **never subtract $+\infty$ from $+\infty$**. This is an undefined expression, not a number that can be cancelled.

---

## 1. Lebesgue Measure

### 1.1 Lebesgue Outer Measure

Before defining the size of an arbitrary set, we start with the size of the simplest building blocks: intervals.

#### Definition: Length of an Interval

If $I$ is a nonempty interval with finite endpoints $a\leq b$, its length is $b-a$. If $I$ is unbounded, its length is $+\infty$:

$$
\ell(I)=
\begin{cases}
b-a, & I\text{ is bounded with endpoints }a,b,\\
+\infty, & I\text{ is unbounded}.
\end{cases}
$$

Whether either endpoint is included does not affect length. Thus $(a,b)$, $[a,b]$, $(a,b]$, and $[a,b)$ have the same length when $a<b$. A singleton has length zero. For convenience, set $\ell(\varnothing)=0$.

#### Definition: Lebesgue Outer Measure

For $A\subseteq\mathbb{R}$, define

$$
m^*(A)=\inf\Sigma_A,
$$

where

$$
\Sigma_A=
\left\{
\sum_{k=1}^{\infty}\ell(I_k):
A\subseteq\bigcup_{k=1}^{\infty}I_k,
\quad I_k\text{ open and bounded intervals}
\right\}.
$$

**Meaning.** Cover every point of $A$ with open intervals. Add their lengths, counting overlaps each time they occur. Different covers have different costs; $m^*(A)$ is the infimum of all those costs.

The infimum need not be attained by a particular cover. What matters is that we can get arbitrarily close to it from above whenever $m^*(A)<\infty$.

#### The covering method you will use repeatedly

To show $m^*(A)\leq L$, construct, for every $\varepsilon>0$, a cover with total length less than $L+\varepsilon$.

To show $m^*(A)\geq L$, show that **every** admissible cover has total length at least $L$.

The relevant infimum fact is: $L=\inf S$ if and only if $L$ is a lower bound of $S$ and, for every $\varepsilon>0$, some $s\in S$ satisfies $s<L+\varepsilon$. Both requirements matter.

A finite cover may also be used in estimates: if the definition requires infinitely many intervals, append intervals whose total length is arbitrarily small.

#### Remark: The Empty Set Has Outer Measure Zero

$$
m^*(\varnothing)=0.
$$

**Proof.** Outer measure is nonnegative. Given $\varepsilon>0$, take

$$
I_k=\left(-\frac{\varepsilon}{2^{k+2}},\frac{\varepsilon}{2^{k+2}}\right).
$$

These intervals cover the empty set vacuously, and

$$
0\leq m^*(\varnothing)
\leq\sum_{k=1}^{\infty}\frac{\varepsilon}{2^{k+1}}
=\frac{\varepsilon}{2}<\varepsilon.
$$

Since this holds for every $\varepsilon>0$, the outer measure is zero. ∎

#### Remark: Monotonicity

If $A\subseteq B$, then

$$
m^*(A)\leq m^*(B).
$$

**Why this is reasonable.** A cover of the larger set also covers the smaller set. Covering fewer points cannot force a higher optimal cost.

**Proof.** Every admissible cover of $B$ is a cover of $A$, so $\Sigma_B\subseteq\Sigma_A$. Taking the infimum over a larger collection can only decrease the result:

$$
m^*(A)=\inf\Sigma_A\leq\inf\Sigma_B=m^*(B).
$$

∎

#### Example: Every Countable Set Has Outer Measure Zero

If $A$ is finite or countably infinite, then $m^*(A)=0$.

**Proof idea.** Give the first point a small interval, the second an even smaller one, and so on. Choose the lengths so their infinite sum stays below the prescribed error.

**Proof.** For a countably infinite set $A=\{a_1,a_2,\ldots\}$ and $\varepsilon>0$, let

$$
I_k=\left(a_k-\frac{\varepsilon}{2^{k+2}},a_k+\frac{\varepsilon}{2^{k+2}}\right).
$$

Each $a_k$ lies in $I_k$. Therefore

$$
0\leq m^*(A)
\leq\sum_{k=1}^{\infty}\ell(I_k)
=\sum_{k=1}^{\infty}\frac{\varepsilon}{2^{k+1}}
=\frac{\varepsilon}{2}.
$$

Let $\varepsilon\downarrow0$. A finite set is contained in a countably infinite set, so monotonicity gives the same conclusion. ∎

**Consequences.** The sets $\mathbb{N}$, $\mathbb{Z}$, and $\mathbb{Q}$ all have outer measure zero. Thus density and size are different notions: $\mathbb{Q}$ is dense in $\mathbb{R}$ but has outer measure zero.

If $m^*(A)>0$, then $A$ is uncountable. The converse is false; the Cantor set will be our counterexample.

#### Example: The Outer Measure of an Interval Is Its Length

For every interval $I$,

$$
m^*(I)=\ell(I).
$$

**Proof roadmap.** First prove the result for a closed bounded interval using compactness. Then use smaller closed intervals to handle other endpoint conventions. Finally, use monotonicity for unbounded intervals.

**Proof.**

**Case 1: $I=[a,b]$, with $a<b$.** For the upper bound, fix $\varepsilon>0$. The open interval $(a-\varepsilon/4,b+\varepsilon/4)$ covers $[a,b]$ and has length $b-a+\varepsilon/2$. Append intervals of total length less than $\varepsilon/2$. This gives

$$
m^*([a,b])\leq b-a+\varepsilon.
$$

Letting $\varepsilon\downarrow0$ yields $m^*([a,b])\leq b-a$.

For the lower bound, take any countable open-interval cover of $[a,b]$. By compactness, finitely many of its intervals still cover $[a,b]$.

Starting with an interval containing $a$, follow an overlapping chain to the right. If its current right endpoint has not reached $b$, that endpoint lies in another interval of the cover with a strictly larger right endpoint. Because the cover is finite, the chain eventually reaches or passes $b$.

Write the chain as $(\alpha_j,\beta_j)$, $1\leq j\leq r$, with $\alpha_1<a$, $\beta_r\geq b$, and $\alpha_{j+1}<\beta_j$. Then

$$
\begin{aligned}
\sum_{j=1}^{r}(\beta_j-\alpha_j)
&=\beta_r-\alpha_1+
\sum_{j=1}^{r-1}(\beta_j-\alpha_{j+1})\\
&\geq\beta_r-\alpha_1\\
&\geq b-a.
\end{aligned}
$$

The total length of the original cover is at least the length of this chain. Hence every cover costs at least $b-a$, so $m^*([a,b])\geq b-a$. If $a=b$, the interval is a singleton and the result follows from the countable-set result.

**Case 2: $I$ is bounded, with endpoints $a<b$.** For every $0<\delta<(b-a)/2$,

$$
[a+\delta,b-\delta]\subseteq I\subseteq[a,b].
$$

By Case 1 and monotonicity,

$$
b-a-2\delta\leq m^*(I)\leq b-a.
$$

Let $\delta\downarrow0$. The restriction on $\delta$ ensures that the smaller interval is nonempty.

**Case 3: $I$ is unbounded.** For every positive integer $n$, the interval $I$ contains a bounded interval of length $n$. Thus $m^*(I)\geq n$ for every $n$, which forces $m^*(I)=+\infty$. ∎

**Review takeaway.** Outer measure extends ordinary interval length, rather than replacing it with an unrelated notion of size.

### 1.2 Properties of the Lebesgue Outer Measure

We now ask whether outer measure behaves well when sets are moved or combined.

#### Proposition: Translation Invariance

For every $A\subseteq\mathbb{R}$ and $y\in\mathbb{R}$,

$$
m^*(A+y)=m^*(A).
$$

**Meaning.** Moving a set left or right changes its position, not its size.

**Proof.** Translating every interval of a cover of $A$ by $y$ gives a cover of $A+y$ with exactly the same total length. Translating back by $-y$ reverses the construction. Hence $\Sigma_A=\Sigma_{A+y}$, and their infima agree. ∎

#### Proposition: Countable Subadditivity

For any sequence of sets $E_1,E_2,\ldots$,

$$
m^*\left(\bigcup_{k=1}^{\infty}E_k\right)
\leq\sum_{k=1}^{\infty}m^*(E_k).
$$

The sets need not be measurable or disjoint.

**Proof idea.** Cover each $E_k$ almost optimally. Allocate an error of $\varepsilon/2^k$ to its cover, so the total error across all sets is at most $\varepsilon$.

**Proof.** If the series on the right is infinite, the inequality is immediate. Otherwise every $m^*(E_k)$ is finite. For a fixed $\varepsilon>0$, choose intervals $I_n^k$ covering $E_k$ such that

$$
\sum_{n=1}^{\infty}\ell(I_n^k)
<m^*(E_k)+\frac{\varepsilon}{2^k}.
$$

The collection of all $I_n^k$, indexed by $(n,k)\in\mathbb{N}^2$, is countable and covers $\bigcup_k E_k$. Therefore

$$
\begin{aligned}
m^*\left(\bigcup_{k=1}^{\infty}E_k\right)
&\leq\sum_{k=1}^{\infty}\sum_{n=1}^{\infty}\ell(I_n^k)\\
&\leq\sum_{k=1}^{\infty}\left(m^*(E_k)+\frac{\varepsilon}{2^k}\right)\\
&=\sum_{k=1}^{\infty}m^*(E_k)+\varepsilon.
\end{aligned}
$$

Let $\varepsilon\downarrow0$. ∎

#### Corollary: Finite Subadditivity

For any finite collection $E_1,\ldots,E_n$,

$$
m^*\left(\bigcup_{k=1}^{n}E_k\right)
\leq\sum_{k=1}^{n}m^*(E_k).
$$

**Proof.** Apply countable subadditivity after setting $E_k=\varnothing$ for $k>n$. ∎

#### Why we need measurable sets

Subadditivity is useful, but for disjoint pieces we would like **equality**: the size of the whole should equal the sum of the sizes of its pieces. Outer measure does not satisfy this for arbitrary disjoint sets.

The next definition identifies a class of sets for which splitting a set creates no discrepancy in outer measure.

---

## 2. Measurable Sets

### Definition: Measurable Set

A set $E\subseteq\mathbb{R}$ is **Lebesgue measurable** if, for every set $A\subseteq\mathbb{R}$,

$$
m^*(A)=m^*(A\cap E)+m^*(A\cap E^c).
$$

This is the **Carathéodory criterion**.

**Meaning.** Use $E$ to split an arbitrary test set $A$ into the part inside $E$ and the part outside $E$. A measurable set always splits outer measure exactly.

**Important:** the test set $A$ is arbitrary; it is not assumed measurable. The universal quantifier is the substance of the definition.

### A useful shortcut: prove only one inequality

Because $A=(A\cap E)\cup(A\cap E^c)$, subadditivity already gives

$$
m^*(A)\leq m^*(A\cap E)+m^*(A\cap E^c).
$$

Thus, to prove measurability, only the reverse inequality needs work:

$$
m^*(A)\geq m^*(A\cap E)+m^*(A\cap E^c).
$$

If $m^*(A)=+\infty$, this reverse inequality is automatic in the extended real numbers. The nontrivial case is often $m^*(A)<\infty$.

### Remark: Complements and Disjoint Pieces

The criterion is symmetric in $E$ and $E^c$. Consequently, $E$ is measurable if and only if $E^c$ is measurable.

If $E\cap F=\varnothing$ and $E$ is measurable, then

$$
m^*(E\cup F)=m^*(E)+m^*(F).
$$

**Proof.** Apply the criterion for $E$ to $A=E\cup F$. The two pieces are exactly $E$ and $F$. Notice that $F$ need not be measurable. ∎

### Remark: Excision Property

If $B\subseteq A$, $B$ is measurable, and $m^*(B)<\infty$, then

$$
m^*(A\setminus B)=m^*(A)-m^*(B).
$$

**Proof.** Applying the criterion for $B$ to $A$ gives

$$
m^*(A)=m^*(B)+m^*(A\setminus B).
$$

Since $m^*(B)$ is finite, it may be subtracted. If $m^*(A)=+\infty$, the identity means that removing a finite-measure set leaves infinite outer measure. ∎

**Why finiteness matters.** Take $A=\mathbb{R}$ and $B=[0,+\infty)$. Both have infinite measure, while $A\setminus B=(-\infty,0)$ also has infinite measure. The expression $m(A)-m(B)$ is undefined. Taking $A=B=\mathbb{R}$ instead leaves the empty set. These examples show why an expression of the form $+\infty-(+\infty)$ cannot determine the measure of a difference.

**Review exercise.** Explain why the original subtraction identity remains valid when $m^*(A)=+\infty$ but $m^*(B)<\infty$.

### Proposition: Finite Additivity Across Measurable Pieces

Let $A$ be arbitrary, and let $E_1,\ldots,E_n$ be pairwise disjoint measurable sets. Then

$$
m^*\left(\bigcup_{k=1}^{n}(A\cap E_k)\right)
=\sum_{k=1}^{n}m^*(A\cap E_k).
$$

In particular, choosing $A=\mathbb{R}$ gives finite additivity for the $E_k$ themselves.

**Proof.** Use induction. For the inductive step, apply the criterion for $E_{n+1}$ to $B=\bigcup_{k=1}^{n+1}(A\cap E_k)$. Disjointness gives

$$
\begin{aligned}
m^*(B)
&=m^*(B\cap E_{n+1})+m^*(B\cap E_{n+1}^c)\\
&=m^*(A\cap E_{n+1})+
 m^*\left(\bigcup_{k=1}^{n}(A\cap E_k)\right)\\
&=\sum_{k=1}^{n+1}m^*(A\cap E_k).
\end{aligned}
$$

The final equality uses the induction hypothesis. ∎

### Proposition: Null Sets Are Measurable

Every set of outer measure zero is measurable. Therefore every countable set is measurable, and every subset of a measure-zero set is measurable.

**Proof.** Suppose $m^*(E)=0$. For every $A$, monotonicity yields $m^*(A\cap E)=0$ and $m^*(A\cap E^c)\leq m^*(A)$. Hence

$$
m^*(A\cap E)+m^*(A\cap E^c)\leq m^*(A).
$$

This is the required reverse inequality. If $N$ has measure zero and $S\subseteq N$, monotonicity gives $m^*(S)=0$, so the same argument applies to $S$. ∎

**Terminology.** This last property is called **completeness** of Lebesgue measure. Even a very complicated subset of a null set remains measurable.

### Theorem: Finite Unions and Intersections Are Measurable

If $E_1$ and $E_2$ are measurable, then so are $E_1\cup E_2$ and $E_1\cap E_2$. Repeating this argument gives the result for any finite collection.

**Proof idea.** First split a test set along $E_1$. Then split the remaining piece along $E_2$. The pieces inside the union account for its outer measure.

For any test set $B$, measurability gives

$$
m^*(B)=m^*(B\cap E_1)+m^*(B\cap E_1^c). \tag{1}
$$

$$
m^*(B)=m^*(B\cap E_2)+m^*(B\cap E_2^c). \tag{2}
$$

In particular,

$$
m^*(A)=m^*(A\cap E_1)+m^*(A\cap E_1^c). \tag{3}
$$

Apply (2) to $B=A\cap E_1^c$. Substituting into (3) yields

$$
\begin{aligned}
m^*(A)
&=m^*(A\cap E_1)+m^*(A\cap E_1^c\cap E_2)
  +m^*(A\cap E_1^c\cap E_2^c)\\
&\geq m^*(A\cap(E_1\cup E_2))+m^*(A\cap(E_1\cup E_2)^c).
\end{aligned}
$$

The inequality is subadditivity applied to the first two pieces. Thus the union is measurable. De Morgan's law and closure under complements give the intersection result. ∎

**Consequence.** Differences of measurable sets are measurable, since $E\setminus F=E\cap F^c$.

### Theorem: Countable Unions and Intersections Are Measurable

If $A_1,A_2,\ldots$ are measurable, then their union and intersection are measurable.

**Proof roadmap.** Remove overlaps, apply finite additivity to the first $n$ pieces, and then let $n$ increase.

Define the disjoint pieces

$$
E_1=A_1,\qquad E_k=A_k\setminus\bigcup_{j=1}^{k-1}A_j\quad(k\geq2).
$$

Each $E_k$ is measurable by finite closure, and $E=\bigcup_k E_k=\bigcup_k A_k$. Put $F_n=\bigcup_{k=1}^n E_k$. For an arbitrary test set $A$,

$$
m^*(A)=m^*(A\cap F_n)+m^*(A\cap F_n^c). \tag{4}
$$

Because $E^c\subseteq F_n^c$, finite additivity and monotonicity imply

$$
m^*(A)\geq\sum_{k=1}^n m^*(A\cap E_k)+m^*(A\cap E^c).
$$

Take the supremum over $n$ of these nonnegative partial sums:

$$
m^*(A)\geq\sum_{k=1}^{\infty}m^*(A\cap E_k)+m^*(A\cap E^c). \tag{5}
$$

Subadditivity gives $m^*(A\cap E)\leq\sum_k m^*(A\cap E_k)$, so (5) proves the required inequality for $E$. Countable intersections follow by De Morgan's law. ∎

**What was used in the limit step?** Only the definition of a nonnegative series as the supremum of its partial sums. We have not used the monotone convergence theorem for integrals.

The measurable sets therefore form a **sigma-algebra**: a family containing $\mathbb R$ and closed under complements and countable unions.

### Definition: Lebesgue Measure

For a measurable set $E$, its **Lebesgue measure** is

$$
m(E)=m^*(E).
$$

The symbol $m$ is reserved for measurable sets; $m^*$ can be applied to every subset of $\mathbb R$. All previously proved properties of outer measure remain available on measurable sets. In particular, $m([0,1])=1$.

### Theorem: Countable Additivity

For pairwise disjoint measurable sets $E_1,E_2,\ldots$,

$$
m\left(\bigcup_{k=1}^{\infty}E_k\right)=\sum_{k=1}^{\infty}m(E_k).
$$

**Proof.** Subadditivity gives the inequality $\leq$. For each $n$, monotonicity and finite additivity give

$$
m\left(\bigcup_{k=1}^{\infty}E_k\right)
\geq m\left(\bigcup_{k=1}^{n}E_k\right)
=\sum_{k=1}^{n}m(E_k).
$$

Taking the supremum of the partial sums gives $\geq$. ∎

**Remember the distinction:** subadditivity allows overlapping sets; additivity requires disjointness.

### Which Familiar Sets Are Measurable?

We now connect the abstract splitting criterion to ordinary intervals and open sets.

**Proposition.** Every ray $(a,\infty)$ is measurable.

**Proof.** Let $H=(a,\infty)$ and let $A$ be arbitrary. If $m^*(A)=\infty$, the required inequality $m^*(A)\geq m^*(A\cap H)+m^*(A\cap H^c)$ is automatic. Otherwise, for $\varepsilon>0$, choose an open interval cover $\{I_k\}$ of $A$ with total length less than $m^*(A)+\varepsilon$.

Split each interval into $J_k=I_k\cap H$ and $K_k=I_k\cap H^c$. These are intervals or empty sets, and their lengths add to $\ell(I_k)$. The interval theorem and subadditivity give

$$
\begin{aligned}
m^*(A\cap H)+m^*(A\cap H^c)
&\leq\sum_k m^*(J_k)+\sum_k m^*(K_k)\\
&=\sum_k\ell(I_k)\\
&<m^*(A)+\varepsilon.
\end{aligned}
$$

Let $\varepsilon\downarrow0$. This proves the criterion. Notice that the split pieces need not be open: we use their already-known outer measures, not their eligibility as open covers. ∎

From here the remaining examples follow efficiently:

- **Half-open intervals:** $(a,b]=(a,\infty)\cap(b,\infty)^c$.
- **Other intervals:** change endpoints by adding or removing singletons, or take countable unions of half-open intervals. Singletons are null and measurable.
- **Open sets:** every open subset of $\mathbb R$ is a countable disjoint union of open intervals. Countability follows because each nonempty component contains a different rational number.
- **Closed sets:** complements of open sets.
- **$G_\delta$ sets:** countable intersections of open sets.
- **$F_\sigma$ sets:** countable unions of closed sets.

Thus all **Borel sets**, meaning the sigma-algebra generated by the open sets, are Lebesgue measurable.

**Excision for measure.** If $B\subseteq A$ are measurable and $m(B)<\infty$, then

$$
m(A\setminus B)=m(A)-m(B).
$$

**Translation of measurable sets.** If $E$ is measurable, so is $E+y$, and $m(E+y)=m(E)$. To check measurability, apply the criterion for $E$ to $A-y$, then translate each piece back using translation invariance of outer measure.

### 2.1 Nonmeasurable Sets

The measurable sets include all familiar examples, but they do not include every subset of $\mathbb R$. The next argument explains why translation invariance and countable additivity impose a real restriction.

#### Lemma: Infinitely Many Disjoint Bounded Translates

Let $E$ be bounded and measurable. Suppose $\Lambda$ is a bounded, countably infinite set of translation parameters, and the sets $E+\lambda$, $\lambda\in\Lambda$, are pairwise disjoint. Then $m(E)=0$.

**Proof.** Their union is bounded, so it has finite measure. Translation invariance and countable additivity give

$$
m\left(\bigcup_{\lambda\in\Lambda}(E+\lambda)\right)
=\sum_{\lambda\in\Lambda}m(E).
$$

If $m(E)>0$, the right side is infinite, a contradiction. ∎

**Intuition.** A bounded region cannot contain infinitely many disjoint copies of the same positive-measure set.

#### Rational Equivalence and a Choice Set

On a set $E$, define

$$
x\sim y\quad\Longleftrightarrow\quad x-y\in\mathbb Q.
$$

This is an equivalence relation: it groups points whose difference is rational. Using the axiom of choice, select exactly one representative from each equivalence class. Call the representative set $C_E$.

Two facts drive the construction:

1. Distinct rational translates of $C_E$ are disjoint. If $c+q=c'+q'$, then $c-c'\in\mathbb Q$, so the representative property forces $c=c'$, and hence $q=q'$.
2. Every $x\in E$ is a rational translate of its representative: $x=c+q$ for some $c\in C_E$ and $q\in\mathbb Q$.

#### Theorem: Vitali's Nonmeasurable Subset

Every bounded measurable set $E$ with $m(E)>0$ contains a nonmeasurable subset.

**Proof.** Choose $b>0$ such that $E\subseteq[-b,b]$, and form $C_E$. Every difference between a point of $E$ and its representative lies in $[-2b,2b]$. Therefore, with $\Lambda=\mathbb Q\cap[-2b,2b]$,

$$
E\subseteq\bigcup_{q\in\Lambda}(C_E+q).
$$

Suppose $C_E$ were measurable. Its translates above are disjoint, and both $C_E$ and $\Lambda$ are bounded. The lemma gives $m(C_E)=0$. The union of these countably many translates would then have measure zero, forcing $m(E)=0$. This contradicts the hypothesis. Thus $C_E$ is nonmeasurable. ∎

**Two useful questions.**

- Can a null set contain a nonmeasurable subset? **No.** Every subset of a null set is measurable.
- Does every unbounded set contain a nonmeasurable subset? **No.** For example, $\mathbb Z$ is unbounded, but all its subsets are countable and measurable.

The correct extension is: **every measurable set of positive measure contains a nonmeasurable subset**, even when it is unbounded. Indeed,

$$
E=\bigcup_{n=1}^{\infty}(E\cap[-n,n]).
$$

If every intersection were null, their union would be null. At least one intersection therefore has positive measure, and the bounded theorem applies to it.

#### Theorem: Continuity of Measure

Here “continuity” describes how measure behaves when sets grow or shrink.

**From below.** If $A_1\subseteq A_2\subseteq\cdots$ are measurable, then

$$
m\left(\bigcup_{n=1}^{\infty}A_n\right)=\lim_{n\to\infty}m(A_n).
$$

There is **no finite-measure assumption**.

**Proof.** Separate the increasing sets into disjoint layers: $C_1=A_1$ and $C_n=A_n\setminus A_{n-1}$ for $n\geq2$. Then

$$
\begin{aligned}
m\left(\bigcup_n A_n\right)
&=\sum_{n=1}^{\infty}m(C_n)\\
&=\lim_{N\to\infty}\sum_{n=1}^N m(C_n)\\
&=\lim_{N\to\infty}m(A_N).
\end{aligned}
$$

This proof works even if a measure is infinite, because it never subtracts infinities. ∎

**From above.** If $B_1\supseteq B_2\supseteq\cdots$ are measurable and $m(B_1)<\infty$, then

$$
m\left(\bigcap_{n=1}^{\infty}B_n\right)=\lim_{n\to\infty}m(B_n).
$$

**Proof.** The sets $D_n=B_1\setminus B_n$ increase to $B_1\setminus\bigcap_n B_n$. Apply continuity from below and subtract from the finite number $m(B_1)$:

$$
m(B_1)-m\left(\bigcap_n B_n\right)
=\lim_n\bigl(m(B_1)-m(B_n)\bigr).
$$

Rearranging gives the result. ∎

**Why finiteness matters.** Take $B_n=[n,\infty)$. Each has infinite measure, but their intersection is empty. Thus the measures do not converge to the measure of the intersection. It is enough for some $B_N$ to have finite measure; then apply the theorem to that tail.

### 2.2 The Cantor Set

We have seen that countable sets have measure zero. The Cantor set shows that the converse fails dramatically: an uncountable set can still have measure zero.

#### Construction

Start with $C_0=[0,1]$. Remove the open middle third of every remaining interval at each stage:

$$
C_1=[0,1/3]\cup[2/3,1],
$$

$$
C_2=[0,1/9]\cup[2/9,1/3]\cup[2/3,7/9]\cup[8/9,1].
$$

At stage $n$, the set $C_n$ consists of $2^n$ disjoint closed intervals, each of length $3^{-n}$. The **Cantor set** is what remains after every stage:

$$
C=\bigcap_{n=0}^{\infty}C_n.
$$

#### Why Its Measure Is Zero

Each $C_n$ is closed, the sequence decreases, and $m(C_0)=1<\infty$. Continuity from above gives

$$
m(C)=\lim_{n\to\infty}m(C_n)
=\lim_{n\to\infty}\left(\frac23\right)^n=0.
$$

The set $C$ is also closed, as an intersection of closed sets.

#### Why It Is Uncountable

At every stage, a point of $C$ lies in either the left child interval or the right child interval. Encode these choices by an infinite binary sequence $(a_1,a_2,\ldots)$, where $0$ means left and $1$ means right.

Every such sequence selects nested closed intervals whose lengths tend to zero. They have exactly one common point. Different sequences first differ at some stage, where they select separated child intervals, so they determine different points. Conversely, each Cantor point determines its sequence of choices.

It remains to see that infinite binary sequences are uncountable. Suppose they were listed as $a^{(1)},a^{(2)},\ldots$. Define a new sequence by

$$
b_n=1-a_n^{(n)}.
$$

It differs from the $n$th listed sequence in position $n$, so it is missing from the list. This contradiction proves uncountability. ∎

**Main lesson.** Cardinality counts how many points there are; measure describes how much length they occupy. These are different notions of size.

## 3. Measurable Functions

Measurable sets let us assign size to regions. Measurable functions let us ask meaningful size questions about values—for example, “How large is the set on which $f$ exceeds a threshold?” This is the bridge from measure to integration.

Throughout this section, the domain $E$ is measurable. Unless a result explicitly says **real-valued**, a function may take values in the extended real line $[-\infty,\infty]$.

### Equivalent Descriptions of Measurability

For $f:E\to[-\infty,\infty]$, the following conditions are equivalent:

1. $\{x\in E:f(x)<a\}$ is measurable for every $a\in\mathbb R$.
2. $\{x\in E:f(x)\leq b\}$ is measurable for every $b\in\mathbb R$.
3. $\{x\in E:f(x)>c\}$ is measurable for every $c\in\mathbb R$.
4. $\{x\in E:f(x)\geq d\}$ is measurable for every $d\in\mathbb R$.

**Definition.** A function satisfying these conditions is **measurable**. You need to check only one of the four families of level sets.

**Why the conditions agree.** Complements are taken **inside $E$**. For example,

$$
\{f\geq a\}=E\setminus\{f<a\},\qquad
\{f\leq c\}=E\setminus\{f>c\}.
$$

Strict and non-strict inequalities are connected by countable operations:

$$
\{f\geq d\}=\bigcap_{k=1}^{\infty}\{f>d-1/k\},
$$

$$
\{f>c\}=\bigcup_{k=1}^{\infty}\{f\geq c+1/k\}.
$$

For the first identity, membership on the right means

$$
f(x)>d-1/k\quad\text{for every }k\geq1. \tag{1}
$$

This is equivalent to $f(x)\geq d$. If $f(x)<d$, choose $k$ with $1/k<d-f(x)$ to contradict (1). The second identity follows by choosing $1/k$ smaller than the positive gap $f(x)-c$. Closure of measurable sets under complements, countable unions, and countable intersections proves the equivalences. ∎

**Equality sets are measurable too.** For real $a$, use $\{f=a\}=\{f\leq a\}\cap\{f\geq a\}$. For infinite values,

$$
\{f=+\infty\}=\bigcap_{k=1}^{\infty}\{f>k\},\qquad
\{f=-\infty\}=\bigcap_{k=1}^{\infty}\{f<-k\}.
$$

### Open-Set Preimages

**Theorem.** A **real-valued** function $f:E\to\mathbb R$ is measurable if and only if $f^{-1}(O)$ is measurable for every open set $O\subseteq\mathbb R$.

**Proof.** If all open preimages are measurable, take $O=(-\infty,a)$ to obtain the defining level sets. Conversely, for measurable $f$,

$$
f^{-1}((a,b))=\{f>a\}\cap\{f<b\}
$$

is measurable. Every open set in $\mathbb R$ is a countable union of open intervals, and preimages preserve unions. Unbounded intervals are handled by the corresponding one-sided level sets. ∎

**Extended-value caution.** Ordinary open subsets of $\mathbb R$ do not contain $+\infty$ or $-\infty$. For extended-valued functions, use open sets of the **extended real line**, including neighborhoods of its endpoints, or separately require the two infinite-value level sets to be measurable. Otherwise the converse fails: a function equal to $+\infty$ on a nonmeasurable set and $-\infty$ elsewhere has empty preimages of all ordinary open subsets of $\mathbb R$, yet is not measurable.

### Continuous Functions Are Measurable

If $f:E\to\mathbb R$ is continuous relative to its measurable domain $E$, then $f$ is measurable.

**Reason.** Relative continuity means that for every open $O\subseteq\mathbb R$, there is an open $U\subseteq\mathbb R$ such that

$$
f^{-1}(O)=E\cap U.
$$

This is an intersection of measurable sets. Apply the open-preimage characterization.

**The converse is false.** The indicator $\mathbf1_{\mathbb Q}$ is measurable because $\mathbb Q$ is measurable, but it is discontinuous everywhere: every neighborhood contains both rational and irrational points.

### Absolute Value Preserves Measurability

If $f$ is measurable, so is $|f|$.

For $c\geq0$,

$$
\{|f|>c\}=\{f>c\}\cup\{f<-c\}.
$$

For $c<0$, this level set is all of $E$. Thus every strict superlevel set is measurable.

### A Reminder About Limit Inferior and Limit Superior

Before taking limits of functions, recall how to describe oscillation in a sequence $(c_k)$ of extended real numbers. Set

$$
a_n=\inf_{k\geq n}c_k,\qquad b_n=\sup_{k\geq n}c_k.
$$

As $n$ increases, fewer terms remain in the tail. Consequently, $a_n$ increases and $b_n$ decreases. Their extended limits always exist:

$$
\liminf_{k\to\infty}c_k
=\sup_n\inf_{k\geq n}c_k,
\qquad
\limsup_{k\to\infty}c_k
=\inf_n\sup_{k\geq n}c_k.
$$

Think of these as the eventual lower and upper boundaries of the sequence. Always $\liminf c_k\leq\limsup c_k$. The sequence has an extended-real limit exactly when these two values agree; it has a finite real limit when their common value is finite.

**Example.** For $c_k=(-1)^k$, every tail contains $-1$ and $1$. Hence $\liminf c_k=-1$ and $\limsup c_k=1$, so there is no limit.

### Theorem: Countable Suprema, Infima, and Limits

Let $f_1,f_2,\ldots$ be measurable on the same measurable set $E$. Then the following functions are measurable, with extended values allowed:

$$
\sup_k f_k,\qquad\inf_k f_k,\qquad
\limsup_{k\to\infty}f_k,\qquad\liminf_{k\to\infty}f_k.
$$

**Proof.** The two essential level-set identities are

$$
\left\{\sup_k f_k>c\right\}=\bigcup_k\{f_k>c\},
\qquad
\left\{\inf_k f_k<c\right\}=\bigcup_k\{f_k<c\}.
$$

These are countable unions of measurable sets. Apply the same result to each tail, then use

$$
\limsup_k f_k=\inf_n\sup_{k\geq n}f_k,
\qquad
\liminf_k f_k=\sup_n\inf_{k\geq n}f_k.
$$

This proves all four claims. ∎

**Consequences.** Finite maxima and minima of measurable functions are measurable. A pointwise limit of measurable functions is measurable whenever the limit exists at every point of the domain.

**Why countability matters.** Sigma-algebras guarantee closure under countable unions, not arbitrary unions. These proofs do not justify uncountable suprema.

### Positive and Negative Parts: Check the Convention

Following the convention in the supplied notes, define

$$
f^+=\max\{f,0\},\qquad f^-=\min\{f,0\}.
$$

Both are measurable, $f^+\geq0$, and $f^-\leq0$. With this **signed negative part** convention,

$$
f=f^++f^-,\qquad |f|=f^+-f^-.
$$

Many books instead define the negative part as the nonnegative function $\max\{-f,0\}$. In that convention the signs in these identities change. Always check which definition your course is using.

### Theorem: Algebra of Real-Valued Measurable Functions

If $f,g:E\to\mathbb R$ are measurable and $\alpha\in\mathbb R$, then $\alpha f$, $f+g$, and $fg$ are measurable.

**Scalar multiplication.** If $\alpha>0$, divide a level-set inequality by $\alpha$. If $\alpha<0$, division reverses the inequality. If $\alpha=0$, the function is constant. Each case reduces to known measurable level sets.

**Addition.** For any real $c$,

$$
\{f+g<c\}
=\bigcup_{q\in\mathbb Q}\bigl(\{f<q\}\cap\{g<c-q\}\bigr).
$$

To understand this identity, suppose $f(x)+g(x)<c$. There is a positive gap between $f(x)$ and $c-g(x)$, so choose a rational $q$ between them. Then $f(x)<q$ and $g(x)<c-q$. Conversely, adding these inequalities gives $f(x)+g(x)<c$. The union is countable because the separating numbers are rational, so the set is measurable.

**Products.** First, the square of a real measurable function $h$ is measurable: for $c\geq0$,

$$
\{h^2>c\}=\{h>\sqrt c\}\cup\{h<-\sqrt c\},
$$

and for $c<0$ the set is $E$. Now use the identity

$$
fg=\frac12\bigl((f+g)^2-f^2-g^2\bigr).
$$

Every operation on the right preserves measurability. ∎

**Why “real-valued” appears here.** Expressions such as $+\infty+(-\infty)$ are undefined. Extended-valued versions require hypotheses or conventions that make the operations meaningful.

### 3.1 Littlewood's Three Principles

The previous sections built a large class of sets and functions. Littlewood's principles explain why these objects can still be studied through familiar ones—intervals, continuous functions, and uniform convergence—after allowing a small exceptional set.

Here “small” refers to **measure**, not to the number of points. Each $\varepsilon>0$ may require a different exceptional set.

#### First Principle: Measurable Sets Are Nearly Finite Unions of Intervals

**Precise statement.** If $E$ is measurable and $m(E)<\infty$, then for every $\varepsilon>0$ there is a finite union $O$ of pairwise disjoint bounded open intervals such that

$$
m(E\setminus O)+m(O\setminus E)<\varepsilon.
$$

Equivalently, $m(E\mathbin{\triangle}O)<\varepsilon$, where the **symmetric difference** consists of points belonging to exactly one of the two sets. The finite union may be empty.

**What this means.** The interval union may miss some points of $E$ and include some extra points. The total measure of both errors is small. “Finite” here means that $E$ has finite measure; it does not mean that $E$ has finitely many points.

**Proof roadmap.** Choose an open interval cover of $E$ with total length less than $m(E)+\varepsilon/2$, and let $G$ be its union. Then $G\supseteq E$, $m(G)<\infty$, and excision gives $m(G\setminus E)<\varepsilon/2$. Decompose $G$ into its disjoint open interval components. Their lengths form a convergent nonnegative series, so a finite subcollection has union $O$ with $m(G\setminus O)<\varepsilon/2$. Now $E\setminus O\subseteq G\setminus O$ and $O\setminus E\subseteq G\setminus E$, which gives the result.

**Regularity fact used below.** Every measurable $A\subseteq\mathbb R$ can be approximated from within by a closed set: for every $\eta>0$, there is closed $F\subseteq A$ with $m(A\setminus F)<\eta$, even if $m(A)=\infty$.

To see this from open approximation, first cover each finite-measure piece of $A^c$ in the partition $[j,j+1)$, $j\in\mathbb Z$, by an open set with an assigned error budget. Choose positive budgets whose sum is less than $\eta$. Their union $U$ is open, contains $A^c$, and satisfies $m(U\setminus A^c)<\eta$. Then $F=\mathbb R\setminus U$ works. This fact is called **inner regularity by closed sets**. If $m(A)<\infty$, one can additionally intersect with a sufficiently large closed bounded interval to obtain a compact approximation.

#### Second Principle: Measurable Functions Are Nearly Continuous — Lusin's Theorem

**Precise statement.** Let $E\subseteq\mathbb R$ be measurable and let $f:E\to\mathbb R$ be measurable. For every $\varepsilon>0$, there are a closed set $F\subseteq E$ and a continuous function $g:\mathbb R\to\mathbb R$ such that

$$
m(E\setminus F)<\varepsilon,
\qquad g(x)=f(x)\quad\text{for every }x\in F.
$$

Thus, outside a set of arbitrarily small measure, $f$ agrees **exactly** with a continuous function.

**How to interpret the theorem.** The restriction $f|_F$ is continuous in the relative topology of $F$. This does not assert that the original function is continuous at those points when approached through all of $E$. The exceptional set depends on $\varepsilon$.

For example, $\mathbf1_{\mathbb Q}$ is discontinuous everywhere, yet one can cover $\mathbb Q$ by an open set of arbitrarily small measure. On the closed complement it agrees with the continuous function $g=0$.

**Hypothesis check.** This closed-set version on $\mathbb R$ does not require $m(E)<\infty$. When $m(E)<\infty$, $F$ can be chosen compact. The general closed-set formulation is given in [Piotr Hajłasz's Analysis I notes](https://sites.pitt.edu/~hajlasz/Notatki/Analysis%20I.pdf). Extending a continuous real function from a closed subset of $\mathbb R$ to $\mathbb R$ gives the stated formulation with $g$; on bounded complementary intervals this extension can be made by linear interpolation between endpoints.

Lusin's theorem is stated here as an approximation theorem; a full proof is beyond the preceding elementary closure arguments.

#### Third Principle: Pointwise Convergence Is Nearly Uniform — Egoroff's Theorem

**Precise statement.** Let $E$ be measurable with $m(E)<\infty$. Suppose measurable real-valued functions $f_n$ converge pointwise on $E$ to a real-valued function $f$. For every $\varepsilon>0$, there is a closed set $F\subseteq E$ such that

$$
m(E\setminus F)<\varepsilon
$$

and $f_n\to f$ uniformly on $F$.

**What changes from pointwise to uniform convergence?**

- Pointwise convergence: for each $x$ and tolerance $\delta>0$, a sufficiently large index may depend on $x$.
- Uniform convergence: for each $\delta>0$, one index works for **all** $x\in F$.

Egoroff's theorem says that the points delaying convergence can be confined to a set of small measure.

**Proof roadmap.** For positive integers $j,N$, define the bad set

$$
B_{j,N}=\bigcup_{n\geq N}\{x\in E:|f_n(x)-f(x)|\geq1/j\}.
$$

For fixed $j$, these measurable sets decrease to the empty set as $N\to\infty$, by pointwise convergence. Since $m(E)<\infty$, continuity from above gives $m(B_{j,N})\to0$. Choose $N_j$ so that

$$
m(B_{j,N_j})<\frac{\varepsilon}{2^{j+1}}.
$$

On $G=E\setminus\bigcup_{j=1}^{\infty}B_{j,N_j}$, all $n\geq N_j$ satisfy $|f_n(x)-f(x)|<1/j$ simultaneously for every $x\in G$. Given $\delta>0$, choose $j$ with $1/j<\delta$; then $N_j$ works for all of $G$. Thus convergence is uniform there, and $m(E\setminus G)<\varepsilon/2$. Finally, use closed-set inner regularity to choose closed $F\subseteq G$ with $m(G\setminus F)<\varepsilon/2$. The uniform convergence persists on $F$. ∎

**Example.** On $[0,1]$, the functions $f_n(x)=x^n$ converge to $0$ for $x<1$ and to $1$ at $x=1$. Convergence is not uniform on the full interval. On $[0,1-\delta]$, however,

$$
\sup_{0\leq x\leq1-\delta}|f_n(x)|=(1-\delta)^n\longrightarrow0.
$$

Discarding a short interval near $1$ makes convergence uniform.

**Why finite measure is essential.** On $\mathbb R$, take $f_n=\mathbf1_{[n,\infty)}$. These functions converge pointwise to $0$. But removing a set of finite measure leaves a point of $[n,\infty)$ for every $n$, so the supremum of $f_n$ on the remaining set is always $1$. Uniform convergence fails there.

The standard measurable-set form also allows almost-everywhere convergence; discard the null set where convergence fails. On the real line, inner regularity supplies the closed-set refinement above. See [Lenya Ryzhik's measure theory notes](https://math.stanford.edu/~ryzhik/STANFORD/STANF205-11/notes-205.pdf) for the standard approximation theorems.

## Review Map

| Topic | Main idea | Hypothesis to remember |
| --- | --- | --- |
| Outer measure | Approximate a set from outside by interval covers. | Defined for every subset of $\mathbb R$. |
| Measurability | Splitting any test set causes no excess outer measure. | The criterion tests every set $A$, not only measurable ones. |
| Countable additivity | Add the measures of disjoint pieces. | Pieces must be measurable and pairwise disjoint. |
| Excision | Subtract the measure of the removed subset. | Its measure must be finite. |
| Continuity from below | Growing sets have the expected limiting measure. | No finite-measure assumption. |
| Continuity from above | Shrinking sets have the expected limiting measure. | At least one set in the sequence must have finite measure. |
| Vitali construction | Rational translates obstruct measurability. | A measurable positive-measure set contains a nonmeasurable subset. |
| Cantor set | Uncountable does not imply positive measure. | Closed, uncountable, and null. |
| Measurable functions | Threshold preimages are measurable. | Use a measurable domain and countable set operations. |
| Lusin | A measurable function agrees with a continuous one on a large closed subset. | Here the function is real-valued; closed need not mean compact. |
| Egoroff | Convergence becomes uniform on a large subset. | The domain has finite measure and the limit is finite. |

### A Small Proof Toolbox

1. **To prove outer measure is small:** construct a cover with a controlled total length.
2. **To prove a set is measurable:** use known closure properties; if necessary, prove the reverse inequality in the splitting criterion.
3. **To handle overlapping unions:** replace them by disjoint successive differences.
4. **To prove a function is measurable:** rewrite one family of level sets using countable unions, intersections, and complements.
5. **To pass to a limit of sets:** check whether they increase or decrease, and whether finiteness is needed.
6. **To manage countably many errors:** give the $k$th error a budget such as $\varepsilon/2^{k+1}$, so their total stays below $\varepsilon$.

### Self-Check Questions

Try answering these before consulting the hints.

1. Why does positive outer measure imply uncountability, while uncountability does not imply positive outer measure?
2. Why does the measurability criterion require only one inequality to be checked?
3. Where does disjointness enter the proof of countable additivity?
4. Give a decreasing sequence showing that continuity from above needs a finite-measure hypothesis.
5. Why do rational numbers appear in the proof that $f+g$ is measurable?
6. What goes wrong if one tests an extended-valued function only with ordinary open subsets of $\mathbb R$?
7. Why does Lusin's theorem not imply that every measurable function is continuous almost everywhere?
8. What is the difference between the conclusions of Lusin's and Egoroff's theorems?

**Hints and short answers.**

1. Countable sets are null; the Cantor set is an uncountable null set.
2. Subadditivity already gives the inequality $\leq$.
3. Finite partial unions have measure equal to the sum of their component measures only because the pieces are disjoint.
4. Use $[n,\infty)$: every measure is infinite, while the intersection is empty.
5. Density supplies a separating number; countability ensures a measurable union.
6. Such open sets do not detect either infinite value.
7. Continuity is asserted for a restriction to a selected closed set. Values at nearby discarded points may still destroy continuity of the original function; $\mathbf1_{\mathbb Q}$ illustrates this.
8. Lusin approximates one function by a continuous function outside a small set. Egoroff strengthens convergence of a sequence to uniform convergence outside a small set.

### Clarifications Made in This Revision

- Replaced the incorrect claim about all unbounded sets containing nonmeasurable subsets with the positive-measure statement, and supplied $\mathbb Z$ as a counterexample to the original claim.
- Stated the open-preimage characterization for real-valued functions and explained the extra care needed for infinite values.
- Distinguished undefined subtraction $\infty-\infty$ from legitimate excision formulas.
- Distinguished finite limits from extended-real limits, and retained the original signed convention for the negative part.
- Clarified “finite measure” in Littlewood's first principle, the closed versus compact forms of Lusin's theorem, and the finite-measure requirement in Egoroff's theorem.
