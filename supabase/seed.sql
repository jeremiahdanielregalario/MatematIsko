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
  ('c0000000-0000-4000-8000-000000000003', 'MATH 40', 'Linear Algebra',
   'Systems of linear equations, vector spaces, linear transformations, and eigenvalues.'),
  ('c0000000-0000-4000-8000-000000000004', 'MATH 126', 'Real Analysis',
   'Sequences, limits, continuity, and differentiability on the real line.'),
  ('cd574181-02fb-4093-9e23-f268fea6baff', 'MATH 110.1', 'Abstract Algebra I',
   'Groups, subgroups, cyclic groups, rings, and ideals.'),
  ('c0000000-0000-4000-8000-000000000006', 'MATH 122', 'Differential Equations and Applications',
   'First-order and linear second-order ordinary differential equations.'),
  ('c0000000-0000-4000-8000-000000000007', 'STAT 101', 'Statistical Methods I',
   'Elementary probability, random variables, and their distributions.'),
  ('c0000000-0000-4000-8000-000000000008', 'STAT 102', 'Statistical Methods II',
   'Estimation, confidence intervals, and hypothesis testing.'),
  ('c0000000-0000-4000-8000-000000000009', 'MATH 142', 'Elementary Topology',
   'Metric and topological spaces, open sets, compactness, and connectedness.')
on conflict (code) do nothing;

-- ---------------------------------------------------------------------------
-- Topics
-- ---------------------------------------------------------------------------
insert into public.topics (id, course_id, name, description) values
  ('d054d6e8-b7f0-5b51-bee3-077535bcff12', 'c0000000-0000-4000-8000-000000000001', 'Limits and Continuity', null),
  ('e0fcbbef-0a2b-5e34-8ea3-a814bec15036', 'c0000000-0000-4000-8000-000000000001', 'Differentiation', null),
  ('891e6378-0089-560a-b6e3-a958bc2ff569', 'c0000000-0000-4000-8000-000000000001', 'Applications of Derivatives', null),
  ('56ed8f8c-e735-5966-8bdf-d69fb026face', 'c0000000-0000-4000-8000-000000000001', 'Integration', null),
  ('f0068c90-d348-53f9-a0cb-5d96616ed130', 'c0000000-0000-4000-8000-000000000002', 'Integration Techniques', null),
  ('a38b0b1e-f4b8-5c1d-8652-87852eb3bcde', 'c0000000-0000-4000-8000-000000000002', 'Sequences and Series', null),
  ('e25dbfed-dfba-520d-896d-0e6e8bad0930', 'c0000000-0000-4000-8000-000000000002', 'Power Series', null),
  ('4278538e-5f97-564b-931e-b93abb751d6d', 'c0000000-0000-4000-8000-000000000003', 'Systems of Linear Equations', null),
  ('fa12d7a6-ff9e-5dd2-ab6b-5762211d30e3', 'c0000000-0000-4000-8000-000000000003', 'Vector Spaces', null),
  ('59c0d7e7-b8c7-5acf-b861-b98d8da62b8c', 'c0000000-0000-4000-8000-000000000003', 'Eigenvalues and Eigenvectors', null),
  ('aedc8388-0405-5758-8869-04cd382811bf', 'c0000000-0000-4000-8000-000000000004', 'Real Sequences and Limits', null),
  ('6a99930b-0342-51d3-8b50-5caec5b9dc32', 'c0000000-0000-4000-8000-000000000004', 'Continuity', null),
  ('e991fd11-981e-5afd-a2f6-cd0a4b9bf058', 'c0000000-0000-4000-8000-000000000004', 'Differentiability', null),
  ('972a40a9-bbb6-518c-beb8-9a3270fd6d88', 'cd574181-02fb-4093-9e23-f268fea6baff', 'Groups and Subgroups', null),
  ('d210d4b4-a572-5804-bdfa-71052bd7dc1b', 'cd574181-02fb-4093-9e23-f268fea6baff', 'Cyclic Groups', null),
  ('5e955520-14c6-5029-b68c-4dc87fc335b1', 'cd574181-02fb-4093-9e23-f268fea6baff', 'Rings and Ideals', null),
  ('a2713fe8-d0fc-5ea4-9bd0-f2c6a253b965', 'c0000000-0000-4000-8000-000000000006', 'First-Order Differential Equations', null),
  ('958f64c7-fb5b-5df0-aad8-74b53387eb79', 'c0000000-0000-4000-8000-000000000006', 'Linear Second-Order Equations', null),
  ('ba213157-df7b-5508-9e84-e89b7546cae8', 'c0000000-0000-4000-8000-000000000007', 'Probability Basics', null),
  ('d7b56557-cf21-5753-89e5-846e0ee7e56c', 'c0000000-0000-4000-8000-000000000007', 'Conditional Probability and Bayes', null),
  ('e6630ffe-d66c-5052-bd01-322238292d9e', 'c0000000-0000-4000-8000-000000000007', 'Random Variables', null),
  ('62c38fcc-f7e3-5797-b4f9-b1f4bc2fc98b', 'c0000000-0000-4000-8000-000000000008', 'Estimation', null),
  ('e496ba7c-761b-5aa8-9e7a-9daf5ecc9ccf', 'c0000000-0000-4000-8000-000000000008', 'Hypothesis Testing', null),
  ('bda32821-a540-5b79-acfe-0691fa8dd2e3', 'c0000000-0000-4000-8000-000000000009', 'Open and Closed Sets', null),
  ('d540ed14-59ca-5ece-9416-7bd146f05802', 'c0000000-0000-4000-8000-000000000009', 'Compactness', null),
  ('82172f37-6c21-565f-8deb-dc67248ff9fe', 'c0000000-0000-4000-8000-000000000009', 'Connectedness', null)
