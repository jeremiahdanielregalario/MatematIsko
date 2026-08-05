-- ============================================================================
-- MatematIsko — Seed data
-- Run AFTER schema.sql. Adds 9 courses, 26 topics, and 25 exam questions
-- (100-level UP math/stat courses) written in Markdown + LaTeX.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- Courses
-- ---------------------------------------------------------------------------
insert into public.courses (id, code, name, description) values
  ('c0000000-0000-4000-8000-000000000001', 'MATH 21', 'Elementary Analysis I',
   'Limits, continuity, and differentiation of single-variable functions.'),
  ('c0000000-0000-4000-8000-000000000002', 'MATH 22', 'Elementary Analysis II',
   'Definite integrals, integration techniques, sequences and series.'),
  ('c0000000-0000-4000-8000-000000000003', 'MATH 111', 'Linear Algebra',
   'Systems of linear equations, vector spaces, linear transformations, and eigenvalues.'),
  ('c0000000-0000-4000-8000-000000000004', 'MATH 110', 'Real Analysis',
   'Sequences, limits, continuity, and differentiability on the real line.'),
  ('c0000000-0000-4000-8000-000000000005', 'MATH 121', 'Modern Algebra',
   'Groups, subgroups, cyclic groups, rings, and ideals.'),
  ('c0000000-0000-4000-8000-000000000006', 'MATH 123', 'Differential Equations',
   'First-order and linear second-order ordinary differential equations.'),
  ('c0000000-0000-4000-8000-000000000007', 'STAT 101', 'Statistical Methods I',
   'Elementary probability, random variables, and their distributions.'),
  ('c0000000-0000-4000-8000-000000000008', 'STAT 102', 'Statistical Methods II',
   'Estimation, confidence intervals, and hypothesis testing.'),
  ('c0000000-0000-4000-8000-000000000009', 'MATH 116', 'Topology',
   'Metric and topological spaces, open sets, compactness, and connectedness.')
on conflict (code) do nothing;

-- ---------------------------------------------------------------------------
-- Topics
-- ---------------------------------------------------------------------------
insert into public.topics (id, course_id, name, description) values
  ('t0000000-0000-4000-8000-000000000101', 'c0000000-0000-4000-8000-000000000001', 'Limits and Continuity', null),
  ('t0000000-0000-4000-8000-000000000102', 'c0000000-0000-4000-8000-000000000001', 'Differentiation', null),
  ('t0000000-0000-4000-8000-000000000103', 'c0000000-0000-4000-8000-000000000001', 'Applications of Derivatives', null),
  ('t0000000-0000-4000-8000-000000000104', 'c0000000-0000-4000-8000-000000000001', 'Integration', null),
  ('t0000000-0000-4000-8000-000000000105', 'c0000000-0000-4000-8000-000000000002', 'Integration Techniques', null),
  ('t0000000-0000-4000-8000-000000000106', 'c0000000-0000-4000-8000-000000000002', 'Sequences and Series', null),
  ('t0000000-0000-4000-8000-000000000107', 'c0000000-0000-4000-8000-000000000002', 'Power Series', null),
  ('t0000000-0000-4000-8000-000000000108', 'c0000000-0000-4000-8000-000000000003', 'Systems of Linear Equations', null),
  ('t0000000-0000-4000-8000-000000000109', 'c0000000-0000-4000-8000-000000000003', 'Vector Spaces', null),
  ('t0000000-0000-4000-8000-000000000110', 'c0000000-0000-4000-8000-000000000003', 'Eigenvalues and Eigenvectors', null),
  ('t0000000-0000-4000-8000-000000000111', 'c0000000-0000-4000-8000-000000000004', 'Real Sequences and Limits', null),
  ('t0000000-0000-4000-8000-000000000112', 'c0000000-0000-4000-8000-000000000004', 'Continuity', null),
  ('t0000000-0000-4000-8000-000000000113', 'c0000000-0000-4000-8000-000000000004', 'Differentiability', null),
  ('t0000000-0000-4000-8000-000000000114', 'c0000000-0000-4000-8000-000000000005', 'Groups and Subgroups', null),
  ('t0000000-0000-4000-8000-000000000115', 'c0000000-0000-4000-8000-000000000005', 'Cyclic Groups', null),
  ('t0000000-0000-4000-8000-000000000116', 'c0000000-0000-4000-8000-000000000005', 'Rings and Ideals', null),
  ('t0000000-0000-4000-8000-000000000117', 'c0000000-0000-4000-8000-000000000006', 'First-Order Differential Equations', null),
  ('t0000000-0000-4000-8000-000000000118', 'c0000000-0000-4000-8000-000000000006', 'Linear Second-Order Equations', null),
  ('t0000000-0000-4000-8000-000000000119', 'c0000000-0000-4000-8000-000000000007', 'Probability Basics', null),
  ('t0000000-0000-4000-8000-000000000120', 'c0000000-0000-4000-8000-000000000007', 'Conditional Probability and Bayes', null),
  ('t0000000-0000-4000-8000-000000000121', 'c0000000-0000-4000-8000-000000000007', 'Random Variables', null),
  ('t0000000-0000-4000-8000-000000000122', 'c0000000-0000-4000-8000-000000000008', 'Estimation', null),
  ('t0000000-0000-4000-8000-000000000123', 'c0000000-0000-4000-8000-000000000008', 'Hypothesis Testing', null),
  ('t0000000-0000-4000-8000-000000000124', 'c0000000-0000-4000-8000-000000000009', 'Open and Closed Sets', null),
  ('t0000000-0000-4000-8000-000000000125', 'c0000000-0000-4000-8000-000000000009', 'Compactness', null),
  ('t0000000-0000-4000-8000-000000000126', 'c0000000-0000-4000-8000-000000000009', 'Connectedness', null)
