-- ============================================================================
-- Insert Math 146 Unit II Course Notes
-- ============================================================================

INSERT INTO public.course_notes (id, course_id, title, content, sort_order)
VALUES (
  'e6c40a16-e845-41ed-83c2-dabd361cb794', -- New UUID for Unit II
  '609dc463-1524-494d-bf0f-91859a2e4cf4', -- MATH 146
  'Unit II: Differential Geometry Notes',
  $BODY$# Math 146: Differential Geometry
**Course Notes**

## Unit II: Meeting 14 (March 11)

### 1. Orthogonal Frame
Let $p \in \mathbb{R}^n$. A collection $\{e_1, \dots, e_n\}$ of nonzero tangent vectors in $T_p(\mathbb{R}^n)$ is an **orthogonal frame** for $T_p(\mathbb{R}^n)$ if $g_p(e_i, e_j) = 0$ whenever $i \neq j$.

### 2. Orthonormal Frame
An orthogonal frame is an **orthonormal frame** if each $e_i$ is a unit tangent vector ($g_p(e_i, e_i) = 1$).

### 3. Orthonormal Frame Field
Let $W \subseteq \mathbb{R}^n$ be open. $\{E_1, \dots, E_n\} \subseteq \mathfrak{X}(W)$ is an **orthonormal frame field** on $W$ if $g(E_i, E_j) = \delta_{ij}$ (where $\delta_{ij}$ is the Kronecker delta).

### 4. Expansion Theorems
An orthonormal frame $\{e_1, \dots, e_n\}$ at point $p$ forms a basis for $T_p(\mathbb{R}^n)$. For any tangent vector $v \in T_p(\mathbb{R}^n)$:

$$v = \sum_{i=1}^n g_p(v, e_i) e_i$$

Similarly, for any vector field $X \in \mathfrak{X}(W)$:

$$X = \sum_{i=1}^n g(X, E_i) E_i$$

### 5. Polar Frame Field (Example)
On $\mathbb{R}^2 \setminus \{(0,0)\}$, with polar coordinates $(r, \theta)$:
$$E_r = \cos \theta U_1 + \sin \theta U_2$$
$$E_\theta = -\sin \theta U_1 + \cos \theta U_2$$
$\{E_r, E_\theta\}$ forms an orthonormal frame field.

---

## Unit II: Meeting 15 (March 13)

### Cylindrical Frame Field
On $\mathbb{R}^3 \setminus \{ (x,y,z) : x=0, y=0 \}$:
$$E_r = \cos \theta U_1 + \sin \theta U_2$$
$$E_\theta = -\sin \theta U_1 + \cos \theta U_2$$
$$E_z = U_3$$

### Frenet Apparatus
For unit-speed curve $\beta: J \to \mathbb{R}^n$:
1.  **Unit tangent:** $T = \beta'$
2.  **Curvature vector:** $T' = \beta''$
3.  **Curvature:** $\kappa = ||T'||$
4.  **Principal normal ($ \kappa > 0$):** $N = \kappa^{-1} T'$
5.  **Binormal ($n=3$):** $B = T \times N$
6.  **Torsion:** $\tau = g(N', B) = -g(B', N)$

The **Frenet Formulas** for $\kappa > 0$ are:
$$T' = \kappa N$$
$$N' = -\kappa T + \tau B$$
$$B' = -\tau N$$

---

## Unit II: Meeting 19 (April 24)

### Coordinate Patch
Let $\Sigma \subseteq \mathbb{R}^n$. A **coordinate patch** in $\Sigma$ is a regular homeomorphism from an open subset of $\mathbb{R}^2$ to an open subset of $\Sigma$.

### Smooth Surface
$\Sigma \subseteq \mathbb{R}^n$ is a **smooth surface** if for all $p \in \Sigma$, there exists a coordinate patch whose image is an open neighborhood of $p$ in $\Sigma$.

### Implicit Function Theorem
If $F: V \subseteq \mathbb{R}^{\ell+m} \to \mathbb{R}^m$ is smooth, $p=(a;b) \in F^{-1}(k)$, and the Jacobian submatrix $\frac{\partial F}{\partial y}$ at $p$ is invertible, then locally the level set $F^{-1}(k)$ is the graph of a unique smooth function $y = g(x)$.

### Regular Level Set Theorem
If $f: V \subseteq \mathbb{R}^3 \to \mathbb{R}$ is smooth and the differential $df|_p \neq 0$ for all $p \in f^{-1}(k)$, then the level set $f^{-1}(k)$ is a smooth surface in $\mathbb{R}^3$.
$BODY$,
  1
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  sort_order = EXCLUDED.sort_order;
