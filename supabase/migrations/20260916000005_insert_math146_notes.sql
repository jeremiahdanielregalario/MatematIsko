-- ============================================================================
-- Insert Math 146 Unit II Course Notes
-- ============================================================================

INSERT INTO public.course_notes (id, course_id, title, content, sort_order)
VALUES (
  'e6c40a16-e845-41ed-83c2-dabd361cb794', -- New UUID for Unit II
  '609dc463-1524-494d-bf0f-91859a2e4cf4', -- MATH 146
  'Unit II: Differential Geometry Notes',
  $BODY$# Math 146: Differential Geometry — Unit II

## Unit II: Meeting 14 (March 11)

### Frames and Frame Fields

**Orthogonal Frame:** For $p \in \mathbb{R}^n$, $\{e_1, \dots, e_n\}$ in $T_p(\mathbb{R}^n)$ is an *orthogonal frame* if $g_p(e_i, e_j) = 0$ for $i \neq j$.

**Orthonormal Frame:** An orthogonal frame where every $e_i$ is a unit vector ($||e_i|| = 1$).

**Frame Fields:** If this holds for a collection of vector fields $\{E_1, \dots, E_n\}$ on an open set $W$, it is an orthonormal frame field. An example is the natural frame field $\{U_1, \dots, U_n\}$ on $\mathbb{R}^n$.

**Theorems:**
- Orthonormal frames form a basis for $T_p(\mathbb{R}^n)$.
- Any tangent vector $v$ can be expanded: $v = \sum g_p(v, e_i)e_i$.
- Any vector field $X$ can be expanded: $X = \sum g(X, E_i)E_i$.

**Polar/Cylindrical Frames:** Coordinate systems like polar/cylindrical allow us to construct non-natural orthonormal frame fields (e.g., $\{E_r, E_\theta\}$ on $\mathbb{R}^2 \setminus \{0\}$).

---

## Unit II: Meeting 19 (April 24)

### Intro to Surfaces
- **Coordinate Patch:** A regular homeomorphism from an open subset of $\mathbb{R}^2$ to a subset of a surface $\Sigma \subseteq \mathbb{R}^n$.
- **Smooth Surface:** A set $\Sigma$ where every point $p \in \Sigma$ is covered by a coordinate patch.
- **Monge Patch:** A simple surface defined as the graph of a smooth function $f(u, v)$ over a domain $D \subseteq \mathbb{R}^2$:
  $$\phi(u, v) = (u, v, f(u, v))$$
- **Implicit Function Theorem:** This theorem provides the criteria for when a level set $F^{-1}(k)$ of a smooth function $F: V \subseteq \mathbb{R}^{\ell+m} \to \mathbb{R}^m$ is locally a smooth surface (given the Jacobian satisfies rank conditions).

### Tangent Vectors to Surfaces
A tangent vector $v_p \in T_p(\mathbb{R}^n)$ is **tangent to $\Sigma$** at $p$ if it is the velocity vector of some curve $\alpha: I \to \Sigma$. The collection of all such vectors forms the **tangent space** $T_p(\Sigma)$.$BODY$,
  2
)
ON CONFLICT (id) DO UPDATE SET
  title = EXCLUDED.title,
  content = EXCLUDED.content,
  sort_order = EXCLUDED.sort_order;
