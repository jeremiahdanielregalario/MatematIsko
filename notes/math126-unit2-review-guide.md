# Math 126: Real Analysis — Unit II

*A review guide to Lebesgue spaces, norms, and the inequalities connecting them*

## How the Unit Fits Together

Unit I introduced measurable sets and functions. This unit asks a new question: **how can we measure the size of a function?**

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

We assume the basic facts about this integral: monotonicity, linearity for integrable functions, invariance under changes on null sets, and the fact that a nonnegative measurable function has integral zero exactly when it is zero almost everywhere.

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

For a standard reference on the norm range, equivalence-class convention, and essential-supremum definition, see Chapter 7 of [John K. Hunter's Measure Theory notes](https://www.math.ucdavis.edu/~hunter/measure_theory/measure_notes.pdf). The organization and expanded explanations above follow the supplied Unit II material.