on conflict (course_id, name) do nothing;

-- ---------------------------------------------------------------------------
-- Questions (Markdown + LaTeX). Inline math uses $...$, display math $$...$$.
-- ---------------------------------------------------------------------------
insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'q0000000-0000-4000-8000-000000000201',
    'c0000000-0000-4000-8000-000000000001',
    't0000000-0000-4000-8000-000000000101',
    'A Limit of a Rational Function',
    $q$Compute the limit

$$\lim_{x \to 2} \frac{x^2 - 4}{x - 2},$$

if it exists.$q$,
    'easy',
    2023,
    'Long Exam 1',
    1,
    $q$Factor the numerator and cancel the common factor before taking the limit.$q$,
    $q$$$4$$$q$,
    $q$For $x \neq 2$,

$$\frac{x^2 - 4}{x - 2} = \frac{(x - 2)(x + 2)}{x - 2} = x + 2.$$

A limit only looks at values *near* $x = 2$, so

$$\lim_{x \to 2} \frac{x^2 - 4}{x - 2} = \lim_{x \to 2} (x + 2) = 4.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000202',
    'c0000000-0000-4000-8000-000000000001',
    't0000000-0000-4000-8000-000000000102',
    'The Derivative at a Point',
    $q$Let $f(x) = x^3$. Using the limit definition of the derivative, compute $f'(2)$.$q$,
    'medium',
    2023,
    'Long Exam 1',
    4,
    $q$Write out $\displaystyle \lim_{h \to 0} \frac{f(2 + h) - f(2)}{h}$ and expand $(2 + h)^3$.$q$,
    $q$$$f'(2) = 12$$$q$,
    $q$By definition,

$$\begin{aligned}
f'(2) &= \lim_{h \to 0} \frac{f(2 + h) - f(2)}{h} \\
     &= \lim_{h \to 0} \frac{(2 + h)^3 - 8}{h}.
\end{aligned}$$

Expanding, $(2 + h)^3 = 8 + 12h + 6h^2 + h^3$, so

$$\lim_{h \to 0} \frac{12h + 6h^2 + h^3}{h}
 = \lim_{h \to 0} (12 + 6h + h^2) = 12.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000203',
    'c0000000-0000-4000-8000-000000000001',
    't0000000-0000-4000-8000-000000000104',
    'A Simple Definite Integral',
    $q$Evaluate

