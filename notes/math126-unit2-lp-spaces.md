# Math 126: Real Analysis — Unit II

---

*Throughout our discussion, $\Omega$ denotes a measurable set of real numbers. Moreover, unless stated otherwise, all functions considered are measurable.*

---

# Lebesgue Spaces ($L^p$ Spaces)

---

### Definition: Lebesgue Spaces $L^p(\Omega)$

For $1 \leq p < \infty$, we define the space $L^p(\Omega)$ as

$$L^p(\Omega) = \left\{ f : \Omega \to \mathbb{R} \ \Big|\ \int_{\Omega} |f|^p < \infty \right\}.$$

When $p = \infty$, the space $L^{\infty}(\Omega)$ is defined as

$$L^{\infty}(\Omega) = \left\{ f : \Omega \to \mathbb{R} \ \Big|\ \exists M > 0 \text{ s.t. } |f| \leq M \text{ a.e. in } \Omega \right\}.$$

### Remarks

1. Let $\mathcal{F}$ be the collection of all measurable extended real-valued functions on $\Omega$ that are finite a.e. in $\Omega$. Define the equivalence relation $\sim$ on $\mathcal{F}$ by $f \sim g \iff f = g$ a.e. in $\Omega$. For $1 \leq p < \infty$, we formally define $L^p(\Omega)$ as $\mathcal{F} / {\sim}$: the collection of equivalence classes $[f]$ such that

$$\int_{\Omega} |f|^p < \infty.$$

   Furthermore, the space $L^{\infty}(\Omega)$ is the collection of equivalence classes $[f]$ such that there exists $M > 0$ with $|f| \leq M$ a.e. in $\Omega$. We use the previous simpler definition for brevity.

2. For $1 \leq p \leq \infty$, $L^p(\Omega)$ is a **linear space**: for all $\alpha, \beta \in \mathbb{R}$, if $f, g \in L^p(\Omega)$, then $\alpha f + \beta g \in L^p(\Omega)$.

   **Proof.** Let $p \in [1, \infty)$. Goal: show that $\displaystyle \int_{\Omega} |\alpha f + \beta g|^p < \infty$. For $x \in \Omega$,

$$|\alpha f(x) + \beta g(x)| \leq |\alpha f(x)| + |\beta g(x)| \leq 2 \max\{|\alpha f(x)|, |\beta g(x)|\}.$$

   This implies

$$|\alpha f(x) + \beta g(x)|^p \leq 2^p \left(\max\{|\alpha f(x)|, |\beta g(x)|\}\right)^p.$$

   Note that $\left(\max\{|\alpha f(x)|, |\beta g(x)|\}\right)^p$ equals either $|\alpha f(x)|^p$ or $|\beta g(x)|^p$, so

$$\left(\max\{|\alpha f(x)|, |\beta g(x)|\}\right)^p \leq |\alpha f(x)|^p + |\beta g(x)|^p.$$

   Hence

$$|\alpha f(x) + \beta g(x)|^p \leq 2^p \left(|\alpha f(x)|^p + |\beta g(x)|^p\right) = 2^p |\alpha|^p |f(x)|^p + 2^p |\beta|^p |g(x)|^p.$$

   By linearity and monotonicity of integration,

$$\int_{\Omega} |\alpha f + \beta g|^p \leq 2^p |\alpha|^p \underbrace{\int_{\Omega} |f|^p}_{< \infty} + 2^p |\beta|^p \underbrace{\int_{\Omega} |g|^p}_{< \infty} < \infty,$$

   so $\alpha f + \beta g \in L^p(\Omega)$.

   Now let $p = \infty$ and $f, g \in L^{\infty}(\Omega)$, $\alpha, \beta \in \mathbb{R}$. Then there exist $M_f, M_g > 0$ such that $|f| \leq M_f$ a.e. in $\Omega$ and $|g| \leq M_g$ a.e. in $\Omega$. Let $\Omega_f$ and $\Omega_g$ be the measure-zero subsets of $\Omega$ on which these bounds fail, respectively. Then

