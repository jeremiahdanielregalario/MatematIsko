# Math 146: Differential Geometry
**Course Notes**

## Unit I: Foundations of Topology and Differentiability

### 1. General Topology
Mathematical analysis studies functions on spaces, but to talk about "closeness" without necessarily having a geometric distance, we use **Topology**.

**Definition (Topology):** A topology on a set $X$ is a collection $\mathcal{T}$ of subsets of $X$ (the *open sets*) that satisfies:
1.  **Existence of Extrema:** $\emptyset \in \mathcal{T}$ and $X \in \mathcal{T}$.
2.  **Closure under Arbitrary Unions:** If $\mathcal{U} \subseteq \mathcal{T}$, then $\bigcup_{U \in \mathcal{U}} U \in \mathcal{T}$.
3.  **Closure under Finite Intersections:** If $U_1, \dots, U_n \in \mathcal{T}$, then $\bigcap_{i=1}^n U_i \in \mathcal{T}$.

*   $(X, \mathcal{T})$ is a **topological space**.
*   **Closed Sets:** $C \subseteq X$ is closed if $X \setminus C \in \mathcal{T}$.
*   **Neighborhood:** $U$ is a neighborhood of $p$ if $p \in U$ and $U \in \mathcal{T}$.

#### Standard vs. Dictionary Topologies on $\mathbb{R}^2$
*   **Standard:** A set $U$ is open if for every $p \in U$, there exists an open ball $B(p, r) \subseteq U$. This captures the usual Euclidean notion of distance.
*   **Dictionary:** Uses intervals $[(a,b), (c,d)]$ defined by a strict lexical ordering. Points "closer" in the first coordinate are "smaller." This is a different way to define "open" sets.

### 2. Interior and Boundary
For a subset $A \subseteq X$:
*   **Interior ($A^\circ$):** The set of interior points $p$. $p$ is interior if $A$ contains some open neighborhood of $p$. It is the **largest open set** contained in $A$.
*   **Boundary ($\partial A$):** The set of points where every neighborhood intersects both $A$ and $X \setminus A$.
*   **Key Property:** $A = A^\circ \cup (\partial A \cap A)$. An element of $A$ is either *inside* (interior) or *on the edge* (boundary).

### 3. Subspace Topology
If $Y \subseteq X$ and $\mathcal{T}$ is a topology on $X$, we "inherit" a topology on $Y$ by intersecting all open sets of $X$ with $Y$.
$$\mathcal{S} = \{Y \cap U \mid U \in \mathcal{T}\}$$
This makes $Y$ a topological space in its own right, restricted to the points within $Y$.

***

## Unit II: Calculus on Euclidean Spaces

### 4. Natural Coordinates and Smoothness
We define functions $x_i: \mathbb{R}^n \to \mathbb{R}$ that act as coordinate projections: $x_i(p_1, \dots, p_n) = p_i$. These allow us to refer to specific dimensions within the space.

A function $f: U \to \mathbb{R}^m$ is **smooth** ($C^\infty$) if all its partial derivatives of all orders exist and are continuous. For sets $A$ with non-empty interior, we say $f$ is smooth if it has a *smooth extension* to an open neighborhood of $A$.

### 5. Tangent Vectors and Vector Fields
In calculus, we often treat arrows as vectors. To be rigorous in Differential Geometry, we distinguish the **base point** $p$ from the **vector part** $v$.

*   **Tangent Vector ($v_p$):** A pair $(p, v)$.
*   **Tangent Space ($T_p\mathbb{R}^n$):** The set of all tangent vectors based at $p$. It forms an $n$-dimensional vector space.
*   **Directional Derivative ($v_p(f)$):** This operator acts like a derivative. $v_p(f)$ calculates the rate of change of a function $f$ at point $p$ in the direction of the vector $v$.
*   **Identification:** The tangent space $T_p\mathbb{R}^n$ can be canonically identified with the space of *linear derivations* $D_p\mathbb{R}^n$ (linear operators that satisfy the Leibniz rule).