$$\int_0^1 x^2 \, dx.$$$q$,
    'easy',
    2023,
    'Final Examination',
    2,
    $q$Apply the power rule in reverse, then evaluate between the limits.$q$,
    $q$$$\frac{1}{3}$$$q$,
    $q$An antiderivative of $x^2$ is $x^3 / 3$, hence

$$\int_0^1 x^2 \, dx = \left[ \frac{x^3}{3} \right]_0^1 = \frac{1}{3} - 0 = \frac{1}{3}.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000204',
    'c0000000-0000-4000-8000-000000000002',
    't0000000-0000-4000-8000-000000000105',
    'Integration by Parts',
    $q$Evaluate

$$\int x e^x \, dx.$$$q$,
    'medium',
    2024,
    'Long Exam 1',
    3,
    $q$Use integration by parts with $u = x$ and $dv = e^x\, dx$.$q$,
    $q$$$e^x (x - 1) + C$$$q$,
    $q$Let $u = x$, $du = dx$, and $dv = e^x\, dx$, $v = e^x$. Then

$$\int x e^x \, dx = x e^x - \int e^x \, dx = x e^x - e^x + C = e^x (x - 1) + C.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000205',
    'c0000000-0000-4000-8000-000000000002',
    't0000000-0000-4000-8000-000000000105',
    'Partial Fractions',
    $q$Evaluate

$$\int \frac{dx}{x^2 - 1}.$$$q$,
    'hard',
    2024,
    'Final Examination',
    1,
    $q$Decompose the integrand into partial fractions with denominators $x - 1$ and $x + 1$.$q$,
    $q$$$\frac{1}{2} \ln\left| \frac{x - 1}{x + 1} \right| + C$$$q$,
    $q$Since $x^2 - 1 = (x - 1)(x + 1)$, write

$$\frac{1}{x^2 - 1} = \frac{1}{2}\left( \frac{1}{x - 1} - \frac{1}{x + 1} \right).$$

Integrating term by term,

$$\int \frac{dx}{x^2 - 1} = \frac{1}{2} \ln|x - 1| - \frac{1}{2} \ln|x + 1| + C
 = \frac{1}{2} \ln\left| \frac{x - 1}{x + 1} \right| + C.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000206',
    'c0000000-0000-4000-8000-000000000002',
    't0000000-0000-4000-8000-000000000106',
    'Convergence of a p-Series',
    $q$Determine whether the series

$$\sum_{n = 1}^{\infty} \frac{1}{n^2}$$

converges or diverges, and justify your answer.$q$,
    'medium',
    2024,
    'Final Examination',
    4,
    $q$Classify this series by the exponent in its general term.$q$,
    $q$The series **converges**.$q$,
    $q$This is a $p$-series $\sum 1/n^p$ with $p = 2$. A $p$-series converges exactly when $p > 1$, so $\sum 1/n^2$ converges.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000207',
    'c0000000-0000-4000-8000-000000000002',
    't0000000-0000-4000-8000-000000000107',
    'Radius of Convergence',
    $q$Find the radius of convergence of the power series

$$\sum_{n = 0}^{\infty} \frac{x^n}{n!}.$$$q$,
    'medium',
    2024,
    'Final Examination',
    6,
    $q$Apply the ratio test to the general term.$q$,
    $q$The radius of convergence is $R = \infty$.$q$,
    $q$Let $a_n = x^n / n!$. The ratio test gives

$$\lim_{n \to \infty} \left| \frac{a_{n + 1}}{a_n} \right|
 = \lim_{n \to \infty} \frac{|x|}{n + 1} = 0 < 1$$

for every real $x$. The series therefore converges for all $x$, so $R = \infty$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000208',
    'c0000000-0000-4000-8000-000000000003',
    't0000000-0000-4000-8000-000000000108',
    'Solving a Linear System',
    $q$Solve the system