$$0 \leq m(\Omega_f \cup \Omega_g) \leq m(\Omega_f) + m(\Omega_g) = 0,$$

   and

$$|\alpha f + \beta g| \leq |\alpha| \, |f| + |\beta| \, |g| \leq |\alpha| M_f + |\beta| M_g \quad \text{on } \Omega \setminus (\Omega_f \cup \Omega_g),$$

   so $|\alpha f + \beta g| \leq |\alpha| M_f + |\beta| M_g$ a.e. in $\Omega$. Hence $\alpha f + \beta g \in L^{\infty}(\Omega)$. ∎

---

### Definition: Essential Supremum

Let $f : \Omega \to \mathbb{R}$.

- If there exists $M > 0$ such that $|f| \leq M$ a.e. in $\Omega$, we say that $f$ is **essentially bounded** in $\Omega$.
- The constant $M$ is called an **essential bound** of $f$. The infimum of all essential bounds is called the **essential supremum**, denoted

$$\operatorname{ess\,sup} f = \inf\{M > 0 : |f| \leq M \text{ a.e. in } \Omega\}.$$

### Examples

1. Consider $f : [0, 1] \to \mathbb{R}$ given by

$$f(x) = \begin{cases} 3, & \text{if } x = 0, \\ x, & \text{if } x \in (0, 1), \\ -4, & \text{if } x = 1. \end{cases}$$

   Essential bounds for $f$: $4, 3, 1$. One can show that $\operatorname{ess\,sup} f = 1$.

2. Consider $g : [0, 1] \to \mathbb{R}$ given by

$$g(x) = \begin{cases} \dfrac{1}{x}, & \text{if } x \in \mathbb{Q} \cap (0, 1], \\[1ex] 0, & \text{if } x \in \big(\mathbb{Q}^{c} \cap [0, 1]\big) \cup \{0\}. \end{cases}$$

   Note that $g$ is not bounded but is essentially bounded, with $\operatorname{ess\,sup} g = 0$.

---

### Definition: Norm and Normed Linear Space

Let $X$ be a linear space. A real-valued function $\|\cdot\|_X$ defined on $X$ is called a **norm** provided that for each $f, g \in X$ and $\alpha \in \mathbb{R}$:

1. *(Triangle Inequality)* $\|f + g\|_X \leq \|f\|_X + \|g\|_X$;
2. *(Positive Homogeneity)* $\|\alpha f\|_X = |\alpha| \, \|f\|_X$;
3. *(Nonnegativity)* $\|f\|_X \geq 0$, and $\|f\|_X = 0 \iff f = 0$ in $X$.

We say that $X$ is a **normed linear space** if there is a norm defined on $X$.

### Examples

1. The set $\mathbb{R}$ is a normed linear space with

$$\|x\|_{\mathbb{R}} = |x|.$$

2. The spaces $L^1(\Omega)$ and $L^{\infty}(\Omega)$ are normed linear spaces with

$$\|f\|_{L^1(\Omega)} = \int_{\Omega} |f| \qquad \text{and} \qquad \|f\|_{L^{\infty}(\Omega)} = \operatorname{ess\,sup} f.$$

   **Proof.** First we show $\|f\|_{L^1(\Omega)} = \displaystyle \int_{\Omega} |f|$ is a norm. Let $f, g \in L^1(\Omega)$ and $\alpha \in \mathbb{R}$.

   *(Triangle Inequality)*

$$\|f + g\|_{L^1(\Omega)} = \int_{\Omega} |f + g| \leq \int_{\Omega} (|f| + |g|) = \int_{\Omega} |f| + \int_{\Omega} |g| = \|f\|_{L^1(\Omega)} + \|g\|_{L^1(\Omega)}.$$

   *(Positive Homogeneity)*

$$\|\alpha f\|_{L^1(\Omega)} = \int_{\Omega} |\alpha f| = \int_{\Omega} |\alpha| \, |f| = |\alpha| \int_{\Omega} |f| = |\alpha| \, \|f\|_{L^1(\Omega)}.$$

   *(Nonnegativity)* Since $|f| \geq 0$, $\displaystyle \|f\|_{L^1(\Omega)} = \int_{\Omega} |f| \geq 0$. Moreover,