### 6. The Differential Map (Tangent Map)
If $f: V \to \mathbb{R}^m$ is a smooth map, it induces a linear map between tangent spaces:
$$f_{*|p} : T_p\mathbb{R}^n \to T_{f(p)}\mathbb{R}^m$$
This map takes a tangent vector $v_p$ and gives a tangent vector at the *target* point $f(p)$. Its matrix representation is the **Jacobian matrix** of $f$ at $p$.

*   **Property:** If $f \circ g$ is defined, then $(f \circ g)_{*|p} = f_{*|g(p)} \circ g_{*|p}$. This is a higher-level version of the **Chain Rule**.

***

## Unit III: Forms and Riemannian Metrics

### 7. Cotangent Vectors and 1-Forms
If $T_p\mathbb{R}^n$ is the space of vectors (velocities), the **Cotangent Space** $T_p^*\mathbb{R}^n$ is the space of linear functionals (functions that "accept" a tangent vector and return a number).
*   **1-Form:** A smooth assignment of a cotangent vector to every point in an open set $W$.
*   **The Differential:** For a smooth function $f$, $df$ is a 1-form defined by $df|_p(v_p) = v_p(f)$. It is the fundamental builder of 1-forms.

### 8. The Wedge Product and $k$-Forms
To multiply differential forms, we use the **Wedge Product ($\wedge$)**.
*   **Properties:** Associative, distributive, and **skew-symmetric** ($\alpha \wedge \beta = - \beta \wedge \alpha$ if $\alpha$ and $\beta$ are 1-forms).
*   This skew-symmetry is what forces $dx \wedge dx = 0$ and $dx \wedge dy = -dy \wedge dx$. It geometrically represents signed area/volume elements.

### 9. Exterior Differentiation ($d$)
The operator $d$ turns a $k$-form into a $(k+1)$-form. It generalizes `grad`, `curl`, and `div`:
*   **0-form $\to$ 1-form:** $d(f) = \text{grad } f$.
*   **1-form $\to$ 2-form:** $d(\dots) = \text{curl } V$.
*   **2-form $\to$ 3-form:** $d(\dots) = \text{div } V$.
*   **Crucial Property:** $d^2 = 0$. This explains why `curl(grad f) = 0` and `div(curl V) = 0`.

### 10. Riemannian Metric ($g$)
The metric $g$ provides the *geometric* structure (distance and angles) to $\mathbb{R}^n$. It is an inner product defined at each tangent space:
$$g_p(v_p, w_p) = v \cdot w$$
This allows us to calculate:
*   **Norm:** $||v_p|| = \sqrt{g_p(v_p, v_p)}$.
*   **Angle:** $\cos \theta = \frac{g_p(v_p, w_p)}{||v_p|| ||w_p||}$.

***

## Unit IV: Curves and Covariant Differentiation

### 11. Smooth Curves
A curve $\alpha: I \to \mathbb{R}^n$ is smooth. 
*   **Regular Curve:** $\alpha'(t) \neq 0$ for all $t$.
*   **Unit-Speed Parametrization:** A curve where $||\alpha'(t)|| = 1$. This is the "natural" parametrization by arc-length $s$.

### 12. Covariant Differentiation ($\nabla$)
If $X$ is a vector field *along* a curve $\alpha$, how do we take its derivative? We use the **covariant derivative** $X'$.
In $\mathbb{R}^n$, this is equivalent to differentiating the coordinate functions of $X$ with respect to $t$.

*   **Geodesics:** Curves that have no acceleration ($\alpha'' = 0$). In Euclidean space $\mathbb{R}^n$, these are simply **straight lines**.

*   **Levi-Civita Connection ($\nabla_X Y$):** This generalizes the covariant derivative to arbitrary vector fields $X, Y$ on an open set $W \subseteq \mathbb{R}^n$. It allows us to differentiate vector fields *in the direction* of other vector fields. 
    *   **Crucial Property:** If $Y = \sum Y_i U_i$, then $\nabla_X Y = \sum X(Y_i) U_i$.
    *   Leibniz rule holds: $\nabla_X(fY) = X(f)Y + f\nabla_X Y$.