$$\begin{cases} x + y = 3 \\ 2x - y = 0. \end{cases}$$$q$,
    'easy',
    2024,
    'Long Exam 1',
    1,
    $q$Add the two equations to eliminate $y$.$q$,
    $q$$$(x, y) = (1, 2)$$$q$,
    $q$Adding the equations gives $3x = 3$, so $x = 1$. Substituting into $x + y = 3$ yields $y = 2$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000209',
    'c0000000-0000-4000-8000-000000000003',
    't0000000-0000-4000-8000-000000000109',
    'Linear Dependence',
    $q$Are the vectors $v_1 = (1, 0, 1)$, $v_2 = (0, 1, 1)$, and $v_3 = (1, 1, 2)$ linearly independent in $\mathbb{R}^3$? Justify your answer.$q$,
    'medium',
    2024,
    'Long Exam 2',
    2,
    $q$Look for a nontrivial linear combination that equals the zero vector.$q$,
    $q$**No**; the vectors are linearly dependent because $v_3 = v_1 + v_2$.$q$,
    $q$Observe that $v_1 + v_2 = (1, 1, 2) = v_3$. Rearranging gives $v_1 + v_2 - v_3 = 0$, a nontrivial linear combination of the vectors equaling the zero vector. Hence they are linearly dependent.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000210',
    'c0000000-0000-4000-8000-000000000003',
    't0000000-0000-4000-8000-000000000110',
    'Eigenvalues of a Symmetric Matrix',
    $q$Find the eigenvalues of

$$A = \begin{pmatrix} 2 & 1 \\ 1 & 2 \end{pmatrix}.$$$q$,
    'medium',
    2024,
    'Final Examination',
    3,
    $q$Compute $\det(A - \lambda I)$ and set it to zero.$q$,
    $q$The eigenvalues are $\lambda = 1$ and $\lambda = 3$.$q$,
    $q$The characteristic polynomial is

$$\det(A - \lambda I) = \begin{vmatrix} 2 - \lambda & 1 \\ 1 & 2 - \lambda \end{vmatrix}
 = (2 - \lambda)^2 - 1 = \lambda^2 - 4\lambda + 3 = (\lambda - 1)(\lambda - 3).$$

Setting this to zero gives $\lambda = 1$ and $\lambda = 3$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000211',
    'c0000000-0000-4000-8000-000000000004',
    't0000000-0000-4000-8000-000000000111',
    'An Epsilon-N Proof',
    $q$Using the $\epsilon$-$N$ definition of convergence, prove that

$$\lim_{n \to \infty} \frac{1}{n} = 0.$$$q$,
    'medium',
    2024,
    'Long Exam 1',
    1,
    $q$Given $\epsilon > 0$, choose a positive integer $N$ with $N > 1 / \epsilon$.$q$,
    $q$Proof: given $\epsilon > 0$, choose $N > 1/\epsilon$; then for all $n \geq N$, $1/n < \epsilon$.$q$,
    $q$Let $\epsilon > 0$ be given. Choose an integer $N > 1/\epsilon$. For every $n \geq N$,

$$\left| \frac{1}{n} - 0 \right| = \frac{1}{n} \leq \frac{1}{N} < \epsilon.$$

This is exactly the definition of $\lim_{n \to \infty} 1/n = 0$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000212',
    'c0000000-0000-4000-8000-000000000004',
    't0000000-0000-4000-8000-000000000112',
    'Not Uniformly Continuous',
    $q$Show that $f(x) = \dfrac{1}{x}$ is **not** uniformly continuous on $(0, 1]$.$q$,
    'hard',
    2024,
    'Long Exam 2',
    4,
    $q$Pick two sequences $x_n, y_n$ in $(0, 1]$ whose difference shrinks to $0$ while $|f(x_n) - f(y_n)|$ stays large.$q$,
    $q$Proof by sequences: take $x_n = 1/n$ and $y_n = 1/(2n)$.$q$,
    $q$Let $x_n = 1/n$ and $y_n = 1/(2n)$. Then

$$|x_n - y_n| = \frac{1}{2n} \to 0,$$

but

$$|f(x_n) - f(y_n)| = |n - 2n| = n \to \infty.$$