on conflict (course_id, name) do nothing;

-- ---------------------------------------------------------------------------
-- Questions (Markdown + LaTeX). Inline math uses $...$, display math $$...$$.
-- ---------------------------------------------------------------------------
insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'ee0b76f1-a574-5812-ab54-b863b7aed767',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
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
    'a936439c-2944-5fa7-a15b-e84e04e719ce',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
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
    '012fb58c-2bc4-5a57-84e7-40aca78ed7b0',
    'c0000000-0000-4000-8000-000000000001',
    '56ed8f8c-e735-5966-8bdf-d69fb026face',
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
    '7a7a3ec2-1728-588c-9fa1-bea45b86fef7',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
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
    '56f07e8f-4c4f-5a79-9c64-be2aec54b0e6',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
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
    '837f33be-f15e-5066-9a9e-2cf7a954b440',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
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
    '91ad71db-c42e-5fd7-9fb2-f14966dd1576',
    'c0000000-0000-4000-8000-000000000002',
    'e25dbfed-dfba-520d-896d-0e6e8bad0930',
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
    '85f7c11c-3b92-5acd-829a-68698c41d158',
    'c0000000-0000-4000-8000-000000000003',
    '4278538e-5f97-564b-931e-b93abb751d6d',
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
    '736981e9-3fb1-54bf-9aac-6ef5c73cd161',
    'c0000000-0000-4000-8000-000000000003',
    'fa12d7a6-ff9e-5dd2-ab6b-5762211d30e3',
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
    '28a2be4f-cef6-5a5e-9ace-bdf410788fd3',
    'c0000000-0000-4000-8000-000000000003',
    '59c0d7e7-b8c7-5acf-b861-b98d8da62b8c',
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
    'c77a9c34-b59e-555a-a0ad-e72447c8e6e5',
    'c0000000-0000-4000-8000-000000000004',
    'aedc8388-0405-5758-8869-04cd382811bf',
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
    'b2eee0de-26fd-560a-9d8d-28fd2c5d718a',
    'c0000000-0000-4000-8000-000000000004',
    '6a99930b-0342-51d3-8b50-5caec5b9dc32',
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
    '7f03576b-28c5-5c1f-92ac-46d38049832f',
    'c0000000-0000-4000-8000-000000000004',
    'e991fd11-981e-5afd-a2f6-cd0a4b9bf058',
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
    'f8e04b72-10a4-562e-b3bb-1f5b9decbce8',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '972a40a9-bbb6-518c-beb8-9a3270fd6d88',
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
    'b4795a18-0eb7-5dd5-8291-fb67147c1224',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    'd210d4b4-a572-5804-bdfa-71052bd7dc1b',
    'Generators of the Cyclic Group $\mathbb{Z}_{12}$',
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
    '98bcf1cd-e8a0-5b5b-96bc-e23043c95e7a',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5e955520-14c6-5029-b68c-4dc87fc335b1',
    'An Ideal of the Ring $\mathbb{Z}_6$',
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
    '0597874c-86f3-59aa-9809-fcc5c23d47e7',
    'c0000000-0000-4000-8000-000000000006',
    'a2713fe8-d0fc-5ea4-9bd0-f2c6a253b965',
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
    'ee2f0e6c-c192-53c4-9ce5-6f1fd2bd966d',
    'c0000000-0000-4000-8000-000000000006',
    'a2713fe8-d0fc-5ea4-9bd0-f2c6a253b965',
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
    '9396fb49-2675-5e8d-83b2-4a9e293365df',
    'c0000000-0000-4000-8000-000000000006',
    '958f64c7-fb5b-5df0-aad8-74b53387eb79',
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
    'dc2bcae8-92df-5ce0-b987-2ea90c3c7b06',
    'c0000000-0000-4000-8000-000000000007',
    'ba213157-df7b-5508-9e84-e89b7546cae8',
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
    '715d76e2-192a-522a-86d0-056096728464',
    'c0000000-0000-4000-8000-000000000007',
    'd7b56557-cf21-5753-89e5-846e0ee7e56c',
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