$$\|f\|_{L^1(\Omega)} = 0 \iff \int_{\Omega} |f| = 0 \iff |f| = 0 \text{ a.e. in } \Omega \iff f = 0 \text{ in } L^1(\Omega).$$

   Next we show $\|f\|_{L^{\infty}(\Omega)} = \operatorname{ess\,sup} f$ is a norm. Let $f, g \in L^{\infty}(\Omega)$ and $\alpha \in \mathbb{R}$.

   *(Positive Homogeneity)* Case 1: $\alpha \neq 0$. Then

$$\|\alpha f\|_{L^{\infty}(\Omega)} = \operatorname{ess\,sup}(\alpha f) = \inf\left\{M > 0 : |\alpha f| \leq M \text{ a.e. in } \Omega\right\} = |\alpha| \inf\left\{\frac{M}{|\alpha|} : |f| \leq \frac{M}{|\alpha|} \text{ a.e. in } \Omega\right\} = |\alpha| \, \operatorname{ess\,sup} f = |\alpha| \, \|f\|_{L^{\infty}(\Omega)}.$$

   Case 2: $\alpha = 0$. Then $\alpha f = 0$ in $\Omega$, so

$$\{M > 0 : |\alpha f| \leq M \text{ a.e. in } \Omega\} = (0, \infty),$$

   hence

$$\operatorname{ess\,sup}(0) = \inf(0, \infty) = 0 \quad \Longrightarrow \quad \|\alpha f\|_{L^{\infty}(\Omega)} = 0 = |\alpha| \, \|f\|_{L^{\infty}(\Omega)}.$$

   *(Nonnegativity)* $\|f\|_{L^{\infty}(\Omega)} \geq 0$, since it is the infimum of a set of positive numbers. We show $\|f\|_{L^{\infty}(\Omega)} = 0 \iff f = 0$ in $L^{\infty}(\Omega)$.

   *($\Leftarrow$)* Suppose $f = 0$ a.e. in $\Omega$. Then $\{M > 0 : |f| \leq M \text{ a.e. in } \Omega\} = (0, \infty)$, so $\|f\|_{L^{\infty}(\Omega)} = 0$.

   *($\Rightarrow$)* Suppose $\|f\|_{L^{\infty}(\Omega)} = 0$, i.e.

$$\operatorname{ess\,sup} f = \inf\{M > 0 : |f| \leq M \text{ a.e. in } \Omega\} = 0.$$

   By the characterization of the infimum, for every $\varepsilon > 0$ there exists $M_{\varepsilon}$ in the set above with $M_{\varepsilon} < 0 + \varepsilon = \varepsilon$. That is, for every $\varepsilon > 0$,

$$|f| \leq M_{\varepsilon} < \varepsilon \quad \text{a.e. in } \Omega.$$

   Hence $|f| < \varepsilon$ a.e. in $\Omega$ for every $\varepsilon > 0$, so $|f| = 0$ a.e. in $\Omega$, i.e. $f = 0$ a.e. in $\Omega$.

   *(Triangle Inequality)* Claim: $\|f\|_{L^{\infty}(\Omega)}$ is an essential bound of $f$. Let $n \in \mathbb{N}$. By the characterization of the infimum (with $\varepsilon = \frac{1}{n}$), there exists $M_n$ in the set above such that

$$|f| \leq M_n < \|f\|_{L^{\infty}(\Omega)} + \frac{1}{n}.$$

   That is, for every $n \in \mathbb{N}$,

$$|f| \leq \|f\|_{L^{\infty}(\Omega)} \quad \text{a.e. in } \Omega.$$

   Then for all $f, g \in L^{\infty}(\Omega)$,

$$|f + g| \leq |f| + |g| \leq \|f\|_{L^{\infty}(\Omega)} + \|g\|_{L^{\infty}(\Omega)} \quad \text{a.e. in } \Omega,$$

   so $\|f\|_{L^{\infty}(\Omega)} + \|g\|_{L^{\infty}(\Omega)}$ is an essential bound of $f + g$, and therefore