If $f$ were uniformly continuous, sequences with $|x_n - y_n| \to 0$ would force $|f(x_n) - f(y_n)| \to 0$. Since that fails, $f$ is not uniformly continuous on $(0, 1]$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000213',
    'c0000000-0000-4000-8000-000000000004',
    't0000000-0000-4000-8000-000000000113',
    'Derivative Implies Continuity',
    $q$Prove that if $f$ is differentiable at $a$, then $f$ is continuous at $a$.$q$,
    'medium',
    2024,
    'Final Examination',
    2,
    $q$Rewrite $f(x) - f(a)$ as a difference quotient times $(x - a)$.$q$,
    $q$Proof: $f(x) - f(a) = \frac{f(x) - f(a)}{x - a} \cdot (x - a) \to f'(a) \cdot 0 = 0$ as $x \to a$.$q$,
    $q$For $x \neq a$,

$$f(x) - f(a) = \frac{f(x) - f(a)}{x - a} \cdot (x - a).$$

Since $f$ is differentiable at $a$, the difference quotient tends to $f'(a)$, while $x - a \to 0$. Therefore $f(x) - f(a) \to f'(a) \cdot 0 = 0$, i.e. $\lim_{x \to a} f(x) = f(a)$, which is continuity at $a$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000214',
    'c0000000-0000-4000-8000-000000000005',
    't0000000-0000-4000-8000-000000000114',
    'Order of an Element and Its Inverse',
    $q$Let $G$ be a group and let $a \in G$. Prove that $a$ and $a^{-1}$ have the same order.$q$,
    'medium',
    2024,
    'Long Exam 1',
    2,
    $q$If $a^n = e$, what can you say about $(a^{-1})^n$?$q$,
    $q$Proof: $a^n = e$ if and only if $(a^{-1})^n = e$, so the least positive such $n$ coincides.$q$,
    $q$Suppose $a$ has finite order $n$, so $a^n = e$. Then

$$(a^{-1})^n = (a^n)^{-1} = e^{-1} = e,$$

so the order of $a^{-1}$ is at most $n$. Repeating the argument with $a$ and $a^{-1}$ swapped gives $\operatorname{ord}(a) \leq \operatorname{ord}(a^{-1})$. Hence the orders are equal. (If $a$ has infinite order, so does $a^{-1}$ by the same pairing.)$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000215',
    'c0000000-0000-4000-8000-000000000005',
    't0000000-0000-4000-8000-000000000115',
    'Generators of the Cyclic Group Z_12',
    $q$How many generators does the cyclic group $\mathbb{Z}_{12}$ have?$q$,
    'easy',
    2024,
    'Long Exam 1',
    1,
    $q$The generators are exactly the elements $k$ with $\gcd(k, 12) = 1$; count them.$q$,
    $q$It has $4$ generators: $1, 5, 7$, and $11$.$q$,
    $q$An element $k$ generates $\mathbb{Z}_{12}$ precisely when $\gcd(k, 12) = 1$. The number of such elements is Euler's totient function $\varphi(12) = 12 \cdot \tfrac12 \cdot \tfrac23 = 4$, namely $1, 5, 7, 11$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000216',
    'c0000000-0000-4000-8000-000000000005',
    't0000000-0000-4000-8000-000000000116',
    'An Ideal of the Ring Z_6',
    $q$In the ring $\mathbb{Z}_6$, show that the set of even residue classes $I = \{ 0, 2, 4 \}$ is an ideal.$q$,
    'medium',
    2024,
    'Final Examination',
    3,
    $q$Check the two defining conditions: $I$ is an additive subgroup, and $I$ absorbs multiplication from both sides.$q$,
    $q$Proof: evens are closed under addition and negation, and any integer multiple of an even class is even.$q$,
    $q$First, $I$ is an additive subgroup of $\mathbb{Z}_6$: the sum of two even classes is even, and the additive inverse of an even class is even. Second, for any $r \in \mathbb{Z}_6$ and any $i \in I$, the product $ri$ is even because each even class is $2$ times some class and multiplication distributes. Hence $rI \subseteq I$ and $Ir \subseteq I$, so $I$ is an ideal.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000217',
    'c0000000-0000-4000-8000-000000000006',
    't0000000-0000-4000-8000-000000000117',
    'A Separable Equation',
    $q$Solve the differential equation $y' = x\,y$.$q$,
    'easy',
    2024,
    'Long Exam 1',
    1,
    $q$Separate the variables so that all $y$'s are on one side and all $x$'s on the other.$q$,
    $q$$$y = C e^{x^2 / 2}$$$q$,
    $q$Separating variables,