$$P(D \mid HH) = \frac{P(HH \mid D)P(D)}{P(HH \mid D)P(D) + P(HH \mid F)P(F)} = \frac{1 \cdot \frac14}{1 \cdot \frac14 + \frac14 \cdot \frac34} = \frac{\frac14}{\frac{7}{16}} = \frac{4}{7}.$$$q$
  ),
  (
    '0e7950ef-b9cf-5729-ad35-68050fec09f4',
    'c0000000-0000-4000-8000-000000000007',
    'e6630ffe-d66c-5052-bd01-322238292d9e',
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
    '275fe246-8bd3-5d4d-9eae-9f28c9e1ebfe',
    'c0000000-0000-4000-8000-000000000008',
    '62c38fcc-f7e3-5797-b4f9-b1f4bc2fc98b',
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
    'f1ba1fce-d19b-5192-9a56-50128ede27f8',
    'c0000000-0000-4000-8000-000000000008',
    'e496ba7c-761b-5aa8-9e7a-9daf5ecc9ccf',
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
    '34bd65f8-2f1e-5a5f-b030-b709e0bb9fdd',
    'c0000000-0000-4000-8000-000000000009',
    'd540ed14-59ca-5ece-9416-7bd146f05802',
    'Is the Interval $(0,1)$ Compact?',
    $q$Is the interval $(0, 1)$ compact as a subset of $\mathbb{R}$ with the usual topology? Justify your answer.$q$,
    'medium',
    2024,
    'Long Exam 2',
    2,
    $q$Recall the Heine–Borel theorem, or build an open cover with no finite subcover.$q$,
    $q$**No**, $(0, 1)$ is not compact.$q$,
    $q$By the Heine–Borel theorem, a subset of $\mathbb{R}$ is compact exactly when it is closed and bounded. The interval $(0, 1)$ is bounded but not closed. Alternatively, the open cover $\{ (1/n, 1 - 1/n) : n \geq 3 \}$ covers $(0, 1)$ yet has no finite subcover: any finite subcover uses only finitely many sets, whose union misses points close to $0$ or $1$.$q$
  );
