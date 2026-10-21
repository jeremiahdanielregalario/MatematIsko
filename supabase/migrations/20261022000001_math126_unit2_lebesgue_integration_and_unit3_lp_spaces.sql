-- ============================================================================
-- MATH 126 Real Analysis:
-- 1. Move existing "Unit II: Lebesgue Spaces ($L^p$ Spaces)" note
--    (e2f6c7d8-8a9b-4c2d-9e4f-5a6b7c8d9e0f) to Unit III (sort_order = 3).
-- 2. Insert "Unit II: Lebesgue Integration"
--    (f3a7d8e9-9b0c-4d3e-8f5a-6b7c8d9e0f1a) at sort_order = 2.
-- Source files: notes/math126-unit2-review-guide.md, notes/math126-unit3-review-guide.md
-- ============================================================================

DO $migration$
BEGIN
  UPDATE public.course_notes
  SET
    title = 'Unit III: Lebesgue Spaces ($L^p$ Spaces)',
    content = $math126_u3$# Math 126: Real Analysis — Unit III

*A review guide to Lebesgue spaces, norms, and the inequalities connecting them*

## How the Unit Fits Together

Units I and II introduced measurable sets, measurable functions, and the Lebesgue integral. This unit asks a new question: **how can we measure the size of a function?**

Different notions of size lead to different spaces. The $L^1$ norm measures total absolute size, the $L^2$ norm measures size through squares, and the $L^\infty$ norm measures the largest magnitude after ignoring a set of measure zero.

The main proof sequence is:

1. Define $L^p$ spaces and explain why functions equal almost everywhere represent the same element.
2. Verify that these spaces are closed under linear combinations.
3. Establish the norm properties, using three connected inequalities: **Young controls a product of numbers; Hölder controls an integral of a product; Minkowski controls the norm of a sum.**
4. Use Hölder to compare different $L^p$ spaces when the domain has finite measure.

**How to review.** For each result, identify what it estimates, the exponents it requires, and the key step in its proof. Pay particular attention to endpoint cases such as $p=1$ and $p=\infty$.

### Standing Assumptions and Notation

Throughout, $\Omega\subseteq\mathbb R$ is Lebesgue measurable, and all functions are measurable. Integrals are Lebesgue integrals with respect to Lebesgue measure $m$:

$$
\int_\Omega h=\int_\Omega h(x)\,dm(x).
$$

We assume the basic facts about this integral from Unit II: monotonicity, linearity for integrable functions, invariance under changes on null sets, and the fact that a nonnegative measurable function has integral zero exactly when it is zero almost everywhere.

| Notation | Meaning |
| --- | --- |
| a.e. | Almost everywhere: outside a set of measure zero |
| $[f]$ | The class of functions equal to $f$ almost everywhere |
| $\|f\|_p$ | The $L^p(\Omega)$ norm, with the domain understood |
| $p'$ | The exponent conjugate to $p$ |
| $\mathbf1_A$ | The function equal to $1$ on $A$ and $0$ elsewhere |

Unless explicitly discussing $0<p<1$, the range in this unit is $1\leq p\leq\infty$.

## 1. Lebesgue Spaces: Which Functions Have Finite Size?

### Definition: The Spaces $L^p(\Omega)$

For $1\leq p<\infty$, the membership condition is

$$
f\in L^p(\Omega)
\quad\Longleftrightarrow\quad
\int_\Omega |f|^p<\infty.
$$

For $p=\infty$, the condition is essential boundedness:

$$
f\in L^\infty(\Omega)
\quad\Longleftrightarrow\quad
\text{there exists }M\geq0\text{ such that }|f|\leq M\text{ a.e. on }\Omega.
$$

**Meaning.** Finite $p$ measures size by integrating a power of the magnitude. The exponent $\infty$ uses an almost-everywhere bound instead of an integral. A function can be unbounded at exceptional points and still belong to $L^\infty$.

### Why Elements Are Equivalence Classes

Changing a function at one point—or on any null set—does not change its Lebesgue integral. It is therefore natural to identify functions that differ only on a null set.

Let $\mathcal F$ be the collection of measurable extended-real-valued functions that are finite almost everywhere. Define

$$
f\sim g\quad\Longleftrightarrow\quad f=g\text{ a.e. on }\Omega.
$$

Formally, $L^p(\Omega)$ is the **subset** of $\mathcal F/{\sim}$ consisting of equivalence classes satisfying the appropriate finiteness condition. It is not the entire quotient $\mathcal F/{\sim}$.

A representative that is infinite on a null set can be changed to zero there, giving a real-valued representative. We use such representatives when doing pointwise algebra. The resulting equivalence class does not depend on the representative chosen.

**Example.** The functions $0$ and $\mathbf1_{\mathbb Q\cap\Omega}$ represent the same element in every $L^p(\Omega)$, because the rationals form a null set. Thus “$f=0$ in $L^p$” means **$f=0$ almost everywhere**, not necessarily at every point.

This identification is essential for the norm axiom that only the zero element has norm zero.

### Proposition: Each $L^p(\Omega)$ Is a Linear Space

If $f,g\in L^p(\Omega)$ and $\alpha,\beta\in\mathbb R$, then $\alpha f+\beta g\in L^p(\Omega)$.

**Proof idea.** First show that a linear combination has finite size. We only need a rough estimate here; the sharper triangle inequality comes later.

**Finite exponents.** For $1\leq p<\infty$,

$$
\begin{aligned}
|\alpha f+\beta g|
&\leq |\alpha f|+|\beta g|\\
&\leq2\max\{|\alpha f|,|\beta g|\}.
\end{aligned}
$$

Raising to the power $p$ gives

$$
|\alpha f+\beta g|^p
\leq2^p\bigl(|\alpha|^p|f|^p+|\beta|^p|g|^p\bigr).
$$

Integrate and use the assumed finiteness of both integrals:

$$
\int_\Omega|\alpha f+\beta g|^p
\leq2^p|\alpha|^p\int_\Omega|f|^p
+2^p|\beta|^p\int_\Omega|g|^p
<\infty.
$$

**The exponent $\infty$.** Choose essential bounds $M_f,M_g$ for $f,g$. Outside the union of their two exceptional null sets,

$$
|\alpha f+\beta g|
\leq|\alpha|M_f+|\beta|M_g.
$$

A finite union of null sets is null, so this is an almost-everywhere bound. ∎

**Why prove this before Minkowski?** Later we will divide by a power of $\|f+g\|_p$. This proposition ensures that quantity is finite before the division is attempted.

## 2. Essential Supremum: Ignore Null Sets, Not Small Positive-Measure Sets

### Definition: Essential Bound and Essential Supremum of the Magnitude

A number $M\geq0$ is an **essential bound** for $f$ if $|f|\leq M$ almost everywhere. Define

$$
\operatorname*{ess\,sup}_{x\in\Omega}|f(x)|
=\inf\{M\geq0:|f|\leq M\text{ a.e. on }\Omega\}.
$$

If there is no finite essential bound, the value is $+\infty$.

We use $M\geq0$ so that the definition also gives zero on a null domain. Using $M>0$ gives the same infimum, but then zero itself is not in the set of allowed bounds.

**Notation matters.** The supplied notes write “$\operatorname{ess\,sup} f$” for this bound on $|f|$. We write the absolute value explicitly. In standard usage, the essential supremum of $f$ itself is an upper bound on signed values; it need not measure magnitude. For example, on $[0,1]$, the essential supremum of the constant function $-4$ is $-4$, but its $L^\infty$ norm is $4$.

### Example 1: Changing Endpoint Values

On $[0,1]$, let

$$
f(x)=
\begin{cases}
3,&x=0,\\
x,&0<x<1,\\
-4,&x=1.
\end{cases}
$$

The ordinary supremum of $|f|$ is $4$. However, the two endpoints form a null set, and $|f(x)|\leq1$ everywhere else. Hence $1$ is an essential bound.

No $M$ with $0\leq M<1$ is an essential bound: $|f(x)|>M$ on the interval $(M,1)$, which has positive measure. Therefore

$$
\operatorname*{ess\,sup}_{[0,1]}|f|=1.
$$

**Takeaway.** A null set can be ignored. An interval of small but positive length cannot be ignored when computing an essential supremum.

### Example 2: Unbounded but Essentially Zero

On $[0,1]$, let

$$
g(x)=
\begin{cases}
1/x,&x\in\mathbb Q\cap(0,1],\\
0,&x\in([0,1]\setminus\mathbb Q)\cup\{0\}.
\end{cases}
$$

Since $g(1/n)=n$, the function is unbounded. But $g$ is zero outside a countable set, so it is zero almost everywhere. Consequently,

$$
\operatorname*{ess\,sup}_{[0,1]}|g|=0.
$$

It represents the zero element of every $L^p([0,1])$.

### Lemma: The Infimum Is Itself an Almost-Everywhere Bound

If

$$
K=\operatorname*{ess\,sup}_\Omega|f|<\infty,
$$

then $|f|\leq K$ almost everywhere.

**Proof.** For every positive integer $n$, the definition of infimum supplies an essential bound $M_n<K+1/n$. Let $N_n$ be a null set outside which $|f|\leq M_n$. The union $N=\bigcup_n N_n$ is null. For every $x\notin N$, all inequalities hold simultaneously:

$$
|f(x)|\leq M_n<K+\frac1n
\quad\text{for every }n.
$$

Let $n\to\infty$ to obtain $|f(x)|\leq K$. ∎

**The important step.** We first choose one common exceptional null set, then take a pointwise limit outside it. The claim does not follow from dropping $1/n$ in a single inequality.

## 3. Norms: Turning Function Size into Distance

### Definition: Norm and Normed Linear Space

A **norm** on a real vector space $X$ assigns a finite number $\|f\|_X$ to each element and satisfies:

1. **Triangle inequality:** $\|f+g\|_X\leq\|f\|_X+\|g\|_X$.
2. **Absolute homogeneity:** $\|\alpha f\|_X=|\alpha|\,\|f\|_X$.
3. **Nonnegativity and definiteness:** $\|f\|_X\geq0$, with equality exactly when $f=0$ in $X$.

A vector space equipped with a norm is a **normed linear space**. The quantity $\|f-g\|_X$ measures the distance between two elements. On $\mathbb R$, the familiar example is $\|x\|=|x|$.

### The $L^p$ Norms

For finite $p$ and for $p=\infty$, respectively, set

$$
\|f\|_p=\left(\int_\Omega|f|^p\right)^{1/p},
\qquad
\|f\|_\infty=\operatorname*{ess\,sup}_\Omega|f|.
$$

Both expressions are unchanged when a representative is changed on a null set, so they are well-defined on equivalence classes.

### Why the $L^1$ Expression Is a Norm

The pointwise triangle inequality and monotonicity of integration give

$$
\begin{aligned}
\|f+g\|_1
&=\int_\Omega|f+g|\\
&\leq\int_\Omega(|f|+|g|)\\
&=\|f\|_1+\|g\|_1.
\end{aligned}
$$

Homogeneity follows by taking the constant $|\alpha|$ outside the integral:

$$
\|\alpha f\|_1=\int_\Omega|\alpha|\,|f|
=|\alpha|\,\|f\|_1.
$$

Nonnegativity is immediate, and definiteness follows from the zero-integral criterion:

$$
\|f\|_1=0
\quad\Longleftrightarrow\quad
f=0\text{ a.e.}
\quad\Longleftrightarrow\quad
[f]=[0].
$$

### Why the $L^\infty$ Expression Is a Norm

**Triangle inequality.** By the preceding lemma, outside a common null set,

$$
|f+g|\leq|f|+|g|\leq\|f\|_\infty+\|g\|_\infty.
$$

The right side is an essential bound, so

$$
\|f+g\|_\infty\leq\|f\|_\infty+\|g\|_\infty.
$$

**Homogeneity.** If $\alpha\neq0$, the condition $|\alpha f|\leq M$ a.e. is equivalent to $|f|\leq M/|\alpha|$ a.e. Thus essential bounds scale by $|\alpha|$, and so do their infima. If $\alpha=0$, both sides of the homogeneity identity are zero.

**Definiteness.** If the norm is zero, the lemma gives $|f|\leq0$ a.e., hence $[f]=[0]$. Conversely, if $f=0$ a.e., zero is an essential bound and the norm is zero.

### What Remains for $1<p<\infty$?

Nonnegativity, definiteness, and homogeneity follow directly from the integral formula. The substantial step is the triangle inequality, called **Minkowski's inequality**. We will prove it using Hölder's inequality, which in turn follows from Young's inequality.

**Caution about $0<p<1$.** The same integral expression can be defined, but it generally fails the triangle inequality. For example, on $(0,2)$ let $f=\mathbf1_{(0,1)}$ and $g=\mathbf1_{(1,2)}$. Then

$$
\|f\|_p=\|g\|_p=1,
\qquad
\|f+g\|_p=2^{1/p}>2
\quad(0<p<1).
$$

Thus this expression is not a norm in that range. The norm results in this unit require $p\geq1$.

## 4. Conjugate Exponents and Young's Inequality

### Definition: Conjugate Exponent

For $1<p<\infty$, the **conjugate exponent** $p'$ is determined by