$$\frac{dy}{y} = x\, dx.$$

Integrating both sides gives $\ln|y| = x^2/2 + C$, so $|y| = e^{x^2/2 + C}$ and

$$y = C e^{x^2 / 2}.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000218',
    'c0000000-0000-4000-8000-000000000006',
    't0000000-0000-4000-8000-000000000117',
    'An Integrating Factor Problem',
    $q$Solve the initial value problem

$$y' + 2y = e^{-t}, \qquad y(0) = 0.$$$q$,
    'medium',
    2024,
    'Long Exam 1',
    4,
    $q$Multiply through by the integrating factor $\mu(t) = e^{2t}$.$q$,
    $q$$$y(t) = e^{-t} - e^{-2t}$$$q$,
    $q$With $\mu(t) = e^{2t}$, the equation becomes

$$(e^{2t} y)' = e^{2t} e^{-t} = e^{t}.$$

Integrating, $e^{2t} y = e^{t} + C$, so $y = e^{-t} + C e^{-2t}$. Applying $y(0) = 0$ gives $1 + C = 0$, hence $C = -1$ and

$$y(t) = e^{-t} - e^{-2t}.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000219',
    'c0000000-0000-4000-8000-000000000006',
    't0000000-0000-4000-8000-000000000118',
    'A Constant-Coefficient Equation',
    $q$Find the general solution of

$$y'' - 3y' + 2y = 0.$$$q$,
    'medium',
    2024,
    'Final Examination',
    2,
    $q$Write and solve the characteristic equation $r^2 - 3r + 2 = 0$.$q$,
    $q$$$y(t) = C_1 e^{t} + C_2 e^{2t}$$$q$,
    $q$The characteristic equation is $r^2 - 3r + 2 = (r - 1)(r - 2) = 0$, giving distinct real roots $r = 1$ and $r = 2$. The general solution is therefore

$$y(t) = C_1 e^{t} + C_2 e^{2t}.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000220',
    'c0000000-0000-4000-8000-000000000007',
    't0000000-0000-4000-8000-000000000119',
    'The Sum of Two Dice',
    $q$Two fair six-sided dice are rolled. What is the probability that the sum of the outcomes is $7$?$q$,
    'easy',
    2023,
    'Long Exam 1',
    1,
    $q$Count the ordered pairs that sum to $7$ out of the $36$ equally likely outcomes.$q$,
    $q$$$\frac{1}{6}$$$q$,
    $q$There are $6 \times 6 = 36$ equally likely ordered outcomes. The pairs summing to $7$ are $(1,6),(2,5),(3,4),(4,3),(5,2),(6,1)$ — six of them. Hence

$$P(\text{sum} = 7) = \frac{6}{36} = \frac{1}{6}.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000221',
    'c0000000-0000-4000-8000-000000000007',
    't0000000-0000-4000-8000-000000000120',
    'Bayes with a Double-Headed Coin',
    $q$A box contains $3$ fair coins and $1$ double-headed coin. A coin is chosen uniformly at random and tossed twice, landing heads both times. What is the probability that the chosen coin is the double-headed coin?$q$,
    'medium',
    2023,
    'Long Exam 2',
    3,
    $q$Let $D$ be the event of choosing the double-headed coin and let $HH$ be the event of two heads. Apply Bayes' theorem.$q$,
    $q$$$\frac{4}{7}$$$q$,
    $q$Let $D$ = "double-headed coin" and $HH$ = "two heads". Then