$$\|f + g\|_{L^{\infty}(\Omega)} \leq \|f\|_{L^{\infty}(\Omega)} + \|g\|_{L^{\infty}(\Omega)}. \quad \blacksquare$$

   **Question:** What about when $p \in (0, \infty)$? In this case, if $f \in L^p(\Omega)$,

$$\|f\|_{L^p(\Omega)} = \left(\int_{\Omega} |f|^p\right)^{1/p}.$$

   One can easily show that this satisfies nonnegativity and positive homogeneity. The triangle inequality for the $L^p$-norm is called the *Minkowski inequality*.

   *Remark:* For simplicity, we write

$$\|\cdot\|_{L^p(\Omega)} = \|\cdot\|_p.$$

---

### Definition: Conjugate Exponent

The conjugate of a number $p \in (1, \infty)$ is the unique $p'$ such that

$$\frac{1}{p} + \frac{1}{p'} = 1.$$

The conjugate of $1$ is defined to be $\infty$, and the conjugate of $\infty$ is $1$.

### Remarks

- For $p \in (1, \infty)$,

$$\frac{1}{p} + \frac{1}{p'} = 1 \quad \Longrightarrow \quad \frac{1}{p'} = 1 - \frac{1}{p} = \frac{p - 1}{p} \quad \Longrightarrow \quad p' = \frac{p}{p - 1}.$$

- For any $p \in [1, \infty]$, $(p')' = p$, since $p = \dfrac{p'}{p' - 1}$.
- $p = 2$ gives $p' = 2$.

---

### Theorem: Young's Inequality

For $1 < p < \infty$, let $p' = \dfrac{p}{p - 1}$ be the conjugate of $p$. For any two positive real numbers $a, b > 0$:

$$ab \leq \frac{a^p}{p} + \frac{b^{p'}}{p'}.$$

**Proof.** Let $1 < p < \infty$, $p' = \dfrac{p}{p - 1}$, and $a, b > 0$. Consider the function

$$f(x) = \frac{x^p}{p} + \frac{1}{p'} - x, \qquad x \in (0, \infty).$$

Note that $f'(x) = x^{p - 1} - 1$ for $x \in (0, \infty)$. Hence $f'(x) > 0$ when $x \in (1, \infty)$, $f'(x) < 0$ when $x \in (0, 1)$, and $f'(1) = 0$. Therefore $f(1)$ is the minimum value of $f$ on $(0, \infty)$. But

$$f(1) = \frac{1}{p} + \frac{1}{p'} - 1 = 0.$$

Thus $f(x) \geq 0$ for all $x \in (0, \infty)$. Take $x = \dfrac{a}{b^{p' - 1}} > 0$. Then

$$\frac{1}{p}\left(\frac{a}{b^{p' - 1}}\right)^{p} + \frac{1}{p'} - \frac{a}{b^{p' - 1}} \geq 0 \quad \Longrightarrow \quad \frac{1}{p} \cdot \frac{a^p}{b^{p(p' - 1)}} + \frac{1}{p'} \geq \frac{a}{b^{p' - 1}}.$$

Note that $p(p' - 1) = p'$. Hence

$$\frac{a^p}{b^{p'}} \cdot \frac{1}{p} + \frac{1}{p'} \geq \frac{a}{b^{p' - 1}}.$$

Multiplying both sides by $b^{p'}$,

$$\frac{a^p}{p} + \frac{b^{p'}}{p'} \geq ab. \quad \blacksquare$$

**Special case:** If $p = 2$, then $p' = 2$ and

$$ab \leq \frac{a^2}{2} + \frac{b^2}{2}.$$

---

### Theorem: Hölder's Inequality

Let $\Omega$ be a measurable set, $1 \leq p < \infty$, and $p'$ the conjugate of $p$. If $f \in L^p(\Omega)$ and $g \in L^{p'}(\Omega)$, then $fg \in L^1(\Omega)$ and

$$\|fg\|_1 \leq \|f\|_p \, \|g\|_{p'}.$$

Moreover, if $f \neq 0$, the function

$$f^{*} = \|f\|_p^{1 - p} \, \operatorname{sgn}(f) \, |f|^{p - 1}$$

belongs to $L^{p'}(\Omega)$, where

$$\operatorname{sgn}(x) = \begin{cases} 1, & \text{if } x > 0, \\ 0, & \text{if } x = 0, \\ -1, & \text{if } x < 0. \end{cases}$$

Additionally,

$$\int_{\Omega} f \cdot f^{*} = \|f\|_p \qquad \text{and} \qquad \|f^{*}\|_{p'} = 1.$$

**Proof.** If $f = 0$ or $g = 0$, the inequality is trivial. Assume $f, g \neq 0$, and assume first that $1 < p < \infty$. For each $x$, apply Young's inequality to $a = \dfrac{|f(x)|}{\|f\|_p}$ and $b = \dfrac{|g(x)|}{\|g\|_{p'}}$:

$$\frac{|f(x)|}{\|f\|_p} \cdot \frac{|g(x)|}{\|g\|_{p'}} \leq \frac{1}{p} \left(\frac{|f(x)|}{\|f\|_p}\right)^{p} + \frac{1}{p'} \left(\frac{|g(x)|}{\|g\|_{p'}}\right)^{p'}.$$

Integrating over $\Omega$,

$$\frac{1}{\|f\|_p \, \|g\|_{p'}} \int_{\Omega} |f g| \leq \frac{1}{p \, \|f\|_p^{p}} \int_{\Omega} |f|^p + \frac{1}{p' \, \|g\|_{p'}^{p'}} \int_{\Omega} |g|^{p'} = \frac{1}{p} + \frac{1}{p'} = 1.$$

Hence $\|fg\|_1 \leq \|f\|_p \, \|g\|_{p'}$.

For $p = 1$, the conjugate is $p' = \infty$ and the inequality reduces to $\int_{\Omega} |fg| \leq \|g\|_{\infty} \int_{\Omega} |f|$, which holds since $|g| \leq \|g\|_{\infty}$ a.e.

For $f \neq 0$, note that $f\, f^{*} = \|f\|_p^{1 - p} \, |f| \, |f|^{p - 1} = \|f\|_p^{1 - p} |f|^{p}$, so

$$\int_{\Omega} f \cdot f^{*} = \|f\|_p^{1 - p} \int_{\Omega} |f|^{p} = \|f\|_p^{1 - p} \cdot \|f\|_p^{p} = \|f\|_p.$$

Also

$$\int_{\Omega} |f^{*}|^{p'} = \|f\|_p^{(1 - p)p'} \int_{\Omega} |f|^{(p - 1)p'} = \|f\|_p^{(1 - p)p'} \int_{\Omega} |f|^{p},$$

and since $(1 - p)p' = -p$, we get $\displaystyle \int_{\Omega} |f^{*}|^{p'} = \|f\|_p^{-p} \|f\|_p^{p} = 1$. Therefore $\|f^{*}\|_{p'} = 1$. ∎

A special case of Hölder's inequality is called the **Cauchy–Schwarz inequality**, obtained when $p = 2 = p'$:

$$\int_{\Omega} |fg| \leq \left(\int_{\Omega} |f|^2\right)^{1/2} \left(\int_{\Omega} |g|^2\right)^{1/2}.$$

---

### Theorem: Minkowski Inequality

Let $1 \leq p \leq \infty$. If $f, g \in L^p(\Omega)$, then $f + g \in L^p(\Omega)$ and

$$\|f + g\|_p \leq \|f\|_p + \|g\|_p.$$

**Proof.** For $1 \leq p \leq \infty$, if $f, g \in L^p(\Omega)$ we have already shown that $f + g \in L^p(\Omega)$, and we have shown the inequality holds when $p = 1$ and $p = \infty$.

It remains to consider $1 < p < \infty$. Then $|f + g| \leq |f| + |g|$, so

$$|f + g|^p \leq (|f| + |g|) \, |f + g|^{p - 1}.$$

Writing $|f + g|^{p - 1} = |f + g|^{p/q}$ when convenient and applying Hölder's inequality with exponents $p$ and $p'$ to each summand,

$$\int_{\Omega} |f + g|^p \leq \left(\int_{\Omega} |f|^p\right)^{1/p} \left(\int_{\Omega} |f + g|^{(p - 1)p'}\right)^{1/p'} + \left(\int_{\Omega} |g|^p\right)^{1/p} \left(\int_{\Omega} |f + g|^{(p - 1)p'}\right)^{1/p'}.$$

Since $(p - 1)p' = p$, this becomes

$$\int_{\Omega} |f + g|^p \leq (\|f\|_p + \|g\|_p)\, \left(\int_{\Omega} |f + g|^p\right)^{1/p'}.$$

If $\displaystyle \int_{\Omega} |f + g|^p = 0$, there is nothing to prove. Otherwise divide both sides by $\left(\int_{\Omega} |f + g|^p\right)^{1/p'}$ to obtain

$$\left(\int_{\Omega} |f + g|^p\right)^{1/p} \leq \|f\|_p + \|g\|_p,$$

i.e. $\|f + g\|_p \leq \|f\|_p + \|g\|_p$. ∎

---

### Example (Seatwork)

Let $\Omega$ be a bounded measurable subset of $\mathbb{R}$. Show that if $f \in L^{\infty}(\Omega)$, then $f \in L^p(\Omega)$ for every $p \in [1, \infty)$; that is,

$$\int_{\Omega} |f|^p < \infty.$$

**Solution.** Suppose $f \in L^{\infty}(\Omega)$ and let $p \in [1, \infty)$. Then $f$ is essentially bounded: there exists $M > 0$ such that $|f| \leq M$ a.e. in $\Omega$. Also, since $\Omega$ is bounded, $m(\Omega) < \infty$. Therefore $|f|^p \leq M^p$ a.e. in $\Omega$, and

$$\int_{\Omega} |f|^p \leq \int_{\Omega} M^p = M^p m(\Omega) < \infty.$$

Hence $f \in L^p(\Omega)$. ∎

### Corollary

Let $\Omega$ be a measurable set of finite measure and $1 \leq p \leq q \leq \infty$. Then

$$L^q(\Omega) \subseteq L^p(\Omega).$$

Moreover,

$$\|f\|_p \leq c \, \|f\|_q, \qquad \forall f \in L^q(\Omega), \tag{1}$$

where $c = m(\Omega)^{\frac{q - p}{pq}}$ if $q < \infty$, and $c = m(\Omega)^{1/p}$ if $q = \infty$.

**Proof.** Let $f \in L^q(\Omega)$. We want to show that $f \in L^p(\Omega)$, i.e. $\displaystyle \int_{\Omega} |f|^p < \infty$.

If $q = \infty$, then $|f| \leq \|f\|_{\infty}$ a.e. in $\Omega$, so

$$\int_{\Omega} |f|^p \leq \|f\|_{\infty}^{p} \, m(\Omega),$$

and hence $\|f\|_p \leq m(\Omega)^{1/p} \, \|f\|_{\infty}$.

If $q < \infty$, apply Hölder's inequality to $|f|^p \in L^{q/p}(\Omega)$ and $1 \in L^{r}(\Omega)$, where $r = \dfrac{q}{q - p}$ is the conjugate of $\dfrac{q}{p}$:

$$\int_{\Omega} |f|^p = \int_{\Omega} |f|^p \cdot 1 \leq \left(\int_{\Omega} \left(|f|^p\right)^{q/p}\right)^{p/q} \left(\int_{\Omega} 1^{r}\right)^{1/r} = \|f\|_q^{p} \, m(\Omega)^{\frac{q - p}{q}}.$$

Raising both sides to the power $1/p$,

$$\|f\|_p \leq m(\Omega)^{\frac{q - p}{pq}} \, \|f\|_q.$$

This proves $L^q(\Omega) \subseteq L^p(\Omega)$ together with the norm inequality (1). ∎