$$
\frac1p+\frac1{p'}=1,
\qquad p'=\frac{p}{p-1}.
$$

At the endpoints, $1'=\infty$ and $\infty'=1$, with the convention $1/\infty=0$. Conjugating twice returns the original exponent: $(p')'=p$.

| $p$ | $p'$ |
| --- | --- |
| $1$ | $\infty$ |
| $3/2$ | $3$ |
| $2$ | $2$ |
| $4$ | $4/3$ |
| $\infty$ | $1$ |

For interior exponents, two useful algebraic identities are

$$
(p-1)p'=p,\qquad p(p'-1)=p'.
$$

**Why these pairs appear.** Raising a $(p-1)$st power to the $p'$th power produces a $p$th power. This is exactly the conversion needed in the proofs below.

### Theorem: Young's Inequality

If $1<p<\infty$ and $a,b\geq0$, then

$$
ab\leq\frac{a^p}{p}+\frac{b^{p'}}{p'}.
$$

**Meaning.** Young turns a product into a sum of powers. This makes the right side easy to integrate separately.

**Proof roadmap.** Prove a one-variable inequality whose minimum is zero, then rescale it to handle $a$ and $b$.

If either number is zero, the inequality is immediate. Otherwise, define

$$
\phi(t)=\frac{t^p}{p}+\frac1{p'}-t,
\qquad t>0.
$$

Its derivative is $\phi'(t)=t^{p-1}-1$, negative for $t<1$ and positive for $t>1$. Hence the minimum occurs at $t=1$, where

$$
\phi(1)=\frac1p+\frac1{p'}-1=0.
$$

Substitute $t=a/b^{p'-1}$ into $\phi(t)\geq0$. Using $p(p'-1)=p'$ gives

$$
\frac{a^p}{p\,b^{p'}}+\frac1{p'}
\geq\frac{a}{b^{p'-1}}.
$$

Multiply by $b^{p'}$ to obtain Young's inequality. ∎

**Equality check.** For positive $a,b$, equality occurs exactly when $t=1$, equivalently $a^p=b^{p'}$. The same condition includes the case $a=b=0$.

**Special case.** When $p=p'=2$,

$$
ab\leq\frac{a^2+b^2}{2},
$$

which is also a rearrangement of $(a-b)^2\geq0$.

## 5. Hölder's Inequality: Controlling Products

### Theorem: Hölder's Inequality

Let $1\leq p\leq\infty$, and let $p'$ be its conjugate. If $f\in L^p(\Omega)$ and $g\in L^{p'}(\Omega)$, then $fg\in L^1(\Omega)$ and

$$
\|fg\|_1=\int_\Omega|fg|
\leq\|f\|_p\,\|g\|_{p'}.
$$

**When to use it.** Look for an integral containing a product, and choose conjugate exponents matching the integrability you know for its two factors.

### Proof: Normalize, Apply Young, Integrate

If either norm is zero, the corresponding function is zero a.e., so the product is zero a.e. Now assume both norms are positive.

For $1<p<\infty$, set $a=|f(x)|/\|f\|_p$ and $b=|g(x)|/\|g\|_{p'}$. Young's inequality gives

$$
\frac{|f(x)g(x)|}{\|f\|_p\|g\|_{p'}}
\leq\frac{|f(x)|^p}{p\,\|f\|_p^p}
+\frac{|g(x)|^{p'}}{p'\,\|g\|_{p'}^{p'}}.
$$

Integrating the nonnegative functions yields

$$
\begin{aligned}
\frac{\int_\Omega|fg|}{\|f\|_p\|g\|_{p'}}
&\leq\frac{\int_\Omega|f|^p}{p\,\|f\|_p^p}
+\frac{\int_\Omega|g|^{p'}}{p'\,\|g\|_{p'}^{p'}}\\
&=\frac1p+\frac1{p'}=1.
\end{aligned}
$$

This proves both finiteness of the product integral and the inequality. **Normalization is the key:** it makes each power integral equal to one.

For $p=1$, use the essential bound directly:

$$
\int_\Omega|fg|
\leq\|g\|_\infty\int_\Omega|f|
=\|f\|_1\|g\|_\infty.
$$

The case $p=\infty$ follows by exchanging $f$ and $g$. ∎

### Special Case: Cauchy–Schwarz

For $p=p'=2$, Hölder becomes

$$
\int_\Omega|fg|
\leq\left(\int_\Omega|f|^2\right)^{1/2}
\left(\int_\Omega|g|^2\right)^{1/2}.
$$

In particular, $|\int_\Omega fg|\leq\|f\|_2\|g\|_2$, since the absolute value of an integral is at most the integral of the absolute value.

### A Function That Achieves Equality

For every nonzero $f\in L^p(\Omega)$ with $1\leq p<\infty$, we can find $f^*\in L^{p'}(\Omega)$ such that

$$
\|f^*\|_{p'}=1,
\qquad\int_\Omega f f^*=\|f\|_p.
$$

Here nonzero means nonzero as an equivalence class, so $\|f\|_p>0$.

**Interior case: $1<p<\infty$.** Define

$$
f^*=\|f\|_p^{1-p}\operatorname{sgn}(f)|f|^{p-1},
$$

where

$$
\operatorname{sgn}(t)=
\begin{cases}
1,&t>0,\\
0,&t=0,\\
-1,&t<0.
\end{cases}
$$

The sign ensures that $ff^*$ is nonnegative. The power $p-1$ is chosen so that taking the $p'$th power produces $|f|^p$. Indeed,

$$
\int_\Omega|f^*|^{p'}
=\|f\|_p^{-p}\int_\Omega|f|^p=1,
$$

and

$$
\int_\Omega ff^*
=\|f\|_p^{1-p}\int_\Omega|f|^p
=\|f\|_p.
$$

**Endpoint case: $p=1$.** Define $f^*=\operatorname{sgn}(f)$ directly. Then $ff^*=|f|$. Also, since $f$ is not zero a.e., the set where $|f^*|=1$ has positive measure. Thus $\|f^*\|_\infty=1$ and $\int_\Omega ff^*=\|f\|_1$.

**Why separate the endpoint?** The power-integral computation above uses finite $p'$. At $p=1$, we instead need an essential-supremum argument, and the direct definition avoids an ambiguous $0^0$ expression. This equality construction is asserted here for finite $p$ only.

## 6. Minkowski's Inequality: Controlling Sums

### Theorem: Minkowski's Inequality

If $1\leq p\leq\infty$ and $f,g\in L^p(\Omega)$, then

$$
\|f+g\|_p\leq\|f\|_p+\|g\|_p.
$$

This is the triangle inequality for $L^p$. Together with the other norm properties, it proves that every $L^p(\Omega)$ in this range is a normed linear space.

### Proof: Turn the Power of a Sum into Products

The cases $p=1$ and $p=\infty$ were proved in Section 3. Assume $1<p<\infty$.

We already know $f+g\in L^p$. Define $h=|f+g|^{p-1}$. Since $(p-1)p'=p$,

$$
\int_\Omega h^{p'}=\int_\Omega|f+g|^p<\infty,
$$

so $h\in L^{p'}$, and

$$
\|h\|_{p'}
=\left(\int_\Omega|f+g|^p\right)^{1/p'}
=\|f+g\|_p^{p-1}.
$$

Now use the pointwise triangle inequality, followed by Hölder on each product:

$$
\begin{aligned}
\|f+g\|_p^p
&=\int_\Omega|f+g|^p\\
&\leq\int_\Omega|f|h+\int_\Omega|g|h\\
&\leq\bigl(\|f\|_p+\|g\|_p\bigr)\|h\|_{p'}\\
&=\bigl(\|f\|_p+\|g\|_p\bigr)\|f+g\|_p^{p-1}.
\end{aligned}
$$

If $\|f+g\|_p=0$, the desired inequality is immediate. Otherwise divide by its positive, finite $(p-1)$st power. ∎

**Proof to remember.** Factor off $|f+g|^{p-1}$, apply Hölder twice, and divide. Checking that the factor belongs to $L^{p'}$ makes the argument valid.

## 7. Comparing $L^p$ Spaces on a Finite-Measure Domain

The three inequalities hold without assuming that $m(\Omega)$ is finite. The inclusion results that follow need this additional hypothesis.

### Example: Essentially Bounded Functions Belong to Every Finite $L^p$

Suppose $m(\Omega)<\infty$ and $f\in L^\infty(\Omega)$. For $1\leq p<\infty$,

$$
\int_\Omega|f|^p
\leq\|f\|_\infty^p m(\Omega)<\infty.
$$

Therefore $f\in L^p(\Omega)$, with

$$
\|f\|_p\leq m(\Omega)^{1/p}\|f\|_\infty.
$$

This solves the original seatwork for a **bounded measurable** domain, because bounded measurable subsets of $\mathbb R$ have finite measure. Finite measure is the actual property the proof uses; the domain need not be bounded.

### Corollary: Inclusion from Larger to Smaller Exponents

If $m(\Omega)<\infty$ and $1\leq p\leq q\leq\infty$, then

$$
L^q(\Omega)\subseteq L^p(\Omega).
$$

For $0<m(\Omega)<\infty$, the norm estimate is

$$
\|f\|_p
\leq m(\Omega)^{\frac1p-\frac1q}\|f\|_q,
\qquad f\in L^q(\Omega), \tag{1}
$$

with $1/\infty=0$. If $m(\Omega)=0$, every class in every space is zero, so the inclusion and norm comparison are trivial; no expression involving $0^0$ is needed.

**Proof.** When $p=q$, the estimate is equality with constant $1$. This also handles $p=q=\infty$.

When $p<q=\infty$, use the preceding example. It remains to consider $p<q<\infty$. Apply Hölder to the two factors $|f|^p$ and $1$, with conjugate exponents

$$
s=\frac qp>1,
\qquad s'=\frac q{q-p}.
$$

The first factor belongs to $L^s$ because $(|f|^p)^s=|f|^q$ is integrable. The second belongs to $L^{s'}$ because the domain has finite measure. Thus

$$
\begin{aligned}
\int_\Omega|f|^p
&=\int_\Omega|f|^p\cdot1\\
&\leq\left(\int_\Omega|f|^q\right)^{p/q}
\left(\int_\Omega1\right)^{(q-p)/q}\\
&=\|f\|_q^p m(\Omega)^{(q-p)/q}.
\end{aligned}
$$

Taking the $p$th root yields (1), since $(q-p)/(pq)=1/p-1/q$. ∎

**Intuition.** On a finite-measure domain, integrability to a larger power controls integrability to a smaller power. The factor involving $m(\Omega)$ accounts for the size of the domain. When $m(\Omega)=1$, the estimate simplifies to $\|f\|_p\leq\|f\|_q$.

### Two Examples That Prevent Common Mistakes

**The reverse inclusion can fail, even on a finite interval.** On $(0,1)$, let $f(x)=x^{-1/2}$. Then

$$
\int_0^1|f(x)|\,dx=2,
\qquad
\int_0^1|f(x)|^2\,dx=\int_0^1\frac{dx}{x}=\infty.
$$

So $f\in L^1(0,1)$ but $f\notin L^2(0,1)$.

**Finite measure cannot simply be dropped.** On $\mathbb R$, the constant function $1$ belongs to $L^\infty$ but not to any finite $L^p$. Even for two finite exponents, take $g(x)=1/x$ on $(1,\infty)$:

$$
\int_1^\infty|g(x)|^2\,dx=1,
\qquad
\int_1^\infty|g(x)|\,dx=\infty.
$$

Thus $L^2(1,\infty)$ is not contained in $L^1(1,\infty)$.

## Review Map

| Result | What it controls | Key idea or hypothesis |
| --- | --- | --- |
| Equivalence classes | Changes on null sets | Equality in $L^p$ means equality a.e. |
| Essential supremum of $\lvert f\rvert$ | Almost-everywhere magnitude | Ignore null sets, not positive-measure sets. |
| Young | A product of nonnegative numbers | Use conjugate powers; $1<p<\infty$. |
| Hölder | The integral of a product | Normalize, apply Young, integrate; handle endpoints separately. |
| Equality construction | A function paired with a unit-norm partner | Use the signed $(p-1)$st power for $1<p<\infty$; the sign for $p=1$. |
| Minkowski | The norm of a sum | Apply Hölder to a factor of $\lvert f+g\rvert^{p-1}$. |
| Finite-measure inclusion | Membership in different $L^p$ spaces | If $p\leq q$, then $L^q\subseteq L^p$ when the domain has finite measure. |

### Choosing an Inequality

- **A product of numbers:** try Young.
- **An integral of a product:** try Hölder and identify the conjugate exponents.
- **A sum inside a norm:** try Minkowski.
- **A smaller exponent on a finite-measure domain:** write the integrand as $|f|^p\cdot1$, then apply Hölder.
- **An $L^\infty$ factor:** use its almost-everywhere bound directly.

### Self-Check Questions

1. Why do we identify functions equal almost everywhere before calling $\|\cdot\|_p$ a norm?
2. Can a pointwise unbounded function have $L^\infty$ norm zero?
3. What justifies passing from essential bounds $K+1/n$ to the bound $K$?
4. Find the conjugate of $p=5/3$.
5. Why does the proof of Hölder divide by the two norms before applying Young?
6. What is the equality partner $f^*$ when $p=1$? When $p=2$?
7. Where does the proof of Minkowski use the earlier linear-space result?
8. If $m(\Omega)=4$, what does (1) give for $\|f\|_1$ in terms of $\|f\|_2$?
9. What fails in the inclusion proof when $m(\Omega)=\infty$?
10. Why is the range $0<p<1$ excluded from the norm theorem?

### Hints and Short Answers

1. A function supported on a null set has norm zero even if it is not pointwise zero. Equivalence classes make it the zero element.
2. Yes: the rational-point example in Section 2 is unbounded but zero a.e.
3. The union of the countably many exceptional null sets is still null; outside that union all bounds hold simultaneously.
4. $p'=5/2$, since $3/5+2/5=1$.
5. Normalization makes the integrals of the two powers equal to one, leaving the sum $1/p+1/p'=1$.
6. For nonzero $f$, use $\operatorname{sgn}(f)$ at $p=1$, and $f/\|f\|_2$ at $p=2$.
7. It ensures $f+g\in L^p$, so the Hölder factor is integrable to the required power and the final division is by a finite quantity.
8. $\|f\|_1\leq2\|f\|_2$.
9. The constant function $1$ need not belong to the required finite-exponent space.
10. The proposed expression can fail the triangle inequality, as shown by two disjoint indicator functions.

### Clarifications Made in This Revision

- Described $L^p$ precisely as the appropriate subset of the quotient by almost-everywhere equality.
- Wrote the essential supremum of the **absolute value** explicitly and supplied the common-null-set argument for its almost-everywhere bound.
- Corrected the norm range to $1\leq p\leq\infty$, with a counterexample for $0<p<1$.
- Included zero inputs in Young's inequality so it applies directly to functions that vanish.
- Separated the $p=1$ equality partner in Hölder from the finite-conjugate-exponent computation.
- Used $p'$ consistently in Minkowski's proof, replacing the unexplained auxiliary exponent in the source.
- Handled equal exponents, both infinite exponents, and null domains separately in the inclusion corollary.

For a standard reference on the norm range, equivalence-class convention, and essential-supremum definition, see Chapter 7 of [John K. Hunter's Measure Theory notes](https://www.math.ucdavis.edu/~hunter/measure_theory/measure_notes.pdf). The organization and expanded explanations above follow the supplied Unit III material.
$math126_u3$,
    sort_order = 3,
    updated_at = now()
  WHERE id = 'e2f6c7d8-8a9b-4c2d-9e4f-5a6b7c8d9e0f'
    AND course_id = 'c0000000-0000-4000-8000-000000000004';

  IF NOT FOUND THEN
    RAISE EXCEPTION 'Expected Math 126 L^p Spaces note (e2f6c7d8-8a9b-4c2d-9e4f-5a6b7c8d9e0f) is missing';
  END IF;

  INSERT INTO public.course_notes (id, course_id, title, content, sort_order)
  VALUES (
    'f3a7d8e9-9b0c-4d3e-8f5a-6b7c8d9e0f1a',
    'c0000000-0000-4000-8000-000000000004',
    'Unit II: Lebesgue Integration',
    $math126_u2$# Math 126: Real Analysis — Unit II

*A review guide to Lebesgue integration and the convergence theorems*

## How the Unit Fits Together

Unit I built a notion of size—**Lebesgue measure**—for sets and identified **measurable functions** whose level sets can be measured. This unit answers the next central question: **how do we integrate measurable functions, and when can we interchange a limit and an integral?**

In calculus, the **Riemann integral** slices the domain $[a,b]$ vertically into narrow subintervals $[x_{k-1},x_k]$. That works well when a function varies slowly on short intervals, but it breaks down for oscillating or everywhere-discontinuous functions (such as the Dirichlet function $\chi_{\mathbb Q\cap[0,1]}$) and requires restrictive uniform-convergence assumptions to pass limits inside the integral.

**Lebesgue's key idea is to slice the range horizontally instead of the domain vertically.** Given a target range of values $[y_{k-1},y_k)$, we ask for the set of inputs $E_k=\{x\in E:y_{k-1}\leq f(x)<y_k\}$ and multiply the height by the measure $m(E_k)$. Because $f$ is measurable, each level set $E_k$ is a measurable set!

To carry this idea out rigorously, we construct the Lebesgue integral in **four cumulative stages**, where each stage defines its integral using the stage right before it:

1. **Stage 1 — Simple functions (on sets of finite measure):** functions taking finitely many values, written as $\varphi=\sum_{i=1}^n a_i\chi_{E_i}$, have the natural integral $\sum_{i=1}^n a_i m(E_i)$.
2. **Stage 2 — Bounded measurable functions (on sets of finite measure):** squeeze $f$ between simple functions from below and above. The **Simple Approximation Lemma** guarantees that the lower and upper Lebesgue integrals agree, and **Egoroff's theorem** yields the **Bounded Convergence Theorem (BCT)**.
3. **Stage 3 — Nonnegative measurable functions (on arbitrary measurable sets):** approximate $f\geq0$ from below by bounded measurable functions of finite support. This stage gives **Chebyshev's inequality**, the **zero-integral criterion**, **Fatou's Lemma**, the **Monotone Convergence Theorem (MCT)**, and **Beppo Levi's Lemma**.
4. **Stage 4 — General measurable functions (on arbitrary measurable sets):** split $f=f^+-f^-$ into two nonnegative measurable functions. When $\int_E|f|<\infty$, both parts have finite integrals, and Fatou's Lemma upgrades to the **Lebesgue Dominated Convergence Theorem (LDCT)**.

**How to review.** Keep track of which stage you are in and which hypotheses belong to that stage. When proving a property at Stage $k$, your primary tool is to reduce the statement to Stage $k-1$. When applying a convergence theorem, always check the three hypotheses: **domain measure**, **monotonicity or domination**, and **pointwise a.e. convergence**.

### Standing Assumptions and Notation

Throughout this unit, $E\subseteq\mathbb R$ denotes a Lebesgue measurable set, and $m$ denotes Lebesgue measure. Write $\mathbb N=\{1,2,3,\ldots\}$.

| Notation | Meaning |
| --- | --- |
| a.e. | Almost everywhere: for all $x\in E\setminus E_0$, where $E_0\subseteq E$ has $m(E_0)=0$ |
| $\chi_A$ | Characteristic (indicator) function of $A$: equal to $1$ on $A$ and $0$ outside $A$ |
| $L^{(L)}(f),\ U^{(L)}(f)$ | Lower and upper Lebesgue integrals of a bounded function $f$ on a finite-measure set |
| $(R)\int_a^b f$ | Riemann integral of $f$ over $[a,b]$ |
| $\int_E f$ | Lebesgue integral of $f$ over $E$ |
| $\operatorname{supp} f$ | Measure-theoretic support $\{x\in E:f(x)\neq0\}$ |
| $A_f$ | Set of integrals $\int_E h$ for bounded measurable $h$ of finite support with $0\leq h\leq f$ |
| $f^+,\ f^-$ | Positive and negative parts $\max\{f,0\}$ and $\max\{-f,0\}=-\min\{f,0\}$ |

**Two conventions to watch carefully:**

- **Support of a function:** In this course, $\operatorname{supp} f=\{x\in E:f(x)\neq0\}$ (the set where $f$ is nonzero), whereas some topology and analysis texts define $\operatorname{supp} f$ as the closure $\overline{\{x\in E:f(x)\neq0\}}$.
- **Negative part $f^-$:** In Unit II, both $f^+=\max\{f,0\}$ and $f^-=\max\{-f,0\}=-\min\{f,0\}$ are **nonnegative** functions, so $f=f^+-f^-$ and $|f|=f^++f^-$. This allows us to apply Stage 3 (nonnegative functions) directly to both $f^+$ and $f^-$.

---

## 1. Almost Everywhere Properties and Simple Functions

Before defining the integral, we formalize what it means to ignore a set of measure zero and introduce the building blocks of Lebesgue integration: characteristic functions and simple functions.

### 1.1 Properties Holding Almost Everywhere

#### Definition: Almost Everywhere (a.e.)

For a measurable set $E$, a property is said to hold **almost everywhere** (abbreviated **a.e.**) on $E$ provided that there exists a subset $E_0\subseteq E$ with $m(E_0)=0$ such that the property holds for every $x\in E\setminus E_0$.

---

**Remarks on the exceptional set $E_0$:**

1. **Measure is unchanged:** $m(E\setminus E_0)=m(E)$, because $E=(E\setminus E_0)\sqcup E_0$ and $m(E_0)=0$.
2. **Measurability is preserved:** Every set of outer measure zero is measurable (by completeness of Lebesgue measure from Unit I), so $E_0$ and $E\setminus E_0$ are automatically measurable whenever $E$ is measurable.

#### Definition: Pointwise Convergence Almost Everywhere

For a sequence $\{f_n\}$ of functions on a measurable set $E$, we say that $f_n$ **converges pointwise almost everywhere** (or simply **converges a.e.**) to $f$ on $E$ if there exists $E_0\subseteq E$ with $m(E_0)=0$ such that

$$
\lim_{n\to\infty}f_n(x)=f(x)\qquad\text{for all }x\in E\setminus E_0.
$$

More generally, on a measurable subset $A\subseteq E$, we say $f_n\to f$ pointwise a.e. on $A$ if $f_n$ converges pointwise to $f$ on $A\setminus B$ for some $B\subseteq A$ with $m(B)=0$.

---

In Unit I we saw that the pointwise limit everywhere on $E$ of measurable functions is measurable. Because Lebesgue measure is complete, the same conclusion holds when convergence fails on a set of measure zero.

#### Proposition: Pointwise a.e. Limit of Measurable Functions Is Measurable

Let $\{f_n\}$ be a sequence of measurable functions on $E$ that converges pointwise a.e. on $E$ to a function $f$. Then $f$ is measurable.

**Proof.** Let $E_0\subseteq E$ with $m(E_0)=0$ be the exceptional set outside which $f_n(x)\to f(x)$, and let $c\in\mathbb R$. On $E\setminus E_0$, a point $x$ satisfies $f(x)<c$ if and only if there is a positive gap $1/n$ ($n\in\mathbb N$) and a tail index $k\in\mathbb N$ such that $f_j(x)<c-1/n$ for all $j\geq k$. On the whole set $E$, one can write the level set as

$$
\{x\in E:f(x)<c\}
=\bigcup_{n=1}^{\infty}\bigcup_{k=1}^{\infty}
\left(
\bigcap_{j=k}^{\infty}
\underbrace{\left\{x\in E:f_j(x)<c-\frac1n\right\}}_{\text{measurable}}
\right)
$$

up to points inside the measure-zero set $E_0$ (and any subset of $E_0$ has outer measure zero and is therefore measurable). Since each $f_j$ is measurable and the class of measurable sets is closed under countable intersections and countable unions, $\{x\in E:f(x)<c\}$ is measurable. Therefore $f$ is measurable. ∎

**Simplified thinking.** Why does the inner condition use $c-1/n$ instead of $c$? Because an infinite intersection of strict inequalities $f_j(x)<c$ only guarantees $\lim_{j\to\infty}f_j(x)\leq c$ (for instance, $c-1/j<c$ has limit $c$). Stepping back by a fixed buffer $1/n$ ensures that the limit is at most $c-1/n<c$.

---

### 1.2 Simple Functions and the Simple Approximation Lemma

We will build the Lebesgue integral in four stages:

1. **Simple functions** (on sets of finite measure)
2. **Bounded functions** (on sets of finite measure)
3. **Nonnegative functions** (on arbitrary measurable sets)
4. **General measurable functions** (on arbitrary measurable sets)

The simplest nontrivial measurable functions are those that only switch between $1$ and $0$.

#### Definition: Characteristic Function

Let $A\subseteq\mathbb R$. The **characteristic function** (or **indicator function**) of $A$, denoted $\chi_A:\mathbb R\to\mathbb R$, is defined by

$$
\chi_A(x)=
\begin{cases}
1, & \text{if }x\in A,\\
0, & \text{if }x\notin A.
\end{cases}
$$

---

**Remark.** The function $\chi_A$ is measurable if and only if the set $A$ is measurable, because for $c\in\mathbb R$,

$$
\{x\in\mathbb R:\chi_A(x)>c\}=
\begin{cases}
\mathbb R, & c<0,\\
A, & 0\leq c<1,\\
\varnothing, & c\geq1.
\end{cases}
$$

#### Definition: Simple Function

A real-valued function $\varphi$ defined on a measurable set $E$ is called **simple** provided it is measurable and takes only a finite number of values.

---

**Examples of simple functions:**

- $\chi_A$, whenever $A$ is a measurable set.
- The floor function $\lfloor x\rfloor$ on $0\leq x\leq 10$, which takes the $11$ integer values $\{0,1,2,\ldots,10\}$ on intervals. This is a **step function** (and every step function is simple).
- The Dirichlet function $\chi_{\mathbb Q}$, which takes only the two values $0$ and $1$ on the measurable sets $\mathbb Q^c$ and $\mathbb Q$. It is **simple**, but it is **not a step function** because $\mathbb Q$ cannot be written as a finite union of intervals.

#### Canonical Representation of a Simple Function

Suppose $\varphi:E\to\mathbb R$ is a simple function, and let $\{a_k\}_{k=1}^n$ be the collection of **distinct** values taken by $\varphi$. For each $k\in\{1,2,\ldots,n\}$, define the level set

$$
E_k=\{x\in E:\varphi(x)=a_k\}=\varphi^{-1}(\{a_k\}).
$$

Each $E_k$ is measurable because $\varphi$ is measurable. Moreover:

1. **The sets $\{E_k\}_{k=1}^n$ are pairwise disjoint:** if there existed $x\in E_j\cap E_k$ with $j\neq k$, then $\varphi(x)=a_j$ and $\varphi(x)=a_k$, which would force $a_j=a_k$, contradicting the assumption that the values $a_1,\ldots,a_n$ are distinct.
2. **They partition $E$:** every $x\in E$ must map to one of the values of $\varphi$, so $x\in E_k$ for a unique index $k\in\{1,2,\ldots,n\}$. At that point $x$,

$$
\sum_{j=1}^n a_j\underbrace{\chi_{E_j}(x)}_{\substack{=1\text{ if }j=k\\=0\text{ if }j\neq k}}=a_k=\varphi(x).
$$

Thus we can write $\varphi$ on $E$ as

$$
\varphi=\sum_{k=1}^n a_k\chi_{E_k}. \tag{1}
$$

Equation $(1)$—where $a_1,\ldots,a_n$ are the **distinct** values of $\varphi$ and $E_k=\varphi^{-1}(\{a_k\})$—is called the **canonical representation** of $\varphi$.

---

The next lemma is the bridge from Stage 1 (simple functions) to Stage 2 (bounded measurable functions). It shows that any bounded measurable function can be sandwiched tightly between two simple functions.

#### Lemma: The Simple Approximation Lemma (SAL)

Let $f$ be a measurable real-valued function on $E$. Assume $f$ is bounded; that is, there exists $M>0$ such that

$$
|f(x)|\leq M\qquad\text{for all }x\in E.
$$

Then for every $\varepsilon>0$, there exist simple functions $\varphi_\varepsilon$ and $\psi_\varepsilon$ on $E$ such that

$$
\varphi_\varepsilon\leq f\leq\psi_\varepsilon
\quad\text{and}\quad
0\leq\psi_\varepsilon-\varphi_\varepsilon<\varepsilon
\quad\text{on }E,
$$

or equivalently,

$$
\varphi_\varepsilon(x)\leq f(x)\leq\psi_\varepsilon(x)
\quad\text{and}\quad
0\leq\psi_\varepsilon(x)-\varphi_\varepsilon(x)<\varepsilon
\qquad\text{for all }x\in E.
$$

**Proof.** Since $f$ is bounded by $M>0$ on $E$, every value $f(x)$ lies in $[-M,M]\subset(-M-1,M+1)$. That is,

$$
\{y\in\mathbb R:y=f(x)\text{ for some }x\in E\}\subseteq(-M-1,M+1)=(c,d),
$$

where we set $c=-M-1$ and $d=M+1$.

Let $\varepsilon>0$. Choose a partition $P=\{y_0,y_1,\ldots,y_n\}$ of $[c,d]$ such that

$$
c=y_0<y_1<y_2<\cdots<y_n=d
\quad\text{and}\quad
y_k-y_{k-1}<\varepsilon
\quad\text{for all }k\in\{1,2,\ldots,n\}.
$$

For each $k\in\{1,2,\ldots,n\}$, define the half-open range strip $I_k=[y_{k-1},y_k)$ and its preimage in $E$:

$$
E_k=f^{-1}(I_k)=\{x\in E:f(x)\in I_k\}=\{x\in E:y_{k-1}\leq f(x)<y_k\}.
$$

Because $f$ is measurable, each $E_k$ is a measurable subset of $E$. Furthermore, since the intervals $I_1,\ldots,I_n$ are pairwise disjoint and cover $[c,d)\supseteq[-M,M]$, the sets $E_1,\ldots,E_n$ are pairwise disjoint and their union is $E$.

Now define the simple functions $\varphi_\varepsilon$ and $\psi_\varepsilon$ on $E$ by

$$
\varphi_\varepsilon(x)=\sum_{k=1}^n y_{k-1}\chi_{E_k}(x)
\quad\text{and}\quad
\psi_\varepsilon(x)=\sum_{k=1}^n y_k\chi_{E_k}(x),
\qquad x\in E.
$$

To verify that $\varphi_\varepsilon$ and $\psi_\varepsilon$ satisfy the conclusion, let $x\in E$. By construction of $\{E_k\}_{k=1}^n$, there is a unique index $j\in\{1,2,\ldots,n\}$ such that $x\in E_j$. Then $\chi_{E_k}(x)=1$ for $k=j$ and $0$ for $k\neq j$, while $f(x)\in I_j=[y_{j-1},y_j)$. Therefore

$$
\varphi_\varepsilon(x)=y_{j-1}\leq f(x)<y_j=\psi_\varepsilon(x),
$$

and

$$
0\leq\psi_\varepsilon(x)-\varphi_\varepsilon(x)=y_j-y_{j-1}<\varepsilon.
$$

∎

**Simplified thinking (why measurability + boundedness are both used):**

- **Boundedness** puts the entire range of $f$ inside a finite interval $[c,d]$, so we only need **finitely many** horizontal strips $I_k=[y_{k-1},y_k)$ of height less than $\varepsilon$. Finitely many strips means $\varphi_\varepsilon$ and $\psi_\varepsilon$ take only finitely many values.
- **Measurability** guarantees that each pullback set $E_k=f^{-1}([y_{k-1},y_k))$ is measurable, so $\varphi_\varepsilon$ and $\psi_\varepsilon$ are measurable simple functions.

---

## 2. Stage 1: Integral of Simple Functions

We begin on sets $E$ of **finite measure** ($m(E)<\infty$) so that multiplying any value of a simple function by the measure of its level set always produces a finite real number.

### Definition: Integral of a Simple Function

For a simple function $\varphi$ defined on a measurable set $E$ of finite measure, we define the **integral of $\varphi$ over $E$** by

$$
\int_E\varphi=\sum_{i=1}^n a_i m(E_i),
$$

where

$$
\varphi=\sum_{i=1}^n a_i\chi_{E_i}
$$

is the **canonical representation** of $\varphi$; that is, $\{a_i\}_{i=1}^n$ are the distinct values taken by $\varphi$ on $E$ and $E_i=\varphi^{-1}(\{a_i\})=\{x\in E:\varphi(x)=a_i\}$.

---

In practice, we often write a simple function as a sum $\sum_{i=1}^n a_i\chi_{E_i}$ where the numbers $a_i$ are **not necessarily distinct** (for instance, when combining two simple functions on a common partition). The next lemma shows that the same formula still computes the integral as long as the sets $E_i$ are disjoint.

### Lemma: Integral Under Disjoint Representations

Let $\{E_i\}_{i=1}^n$ be a collection of pairwise disjoint measurable subsets of a set $E$ of finite measure (partitioning $E$, or with $\varphi=0$ outside $\bigcup_{i=1}^n E_i$). For $1\leq i\leq n$, let $a_i\in\mathbb R$. If

$$
\varphi=\sum_{i=1}^n a_i\chi_{E_i}, \tag{1}
$$

then

$$
\int_E\varphi=\sum_{i=1}^n a_i m(E_i).
$$

**Proof.** Note first that since $\{E_i\}_{i=1}^n$ is pairwise disjoint and $\chi_{E_i}(x)=1\iff x\in E_i$, we have $\varphi(x)=a_i$ for every $x\in E_i$ (and if $\bigcup_{i=1}^n E_i\subsetneq E$, we may adjoin $E_0=E\setminus\bigcup_{i=1}^n E_i$ with $a_0=0$ without changing either side).

Let $\{\lambda_j\}_{j=1}^m$ be the collection of **distinct** values taken by $\varphi$, and for each $1\leq j\leq m$ set

$$
A_j=\varphi^{-1}(\{\lambda_j\})=\{x\in E:\varphi(x)=\lambda_j\}.
$$

Then $\varphi=\sum_{j=1}^m\lambda_j\chi_{A_j}$ is the canonical representation of $\varphi$, so by definition

$$
\int_E\varphi=\sum_{j=1}^m\lambda_j m(A_j).
$$

For each $j\in\{1,2,\ldots,m\}$, collect the indices that share the value $\lambda_j$:

$$
I_j=\{i\in\{1,2,\ldots,n\}:a_i=\lambda_j\}.
$$

Then $\{I_j\}_{j=1}^m$ partitions $\{1,2,\ldots,n\}$ and

$$
A_j=\bigcup_{i\in I_j}E_i.
$$

Because the sets $E_i$ are pairwise disjoint and measurable, **finite additivity** of Lebesgue measure gives

$$
m(A_j)=m\left(\bigcup_{i\in I_j}E_i\right)=\sum_{i\in I_j}m(E_i).
$$

Grouping the sum by the index sets $I_j$, we obtain

$$
\begin{aligned}
\sum_{i=1}^n a_i m(E_i)
&=\sum_{j=1}^m\sum_{i\in I_j}a_i m(E_i)\\
&=\sum_{j=1}^m\sum_{i\in I_j}\lambda_j m(E_i)\\
&=\sum_{j=1}^m\lambda_j\sum_{i\in I_j}m(E_i)\\
&=\sum_{j=1}^m\lambda_j m(A_j)\\
&=\int_E\varphi.
\end{aligned}
$$

∎

### Examples: Characteristic Functions and the Dirichlet Function

1. **Integral of a characteristic function:** For any measurable subset $A$ of a finite-measure set $E$,

$$
\int_E\chi_A=m(A),
$$

   since $\chi_A=1\cdot\chi_A+0\cdot\chi_{E\setminus A}$ has integral $1\cdot m(A)+0\cdot m(E\setminus A)=m(A)$.

2. **The Dirichlet function on $E=[0,1]$:** Let

$$
\varphi(x)=
\begin{cases}
1, & \text{if }x\in\mathbb Q\cap[0,1],\\
0, & \text{if }x\in\mathbb Q^c\cap[0,1].
\end{cases}
$$

   Its canonical representation is

$$
\varphi=1\cdot\chi_{\mathbb Q\cap[0,1]}+0\cdot\chi_{\mathbb Q^c\cap[0,1]}.
$$

   Since $\mathbb Q\cap[0,1]$ is countable, $m(\mathbb Q\cap[0,1])=0$, while $m(\mathbb Q^c\cap[0,1])=1$. Therefore

$$
\begin{aligned}
\int_{[0,1]}\varphi
&=1\cdot m(\mathbb Q\cap[0,1])+0\cdot m(\mathbb Q^c\cap[0,1])\\
&=1\cdot 0+0\cdot 1\\
&=0.
\end{aligned}
$$

   Notice that $\varphi$ is **not Riemann integrable** on $[0,1]$ (every subinterval contains both rationals and irrationals, so $L(\varphi)=0\neq 1=U(\varphi)$), yet it is Lebesgue integrable with integral $0$.

---

To add two simple functions $\varphi$ and $\psi$, their canonical partitions might not match. The trick is to refine both partitions into a single **common disjoint partition** on which both $\varphi$ and $\psi$ are constant, and then apply the preceding lemma.

### Proposition: Linearity and Monotonicity for Simple Functions

Let $\varphi$ and $\psi$ be simple functions defined on a set $E$ of finite measure.

1. **(Linearity)** For any $\alpha,\beta\in\mathbb R$,

$$
\int_E(\alpha\varphi+\beta\psi)=\alpha\int_E\varphi+\beta\int_E\psi.
$$

2. **(Monotonicity)** If $\varphi\leq\psi$ on $E$ (that is, $\varphi(x)\leq\psi(x)$ for all $x\in E$), then

$$
\int_E\varphi\leq\int_E\psi.
$$

**Proof.** Let $\varphi$ and $\psi$ be simple functions on a finite-measure set $E$. If $\varphi$ is constant on pairwise disjoint measurable sets $\{A_j\}_{j=1}^p$ partitioning $E$ and $\psi$ is constant on pairwise disjoint measurable sets $\{B_k\}_{k=1}^q$ partitioning $E$, then the non-empty intersections $E_i=A_j\cap B_k$ form a disjoint collection $\{E_i\}_{i=1}^n$ of measurable subsets of $E$ such that **both $\varphi$ and $\psi$ are constant on each $E_i$**.

**Concrete example of refining to a common partition:** Suppose on $E=[0,7]$ we have

$$
\varphi(x)=
\begin{cases}
1, & x\in[0,1],\\
2, & x\in(1,3),\\
3, & x\in[3,7],
\end{cases}
\qquad
\psi(x)=
\begin{cases}
-4, & x\in[0,2],\\
-3, & x\in(2,5],\\
-2, & x\in(5,6),\\
-1, & x\in[6,7].
\end{cases}
$$

On the coarse pieces $[0,1]$, $(1,3)$, $[3,7]$, the function $\psi$ is not constant (for instance, on $(1,3)$ it takes both $-4$ and $-3$). Taking pairwise intersections produces the $6$-piece common refinement on which both functions are constant, even though the values in each row are no longer distinct:

| Function | $[0,1]$ | $(1,2]$ | $(2,3)$ | $[3,5]$ | $(5,6)$ | $[6,7]$ |
| --- | --- | --- | --- | --- | --- | --- |
| $\varphi$ | $1$ | $2$ | $2$ | $3$ | $3$ | $3$ |
| $\psi$ | $-4$ | $-4$ | $-3$ | $-3$ | $-2$ | $-1$ |

Returning to the general proof, on the common disjoint partition $\{E_i\}_{i=1}^n$ we can write

$$
\varphi=\sum_{i=1}^n a_i\chi_{E_i}
\quad\text{and}\quad
\psi=\sum_{i=1}^n b_i\chi_{E_i},
$$

where $a_i$ and $b_i$ are the values taken by $\varphi$ and $\psi$ on $E_i$ (not necessarily distinct). By the previous lemma,

$$
\int_E\varphi=\sum_{i=1}^n a_i m(E_i)
\quad\text{and}\quad
\int_E\psi=\sum_{i=1}^n b_i m(E_i).
$$

Since $\varphi$ and $\psi$ are constant on each $E_i$, the linear combination $\alpha\varphi+\beta\psi$ is also constant on each $E_i$:

$$
\alpha\varphi+\beta\psi=\sum_{i=1}^n(\alpha a_i+\beta b_i)\chi_{E_i}.
$$

Applying the previous lemma again gives linearity:

$$
\begin{aligned}
\int_E(\alpha\varphi+\beta\psi)
&=\sum_{i=1}^n(\alpha a_i+\beta b_i)m(E_i)\\
&=\alpha\sum_{i=1}^n a_i m(E_i)+\beta\sum_{i=1}^n b_i m(E_i)\\
&=\alpha\int_E\varphi+\beta\int_E\psi.
\end{aligned}
$$

To prove monotonicity, we first observe that if $\lambda$ is a simple function on $E$ with $\lambda(x)\geq0$ for all $x\in E$, then $\int_E\lambda\geq0$. Indeed, in the canonical representation $\lambda=\sum_{i=1}^n c_i\chi_{F_i}$, every distinct value satisfies $c_i\geq0$ and every measure satisfies $m(F_i)\geq0$, so

$$
\int_E\lambda=\sum_{i=1}^n\underbrace{c_i}_{\geq0}\underbrace{m(F_i)}_{\geq0}\geq0.
$$

Now, if $\varphi\leq\psi$ on $E$, define the simple function $\lambda=\psi-\varphi\geq0$ on $E$. By nonnegativity and linearity,

$$
0\leq\int_E\lambda=\int_E(\psi-\varphi)=\int_E\psi-\int_E\varphi
\quad\Longrightarrow\quad
\int_E\varphi\leq\int_E\psi.
$$

∎

**Remark (Finiteness).** For any simple function $\varphi=\sum_{i=1}^n a_i\chi_{E_i}$ defined on a set $E$ of finite measure, $\int_E\varphi$ is finite:

$$
\left|\int_E\varphi\right|=\left|\sum_{i=1}^n a_i m(E_i)\right|<\infty,
$$

because each $m(E_i)\leq m(E)<\infty$.

---

Once linearity is known, we can drop **both** the distinct-values condition and the disjoint-sets condition in $\varphi=\sum_{i=1}^n a_i\chi_{E_i}$.

### Corollary: Integral of Any Finite Combination of Characteristic Functions

For any simple function $\varphi$ defined on a set $E$ of finite measure of the form

$$
\varphi=\sum_{i=1}^n a_i\chi_{E_i},
$$

where $\{E_i\}_{i=1}^n$ is any collection of measurable subsets of $E$ (not necessarily disjoint) and $\{a_i\}_{i=1}^n$ are real numbers (not necessarily distinct),

$$
\int_E\varphi=\sum_{i=1}^n a_i m(E_i).
$$

**Proof.** We first prove by mathematical induction that for any simple functions $\varphi_1,\ldots,\varphi_n$ on $E$ and scalars $\alpha_1,\ldots,\alpha_n\in\mathbb R$,

$$
\int_E\sum_{i=1}^n\alpha_i\varphi_i=\sum_{i=1}^n\alpha_i\int_E\varphi_i.
$$

For $n=1$ this is immediate, and for $n=2$ it is the linearity proposition just proved. Suppose the formula holds for some $n\in\mathbb N$. Then for $n+1$ terms,

$$
\begin{aligned}
\int_E\sum_{i=1}^{n+1}\alpha_i\varphi_i
&=\int_E\left(\sum_{i=1}^n\alpha_i\varphi_i+\alpha_{n+1}\varphi_{n+1}\right)\\
&=\int_E\sum_{i=1}^n\alpha_i\varphi_i+\alpha_{n+1}\int_E\varphi_{n+1}\\
&=\sum_{i=1}^n\alpha_i\int_E\varphi_i+\alpha_{n+1}\int_E\varphi_{n+1}\\
&=\sum_{i=1}^{n+1}\alpha_i\int_E\varphi_i.
\end{aligned}
$$

By the Principle of Mathematical Induction, finite linearity holds for any $n\in\mathbb N$. Applying this to $\varphi_i=\chi_{E_i}$ and $\alpha_i=a_i$ yields

$$
\int_E\varphi
=\int_E\sum_{i=1}^n a_i\chi_{E_i}
=\sum_{i=1}^n a_i\int_E\chi_{E_i}
=\sum_{i=1}^n a_i m(E_i).
$$

∎

---

## 3. Stage 2: Integral of Bounded Functions on Sets of Finite Measure

### 3.1 From Darboux Sums to Lower and Upper Lebesgue Integrals

**Recall (Riemann integrals via Darboux sums).** Let $f$ be a bounded function on $[a,b]$, and let $P=\{x_0,x_1,\ldots,x_n\}$ be a partition of $[a,b]$. Set

$$
m_k=\inf_{x\in[x_{k-1},x_k]}f(x),
\qquad
M_k=\sup_{x\in[x_{k-1},x_k]}f(x).
$$

The lower and upper Darboux sums and integrals are

$$
L(f,P)=\sum_{k=1}^n m_k(x_k-x_{k-1}),
\qquad
U(f,P)=\sum_{k=1}^n M_k(x_k-x_{k-1}),
$$

$$
L(f)=\sup\{L(f,P):P\text{ is a partition of }[a,b]\},
\qquad
U(f)=\inf\{U(f,P):P\text{ is a partition of }[a,b]\}.
$$

We say $f$ is **Riemann integrable** on $[a,b]$ when $L(f)=U(f)$, and write $(R)\int_a^b f$ or $(R)\int_{[a,b]}f$ for their common value.

Lebesgue replaces step functions on intervals with **simple functions on measurable sets**.

#### Definition: Lower and Upper Lebesgue Integrals

Let $f$ be a bounded real-valued function on a measurable set $E$ of finite measure.

1. The **lower Lebesgue integral** of $f$ over $E$ is

$$
L^{(L)}(f)=\sup\underbrace{\left\{\int_E\varphi:\varphi\text{ simple and }\varphi\leq f\text{ on }E\right\}}_{B}.
$$

2. The **upper Lebesgue integral** of $f$ over $E$ is

$$
U^{(L)}(f)=\inf\underbrace{\left\{\int_E\psi:\psi\text{ simple and }f\leq\psi\text{ on }E\right\}}_{A}.
$$

---

#### Proposition: Lower Integral Never Exceeds Upper Integral

For any bounded function $f$ defined on a set $E$ of finite measure,

$$
L^{(L)}(f)\leq U^{(L)}(f).
$$

**Proof.** Fix a simple function $\varphi$ such that $\varphi\leq f$ on $E$. For every simple function $\psi$ with $f\leq\psi$ on $E$, we have $\varphi\leq f\leq\psi$ on $E$. By monotonicity of the integral for simple functions,

$$
\int_E\varphi\leq\int_E\psi
\qquad\text{for all simple }\psi\text{ with }f\leq\psi\text{ on }E.
$$

Thus $\int_E\varphi$ is a lower bound of the set $A$, so

$$
\int_E\varphi\leq\inf A=U^{(L)}(f).
$$

Since $\varphi$ was an arbitrary simple function with $\varphi\leq f$ on $E$, the number $U^{(L)}(f)$ is an upper bound of the set $B$. Therefore

$$
L^{(L)}(f)=\sup B\leq U^{(L)}(f).
$$

∎

#### Definition: Lebesgue Integrability for Bounded Functions

A bounded function $f$ on a set $E$ of finite measure is said to be **Lebesgue integrable over $E$** provided

$$
L^{(L)}(f)=U^{(L)}(f).
$$

Their common value is called the **Lebesgue integral** (or simply the **integral**) of $f$ over $E$, denoted by

$$
\int_E f.
$$

---

How does this compare to the Riemann integral on $[a,b]$? Recall that a function $\psi:[a,b]\to\mathbb R$ is a **step function** if there exist a partition $P=\{x_0,x_1,\ldots,x_n\}$ of $[a,b]$ and constants $c_1,\ldots,c_n\in\mathbb R$ such that $\psi(x)=c_i$ for all $x\in(x_{i-1},x_i)$. Every step function is a simple function (since singletons $\{x_i\}$ have measure zero), and its Riemann and Lebesgue integrals agree:

$$
(R)\int_a^b\psi=\sum_{i=1}^n c_i(x_i-x_{i-1})=\sum_{i=1}^n c_i m\big((x_{i-1},x_i)\big)=\int_{[a,b]}\psi.
$$

Consequently, the lower and upper Riemann integrals can be written as

$$
L(f)=\sup\left\{\int_{[a,b]}\varphi:\varphi\text{ step and }\varphi\leq f\text{ on }[a,b]\right\},
\qquad
U(f)=\inf\left\{\int_{[a,b]}\psi:\psi\text{ step and }f\leq\psi\text{ on }[a,b]\right\}.
$$

Because every step function is simple—but not every simple function is a step function—Lebesgue allows a larger family of approximating functions, which pinches the lower and upper integrals closer together.

#### Theorem: Every Riemann Integrable Function Is Lebesgue Integrable

Let $f$ be a bounded function defined on $[a,b]$. If $f$ is Riemann integrable over $[a,b]$, then $f$ is Lebesgue integrable over $[a,b]$, and the two integrals are equal:

$$
(R)\int_a^b f=\int_{[a,b]}f.
$$

**Proof.** Suppose $f$ is Riemann integrable on $[a,b]$, so $L(f)=U(f)$. Since the family of simple functions on $[a,b]$ contains the family of step functions on $[a,b]$, taking the infimum over all simple $\psi\geq f$ produces a value less than or equal to the infimum over step functions $\psi\geq f$, and similarly for the supremum from below:

$$
\begin{aligned}
L^{(L)}(f)
&\leq U^{(L)}(f)=\inf\left\{\int_{[a,b]}\psi:\psi\text{ simple and }\psi\geq f\text{ on }[a,b]\right\}\\
&\leq U(f)=\inf\left\{\int_{[a,b]}\psi:\psi\text{ step and }\psi\geq f\text{ on }[a,b]\right\}\\
&=L(f)=\sup\left\{\int_{[a,b]}\varphi:\varphi\text{ step and }\varphi\leq f\text{ on }[a,b]\right\}\\
&\leq L^{(L)}(f)=\sup\left\{\int_{[a,b]}\varphi:\varphi\text{ simple and }\varphi\leq f\text{ on }[a,b]\right\}.
\end{aligned}
$$

All inequalities in the chain must therefore be equalities:

$$
L^{(L)}(f)=U^{(L)}(f)=\int_{[a,b]}f=L(f)=U(f)=(R)\int_a^b f.
$$

∎

**Remark.** The converse is false: the Dirichlet function $\chi_{\mathbb Q\cap[0,1]}$ is bounded and Lebesgue integrable on $[0,1]$ (with integral $0$), but is not Riemann integrable.

---

For Riemann integration, deciding which bounded functions are integrable requires analyzing their set of discontinuities. For Lebesgue integration, the answer is remarkably clean: **every bounded measurable function on a finite-measure set is Lebesgue integrable.**

#### Theorem: Bounded Measurable Functions on Finite-Measure Sets Are Integrable

Let $f$ be a bounded measurable function defined on a measurable set $E$ with $m(E)<\infty$. Then $f$ is Lebesgue integrable over $E$.

**Proof.** We use the Simple Approximation Lemma (SAL). Let $n\in\mathbb N$ and apply SAL with $\varepsilon=1/n$. There exist simple functions $\varphi_n$ and $\psi_n$ on $E$ such that

$$
\varphi_n\leq f\leq\psi_n
\quad\text{and}\quad
0\leq\psi_n-\varphi_n<\frac1n
\quad\text{on }E.
$$

By linearity and monotonicity of the integral for simple functions,

$$
0\leq\int_E(\psi_n-\varphi_n)
=\int_E\psi_n-\int_E\varphi_n
\leq\int_E\frac1n\chi_E
=\frac1n\underbrace{m(E)}_{<\infty}.
$$

Since $\varphi_n$ is simple with $\varphi_n\leq f$ on $E$, and $\psi_n$ is simple with $f\leq\psi_n$ on $E$, the definitions of $L^{(L)}(f)$ and $U^{(L)}(f)$ give

$$
\int_E\varphi_n\leq L^{(L)}(f)\leq U^{(L)}(f)\leq\int_E\psi_n.
$$

Subtracting $\int_E\varphi_n\leq L^{(L)}(f)$ from $U^{(L)}(f)\leq\int_E\psi_n$ yields

$$
0\leq U^{(L)}(f)-L^{(L)}(f)
\leq\int_E\psi_n-\int_E\varphi_n
\leq\frac1n m(E).
$$

Letting $n\to\infty$, the right-hand side tends to $0$, so $U^{(L)}(f)-L^{(L)}(f)=0$. Hence $L^{(L)}(f)=U^{(L)}(f)$, and $f$ is integrable over $E$. ∎

---

### 3.2 Basic Properties of the Integral for Bounded Measurable Functions

#### Theorem: Linearity and Monotonicity (Bounded Functions)

Let $f$ and $g$ be bounded measurable functions on a set $E$ of finite measure. Then for all $\alpha,\beta\in\mathbb R$, the function $\alpha f+\beta g$ is integrable over $E$, and

$$
\int_E(\alpha f+\beta g)=\alpha\int_E f+\beta\int_E g.
$$

Moreover, if $f\leq g$ on $E$, then

$$
\int_E f\leq\int_E g.
$$

**Proof.** Since $f$ and $g$ are bounded and measurable on $E$, any linear combination $\alpha f+\beta g$ is also bounded and measurable on $E$, hence integrable by the preceding theorem.

**Step 1: Scalar homogeneity $\int_E\alpha f=\alpha\int_E f$.** Because $\alpha f$ is integrable, $L^{(L)}(\alpha f)=U^{(L)}(\alpha f)=\int_E\alpha f$. We check three cases for $\alpha\in\mathbb R$:

- **Case 1 ($\alpha=0$):** $\int_E 0\cdot f=\int_E\chi_{\varnothing}=m(\varnothing)=0=0\cdot\int_E f$.
- **Case 2 ($\alpha>0$):** Dividing by $\alpha$ preserves inequalities and maps simple functions to simple functions, so

$$
\begin{aligned}
\int_E\alpha f
&=L^{(L)}(\alpha f)
=\sup\left\{\int_E\varphi:\varphi\text{ simple and }\frac{\varphi}{\alpha}\leq f\text{ on }E\right\}\\
&=\sup\left\{\alpha\int_E\frac{\varphi}{\alpha}:\frac{\varphi}{\alpha}\text{ simple and }\frac{\varphi}{\alpha}\leq f\text{ on }E\right\}\\
&=\alpha L^{(L)}(f)
=\alpha\int_E f.
\end{aligned}
$$

- **Case 3 ($\alpha<0$):** Dividing $\varphi\leq\alpha f$ by the negative number $\alpha$ reverses the inequality to $\varphi/\alpha\geq f$, and pulling $\alpha<0$ out of a supremum converts $\sup$ into $\alpha\inf$:

$$
\begin{aligned}
\int_E\alpha f
&=L^{(L)}(\alpha f)
=\sup\left\{\int_E\varphi:\varphi\text{ simple and }\varphi\leq\alpha f\text{ on }E\right\}\\
&=\sup\left\{\alpha\int_E\frac{\varphi}{\alpha}:\frac{\varphi}{\alpha}\text{ simple and }\frac{\varphi}{\alpha}\geq f\text{ on }E\right\}\\
&=\alpha\inf\left\{\int_E\frac{\varphi}{\alpha}:\frac{\varphi}{\alpha}\text{ simple and }\frac{\varphi}{\alpha}\geq f\text{ on }E\right\}\\
&=\alpha U^{(L)}(f)
=\alpha\int_E f.
\end{aligned}
$$

**Step 2: Additivity $\int_E(f+g)=\int_E f+\int_E g$.** To prove $\int_E(f+g)\leq\int_E f+\int_E g$, let $\psi_1$ and $\psi_2$ be any simple functions on $E$ such that $f\leq\psi_1$ and $g\leq\psi_2$ on $E$. Then $\psi_1+\psi_2$ is a simple function satisfying $f+g\leq\psi_1+\psi_2$ on $E$. Using the upper integral characterization of $\int_E(f+g)$ and linearity for simple functions,

$$
\int_E(f+g)=U^{(L)}(f+g)\leq\int_E(\psi_1+\psi_2)=\int_E\psi_1+\int_E\psi_2.
$$

Fix $\psi_1$. Since the inequality holds for every simple $\psi_2\geq g$, the number $\int_E(f+g)$ is a lower bound of $\left\{\int_E\psi_1+\int_E\psi_2:\psi_2\text{ simple and }g\leq\psi_2\text{ on }E\right\}$. Taking the infimum over $\psi_2$ gives

$$
\int_E(f+g)
\leq\int_E\psi_1+\inf\left\{\int_E\psi_2:\psi_2\text{ simple and }g\leq\psi_2\text{ on }E\right\}
=\int_E\psi_1+U^{(L)}(g)
=\int_E\psi_1+\int_E g.
$$

Now, since $\psi_1$ was an arbitrary simple function with $f\leq\psi_1$ on $E$, taking the infimum over $\psi_1$ yields

$$
\int_E(f+g)
\leq\inf\left\{\int_E\psi_1:\psi_1\text{ simple and }f\leq\psi_1\text{ on }E\right\}+\int_E g
=U^{(L)}(f)+\int_E g
=\int_E f+\int_E g.
$$

The reverse inequality $\int_E(f+g)\geq\int_E f+\int_E g$ follows by an identical argument using lower integrals $L^{(L)}$ and simple functions $\varphi_1\leq f$, $\varphi_2\leq g$ (left as a homework exercise in lecture).

**Step 3: Monotonicity.** If $h$ is a bounded measurable function with $h\geq0$ on $E$, then the zero function $\chi_{\varnothing}=0$ is a simple function satisfying $\chi_{\varnothing}\leq h$ on $E$. Therefore

$$
0=\int_E\chi_{\varnothing}\in\left\{\int_E\varphi:\varphi\text{ simple and }\varphi\leq h\text{ on }E\right\}
\quad\Longrightarrow\quad
0\leq L^{(L)}(h)=\int_E h.
$$

If $f\leq g$ on $E$, apply this to $h=g-f\geq0$ and use linearity:

$$
0\leq\int_E(g-f)=\int_E g-\int_E f
\quad\Longrightarrow\quad
\int_E f\leq\int_E g.
$$

∎

---

#### Proposition: Integration Over a Measurable Subset

Let $f$ be a bounded measurable function on a set $E$ of finite measure. For any measurable subset $A\subseteq E$,

$$
\int_A f=\int_E f\chi_A.
$$

**Proof.** We first verify the identity for a simple function $\varphi$ on $E$ with canonical representation $\varphi=\sum_{i=1}^n a_i\chi_{E_i}$. Recall that for any sets $A$ and $B$,

$$
\chi_A\cdot\chi_B=\chi_{A\cap B}
\quad\text{and}\quad
\chi_A+\chi_B-\chi_{A\cap B}=\chi_{A\cup B}.
$$

Multiplying $\varphi$ by $\chi_A$ gives

$$
\varphi\chi_A
=\sum_{i=1}^n a_i\chi_{E_i}\chi_A
=\sum_{i=1}^n a_i\chi_{E_i\cap A}.
$$

Since $\{E_i\cap A\}_{i=1}^n$ is a disjoint collection of measurable subsets of $A$ with $\bigcup_{i=1}^n(E_i\cap A)=A$, we have

$$
\int_E\varphi\chi_A=\sum_{i=1}^n a_i m(E_i\cap A)=\int_A\varphi.
$$

Now let $f$ be any bounded measurable function on $E$. If $\varphi$ is a simple function on $E$ satisfying $\varphi\leq f\chi_A$ on $E$, then on $E\setminus A$ we have $\varphi\leq 0=\varphi\chi_A$, while on $A$ we have $\varphi=\varphi\chi_A\leq f$. Thus $\varphi\leq\varphi\chi_A\leq f\chi_A$ on $E$ and $\int_E\varphi\leq\int_E\varphi\chi_A=\int_A\varphi$. Consequently, the supremum over simple $\varphi\leq f\chi_A$ on $E$ coincides with the supremum over simple functions $\varphi\chi_A$:

$$
\begin{aligned}
\int_E f\chi_A
&=\sup\left\{\int_E\varphi:\varphi\text{ simple and }\varphi\leq f\chi_A\text{ on }E\right\}\\
&=\sup\left\{\int_E\varphi\chi_A:\varphi\chi_A\text{ simple and }\varphi\chi_A\leq f\chi_A\text{ on }E\right\}\\
&=\sup\left\{\int_A\varphi:\varphi\text{ simple on }A\text{ and }\varphi\leq f\text{ on }A\right\}\\
&=\int_A f.
\end{aligned}
$$

∎

**Immediate consequence (Additivity over disjoint domains).** If $A,B\subseteq E$ are disjoint measurable subsets, then $\chi_{A\cup B}=\chi_A+\chi_B$, so linearity gives

$$
\int_{A\cup B}f=\int_E f(\chi_A+\chi_B)=\int_E f\chi_A+\int_E f\chi_B=\int_A f+\int_B f.
$$

#### Corollary: Triangle Inequality for Bounded Integrable Functions

If $f$ is a bounded measurable function on a set $E$ of finite measure, then $|f|$ is integrable on $E$ and

$$
\left|\int_E f\right|\leq\int_E|f|.
$$

**Proof.** Since $-|f|\leq f\leq|f|$ on $E$, monotonicity and linearity of the integral for bounded measurable functions yield

$$
-\int_E|f|=\int_E(-|f|)\leq\int_E f\leq\int_E|f|
\quad\Longrightarrow\quad
\left|\int_E f\right|\leq\int_E|f|.
$$

∎

---

### 3.3 Passing Limits Inside the Integral: Uniform and Bounded Convergence

When does $\lim_{n\to\infty}\int_E f_n=\int_E\left(\lim_{n\to\infty}f_n\right)$? On a set of finite measure, **uniform convergence** is the easiest case, and **Egoroff's Theorem** upgrades this to **uniformly bounded pointwise convergence**.

**Recall (Uniform convergence).** A sequence $\{f_n\}$ converges **uniformly** to $f$ on $E$ if and only if

$$
\forall\varepsilon>0,\ \exists N(\varepsilon)\in\mathbb N
\text{ such that }\forall n\geq N(\varepsilon),\ |f_n(x)-f(x)|<\varepsilon\text{ for all }x\in E.
$$

#### Proposition: Uniform Convergence Permutes With Integration

Let $\{f_n\}$ be a sequence of bounded measurable functions on a set $E$ of finite measure. If $f_n\to f$ uniformly on $E$, then

$$
\lim_{n\to\infty}\int_E f_n=\int_E f=\int_E\lim_{n\to\infty}f_n.
$$

**Proof.** Suppose $f_n\to f$ uniformly on $E$. Then $f$ is measurable and bounded on $E$ (for $n\geq N(1)$, $|f|\leq|f_N|+1$). We show that for every $\varepsilon>0$, there exists $N(\varepsilon)\in\mathbb N$ such that $\left|\int_E f_n-\int_E f\right|<\varepsilon$ for all $n\geq N(\varepsilon)$.

- **Case 1 ($m(E)=0$):** For any simple function $\varphi=\sum_{i=1}^k a_i\chi_{E_i}$ on $E$, we have $0\leq m(E_i)\leq m(E)=0$, so $\int_E\varphi=0$. Consequently, for any bounded measurable function $g$ on $E$, $\int_E g=L^{(L)}(g)=0$. Thus $\int_E f_n=0=\int_E f$ for every $n\in\mathbb N$, and the limit holds trivially.
- **Case 2 ($m(E)>0$):** Let $\varepsilon>0$. By uniform convergence on $E$, there exists $N(\varepsilon)\in\mathbb N$ such that for all $n\geq N(\varepsilon)$,

$$
|f_n(x)-f(x)|<\frac{\varepsilon}{2m(E)}
\qquad\text{for all }x\in E.
$$

  By linearity, monotonicity, and the triangle inequality for bounded measurable functions, for all $n\geq N(\varepsilon)$,

$$
\begin{aligned}
\left|\int_E f_n-\int_E f\right|
&=\left|\int_E(f_n-f)\right|\\
&\leq\int_E|f_n-f|\\
&\leq\int_E\frac{\varepsilon}{2m(E)}\chi_E
=\frac{\varepsilon}{2m(E)}\cdot m(E)
=\frac{\varepsilon}{2}<\varepsilon.
\end{aligned}
$$

  ∎

---

What if $f_n\to f$ only **pointwise** on $E$, rather than uniformly? In Riemann integration, pointwise limits of uniformly bounded functions can fail to be Riemann integrable (for example, enumerating $\mathbb Q\cap[0,1]=\{q_1,q_2,\ldots\}$ and setting $f_n=\chi_{\{q_1,\ldots,q_n\}}$ gives Riemann integrable functions converging pointwise to the Dirichlet function). In Lebesgue integration, no such failure occurs!

#### Theorem: Bounded Convergence Theorem (BCT)

Let $\{f_n\}$ be a sequence of measurable functions on a set $E$ of finite measure. Suppose $\{f_n\}$ is **uniformly pointwise bounded** on $E$; that is, there exists $M>0$ such that

$$
|f_n(x)|\leq M
\qquad\text{for all }x\in E\text{ and all }n\in\mathbb N.
$$

If $f_n\to f$ pointwise on $E$ (or pointwise a.e. on $E$), then

$$
\lim_{n\to\infty}\int_E f_n=\int_E f=\int_E\lim_{n\to\infty}f_n.
$$

**Proof.** Since $|f_n(x)|\leq M$ for all $n$ and $f_n(x)\to f(x)$, taking the limit gives $|f(x)|\leq M$ on $E$, so $f$ is also bounded and measurable. The case $m(E)=0$ is trivial, so assume $m(E)>0$.

For any measurable subset $A\subseteq E$ and any $n\in\mathbb N$, we can split the domain of integration into $A$ and $E\setminus A$:

$$
\begin{aligned}
\left|\int_E f_n-\int_E f\right|
&=\left|\int_{E\setminus A}f_n+\int_A f_n-\int_{E\setminus A}f-\int_A f\right|\\
&=\left|\int_{E\setminus A}f_n-\int_{E\setminus A}f+\int_A(f_n-f)\right|\\
&\leq\left|\int_{E\setminus A}f_n\right|+\left|\int_{E\setminus A}f\right|+\left|\int_A(f_n-f)\right|\\
&\leq\int_{E\setminus A}|f_n|+\int_{E\setminus A}|f|+\int_A|f_n-f|\\
&\leq\int_{E\setminus A}M+\int_{E\setminus A}M+\int_A|f_n-f|\\
&=2M\,m(E\setminus A)+\int_A|f_n-f|. \tag{1}
\end{aligned}
$$

**Recall (Egoroff's Theorem).** Since $m(E)<\infty$ and $f_n\to f$ pointwise on $E$, for every $\eta>0$ there exists a measurable (in fact, closed) subset $F_\eta\subseteq E$ such that $f_n\to f$ uniformly on $F_\eta$ and $m(E\setminus F_\eta)<\eta$.

Let $\varepsilon>0$. Apply Egoroff's Theorem with $\eta=\dfrac{\varepsilon}{4M}$ to obtain a measurable subset $F_\varepsilon\subseteq E$ such that $f_n\to f$ uniformly on $F_\varepsilon$ and

$$
m(E\setminus F_\varepsilon)<\frac{\varepsilon}{4M}.
$$

Because $f_n\to f$ uniformly on $F_\varepsilon$, there exists $N(\varepsilon)\in\mathbb N$ such that for all $n\geq N(\varepsilon)$,

$$
|f_n(x)-f(x)|<\frac{\varepsilon}{2m(E)}
\qquad\text{for all }x\in F_\varepsilon.
$$

Choosing $A=F_\varepsilon$ in $(1)$, we obtain for every $n\geq N(\varepsilon)$:

$$
\begin{aligned}
\left|\int_E f_n-\int_E f\right|
&\leq 2M\,m(E\setminus F_\varepsilon)+\int_{F_\varepsilon}|f_n-f|\\
&<2M\cdot\frac{\varepsilon}{4M}+\frac{\varepsilon}{2m(E)}m(F_\varepsilon)\\
&\leq\frac{\varepsilon}{2}+\frac{\varepsilon}{2}
=\varepsilon.
\end{aligned}
$$

∎

**Simplified thinking (the two-budget Egoroff split):**

- On the "bad" set $E\setminus F_\varepsilon$ where convergence is slow, the integrand $|f_n-f|$ is at most $2M$, and Egoroff makes the set's measure smaller than $\varepsilon/(4M)$, so the bad set contributes less than $2M\cdot\varepsilon/(4M)=\varepsilon/2$.
- On the "good" set $F_\varepsilon$, convergence is uniform, so for $n\geq N(\varepsilon)$ the integrand is smaller than $\varepsilon/(2m(E))$ and contributes at most $\frac{\varepsilon}{2m(E)}m(F_\varepsilon)\leq\varepsilon/2$.

---

## 4. Stage 3: Integral of Nonnegative Measurable Functions

Stage 2 required two strong hypotheses: $f$ had to be **bounded** and the domain $E$ had to have **finite measure**. In Stage 3, we drop both restrictions for **nonnegative measurable functions** $f:E\to[0,\infty]$.

### 4.1 Support and the Supremum Definition

#### Definition: Support of a Function

Let $f$ be a measurable function on a measurable set $E$. The **support** of $f$, denoted $\operatorname{supp} f$, is

$$
\operatorname{supp} f=\{x\in E:f(x)\neq0\}=E\setminus\{x\in E:f(x)=0\}.
$$

If $m(\operatorname{supp} f)<\infty$, we say that $f$ has **finite support** (or support of finite measure).

---

**Remark (Integrating bounded functions of finite support on infinite-measure domains).** Suppose $h$ is a bounded measurable function on $E$ with finite support, even when $m(E)=\infty$. Let $E_0\subseteq E$ be any measurable set with $m(E_0)<\infty$ such that $h=0$ on $E\setminus E_0$ (for example, $E_0=\operatorname{supp} h$). We define the Stage 2 integral of $h$ over $E$ by

$$
\int_E h=\int_{E_0}h.
$$

This value is independent of the choice of $E_0$: if $E_1\subseteq E$ is another measurable set with $m(E_1)<\infty$ and $h=0$ on $E\setminus E_1$, then $h=0$ outside $E_0\cap E_1$, so Stage 2 domain additivity gives

$$
\int_{E_0}h=\int_{E_0\cap E_1}h+\underbrace{\int_{E_0\setminus E_1}h}_{=0}=\int_{E_0\cap E_1}h=\int_{E_1}h.
$$

#### Definition: Integral of a Nonnegative Measurable Function

For a nonnegative measurable function $f$ defined on a measurable set $E$, we define the **integral of $f$ over $E$** by

$$
\int_E f=\sup\underbrace{\left\{\int_E h:h\text{ is bounded, measurable, of finite support, and }0\leq h\leq f\text{ on }E\right\}}_{A_f}.
$$

---

Here $\int_E f$ takes values in $[0,+\infty]$. When $f$ is already bounded and $m(E)<\infty$, $f$ itself belongs to the admissible class in $A_f$ and dominates every $h\in A_f$, so this Stage 3 definition agrees with the Stage 2 integral.

#### Example: Integrating an Indicator Over an Unbounded Ray

For every $a\in\mathbb R$,

$$
\int_{\mathbb R}\chi_{[a,\infty)}=+\infty.
$$

**Proof.** Fix $a\in\mathbb R$. It suffices to show that $\int_{\mathbb R}\chi_{[a,\infty)}\geq n$ for every $n\in\mathbb N$. Let $n\in\mathbb N$ and consider $h_n=\chi_{[a,a+n]}$. Note that:

- $h_n$ is bounded (taking only the values $0$ and $1$) and measurable (since $[a,a+n]$ is measurable).
- $h_n$ has finite support because $m(\operatorname{supp} h_n)=m([a,a+n])=n<\infty$.
- $0\leq h_n\leq\chi_{[a,\infty)}$ everywhere on $\mathbb R$: both functions equal $0$ on $(-\infty,a)$, both equal $1$ on $[a,a+n]$, and $h_n(x)=0\leq 1=\chi_{[a,\infty)}(x)$ on $(a+n,\infty)$.

Therefore $\int_{\mathbb R}h_n\in A_{\chi_{[a,\infty)}}$. Since

$$
\int_{\mathbb R}h_n=\int_{[a,a+n]}\chi_{[a,a+n]}=m([a,a+n])=n,
$$

we have $n\leq\sup A_{\chi_{[a,\infty)}}=\int_{\mathbb R}\chi_{[a,\infty)}$ for every $n\in\mathbb N$. Taking $n\to\infty$ gives $\int_{\mathbb R}\chi_{[a,\infty)}=+\infty$. ∎

---

### 4.2 Chebyshev's Inequality, the Zero-Integral Criterion, and Basic Properties

The next inequality is a fundamental tool in measure theory and probability: **if $\int_E f$ is small, then the set where $f\geq\lambda$ must have small measure.**

#### Proposition: Chebyshev's Inequality

Let $f$ be a nonnegative measurable function defined on $E$. Then for every $\lambda>0$,

$$
m\big(\{x\in E:f(x)\geq\lambda\}\big)\leq\frac{1}{\lambda}\int_E f.
$$

**Proof.** Let $\lambda>0$ and define the measurable level set $E_\lambda=\{x\in E:f(x)\geq\lambda\}$.

- **Case 1 ($m(E_\lambda)<\infty$):** Define $h=\lambda\chi_{E_\lambda}$ on $E$. Then $h$ is measurable, bounded ($0\leq h\leq\lambda$), and of finite support since $\operatorname{supp} h=E_\lambda$ has $m(E_\lambda)<\infty$. Moreover, $h\leq f$ on $E$ because:
  - if $x\in E_\lambda$, then $h(x)=\lambda\leq f(x)$;
  - if $x\notin E_\lambda$, then $h(x)=0\leq f(x)$.

  Thus $\int_E h\in A_f$, which implies

$$
\lambda\,m(E_\lambda)=\int_E\lambda\chi_{E_\lambda}=\int_E h\leq\sup A_f=\int_E f
\quad\Longrightarrow\quad
m(E_\lambda)\leq\frac{1}{\lambda}\int_E f.
$$

- **Case 2 ($m(E_\lambda)=\infty$):** For each $n\in\mathbb N$, define the truncated set $E_{\lambda,n}=E_\lambda\cap[-n,n]$ and the function $\psi_n=\lambda\chi_{E_{\lambda,n}}$. Since $E_{\lambda,n}\subseteq[-n,n]$ has finite measure ($\leq 2n$) and $0\leq\psi_n\leq f$ on $E$, the same argument as in Case 1 shows that for every $n\in\mathbb N$,

$$
\lambda\,m(E_{\lambda,n})=\int_E\psi_n\leq\int_E f
\quad\Longrightarrow\quad
m(E_{\lambda,n})\leq\frac{1}{\lambda}\int_E f. \tag{2}
$$

  Now observe that $\{E_{\lambda,n}\}_{n=1}^{\infty}$ is an ascending collection of measurable sets ($E_{\lambda,n}\subseteq E_{\lambda,n+1}$) whose union is $\bigcup_{n=1}^{\infty}(E_\lambda\cap[-n,n])=E_\lambda$. By **continuity of measure from below**,

$$
\lim_{n\to\infty}m(E_{\lambda,n})=m(E_\lambda)=\infty.
$$

  Taking the limit as $n\to\infty$ in $(2)$ gives $\infty=m(E_\lambda)\leq\frac{1}{\lambda}\int_E f$, so $\int_E f=\infty$ and the inequality holds. ∎

**Visual intuition for Chebyshev's inequality.** On the set $E_\lambda=\{f\geq\lambda\}$, the graph of $f$ sits above a flat box of height $\lambda$ and base measure $m(E_\lambda)$. The area of that box is $\lambda\,m(E_\lambda)$, which cannot exceed the total integral $\int_E f$.

---

Chebyshev's inequality immediately yields one of the most frequently used facts in analysis (and the reason $\|\cdot\|_1$ is a norm on equivalence classes in Unit III):

#### Proposition: Zero-Integral Criterion for Nonnegative Functions

Let $f$ be a nonnegative measurable function defined on $E$. Then

$$
f=0\text{ a.e. on }E
\quad\Longleftrightarrow\quad
\int_E f=0.
$$

**Proof.**

- **($\Rightarrow$)** Suppose $f=0$ a.e. on $E$, and let $E_0=\{x\in E:f(x)\neq0\}$, so $m(E_0)=0$. Let $h$ be any bounded measurable function of finite support with $0\leq h\leq f$ on $E$. On $E\setminus E_0$, we have $0\leq h\leq f=0$, so $h=0$ on $E\setminus E_0$. By Stage 2 domain additivity,

$$
\int_E h=\underbrace{\int_{E\setminus E_0}h}_{=0}+\underbrace{\int_{E_0}h}_{m(E_0)=0}=0+0=0.
$$

  Since $\int_E h=0$ for every $h$ in $A_f$, we obtain $\int_E f=\sup A_f=\sup\{0\}=0$.

- **($\Leftarrow$)** Suppose $\int_E f=0$. We want to show that $f=0$ a.e. on $E$, which is equivalent to $m(\{x\in E:f(x)>0\})=0$. Express the set where $f>0$ as the ascending countable union

$$
\{x\in E:f(x)>0\}
=\bigcup_{n=1}^{\infty}\underbrace{\left\{x\in E:f(x)\geq\frac1n\right\}}_{B_n}.
$$

  Since $B_n\subseteq B_{n+1}$ for all $n\in\mathbb N$, **continuity of measure** gives

$$
m(\{x\in E:f(x)>0\})=\lim_{n\to\infty}m(B_n). \tag{3}
$$

  By **Chebyshev's inequality** with $\lambda=1/n$,

$$
0\leq m(B_n)\leq n\int_E f=0
\quad\Longrightarrow\quad
m(B_n)=0\qquad\text{for all }n\in\mathbb N.
$$

  Substituting this into $(3)$ gives $m(\{x\in E:f(x)>0\})=\lim_{n\to\infty}0=0$, so $f=0$ a.e. on $E$. ∎

---

#### Theorem: Properties of the Integral for Nonnegative Functions

Let $f$ and $g$ be nonnegative measurable functions on $E$.

1. **(Linearity for nonnegative scalars)** If $\alpha>0$ and $\beta>0$ (or $\alpha,\beta\geq0$), then

$$
\int_E(\alpha f+\beta g)=\alpha\int_E f+\beta\int_E g.
$$

2. **(Monotonicity)** If $f\leq g$ on $E$, then

$$
\int_E f\leq\int_E g.
$$

3. **(Additivity over Domains of Integration)** If $A$ and $B$ are disjoint measurable subsets of $E$, then

$$
\int_{A\cup B}f=\int_A f+\int_B f.
$$

   In particular, if $E_0\subseteq E$ has $m(E_0)=0$, then

$$
\int_E f=\int_{E\setminus E_0}f.
$$

**Proof.**

**1. Linearity.** First let $\alpha>0$. Rescaling the admissible functions $h$ by $1/\alpha$ gives

$$
\begin{aligned}
\int_E\alpha f
&=\sup\left\{\int_E h:h\text{ bounded, measurable, of finite support, }0\leq h\leq\alpha f\right\}\\
&=\sup\left\{\alpha\int_E\frac{h}{\alpha}:\frac{h}{\alpha}\text{ bounded, measurable, of finite support, }0\leq\frac{h}{\alpha}\leq f\right\}\\
&=\alpha\sup\left\{\int_E\frac{h}{\alpha}:\frac{h}{\alpha}\text{ bounded, measurable, of finite support, }0\leq\frac{h}{\alpha}\leq f\right\}\\
&=\alpha\int_E f.
\end{aligned}
$$

Next we show $\int_E(f+g)=\int_E f+\int_E g$ by proving both inequalities.

- **($\geq$)** Let $h$ and $k$ be bounded measurable functions on $E$ of finite support such that $0\leq h\leq f$ and $0\leq k\leq g$ on $E$. Then $h+k$ is bounded, measurable, of finite support ($\operatorname{supp}(h+k)\subseteq\operatorname{supp} h\cup\operatorname{supp} k$), and satisfies $0\leq h+k\leq f+g$ on $E$. By Stage 2 linearity,

$$
\int_E h+\int_E k=\int_E(h+k)\in A_{f+g}
\quad\Longrightarrow\quad
\int_E h+\int_E k\leq\int_E(f+g).
$$

  Fixing $k$ and taking the supremum over $h$ gives $\int_E f+\int_E k\leq\int_E(f+g)$. Then taking the supremum over $k$ yields

$$
\int_E f+\int_E g\leq\int_E(f+g).
$$

- **($\leq$)** Let $\ell$ be any bounded measurable function on $E$ of finite support such that $0\leq\ell\leq f+g$ on $E$. Define two functions $h$ and $k$ on $E$ by

$$
h=\min\{f,\ell\}
\quad\text{and}\quad
k=\ell-h
\quad\text{on }E.
$$

  We claim that $h$ and $k$ are bounded, measurable, of finite support, and satisfy $0\leq h\leq f$ and $0\leq k\leq g$ on $E$:
  - **Measurability:** $h=\min\{f,\ell\}$ is the minimum of two measurable functions, so $h$ is measurable, and $k=\ell-h$ is the difference of two measurable functions, so $k$ is measurable.
  - **Nonnegativity and boundedness:** Since $f\geq0$ and $0\leq\ell\leq M$ for some $M>0$, we have $0\leq h(x)=\min\{f(x),\ell(x)\}\leq\ell(x)\leq M$ and $0\leq k(x)=\ell(x)-h(x)\leq\ell(x)\leq M$.
  - **Finite support:** If $x\notin\operatorname{supp}\ell$, then $\ell(x)=0$, which forces $h(x)=0$ and $k(x)=0$. Thus $\operatorname{supp} h\subseteq\operatorname{supp}\ell$ and $\operatorname{supp} k\subseteq\operatorname{supp}\ell$, so both have finite measure.
  - **Domination by $f$ and $g$:** By definition, $0\leq h(x)\leq f(x)$ for all $x\in E$. For $k$, at any $x\in E$:
    - if $f(x)\leq\ell(x)$, then $h(x)=f(x)$, so $0\leq k(x)=\ell(x)-f(x)\leq g(x)$ (since $\ell\leq f+g$);
    - if $\ell(x)<f(x)$, then $h(x)=\ell(x)$, so $k(x)=\ell(x)-\ell(x)=0\leq g(x)$.

  Hence $\int_E h\in A_f$ and $\int_E k\in A_g$. Since $\ell=h+k$, Stage 2 linearity gives

$$
\int_E\ell=\int_E h+\int_E k\leq\int_E f+\int_E g.
$$

  Taking the supremum over all $\ell\in A_{f+g}$ yields $\int_E(f+g)\leq\int_E f+\int_E g$.

**2. Monotonicity.** If $0\leq f\leq g$ on $E$, then every $h$ satisfying $0\leq h\leq f$ also satisfies $0\leq h\leq g$. Thus $A_f\subseteq A_g$, so $\int_E f=\sup A_f\leq\sup A_g=\int_E g$.

**3. Additivity over Domains.** If $A$ and $B$ are disjoint measurable subsets of $E$, then $\chi_{A\cup B}=\chi_A+\chi_B$, so applying part (1) to the nonnegative functions $f\chi_A$ and $f\chi_B$ gives

$$
\int_{A\cup B}f=\int_E f\chi_{A\cup B}=\int_E(f\chi_A+f\chi_B)=\int_E f\chi_A+\int_E f\chi_B=\int_A f+\int_B f.
$$

In particular, if $E_0\subseteq E$ has $m(E_0)=0$, then $f=0$ a.e. on $E_0$, so $\int_{E_0}f=0$ by the zero-integral criterion, and $\int_E f=\int_{E\setminus E_0}f+\int_{E_0}f=\int_{E\setminus E_0}f$. ∎

---

### 4.3 Fatou's Lemma and the Monotone Convergence Theorem

**Remarks (Properties of $\liminf$ and $\limsup$ for extended real sequences).** Let $\{a_n\}$ be a sequence in $[-\infty,+\infty]$.

1. $\displaystyle\liminf_{n\to\infty}a_n\leq\limsup_{n\to\infty}a_n$ always holds.
2. The limit $\lim_{n\to\infty}a_n$ exists in $[-\infty,+\infty]$ if and only if $\liminf_{n\to\infty}a_n=\limsup_{n\to\infty}a_n$, in which case the limit equals their common value.

We now prove the foundational convergence inequality for nonnegative functions. Notice that **Fatou's Lemma requires only nonnegativity and pointwise a.e. convergence**—no boundedness and no finite-measure domain!

#### Lemma: Fatou's Lemma

Let $\{f_n\}$ be a sequence of nonnegative measurable functions on $E$. If $f_n\to f$ pointwise a.e. on $E$, then

$$
\int_E\lim_{n\to\infty}f_n=\int_E f\leq\liminf_{n\to\infty}\int_E f_n.
$$

**Proof.** Let $E_0\subseteq E$ with $m(E_0)=0$ be the exceptional set where $f_n(x)\not\to f(x)$. Since $\int_E f=\int_{E\setminus E_0}f$ and $\int_E f_n=\int_{E\setminus E_0}f_n$ for every $n$, we may replace $E$ by $E\setminus E_0$ and assume without loss of generality that $f_n\to f$ pointwise everywhere on $E$. Since each $f_n\geq0$, the limit $f$ is also nonnegative and measurable.

To show that

$$
\int_E f=\sup A_f\leq\liminf_{n\to\infty}\int_E f_n,
$$

it suffices to prove that $\liminf_{n\to\infty}\int_E f_n$ is an upper bound of $A_f$. Let $h$ be any bounded measurable function of finite support such that $0\leq h(x)\leq f(x)$ for all $x\in E$.

For each $n\in\mathbb N$, define the truncated function

$$
h_n(x)=\min\{h(x),f_n(x)\},
\qquad x\in E.
$$

We want to apply the **Bounded Convergence Theorem (BCT)** to $\{h_n\}$ on the set $E_1=\operatorname{supp} h$, which has finite measure $m(E_1)<\infty$:

1. **Measurability and uniform bound:** Each $h_n$ is the minimum of two measurable functions, hence measurable. Since $h\geq0$, $f_n\geq0$, and $h$ is bounded by some $M>0$, we have

$$
0\leq h_n(x)\leq h(x)\leq M
\qquad\text{for all }x\in E\text{ and }n\in\mathbb N.
$$

2. **Supported in $E_1$:** For every $x\in E\setminus E_1$, $h(x)=0$ and $f_n(x)\geq0$, so $h_n(x)=\min\{0,f_n(x)\}=0$. Thus $\operatorname{supp} h_n\subseteq E_1$.
3. **Pointwise convergence to $h$:** Since $\lim_{n\to\infty}f_n(x)=f(x)$ and $h(x)\leq f(x)$ for all $x\in E$, continuity of $\min\{h(x),\cdot\}$ gives

$$
\lim_{n\to\infty}h_n(x)=\lim_{n\to\infty}\min\{h(x),f_n(x)\}=\min\{h(x),f(x)\}=h(x),
\qquad\forall x\in E.
$$

By the **Bounded Convergence Theorem** on the finite-measure set $E_1$,

$$
\lim_{n\to\infty}\int_{E_1}h_n=\int_{E_1}h
\quad\Longrightarrow\quad
\lim_{n\to\infty}\int_E h_n=\int_E h.
$$

Finally, for every $n\in\mathbb N$, $h_n$ is bounded, measurable, of finite support, and satisfies $0\leq h_n\leq f_n$ on $E$, so $\int_E h_n\leq\int_E f_n$ by definition of $\int_E f_n$. Taking $\liminf_{n\to\infty}$ on both sides yields

$$
\int_E h=\lim_{n\to\infty}\int_E h_n=\liminf_{n\to\infty}\int_E h_n\leq\liminf_{n\to\infty}\int_E f_n.
$$

Since $h\in A_f$ was arbitrary, taking the supremum over $h\in A_f$ gives $\int_E f\leq\liminf_{n\to\infty}\int_E f_n$. ∎

**Why can strict inequality occur in Fatou's Lemma?** Mass can "escape to infinity" or "concentrate into a spike of measure zero" in the limit:

- **Escaping to infinity:** Let $f_n=\chi_{[n,n+1]}$ on $\mathbb R$. For every $x\in\mathbb R$, $f_n(x)=0$ once $n>x$, so $f_n\to 0$ pointwise on $\mathbb R$ and $\int_{\mathbb R}f=0$. Yet $\int_{\mathbb R}f_n=1$ for every $n$, so $\liminf_{n\to\infty}\int_{\mathbb R}f_n=1>0$.
- **Concentrating into a narrow spike:** Let $f_n=n\chi_{(0,1/n)}$ on $(0,1)$. Then $f_n\to 0$ pointwise on $(0,1)$, so $\int_{(0,1)}f=0$, while $\int_{(0,1)}f_n=n\cdot(1/n)=1$ for every $n$.

---

When the nonnegative sequence $\{f_n\}$ is **increasing** ($f_n\leq f_{n+1}$), no mass can be lost in the limit, so Fatou's inequality becomes an **equality**.

#### Theorem: Monotone Convergence Theorem (MCT) for Lebesgue Integrals

Let $\{f_n\}$ be an increasing sequence ($f_n\leq f_{n+1}$) of nonnegative measurable functions on $E$. If $f_n\to f$ pointwise a.e. on $E$, then

$$
\lim_{n\to\infty}\int_E f_n=\int_E f=\int_E\lim_{n\to\infty}f_n.
$$

**Proof.** As in the proof of Fatou's Lemma, excising the measure-zero exceptional set does not change any of the integrals, so we may assume $f_n\to f$ pointwise everywhere on $E$.

By **Fatou's Lemma**,

$$
\int_E f\leq\liminf_{n\to\infty}\int_E f_n\leq\limsup_{n\to\infty}\int_E f_n.
$$

It remains to show that $\limsup_{n\to\infty}\int_E f_n\leq\int_E f$. For each $x\in E$, $\{f_n(x)\}$ is an increasing sequence in $[0,\infty]$, so by the Monotone Convergence Theorem for sequences of real numbers,

$$
f(x)=\lim_{n\to\infty}f_n(x)=\sup_{n\in\mathbb N}f_n(x)
\quad\Longrightarrow\quad
f_n(x)\leq f(x)\qquad\text{for all }n\in\mathbb N\text{ and }x\in E.
$$

By monotonicity of the integral for nonnegative functions,

$$
\int_E f_n\leq\int_E f\qquad\text{for all }n\in\mathbb N
\quad\Longrightarrow\quad
\limsup_{n\to\infty}\int_E f_n\leq\int_E f.
$$

Combining both inequalities gives $\liminf_{n\to\infty}\int_E f_n=\limsup_{n\to\infty}\int_E f_n=\int_E f$, so $\lim_{n\to\infty}\int_E f_n=\int_E f$. ∎

#### Corollary: Term-by-Term Integration of Nonnegative Series

Let $\{u_n\}$ be a sequence of nonnegative measurable functions on $E$. If

$$
f=\sum_{n=1}^{\infty}u_n
\qquad\text{pointwise a.e. on }E,
$$

then

$$
\int_E f=\sum_{n=1}^{\infty}\int_E u_n.
$$

**Proof.** Define the partial sums $f_n=\sum_{k=1}^n u_k$. Because each $u_k\geq0$, $\{f_n\}$ is an increasing sequence of nonnegative measurable functions converging pointwise a.e. on $E$ to $f$. Applying the Monotone Convergence Theorem and finite linearity for nonnegative functions gives

$$
\int_E f
=\lim_{n\to\infty}\int_E f_n
=\lim_{n\to\infty}\sum_{k=1}^n\int_E u_k
=\sum_{n=1}^{\infty}\int_E u_n.
$$

∎

---

#### Definition: Integrability of a Nonnegative Function

A nonnegative measurable function $f$ on a measurable set $E$ is said to be **integrable over $E$** provided

$$
\int_E f<\infty.
$$

---

#### Proposition: Integrable Nonnegative Functions Are Finite Almost Everywhere

Let $f$ be a nonnegative measurable function on $E$. If $f$ is integrable over $E$, then $f$ is finite a.e. on $E$.

**Proof.** Saying that $f$ is finite a.e. on $E$ means $m(\{x\in E:f(x)=\infty\})=0$. Observe that for every $n\in\mathbb N$,

$$
\{x\in E:f(x)=\infty\}\subseteq\{x\in E:f(x)\geq n\}.
$$

By monotonicity of measure and **Chebyshev's inequality** (with $\lambda=n$),

$$
0\leq m(\{x\in E:f(x)=\infty\})
\leq m(\{x\in E:f(x)\geq n\})
\leq\frac{1}{n}\int_E f.
$$

Since $\int_E f<\infty$, taking the limit as $n\to\infty$ gives $m(\{x\in E:f(x)=\infty\})=0$. ∎

#### Lemma: Beppo Levi's Lemma

Let $\{f_n\}$ be an increasing sequence of nonnegative measurable functions on $E$. If the sequence of integrals $\left\{\int_E f_n\right\}$ is bounded above, then $\{f_n\}$ converges pointwise on $E$ to a measurable function $f$ that is finite a.e. on $E$, and

$$
\lim_{n\to\infty}\int_E f_n=\int_E f<\infty.
$$

**Proof.** For each $x\in E$, $\{f_n(x)\}$ is an increasing sequence in $[0,\infty]$, so it converges in $[0,\infty]$ to $f(x)=\lim_{n\to\infty}f_n(x)=\sup_{n\in\mathbb N}f_n(x)$. Thus $f_n\to f$ pointwise on $E$, and $f$ is a nonnegative measurable function.

By the **Monotone Convergence Theorem**,

$$
\int_E f=\lim_{n\to\infty}\int_E f_n.
$$

Since $\{f_n\}$ is increasing, the sequence of real numbers $\left\{\int_E f_n\right\}$ is increasing, and by hypothesis it is bounded above. By the Monotone Convergence Theorem for real sequences, its limit is finite, so $\int_E f<\infty$. By the preceding proposition, $f$ is finite a.e. on $E$. ∎

---

## 5. Stage 4: The General Lebesgue Integral and Dominated Convergence

Now we reach the final stage: integrating measurable functions $f:E\to[-\infty,\infty]$ that can take **both positive and negative values** on an arbitrary measurable domain $E$.

### 5.1 Positive and Negative Parts of $f$

For an extended real-valued function $f:E\to[-\infty,\infty]$, define its **positive part** $f^+$ and **negative part** $f^-$ on $E$ by

$$
f^+=\max\{f,0\}
\quad\text{and}\quad
f^-=\max\{-f,0\}=-\min\{f,0\}.
$$

Both $f^+$ and $f^-$ are **nonnegative** functions on $E$, and $f$ is measurable if and only if both $f^+$ and $f^-$ are measurable. At every point of $E$, they satisfy

$$
f=f^+-f^-
\quad\text{and}\quad
|f|=f^++f^-.
$$

#### Proposition: Integrability of $f^+$ and $f^-$ Versus $|f|$

Let $f$ be a measurable function on $E$. Then $f^+$ and $f^-$ are integrable over $E$ if and only if $|f|$ is integrable over $E$.

**Proof.**

- **($\Rightarrow$)** Suppose $f^+$ and $f^-$ are integrable over $E$, so $\int_E f^+<\infty$ and $\int_E f^-<\infty$. Since $|f|=f^++f^-$ is a sum of nonnegative measurable functions, Stage 3 linearity gives

$$
\int_E|f|=\int_E(f^++f^-)=\underbrace{\int_E f^+}_{<\infty}+\underbrace{\int_E f^-}_{<\infty}<\infty,
$$

  so $|f|$ is integrable over $E$.

- **($\Leftarrow$)** Suppose $|f|$ is integrable over $E$, so $\int_E|f|<\infty$. Since $f^+\geq0$ and $f^-\geq0$ with $f^++f^-=|f|$, we have

$$
0\leq f^+\leq|f|
\quad\text{and}\quad
0\leq f^-\leq|f|
\qquad\text{on }E.
$$

  By monotonicity of the integral for nonnegative functions,

$$
\int_E f^+\leq\int_E|f|<\infty
\quad\text{and}\quad
\int_E f^-\leq\int_E|f|<\infty,
$$

  so both $f^+$ and $f^-$ are integrable over $E$. ∎

**Why we cannot skip straight from Stage 3 linearity to $\int_E f=\int_E f^+-\int_E f^-$:** Stage 3 only defines integrals for nonnegative functions and proves linearity only for **positive** scalars ($\alpha,\beta>0$). Moreover, if both $\int_E f^+=\infty$ and $\int_E f^-=\infty$, the difference $\infty-\infty$ is undefined. Requiring $\int_E|f|<\infty$ guarantees that both $\int_E f^+$ and $\int_E f^-$ are finite real numbers!

---

### 5.2 General Integrability and Basic Properties

#### Definition: General Lebesgue Integrability and the Integral

A measurable function $f$ defined on $E$ is said to be **integrable over $E$** provided $|f|$ is integrable over $E$; that is,

$$
\int_E|f|<\infty.
$$

In this case, we define the **integral of $f$ over $E$** by

$$
\int_E f=\int_E f^+-\int_E f^-.
$$

---

**Crucial distinction from improper Riemann integrals:** In Lebesgue theory, "$f$ is integrable" means **absolutely integrable** ($\int_E|f|<\infty$). A function whose positive and negative areas both diverge to $+\infty$ (such as $\frac{\sin x}{x}$ on $(0,\infty)$) is **not** Lebesgue integrable on $(0,\infty)$, even though its improper Riemann integral $\lim_{b\to\infty}\int_0^b\frac{\sin x}{x}\,dx$ converges conditionally.

#### Proposition: Integrable Functions Are Finite a.e. and Invariant Under Null Sets

Let $f$ be integrable over $E$. Then $f$ is finite a.e. on $E$, and for any measurable subset $E_0\subseteq E$ with $m(E_0)=0$,

$$
\int_E f=\int_{E\setminus E_0}f.
$$

**Proof.** Since $f$ is integrable over $E$, the nonnegative function $|f|$ is integrable over $E$. By our Stage 3 result, $|f|$ is finite a.e. on $E$, meaning

$$
m(\{x\in E:|f(x)|=\infty\})=0.
$$

Since $\{x\in E:|f(x)|=\infty\}=\{x\in E:f(x)=\infty\}\cup\{x\in E:f(x)=-\infty\}$, the set where $f(x)=\pm\infty$ has measure zero, so $f$ is finite a.e. on $E$.

Now let $E_0\subseteq E$ with $m(E_0)=0$. Applying Stage 3 null-set invariance to the nonnegative functions $f^+$ and $f^-$ gives

$$
\int_E f^+=\int_{E\setminus E_0}f^+
\quad\text{and}\quad
\int_E f^-=\int_{E\setminus E_0}f^-.
$$

Subtracting the two finite numbers yields

$$
\int_E f=\int_E f^+-\int_E f^-=\int_{E\setminus E_0}f^+-\int_{E\setminus E_0}f^-=\int_{E\setminus E_0}f.
$$

∎

---

#### Proposition: Integral Comparison Test (ICT)

Let $f$ be a measurable function on $E$. Suppose there is a nonnegative function $g$ that is integrable over $E$ and **dominates** $f$ in the sense that

$$
|f(x)|\leq g(x)\qquad\text{for all }x\in E\text{ (or a.e. on }E\text{)}.
$$

Then $f$ is integrable over $E$, and

$$
\left|\int_E f\right|\leq\int_E|f|<\infty.
$$

**Proof.** Since $0\leq|f|\leq g$ on $E$ and $g$ is integrable over $E$, monotonicity of integration for nonnegative functions gives

$$
\int_E|f|\leq\int_E g<\infty,
$$

so $f$ is integrable over $E$. For the triangle inequality, the ordinary triangle inequality in $\mathbb R$ and Stage 3 additivity give

$$
\begin{aligned}
\left|\int_E f\right|
&=\left|\int_E f^+-\int_E f^-\right|\\
&\leq\left|\int_E f^+\right|+\left|\int_E f^-\right|\\
&=\int_E f^++\int_E f^-\\
&=\int_E(f^++f^-)=\int_E|f|<\infty.
\end{aligned}
$$

∎

---

#### Theorem: Linearity, Monotonicity, and Domain Additivity for Integrable Functions

Let $f$ and $g$ be integrable functions over $E$.

1. **(Linearity)** For any $\alpha,\beta\in\mathbb R$, the linear combination $\alpha f+\beta g$ is integrable over $E$ and

$$
\int_E(\alpha f+\beta g)=\alpha\int_E f+\beta\int_E g.
$$

2. **(Monotonicity)** If $f\leq g$ on $E$ (or a.e. on $E$), then

$$
\int_E f\leq\int_E g.
$$

3. **(Additivity over Domains of Integration)** If $A$ and $B$ are disjoint measurable subsets of $E$, then

$$
\int_{A\cup B}f=\int_A f+\int_B f.
$$

**Proof.**

**1. Linearity.** First let $\alpha\in\mathbb R$. Since $\int_E|f|<\infty$, Stage 3 homogeneity gives

$$
\int_E|\alpha f|=\int_E|\alpha|\,|f|=|\alpha|\int_E|f|<\infty,
$$

so $\alpha f$ is integrable over $E$. We check $\int_E\alpha f=\alpha\int_E f$ in three cases:

- **Case 1 ($\alpha=0$):** Both sides equal $0$.
- **Case 2 ($\alpha>0$):** Since $\alpha>0$, we have

$$
(\alpha f)^+=\max\{\alpha f,0\}=\alpha\max\{f,0\}=\alpha f^+,
\qquad
(\alpha f)^-=-\min\{\alpha f,0\}=\alpha(-\min\{f,0\})=\alpha f^-.
$$

  By the definition of $\int_E\alpha f$ and Stage 3 homogeneity,

$$
\int_E\alpha f
=\int_E(\alpha f)^+-\int_E(\alpha f)^-
=\alpha\int_E f^+-\alpha\int_E f^-
=\alpha\left(\int_E f^+-\int_E f^-\right)
=\alpha\int_E f.
$$

- **Case 3 ($\alpha<0$):** When $\alpha<0$, multiplying by $\alpha$ flips signs (and $-\alpha>0$), so

$$
(\alpha f)^+=\max\{\alpha f,0\}=\alpha\min\{f,0\}=(-\alpha)f^-,
\qquad
(\alpha f)^-=-\min\{\alpha f,0\}=-\alpha\max\{f,0\}=(-\alpha)f^+.
$$

  Applying Stage 3 homogeneity with the positive scalar $-\alpha>0$ gives

$$
\int_E\alpha f
=\int_E(\alpha f)^+-\int_E(\alpha f)^-
=(-\alpha)\int_E f^--(-\alpha)\int_E f^+
=\alpha\left(\int_E f^+-\int_E f^-\right)
=\alpha\int_E f.
$$

Next we show that $f+g$ is integrable over $E$ and $\int_E(f+g)=\int_E f+\int_E g$. By the pointwise triangle inequality $|f+g|\leq|f|+|g|$ and Stage 3 monotonicity/additivity,

$$
\int_E|f+g|\leq\int_E(|f|+|g|)=\int_E|f|+\int_E|g|<\infty,
$$

so $f+g$ is integrable over $E$. Consequently, all six nonnegative functions $f^+,f^-,g^+,g^-,(f+g)^+,(f+g)^-$ are integrable and finite a.e. on $E$. Outside the measure-zero set where $f$ or $g$ is infinite, we have

$$
(f^+-f^-)+(g^+-g^-)=f+g=(f+g)^+-(f+g)^-.
$$

Rearranging terms so that **every term on both sides is nonnegative** yields

$$
f^++g^++(f+g)^-=(f+g)^++f^-+g^-\qquad\text{a.e. on }E.
$$

Integrating over $E$ and applying Stage 3 additivity for nonnegative functions gives

$$
\int_E f^++\int_E g^++\int_E(f+g)^-=\int_E(f+g)^++\int_E f^-+\int_E g^-.
$$

Because all six integrals are finite real numbers, we may rearrange them into

$$
\int_E f^+-\int_E f^-+\int_E g^+-\int_E g^-=\int_E(f+g)^+-\int_E(f+g)^-,
$$

which is $\int_E f+\int_E g=\int_E(f+g)$.

**2. Monotonicity.** If $f\leq g$ on $E$, then $g-f\geq0$ on $E$. By Stage 3 nonnegativity and part (1) linearity,

$$
0\leq\int_E(g-f)=\int_E g-\int_E f
\quad\Longrightarrow\quad
\int_E f\leq\int_E g.
$$

**3. Additivity over Domains.** Let $A$ and $B$ be disjoint measurable subsets of $E$. Applying Stage 3 domain additivity to $f^+$ and $f^-$ separately gives

$$
\int_{A\cup B}f^+=\int_A f^++\int_B f^+
\quad\text{and}\quad
\int_{A\cup B}f^-=\int_A f^-+\int_B f^-.
$$

Subtracting the second equation from the first yields

$$
\int_{A\cup B}f
=\int_{A\cup B}f^+-\int_{A\cup B}f^-
=\left(\int_A f^+-\int_A f^-\right)+\left(\int_B f^+-\int_B f^-\right)
=\int_A f+\int_B f.
$$

∎

---

### 5.3 The Lebesgue Dominated Convergence Theorem

We conclude with the crown jewel of Unit II. The **Lebesgue Dominated Convergence Theorem (LDCT)** allows us to pass a pointwise a.e. limit inside an integral on **any** measurable domain $E$ (even with $m(E)=\infty$) for functions of **arbitrary sign**, provided the entire sequence is trapped inside a single integrable envelope $|f_n|\leq g$.

#### Theorem: Lebesgue Dominated Convergence Theorem (LDCT)

Let $\{f_n\}$ be a sequence of measurable functions on $E$. Suppose there is a function $g$ that is integrable over $E$ and **dominates** $\{f_n\}$ on $E$ in the sense that

$$
|f_n(x)|\leq g(x)
\qquad\text{for all }x\in E\text{ and all }n\in\mathbb N. \tag{1}
$$

If $f_n\to f$ pointwise a.e. on $E$, then $f$ is integrable over $E$ and

$$
\lim_{n\to\infty}\int_E f_n=\int_E f=\int_E\lim_{n\to\infty}f_n.
$$

**Proof.** By $(1)$ and the Integral Comparison Test (ICT), each $f_n$ is integrable over $E$. Passing to the pointwise a.e. limit in $|f_n(x)|\leq g(x)$ gives $|f(x)|\leq g(x)$ a.e. on $E$, so $f$ is also integrable over $E$ by ICT.

Observe that $(1)$ is equivalent to $-g(x)\leq f_n(x)\leq g(x)$ for all $x\in E$ and $n\in\mathbb N$, which gives **two sequences of nonnegative measurable functions**:

$$
g(x)+f_n(x)\geq0
\quad\text{and}\quad
g(x)-f_n(x)\geq0
\qquad\text{for all }x\in E\text{ and }n\in\mathbb N.
$$

Moreover, $g+f_n\to g+f\geq0$ pointwise a.e. on $E$, and $g-f_n\to g-f\geq0$ pointwise a.e. on $E$. We can therefore apply **Fatou's Lemma** to both nonnegative sequences:

1. Applying Fatou's Lemma to $g+f_n\geq0$, followed by linearity and the definition of $\liminf$, gives

$$
\begin{aligned}
\int_E g+\int_E f
&=\int_E(g+f)\\
&\leq\liminf_{n\to\infty}\int_E(g+f_n)\\
&=\sup_{n\in\mathbb N}\left(\inf_{k\geq n}\left(\int_E g+\int_E f_k\right)\right)\\
&=\int_E g+\sup_{n\in\mathbb N}\left(\inf_{k\geq n}\int_E f_k\right)\\
&=\int_E g+\liminf_{n\to\infty}\int_E f_n.
\end{aligned}
$$

   Since $\int_E g<\infty$ is finite, subtracting $\int_E g$ from both sides yields

$$
\int_E f\leq\liminf_{n\to\infty}\int_E f_n.
$$

2. Similarly, applying Fatou's Lemma to $g-f_n\geq0$ and using $\inf_{k\geq n}(-a_k)=-\sup_{k\geq n}a_k$ gives

$$
\begin{aligned}
\int_E g-\int_E f
&=\int_E(g-f)\\
&\leq\liminf_{n\to\infty}\int_E(g-f_n)\\
&=\sup_{n\in\mathbb N}\left(\inf_{k\geq n}\left(\int_E g-\int_E f_k\right)\right)\\
&=\int_E g+\sup_{n\in\mathbb N}\left(\inf_{k\geq n}\left(-\int_E f_k\right)\right)\\
&=\int_E g-\inf_{n\in\mathbb N}\left(\sup_{k\geq n}\int_E f_k\right)\\
&=\int_E g-\limsup_{n\to\infty}\int_E f_n.
\end{aligned}
$$

   Subtracting $\int_E g$ and multiplying by $-1$ yields

$$
-\int_E f\leq-\limsup_{n\to\infty}\int_E f_n
\quad\Longrightarrow\quad
\limsup_{n\to\infty}\int_E f_n\leq\int_E f.
$$

Combining the two inequalities gives

$$
\limsup_{n\to\infty}\int_E f_n\leq\int_E f\leq\liminf_{n\to\infty}\int_E f_n\leq\limsup_{n\to\infty}\int_E f_n,
$$

so $\liminf_{n\to\infty}\int_E f_n=\limsup_{n\to\infty}\int_E f_n=\int_E f$, and hence $\lim_{n\to\infty}\int_E f_n=\int_E f$. ∎

**How BCT and LDCT are related.** Notice that the **Bounded Convergence Theorem** is the special case of LDCT where $m(E)<\infty$ and $g(x)=M\chi_E(x)$: because $m(E)<\infty$, the constant function $M$ is integrable over $E$ ($\int_E M=M\,m(E)<\infty$). Note, however, that in our logical development we proved BCT *first* (using Egoroff's theorem) and used BCT to prove Fatou's Lemma, which in turn proved MCT and LDCT!

---

## Review Map

| Result | Stage | Key Formula or Conclusion | Essential Hypotheses |
| --- | --- | --- | --- |
| Pointwise a.e. limit | Pre-integral | $f_n\to f$ a.e. $\implies f$ measurable | Each $f_n$ measurable; Lebesgue measure is complete. |
| Simple Approximation Lemma | Stage 1 $\to$ 2 | $\varphi_\varepsilon\leq f\leq\psi_\varepsilon$ and $0\leq\psi_\varepsilon-\varphi_\varepsilon<\varepsilon$ | $f$ measurable and **bounded** on $E$. |
| Simple integral linearity | Stage 1 | $\int_E\sum_{i=1}^n a_i\chi_{E_i}=\sum_{i=1}^n a_i m(E_i)$ | $m(E)<\infty$; sets $E_i$ need not be disjoint once linearity is proved. |
| Riemann $\implies$ Lebesgue | Stage 2 | $(R)\int_a^b f=\int_{[a,b]}f$ | $f$ bounded and Riemann integrable on $[a,b]$. |
| Bounded measurability $\implies$ integrable | Stage 2 | $L^{(L)}(f)=U^{(L)}(f)$ | $f$ bounded and measurable, and **$m(E)<\infty$**. |
| Bounded Convergence Theorem (BCT) | Stage 2 | $\lim_{n\to\infty}\int_E f_n=\int_E f$ | **$m(E)<\infty$**, $\|f_n\|\leq M$ for all $n$, and $f_n\to f$ a.e. |
| Chebyshev's Inequality | Stage 3 | $m(\{f\geq\lambda\})\leq\frac{1}{\lambda}\int_E f$ | $f\geq0$ measurable on $E$, and $\lambda>0$. |
| Zero-Integral Criterion | Stage 3 | $\int_E f=0\iff f=0$ a.e. on $E$ | **$f\geq0$** measurable on $E$ (fails if $f$ changes sign!). |
| Fatou's Lemma | Stage 3 | $\int_E f\leq\liminf_{n\to\infty}\int_E f_n$ | **$f_n\geq0$** measurable and $f_n\to f$ a.e. |
| Monotone Convergence Theorem (MCT) | Stage 3 | $\lim_{n\to\infty}\int_E f_n=\int_E f$ | **$0\leq f_n\leq f_{n+1}$** measurable and $f_n\to f$ a.e. |
| Nonnegative Series Corollary | Stage 3 | $\int_E\sum_{n=1}^{\infty}u_n=\sum_{n=1}^{\infty}\int_E u_n$ | **$u_n\geq0$** measurable on $E$. |
| Beppo Levi's Lemma | Stage 3 | $f_n\to f$ finite a.e. and $\lim\int_E f_n=\int_E f<\infty$ | $0\leq f_n\leq f_{n+1}$ and $\sup_n\int_E f_n<\infty$. |
| Integral Comparison Test (ICT) | Stage 4 | $\|f\|\leq g\implies f$ integrable and $\lvert\int_E f\rvert\leq\int_E\|f\|$ | $f$ measurable, $g\geq0$ integrable over $E$. |
| Dominated Convergence Theorem (LDCT) | Stage 4 | $\lim_{n\to\infty}\int_E f_n=\int_E f$ | $\|f_n\|\leq g$ with **$\int_E g<\infty$**, and $f_n\to f$ a.e. |

### Choosing a Convergence Theorem in Exam Problems

When asked to evaluate or justify $\lim_{n\to\infty}\int_E f_n=\int_E\lim_{n\to\infty}f_n$:

1. **Check if the domain $E$ has finite measure ($m(E)<\infty$) and $|f_n(x)|\leq M$ is bounded by a constant $M$ independent of $n$ and $x$:**
   - Use the **Bounded Convergence Theorem (BCT)**.
2. **Check if the functions are nonnegative ($f_n\geq0$) and increasing ($f_n\leq f_{n+1}$) on $E$ (or if you have a series $\sum_{n=1}^{\infty}u_n$ with $u_n\geq0$):**
   - Use the **Monotone Convergence Theorem (MCT)** (or its series corollary). You do **not** need to find an integrable dominating function!
3. **Check if $f_n$ changes sign, decreases, or lives on an infinite-measure domain like $[0,\infty)$ or $\mathbb R$:**
   - Look for a single $n$-independent dominating function $g(x)\geq0$ such that $|f_n(x)|\leq g(x)$ for all $n$ and $\int_E g<\infty$, then apply the **Lebesgue Dominated Convergence Theorem (LDCT)**.
4. **If you only know $f_n\geq0$ and $f_n\to f$ a.e. without monotonicity or a dominating function:**
   - You can only conclude the one-sided inequality $\int_E f\leq\liminf_{n\to\infty}\int_E f_n$ via **Fatou's Lemma**.

### Self-Check Questions

Try answering these before consulting the hints below.

1. Why is $\chi_{\mathbb Q\cap[0,1]}$ a simple function but not a step function, and what is its Lebesgue integral over $[0,1]$?
2. In the Simple Approximation Lemma, why do we partition the range $[-M-1,M+1]$ instead of the domain $E$?
3. What is the difference between the canonical representation of a simple function $\varphi$ and a general representation $\varphi=\sum_{i=1}^n a_i\chi_{E_i}$?
4. Why does every Riemann integrable function on $[a,b]$ have to be Lebesgue integrable with the same integral?
5. Where does the proof of the Bounded Convergence Theorem use the assumption $m(E)<\infty$?
6. How is Chebyshev's inequality used to prove that $\int_E f=0\implies f=0$ a.e. for a nonnegative measurable function $f$?
7. Why does $\int_E f=0\implies f=0$ a.e. fail if we drop the hypothesis $f\geq0$?
8. In the proof of Fatou's Lemma, why do we define $h_n=\min\{h,f_n\}$ where $h\in A_f$, instead of applying BCT directly to $f_n$?
9. Why do we rearrange $(f^+-f^-)+(g^+-g^-)=(f+g)^+-(f+g)^-$ into $f^++g^++(f+g)^-=(f+g)^++f^-+g^-$ when proving linearity in Stage 4?
10. How does Fatou's Lemma produce **both** the $\liminf$ inequality and the $\limsup$ inequality in the proof of the Dominated Convergence Theorem?

### Hints and Short Answers

1. It takes only two values ($0$ and $1$) on measurable sets, so it is simple, but $\mathbb Q\cap[0,1]$ is not a finite union of intervals. Its integral is $1\cdot m(\mathbb Q\cap[0,1])+0\cdot m(\mathbb Q^c\cap[0,1])=0$.
2. Partitioning the domain into intervals cannot control a measurable function that oscillates wildly inside every interval; partitioning the range into strips $[y_{k-1},y_k)$ of height $<\varepsilon$ forces $0\leq\psi_\varepsilon-\varphi_\varepsilon<\varepsilon$ everywhere on $E$.
3. The canonical representation uses the **distinct** values $a_1,\ldots,a_n$ of $\varphi$ and the pairwise disjoint preimages $E_i=\varphi^{-1}(\{a_i\})$. By linearity (the Stage 1 corollary), $\int_E\varphi=\sum_{i=1}^n a_i m(E_i)$ holds even when the $a_i$ are not distinct and the $E_i$ overlap.
4. Every step function is a simple function, so $L(f)\leq L^{(L)}(f)\leq U^{(L)}(f)\leq U(f)$. When $L(f)=U(f)$, all four quantities coincide.
5. In two places: first to invoke **Egoroff's Theorem** (which requires $m(E)<\infty$), and second to integrate the constant bound $\frac{\varepsilon}{2m(E)}$ over $F_\varepsilon\subseteq E$.
6. Write $\{f>0\}=\bigcup_{n=1}^{\infty}\{f\geq 1/n\}$. Chebyshev gives $m(\{f\geq 1/n\})\leq n\int_E f=0$ for every $n$, and continuity of measure gives $m(\{f>0\})=\lim_{n\to\infty}0=0$.
7. If $f$ changes sign, positive and negative parts can cancel (for example, $f(x)=x$ on $[-1,1]$ has $\int_{[-1,1]}f=0$ even though $f\neq0$ a.e.).
8. The functions $f_n$ may be unbounded and $E$ may have infinite measure, so BCT does not apply to $f_n$. Truncating by $h\in A_f$ restricts the support to $E_1=\operatorname{supp} h$ (where $m(E_1)<\infty$) and bounds $0\leq h_n\leq h\leq M$, making BCT applicable.
9. Stage 3 additivity is proved only for **nonnegative** functions with positive coefficients; moving all negative terms to the opposite side yields an identity between sums of nonnegative functions.
10. Because $|f_n|\leq g$, both $g+f_n\geq0$ and $g-f_n\geq0$ are nonnegative. Fatou on $g+f_n$ gives $\int_E f\leq\liminf\int_E f_n$, while Fatou on $g-f_n$ turns $\liminf\int_E(g-f_n)$ into $\int_E g-\limsup\int_E f_n$, giving $\limsup\int_E f_n\leq\int_E f$.

### Clarifications Made in This Revision

The mathematical content and proof progression above follow the supplied Unit II lecture notes. Several minor transcription slips in the raw Typst source were cleaned up for accuracy:

- **Measurability of a.e. limits:** Ordered the countable unions as $\bigcup_{n=1}^{\infty}\bigcup_{k=1}^{\infty}\bigcap_{j=k}^{\infty}\{f_j<c-1/n\}$ so the buffer $1/n$ is fixed across the tail $j\geq k$, and noted completeness of measure on the exceptional null set $E_0$.
- **Disjoint simple-function lemma:** Corrected $A_j=\varphi^{-1}(\{\lambda_j\})$ and $\varphi=\sum_{j=1}^m\lambda_j\chi_{A_j}$ (written with $a_j$ and $m(A_j)$ in the source), and noted that $m(A_j)=\sum_{i\in I_j}m(E_i)$ uses finite **additivity** of measure on disjoint sets.
- **Stage 1 linearity and corollary:** Replaced the raw matrix layout with a clear common-refinement table, fixed the sign typo $-\sum\beta b_i m(E_i)\to+\sum\beta b_i m(E_i)$, and fixed the upper summation limit $\sum_{i=1}^{\infty}\to\sum_{i=1}^n$ in the induction step.
- **Stage 2 integrals:** Fixed $U(f)=\sup$ to $U(f)=\inf$ in the step-function rewrite of the upper Riemann integral, corrected the limit $n\to 0$ to $n\to\infty$ in the SAL integrability proof, and wrote $f+g\leq\psi$ in the definition of $U^{(L)}(f+g)$.
- **Stage 3 additivity and Fatou's Lemma:** Corrected $\ell(x)-f(x)=0$ to $\ell(x)-h(x)=\ell(x)-\ell(x)=0$ when $\ell(x)<f(x)$, and restored $\liminf_{n\to\infty}\int_E f_n$ in the statement of Fatou's Lemma (matching its proof).
- **Stage 4 proofs:** Corrected $\int_E f^-\leq\int_E|f|<\infty$, wrote $\{|f(x)|=\infty\}$ for the null set of infinite values, fixed $(\alpha f)^-=-\min\{\alpha f,0\}$, used $\int_E|f+g|\leq\int_E(|f|+|g|)$, and fixed the sign in the domain-additivity subtraction.
- **Dominated Convergence Theorem:** Corrected $\int_E(g-f_n)=\int_E g-\int_E f$ to $\int_E(g-f)$ and $\limsup\int_E f_n\leq\int_E f$ in the final deduction.
$math126_u2$,
    2
  )
  ON CONFLICT (id) DO UPDATE
  SET
    course_id = EXCLUDED.course_id,
    title = EXCLUDED.title,
    content = EXCLUDED.content,
    sort_order = EXCLUDED.sort_order,
    updated_at = now();
END
$migration$;