$$P(HH \mid D) = 1, \qquad P(HH \mid F) = \frac14, \qquad P(D) = \frac14, \qquad P(F) = \frac34.$$

By Bayes' theorem,

$$P(D \mid HH) = \frac{P(HH \mid D)P(D)}{P(HH \mid D)P(D) + P(HH \mid F)P(F)}
 = \frac{1 \cdot \frac14}{1 \cdot \frac14 + \frac14 \cdot \frac34} = \frac{\frac14}{\frac{7}{16}} = \frac{4}{7}.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000222',
    'c0000000-0000-4000-8000-000000000007',
    't0000000-0000-4000-8000-000000000121',
    'A Binomial Probability',
    $q$Let $X \sim \mathrm{Binomial}(n = 4, p = \tfrac12)$. Compute $P(X = 2)$.$q$,
    'medium',
    2024,
    'Long Exam 1',
    4,
    $q$Use the binomial formula $P(X = k) = \binom{n}{k} p^k (1 - p)^{n - k}$.$q$,
    $q$$$\frac{3}{8}$$$q$,
    $q$Applying the binomial formula,

$$P(X = 2) = \binom{4}{2} \left( \frac12 \right)^2 \left( \frac12 \right)^2
 = 6 \cdot \frac{1}{16} = \frac{3}{8}.$$$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000223',
    'c0000000-0000-4000-8000-000000000008',
    't0000000-0000-4000-8000-000000000122',
    'A Confidence Interval for the Mean',
    $q$A sample of size $n = 100$ from a normal population with known $\sigma = 10$ gives $\bar{x} = 50$. Compute a $95\%$ confidence interval for the population mean $\mu$.$q$,
    'medium',
    2024,
    'Long Exam 1',
    2,
    $q$Use the $z$-interval $\bar{x} \pm z_{\alpha/2} \cdot \sigma / \sqrt{n}$ with $z_{0.025} \approx 1.96$.$q$,
    $q$$$(48.04,\ 51.96)$$$q$,
    $q$The margin of error is

$$z_{0.025} \cdot \frac{\sigma}{\sqrt{n}} = 1.96 \cdot \frac{10}{10} = 1.96.$$

So the interval is $50 \pm 1.96 = (48.04, 51.96)$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000224',
    'c0000000-0000-4000-8000-000000000008',
    't0000000-0000-4000-8000-000000000123',
    'Interpreting a p-value',
    $q$A two-tailed test of $H_0: \mu = 5$ versus $H_1: \mu \neq 5$ returns a $p$-value of $0.03$ at significance level $\alpha = 0.05$. State the conclusion in plain language.$q$,
    'medium',
    2024,
    'Final Examination',
    3,
    $q$Reject $H_0$ whenever the $p$-value is less than $\alpha$.$q$,
    $q$Reject $H_0$: there is evidence that $\mu \neq 5$.$q$,
    $q$Since $0.03 < 0.05$, the result is significant at the $5\%$ level. We reject the null hypothesis and conclude there is evidence that the population mean differs from $5$.$q$
  ),
  (
    'q0000000-0000-4000-8000-000000000225',
    'c0000000-0000-4000-8000-000000000009',
    't0000000-0000-4000-8000-000000000125',
    'Is the Interval (0,1) Compact?',
    $q$Is the interval $(0, 1)$ compact as a subset of $\mathbb{R}$ with the usual topology? Justify your answer.$q$,
    'medium',
    2024,
    'Long Exam 2',
    2,
    $q$Recall the Heine–Borel theorem, or build an open cover with no finite subcover.$q$,
    $q$**No**, $(0, 1)$ is not compact.$q$,
    $q$By the Heine–Borel theorem, a subset of $\mathbb{R}$ is compact exactly when it is closed and bounded. The interval $(0, 1)$ is bounded but not closed. Alternatively, the open cover $\{ (1/n, 1 - 1/n) : n \geq 3 \}$ covers $(0, 1)$ yet has no finite subcover: any finite subcover uses only finitely many sets, whose union misses points close to $0$ or $1$.$q$
  );
