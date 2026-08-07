-- ============================================================================
-- MatematIsko — Seed data (single file, safe to re-run)
-- Run AFTER schema.sql.
-- Adds 9 courses, 29 topics, and 47 exam questions (100-level UP math/stat
-- courses + Math 110.1) written in Markdown + LaTeX.
--
-- Safe to re-run: courses upsert by code, topics/questions use ON CONFLICT
-- DO NOTHING, so existing rows are left untouched. To force a full refresh:
--   TRUNCATE questions, topics, courses RESTART IDENTITY CASCADE;
-- then run this file.
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
   'Groups, rings, fields, ideals, homomorphisms, and fields of quotients.'),
  ('c0000000-0000-4000-8000-000000000006', 'MATH 122', 'Differential Equations and Applications',
   'First-order and linear second-order ordinary differential equations.'),
  ('c0000000-0000-4000-8000-000000000007', 'STAT 101', 'Statistical Methods I',
   'Elementary probability, random variables, and their distributions.'),
  ('c0000000-0000-4000-8000-000000000008', 'STAT 102', 'Statistical Methods II',
   'Estimation, confidence intervals, and hypothesis testing.'),
  ('c0000000-0000-4000-8000-000000000009', 'MATH 142', 'Elementary Topology',
   'Metric and topological spaces, open sets, compactness, and connectedness.')
on conflict (code) do update set name = excluded.name, description = excluded.description;

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
  ('5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae', 'cd574181-02fb-4093-9e23-f268fea6baff', 'Rings, Ideals, and Fields', null),
  ('656800c1-6424-48fd-b98d-0e1869bc0993', 'cd574181-02fb-4093-9e23-f268fea6baff',
   'Prime and Maximal Ideals', 'Characterizing ideals via quotient rings in Z_n and Z x Z.'),
  ('7977cbab-91ae-4b90-ac11-632565468414', 'cd574181-02fb-4093-9e23-f268fea6baff',
   'Fields of Quotients', 'Constructing the field of fractions from an integral domain.'),
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
-- Questions — Base set (25). Inline math uses $...$, display math $$...$$.
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

$$

\begin{equation*}\lim_{x \to 2} \frac{x^2 - 4}{x - 2},\end{equation*}
$$

if it exists.$q$,
    'easy',
    2023,
    'Long Exam 1',
    1,
    $q$Factor the numerator and cancel the common factor before taking the limit.$q$,
    $q$$4$$q$,
    $q$For $x \neq 2$,

$$

\begin{equation*}\frac{x^2 - 4}{x - 2} = \frac{(x - 2)(x + 2)}{x - 2} = x + 2.\end{equation*}
$$

A limit only looks at values *near* $x = 2$, so

$$

\begin{equation*}\lim_{x \to 2} \frac{x^2 - 4}{x - 2} = \lim_{x \to 2} (x + 2) = \boxed{4}.\end{equation*}
$$$q$
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
    $q$$f'(2) = 12$$q$,
    $q$By definition,

$$

\begin{aligned}
f'(2) &= \lim_{h \to 0} \frac{f(2 + h) - f(2)}{h} \\
     &= \lim_{h \to 0} \frac{(2 + h)^3 - 8}{h}.
\end{aligned}
$$

Expanding, $(2 + h)^3 = 8 + 12h + 6h^2 + h^3$, so

$$
\begin{aligned}
\lim_{h \to 0} \frac{12h + 6h^2 + h^3}{h} = \lim_{h \to 0} (12 + 6h + h^2) = \boxed{12}.
\end{aligned}
$$$q$
  ),
  (
    '012fb58c-2bc4-5a57-84e7-40aca78ed7b0',
    'c0000000-0000-4000-8000-000000000001',
    '56ed8f8c-e735-5966-8bdf-d69fb026face',
    'A Simple Definite Integral',
    $q$Evaluate

$$

\begin{equation*}\int_0^1 x^2 \, dx.\end{equation*}
$$$q$,
    'easy',
    2023,
    'Final Examination',
    2,
    $q$Apply the power rule in reverse, then evaluate between the limits.$q$,
    $q$$\frac{1}{3}$$q$,
    $q$An antiderivative of $x^2$ is $x^3 / 3$, hence

$$

\begin{equation*}\int_0^1 x^2 \, dx = \left[ \frac{x^3}{3} \right]_0^1 = \frac{1}{3} - 0 = \boxed{\frac{1}{3}}.\end{equation*}
$$$q$
  ),
  (
    '7a7a3ec2-1728-588c-9fa1-bea45b86fef7',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
    'Integration by Parts',
    $q$Evaluate

$$

\begin{equation*}\int x e^x \, dx.\end{equation*}
$$$q$,
    'medium',
    2024,
    'Long Exam 1',
    3,
    $q$Use integration by parts with $u = x$ and $dv = e^x\, dx$.$q$,
    $q$$e^x (x - 1) + C$$q$,
    $q$Let $u = x$, $du = dx$, and $dv = e^x\, dx$, $v = e^x$. Then

$$

\begin{equation*}\int x e^x \, dx = x e^x - \int e^x \, dx = x e^x - e^x + C = \boxed{e^x (x - 1) + C}.\end{equation*}
$$$q$
  ),
  (
    '56f07e8f-4c4f-5a79-9c64-be2aec54b0e6',
    'c0000000-0000-4000-8000-000000000002',
    'f0068c90-d348-53f9-a0cb-5d96616ed130',
    'Partial Fractions',
    $q$Evaluate

$$

\begin{equation*}\int \frac{dx}{x^2 - 1}.\end{equation*}
$$$q$,
    'hard',
    2024,
    'Final Examination',
    1,
    $q$Decompose the integrand into partial fractions with denominators $x - 1$ and $x + 1$.$q$,
    $q$$\frac{1}{2} \ln\left| \frac{x - 1}{x + 1} \right| + C$$q$,
    $q$Since $x^2 - 1 = (x - 1)(x + 1)$, write

$$

\begin{equation*}\frac{1}{x^2 - 1} = \frac{1}{2}\left( \frac{1}{x - 1} - \frac{1}{x + 1} \right).\end{equation*}
$$

Integrating term by term,

$$

\begin{equation*}\int \frac{dx}{x^2 - 1} = \frac{1}{2} \ln|x - 1| - \frac{1}{2} \ln|x + 1| + C = \boxed{\frac{1}{2} \ln\left| \frac{x - 1}{x + 1} \right| + C}.\end{equation*}
$$$q$
  ),
  (
    '837f33be-f15e-5066-9a9e-2cf7a954b440',
    'c0000000-0000-4000-8000-000000000002',
    'a38b0b1e-f4b8-5c1d-8652-87852eb3bcde',
    'Convergence of a p-Series',
    $q$Determine whether the series

$$

\begin{equation*}\sum_{n = 1}^{\infty} \frac{1}{n^2}\end{equation*}
$$

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

$$

\begin{equation*}\sum_{n = 0}^{\infty} \frac{x^n}{n!}.\end{equation*}
$$$q$,
    'medium',
    2024,
    'Final Examination',
    6,
    $q$Apply the ratio test to the general term.$q$,
    $q$The radius of convergence is $R = \infty$.$q$,
    $q$Let $a_n = x^n / n!$. The ratio test gives

$$

\begin{equation*}\lim_{n \to \infty} \left| \frac{a_{n + 1}}{a_n} \right| = \lim_{n \to \infty} \frac{|x|}{n + 1} = 0 < 1\end{equation*}
$$

for every real $x$. The series therefore converges for all $x$, so $\boxed{R = \infty}$.$q$
  ),
  (
    '85f7c11c-3b92-5acd-829a-68698c41d158',
    'c0000000-0000-4000-8000-000000000003',
    '4278538e-5f97-564b-931e-b93abb751d6d',
    'Solving a Linear System',
    $q$Solve the system

$$

\begin{equation*}\begin{cases} x + y = 3 \\ 2x - y = 0. \end{cases}\end{equation*}
$$$q$,
    'easy',
    2024,
    'Long Exam 1',
    1,
    $q$Add the two equations to eliminate $y$.$q$,
    $q$$(x, y) = (1, 2)$$q$,
    $q$Adding the equations gives $3x = 3$, so $x = 1$. Substituting into $x + y = 3$ yields $y = 2$, so $\boxed{(x, y) = (1, 2)}$.$q$
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

$$

\begin{equation*}A = \begin{pmatrix} 2 & 1 \\ 1 & 2 \end{pmatrix}.\end{equation*}
$$$q$,
    'medium',
    2024,
    'Final Examination',
    3,
    $q$Compute $\det(A - \lambda I)$ and set it to zero.$q$,
    $q$The eigenvalues are $\lambda = 1$ and $\lambda = 3$.$q$,
    $q$The characteristic polynomial is

$$

\begin{equation*}\det(A - \lambda I) = \begin{vmatrix} 2 - \lambda & 1 \\ 1 & 2 - \lambda \end{vmatrix} = (2 - \lambda)^2 - 1 = \lambda^2 - 4\lambda + 3 = (\lambda - 1)(\lambda - 3).\end{equation*}
$$

Setting this to zero gives $\lambda = \boxed{1}$ and $\lambda = \boxed{3}$.$q$
  ),
  (
    'c77a9c34-b59e-555a-a0ad-e72447c8e6e5',
    'c0000000-0000-4000-8000-000000000004',
    'aedc8388-0405-5758-8869-04cd382811bf',
    'An Epsilon-N Proof',
    $q$Using the $\epsilon$-$N$ definition of convergence, prove that

$$

\begin{equation*}\lim_{n \to \infty} \frac{1}{n} = 0.\end{equation*}
$$$q$,
    'medium',
    2024,
    'Long Exam 1',
    1,
    $q$Given $\epsilon > 0$, choose a positive integer $N$ with $N > 1 / \epsilon$.$q$,
    $q$Proof: given $\epsilon > 0$, choose $N > 1/\epsilon$; then for all $n \geq N$, $1/n < \epsilon$.$q$,
    $q$Let $\epsilon > 0$ be given. Choose an integer $N > 1/\epsilon$. For every $n \geq N$,

$$

\begin{equation*}\left| \frac{1}{n} - 0 \right| = \frac{1}{n} \leq \frac{1}{N} < \epsilon.\end{equation*}
$$

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

$$

\begin{equation*}|x_n - y_n| = \frac{1}{2n} \to 0,\end{equation*}
$$

but

$$

\begin{equation*}|f(x_n) - f(y_n)| = |n - 2n| = n \to \infty.\end{equation*}
$$

If $f$ were uniformly continuous, sequences with $|x_n - y_n| \to 0$ would force $|f(x_n) - f(y_n)| \to 0$. Since that fails, $f$ is not uniformly continuous on $(0, 1]$.$q$
  ),
  (
    '7f03576b-28c5-5c1f-92ac-46d38049832f',
    'c0000000-0000-4000-8000-000000000004',
    'e991fd11-981e-5afd-a2f6-cd0a4b9bf058',
    'Differentiability Implies Continuity',
    $q$Prove that if $f$ is differentiable at $a$, then $f$ is continuous at $a$.$q$,
    'medium',
    2024,
    'Final Examination',
    2,
    $q$Rewrite $f(x) - f(a)$ as a difference quotient times $(x - a)$.$q$,
    $q$Proof: $f(x) - f(a) = \frac{f(x) - f(a)}{x - a} \cdot (x - a) \to f'(a) \cdot 0 = 0$ as $x \to a$.$q$,
    $q$For $x \neq a$,

$$

\begin{equation*}f(x) - f(a) = \frac{f(x) - f(a)}{x - a} \cdot (x - a).\end{equation*}
$$

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

$$

\begin{equation*}(a^{-1})^n = (a^n)^{-1} = e^{-1} = e,\end{equation*}
$$

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
    $q$$y = C e^{x^2 / 2}$$q$,
    $q$Separating variables,

$$

\begin{equation*}\frac{dy}{y} = x\, dx.\end{equation*}
$$

Integrating both sides gives $\ln|y| = x^2/2 + C$, so $|y| = e^{x^2/2 + C}$ and

$$

\begin{equation*}\boxed{y = C e^{x^2 / 2}}.\end{equation*}
$$$q$
  ),
  (
    'ee2f0e6c-c192-53c4-9ce5-6f1fd2bd966d',
    'c0000000-0000-4000-8000-000000000006',
    'a2713fe8-d0fc-5ea4-9bd0-f2c6a253b965',
    'An Integrating Factor Problem',
    $q$Solve the initial value problem

$$

\begin{equation*}y' + 2y = e^{-t}, \qquad y(0) = 0.\end{equation*}
$$$q$,
    'medium',
    2024,
    'Long Exam 1',
    4,
    $q$Multiply through by the integrating factor $\mu(t) = e^{2t}$.$q$,
    $q$$y(t) = e^{-t} - e^{-2t}$$q$,
    $q$With $\mu(t) = e^{2t}$, the equation becomes

$$

\begin{equation*}(e^{2t} y)' = e^{2t} e^{-t} = e^{t}.\end{equation*}
$$

Integrating, $e^{2t} y = e^{t} + C$, so $y = e^{-t} + C e^{-2t}$. Applying $y(0) = 0$ gives $1 + C = 0$, hence $C = -1$ and

$$

\begin{equation*}\boxed{y(t) = e^{-t} - e^{-2t}}.\end{equation*}
$$$q$
  ),
  (
    '9396fb49-2675-5e8d-83b2-4a9e293365df',
    'c0000000-0000-4000-8000-000000000006',
    '958f64c7-fb5b-5df0-aad8-74b53387eb79',
    'A Constant-Coefficient Equation',
    $q$Find the general solution of

$$

\begin{equation*}y'' - 3y' + 2y = 0.\end{equation*}
$$$q$,
    'medium',
    2024,
    'Final Examination',
    2,
    $q$Write and solve the characteristic equation $r^2 - 3r + 2 = 0$.$q$,
    $q$$y(t) = C_1 e^{t} + C_2 e^{2t}$$q$,
    $q$The characteristic equation is $r^2 - 3r + 2 = (r - 1)(r - 2) = 0$, giving distinct real roots $r = 1$ and $r = 2$. The general solution is therefore

$$

\begin{equation*}\boxed{y(t) = C_1 e^{t} + C_2 e^{2t}}.\end{equation*}
$$$q$
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
    $q$$\frac{1}{6}$$q$,
    $q$There are $6 \times 6 = 36$ equally likely ordered outcomes. The pairs summing to $7$ are $(1,6),(2,5),(3,4),(4,3),(5,2),(6,1)$ — six of them. Hence

$$

\begin{equation*}P(\text{sum} = 7) = \frac{6}{36} = \boxed{\frac{1}{6}}.\end{equation*}
$$$q$
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
    $q$$\frac{4}{7}$$q$,
    $q$Let $D$ = "double-headed coin" and $HH$ = "two heads". Then

$$

\begin{equation*}P(HH \mid D) = 1, \qquad P(HH \mid F) = \frac14, \qquad P(D) = \frac14, \qquad P(F) = \frac34.\end{equation*}
$$

By Bayes' theorem,

$$

\begin{equation*}P(D \mid HH) = \frac{P(HH \mid D)P(D)}{P(HH \mid D)P(D) + P(HH \mid F)P(F)} = \frac{1 \cdot \frac14}{1 \cdot \frac14 + \frac14 \cdot \frac34} = \frac{\frac14}{\frac{7}{16}} = \boxed{\frac{4}{7}}.\end{equation*}
$$$q$
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
    $q$$\frac{3}{8}$$q$,
    $q$Applying the binomial formula,

$$

\begin{equation*}P(X = 2) = \binom{4}{2} \left( \frac12 \right)^2 \left( \frac12 \right)^2 = 6 \cdot \frac{1}{16} = \boxed{\frac{3}{8}}.\end{equation*}
$$$q$
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
    $q$$(48.04,\ 51.96)$$q$,
    $q$The margin of error is

$$

\begin{equation*}z_{0.025} \cdot \frac{\sigma}{\sqrt{n}} = 1.96 \cdot \frac{10}{10} = 1.96.\end{equation*}
$$

So the interval is $50 \pm 1.96 = \boxed{(48.04, 51.96)}$.$q$
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
    'Is the open unit interval compact?',
    $q$Is the interval $(0, 1)$ compact as a subset of $\mathbb{R}$ with the usual topology? Justify your answer.$q$,
    'medium',
    2024,
    'Long Exam 2',
    2,
    $q$Recall the Heine–Borel theorem, or build an open cover with no finite subcover.$q$,
    $q$**No**, $(0, 1)$ is not compact.$q$,
    $q$By the Heine–Borel theorem, a subset of $\mathbb{R}$ is compact exactly when it is closed and bounded. The interval $(0, 1)$ is bounded but not closed. Alternatively, the open cover $\{ (1/n, 1 - 1/n) : n \geq 3 \}$ covers $(0, 1)$ yet has no finite subcover: any finite subcover uses only finitely many sets, whose union misses points close to $0$ or $1$.$q$
  )
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- Questions — Math 110.1 Third Long Exam 2023-2024 (8)
-- ---------------------------------------------------------------------------
insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '40da8bc6-d7c7-4255-a1c2-bb19cf54400b',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Definitions: Division Ring, Zero Divisor, Prime Ideal',
    $q$Define the following precisely:

**(a)** Division ring
**(b)** Zero divisor
**(c)** Prime ideal$q$,
    'medium',
    2023,
    'Third Long Exam',
    1,
    $q$Recall the exact algebraic conditions that each definition requires — do not state partial definitions.$q$,
    $q$**(a)** A *division ring* (or *skew field*) is a ring $R$ with unity $1 \neq 0$ in which every nonzero element has a multiplicative inverse. (Multiplication need not be commutative.)

**(b)** A *zero divisor* in a ring $R$ is a nonzero element $a \in R$ such that there exists a nonzero $b \in R$ with $ab = 0$ or $ba = 0$.

**(c)** A *prime ideal* of a commutative ring $R$ is a proper ideal $P$ such that whenever $ab \in P$ for $a, b \in R$, then $a \in P$ or $b \in P$.$q$,
    $q$**(a)** A **division ring** (skew field) is a ring $(R, +, \cdot)$ with unity $1 \neq 0$ such that every nonzero element $a \in R$ has a multiplicative inverse $a^{-1} \in R$. Note: multiplication is not required to be commutative.

**(b)** A **zero divisor** in a ring $R$ is a nonzero element $a \in R$ for which there exists a nonzero $b \in R$ with $ab = 0$ (left zero divisor) or $ba = 0$ (right zero divisor).

**(c)** A **prime ideal** of a commutative ring $R$ is an ideal $P \subsetneq R$ with $P \neq R$ such that for all $a, b \in R$, if $ab \in P$ then $a \in P$ or $b \in P$. Equivalently, $R/P$ is an integral domain.$q$
  ),
  (
    'fc5c2b8a-16cc-450f-a24c-c86553483b28',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Fill in the Blanks: Rings and Ideals',
    $q$Fill in the blanks with the word, phrase, number, or symbol that best completes the statement.

**(a)** If $M$ is a maximal ideal of a commutative ring with unity, then $R/M$ is a \_\_\_\_\_\_.
**(b)** The group of units of $\mathbb{Z}_9$ is $U(\mathbb{Z}_9) = $ \_\_\_\_\_\_.
**(c)** An example of an integral domain that is not a field is \_\_\_\_\_\_.
**(d)** If $I$ is a proper ideal of a field $F$, then $F/I$ is isomorphic to \_\_\_\_\_\_.
**(e)** If an ideal $I$ of the ring $\mathbb{Z}[i] = \{a + bi \mid a, b \in \mathbb{Z}\}$ contains the element $i$, then $I =$ \_\_\_\_\_\_.
**(f)** The only possible characteristics of an integral domain are \_\_\_\_\_\_.
**(g)** The prime subfield of a field with $81$ elements is \_\_\_\_\_\_.$q$,
    'medium',
    2023,
    'Third Long Exam',
    2,
    $q$For (a), recall the correspondence theorem. For (b), list the elements coprime to 9. For (f), remember that the characteristic of an integral domain is always prime or zero.$q$,
    $q$**(a)** a field
**(b)** $\{1, 2, 4, 5, 7, 8\}$
**(c)** $\mathbb{Z}$
**(d)** $F$ itself (the zero ring)
**(e)** $\mathbb{Z}[i]$ (the whole ring)
**(f)** $0$ or a prime number
**(g)** $\mathbb{Z}_3$ (the field with 3 elements)$q$,
    $q$**(a)** By the correspondence theorem, if $M$ is maximal in $R$ then $R/M$ is a **field**.

**(b)** $U(\mathbb{Z}_9)$ consists of elements coprime to $9$: $\{1, 2, 4, 5, 7, 8\}$. These form a group under multiplication mod $9$.

**(c)** $\mathbb{Z}$ is an integral domain (no zero divisors) but not a field (only $\pm 1$ are units).

**(d)** Since $F$ is a field, its only proper ideal is $\{0\}$. So $F/I \cong F/\{0\} \cong F$.

**(e)** Since $i \in I$ and $\mathbb{Z}[i]$ is a Euclidean domain, the ideal generated by $i$ is all of $\mathbb{Z}[i]$ because $1 = -i \cdot i \in I$, so $I = \mathbb{Z}[i]$.

**(f)** The characteristic of an integral domain is always **$0$ or a prime number**. (If the characteristic were $n = ab$ with $a, b > 1$, then $1 \cdot 1 = (1 \cdot a)(1 \cdot b) = 0$ would give zero divisors.)

**(g)** Since $|F| = 81 = 3^4$, the characteristic of $F$ is $3$, so the prime subfield is $\mathbb{Z}_3$.$q$
  ),
  (
    '5db13bab-d471-42d5-957f-0ccaf2f618fc',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    '$\mathbb{Z}[\sqrt{2}]$: Subring, Ideal, or Subfield of $\mathbb{R}$?',
    $q$Let $\mathbb{Z}[\sqrt{2}] = \{a + b\sqrt{2} \mid a, b \in \mathbb{Z}\}$.

**(a)** Show that $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$.

**(b)** Is $\mathbb{Z}[\sqrt{2}]$ an ideal of $\mathbb{R}$? Justify your answer.

**(c)** Is $\mathbb{Z}[\sqrt{2}]$ a subfield of $\mathbb{R}$? Justify your answer.$q$,
    'hard',
    2023,
    'Third Long Exam',
    3,
    $q$For (a), verify the subring test: nonempty, closed under subtraction and multiplication. For (b), check whether $\mathbb{R} \cdot \mathbb{Z}[\sqrt{2}] \subseteq \mathbb{Z}[\sqrt{2}]$. For (c), check whether every nonzero element has a multiplicative inverse in $\mathbb{Z}[\sqrt{2}]$.$q$,
    $q$**(a)** $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$. It contains $0$, is closed under subtraction and multiplication.

**(b)** No — $\mathbb{Z}[\sqrt{2}]$ is not an ideal of $\mathbb{R}$.

**(c)** No — $\mathbb{Z}[\sqrt{2}]$ is not a subfield of $\mathbb{R}$.$q$,
    $q$**(a)** To show $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$:

- $0 = 0 + 0\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$, so it is nonempty.
- If $x = a + b\sqrt{2}$ and $y = c + d\sqrt{2}$, then $x - y = (a - c) + (b - d)\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$.
- $xy = (ac + 2bd) + (ad + bc)\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$.

By the subring test, $\mathbb{Z}[\sqrt{2}]$ is a subring of $\mathbb{R}$.

**(b)** No. For $\mathbb{Z}[\sqrt{2}]$ to be an ideal of $\mathbb{R}$, we would need $r \cdot x \in \mathbb{Z}[\sqrt{2}]$ for all $r \in \mathbb{R}$ and $x \in \mathbb{Z}[\sqrt{2}]$. But $\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$ and $\frac{1}{2} \in \mathbb{R}$, yet $\frac{1}{2} \cdot \sqrt{2} = \frac{\sqrt{2}}{2} \notin \mathbb{Z}[\sqrt{2}]$ (since $\frac{1}{2} \notin \mathbb{Z}$). So $\mathbb{Z}[\sqrt{2}]$ fails the absorption property.

**(c)** No. For $\mathbb{Z}[\sqrt{2}]$ to be a subfield, every nonzero element would need a multiplicative inverse in $\mathbb{Z}[\sqrt{2}]$. But $2 = 2 + 0\sqrt{2} \in \mathbb{Z}[\sqrt{2}]$, and its inverse in $\mathbb{R}$ is $\frac{1}{2}$, which is not in $\mathbb{Z}[\sqrt{2}]$. So $\mathbb{Z}[\sqrt{2}]$ is not a subfield.$q$
  ),
  (
    '7b8ad2d0-c40f-4b29-a96a-d194f9953904',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Ring Homomorphism from $\mathbb{Z}_4$ to $\mathbb{Z}_{12}$',
    $q$Determine if the map $\varphi: \mathbb{Z}_4 \to \mathbb{Z}_{12}$ given by $\varphi(x) = 3x \pmod{12}$ is a ring homomorphism.$q$,
    'medium',
    2023,
    'Third Long Exam',
    4,
    $q$Check whether $\varphi$ preserves addition and multiplication, and whether $\varphi(1) = 1$.$q$,
    $q$**No**, $\varphi$ is not a ring homomorphism.$q$,
    $q$For $\varphi$ to be a ring homomorphism, we need $\varphi(1) = 1$. But $\varphi(1) = 3 \pmod{12}$, and $3 \neq 1$ in $\mathbb{Z}_{12}$. So $\varphi$ does not preserve the multiplicative identity.

Alternatively, check multiplication: $\varphi(1 \cdot 1) = 3$ but $\varphi(1) \cdot \varphi(1) = 3 \cdot 3 = 9 \neq 3$ in $\mathbb{Z}_{12}$. So $\varphi$ does not preserve multiplication.$q$
  ),
  (
    'f8d6c809-788f-46b1-bbb2-981db4b62e36',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Quotient Ring $5\mathbb{Z} / 30\mathbb{Z}$',
    $q$Consider the ring $R = 5\mathbb{Z}$ under the usual addition and multiplication. Let $I$ be the ideal $30\mathbb{Z}$.

**(a)** List all six elements of the quotient ring $R/I$.

**(b)** Construct the multiplication table for $R/I$.

**(c)** Does $R/I$ have unity? If yes, identify the unity.

**(d)** Identify all the zero divisors of $R/I$.$q$,
    'medium',
    2023,
    'Third Long Exam',
    5,
    $q$The cosets of $30\mathbb{Z}$ in $5\mathbb{Z}$ are $5k + 30\mathbb{Z}$ for $k = 0, 1, 2, 3, 4, 5$. Think of $R/I \cong \mathbb{Z}_6$ under the natural isomorphism.$q$,
    $q$**(a)** The six elements are $5\mathbb{Z}/30\mathbb{Z}$: $\{0 + 30\mathbb{Z},\; 5 + 30\mathbb{Z},\; 10 + 30\mathbb{Z},\; 15 + 30\mathbb{Z},\; 20 + 30\mathbb{Z},\; 25 + 30\mathbb{Z}\}$.

**(c)** Yes, the unity is $25 + 30\mathbb{Z}$.

**(d)** The zero divisors are $10 + 30\mathbb{Z}$, $15 + 30\mathbb{Z}$, and $20 + 30\mathbb{Z}$.$q$,
    $q$Note: $R/I = 5\mathbb{Z}/30\mathbb{Z}$ is isomorphic to $\mathbb{Z}_6$ as a ring (the correspondence is $\overline{5}\leftrightarrow\bar{5}$, $\overline{10}\leftrightarrow\bar{4}$, $\overline{15}\leftrightarrow\bar{3}$, $\overline{20}\leftrightarrow\bar{2}$, $\overline{25}\leftrightarrow\bar{1}$, $\overline{0}\leftrightarrow\bar{0}$; in particular the unity $\overline{25}$ maps to $\bar{1}$). The table below is computed directly in $R/I$.

**(a)** The six cosets are:
- $\overline{0} = 0 + 30\mathbb{Z}$
- $\overline{5} = 5 + 30\mathbb{Z}$
- $\overline{10} = 10 + 30\mathbb{Z}$
- $\overline{15} = 15 + 30\mathbb{Z}$
- $\overline{20} = 20 + 30\mathbb{Z}$
- $\overline{25} = 25 + 30\mathbb{Z}$

**(b)** Under the isomorphism $R/I \cong \mathbb{Z}_6$ (where $\overline{5k} \leftrightarrow \bar{k}$), the multiplication table mirrors $\mathbb{Z}_6$:

| $\cdot$ | $\overline{0}$ | $\overline{5}$ | $\overline{10}$ | $\overline{15}$ | $\overline{20}$ | $\overline{25}$ |
|---|---|---|---|---|---|---|
| $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ | $\overline{0}$ |
| $\overline{5}$ | $\overline{0}$ | $\overline{25}$ | $\overline{20}$ | $\overline{15}$ | $\overline{10}$ | $\overline{5}$ |
| $\overline{10}$ | $\overline{0}$ | $\overline{20}$ | $\overline{10}$ | $\overline{0}$ | $\overline{20}$ | $\overline{10}$ |
| $\overline{15}$ | $\overline{0}$ | $\overline{15}$ | $\overline{0}$ | $\overline{15}$ | $\overline{0}$ | $\overline{15}$ |
| $\overline{20}$ | $\overline{0}$ | $\overline{10}$ | $\overline{20}$ | $\overline{0}$ | $\overline{10}$ | $\overline{20}$ |
| $\overline{25}$ | $\overline{0}$ | $\overline{5}$ | $\overline{10}$ | $\overline{15}$ | $\overline{20}$ | $\overline{25}$ |

**(c)** The unity is $\overline{25}$ (corresponding to $\bar{1}$ in $\mathbb{Z}_6$, since $25 \equiv 1 \pmod{6}$). The row for $\overline{25}$ reproduces each column, confirming it acts as the identity.

**(d)** The zero divisors are $\overline{10}$, $\overline{15}$, and $\overline{20}$ (corresponding to $\bar{2}$, $\bar{3}$, $\bar{4}$ in $\mathbb{Z}_6$). They multiply to $\overline{0}$ with at least one other nonzero element: $\overline{10} \cdot \overline{15} = \overline{0}$ and $\overline{20} \cdot \overline{15} = \overline{0}$. The elements $\overline{5}$ and $\overline{25}$ are not zero divisors since their rows are permutations of all six cosets.$q$
  ),
  (
    '823c05f6-6e51-4758-ad65-53f1593c4daa',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Proof: Image of an Ideal Under a Ring Homomorphism from $R$ to $R''$',
    $q$Let $\varphi: R \to R'$ be a ring homomorphism. Show that if $I$ is an ideal of $R$, then $\varphi(I)$ is an ideal of $\varphi(R)$.$q$,
    'hard',
    2023,
    'Third Long Exam',
    6,
    $q$To show $\varphi(I)$ is an ideal of $\varphi(R)$: (1) show it is an additive subgroup, (2) show it absorbs multiplication by arbitrary elements of $\varphi(R)$. Use the fact that every element of $\varphi(R)$ is $\varphi(r)$ for some $r \in R$.$q$,
    $q$Proof: We verify the ideal conditions for $\varphi(I)$ in $\varphi(R)$.$q$,
    $q$We verify that $\varphi(I)$ is an ideal of $\varphi(R)$ by checking the two conditions.

**$\varphi(I)$ is an additive subgroup of $\varphi(R)$:**
- $0 = \varphi(0) \in \varphi(I)$ since $0 \in I$.
- If $\varphi(a), \varphi(b) \in \varphi(I)$ with $a, b \in I$, then $\varphi(a) - \varphi(b) = \varphi(a - b) \in \varphi(I)$ since $a - b \in I$ (ideals are additive subgroups).

**Absorption:** Let $\varphi(r) \in \varphi(R)$ (with $r \in R$) and $\varphi(a) \in \varphi(I)$ (with $a \in I$).
- $\varphi(r) \cdot \varphi(a) = \varphi(ra) \in \varphi(I)$ since $ra \in I$ ($I$ is an ideal of $R$).
- $\varphi(a) \cdot \varphi(r) = \varphi(ar) \in \varphi(I)$ since $ar \in I$ ($I$ is an ideal of $R$).

Therefore $\varphi(I)$ is an ideal of $\varphi(R)$. $\blacksquare$$q$
  ),
  (
    'f5346797-b42c-4737-bf62-9f2ac9534593',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Proof: Kernel of Epimorphism onto an Integral Domain from $R$ to $R''$',
    $q$Let $R$ and $R'$ be rings and $\varphi: R \to R'$ a ring epimorphism. Prove that if $R$ is a commutative ring with unity and $R'$ is an integral domain, then $\ker \varphi$ is a prime ideal of $R$.$q$,
    'hard',
    2023,
    'Third Long Exam',
    7,
    $q$Use the first isomorphism theorem: $R/\ker\varphi \cong R'$. Since $R'$ is an integral domain, $R/\ker\varphi$ is an integral domain, which characterizes prime ideals.$q$,
    $q$Proof: By the First Isomorphism Theorem, $R/\ker\varphi \cong R'$. Since $R'$ is an integral domain, $R/\ker\varphi$ is an integral domain. A proper ideal of a commutative ring is prime if and only if the quotient ring is an integral domain. Since $R'$ is an integral domain (hence $R' \neq \{0\}$), $\ker\varphi \neq R$, so $\ker\varphi$ is a proper ideal. Thus $\ker\varphi$ is a prime ideal of $R$. $\blacksquare$$q$,
    $q$By the First Isomorphism Theorem for rings, since $\varphi$ is an epimorphism (surjective):

$$

\begin{equation*}R / \ker \varphi \cong R'.\end{equation*}
$$

Since $R'$ is an integral domain, the quotient $R/\ker\varphi$ is also an integral domain (isomorphic rings share algebraic properties).

We need to verify that $\ker \varphi$ is a **proper** ideal. Since $R'$ is an integral domain, $R' \neq \{0\}$ (integral domains must have $1 \neq 0$). Since $\varphi$ is surjective and $1_{R'} \neq 0_{R'}$, there exists $r \in R$ with $\varphi(r) = 1_{R'} \neq 0$, so $r \notin \ker\varphi$, hence $\ker\varphi \neq R$.

For a commutative ring $R$ with unity, an ideal $P$ is prime if and only if $R/P$ is an integral domain (and $P$ is proper). Since $R/\ker\varphi$ is an integral domain and $\ker\varphi$ is proper, $\ker\varphi$ is a prime ideal of $R$. $\blacksquare$$q$
  ),
  (
    '1d3fa77b-bce2-46af-b765-7136783a686e',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '5ec2fec4-2ebc-45a8-a1bd-90a63b94b0ae',
    'Proof: Prime Element in an Integral Domain $D$',
    $q$Let $D$ be an integral domain and $0 \neq p \in D$. Suppose the principal ideal $\langle p \rangle$ is a prime ideal of $D$. Prove that if $p = ab$, then either $a$ is a unit of $D$ or $b$ is a unit of $D$.$q$,
    'hard',
    2023,
    'Third Long Exam',
    8,
    $q$Since $\langle p \rangle$ is prime, $p \mid ab$ implies $p \mid a$ or $p \mid b$. Consider what $p = ab$ then forces.$q$,
    $q$Proof: Since $p = ab$, we have $ab = p \in \langle p \rangle$. Since $\langle p \rangle$ is a prime ideal, $a \in \langle p \rangle$ or $b \in \langle p \rangle$.

Without loss of generality, suppose $a \in \langle p \rangle$. Then $a = pc$ for some $c \in D$. Substituting, $p = ab = pcb$, so $p(1 - cb) = 0$. Since $D$ is an integral domain and $p \neq 0$, we get $cb = 1$. Thus $b$ is a unit of $D$. $\blacksquare$$q$,
    $q$Since $p = ab$, we have $ab \in \langle p \rangle$. Because $\langle p \rangle$ is a prime ideal, $a \in \langle p \rangle$ or $b \in \langle p \rangle$.

**Case 1:** Suppose $a \in \langle p \rangle$. Then $a = pc$ for some $c \in D$. Substituting into $p = ab$:

$$

\begin{equation*}p = (pc)b = p(cb).\end{equation*}
$$

Since $D$ is an integral domain and $p \neq 0$, we may cancel $p$:

$$

\begin{equation*}1 = cb.\end{equation*}
$$

This shows $b$ is a unit (with $c$ as its inverse).

**Case 2:** Suppose $b \in \langle p \rangle$. Then $b = pd$ for some $d \in D$. Similarly, $p = a(pd) = (ap)d$, and canceling $p$ gives $ad = 1$, so $a$ is a unit.

In either case, $a$ or $b$ is a unit. $\blacksquare$$q$
  )
on conflict (id) do nothing;

-- ---------------------------------------------------------------------------
-- Questions — Math 110.1 Exercise 12 (14)
-- Prime and Maximal Ideals, Fields of Quotients
-- ---------------------------------------------------------------------------
insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    'b93a06e0-5aa0-4462-8393-cc2f95ca2309',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    'Is $\langle 6 \rangle$ a Maximal or Prime Ideal of $\mathbb{Z}_{12}$?',
    $q$Consider the ring $\mathbb{Z}_{12}$ under addition and multiplication modulo $12$. Is $\langle 6 \rangle$ a maximal ideal of $\mathbb{Z}_{12}$? Is it a prime ideal of $\mathbb{Z}_{12}$?$q$,
    'medium',
    2023,
    'Exercise 12',
    1,
    $q$An ideal $P$ is prime iff $R/P$ is an integral domain; it is maximal iff $R/P$ is a field. Compute $\mathbb{Z}_{12}/\langle 6 \rangle$ and look for zero divisors.$q$,
    $q$**Neither.** $\langle 6 \rangle$ is not a prime ideal and not a maximal ideal of $\mathbb{Z}_{12}$.$q$,
    $q$$\langle 6 \rangle = \{0, 6\} \subseteq \mathbb{Z}_{12}$ is the principal ideal generated by $6$. The quotient $\mathbb{Z}_{12}/\langle 6 \rangle$ is a commutative ring with unity $1 + \langle 6 \rangle$.

In $\mathbb{Z}_{12}/\langle 6 \rangle$,

$$

\begin{equation*}(2 + \langle 6 \rangle)(3 + \langle 6 \rangle) = 6 + \langle 6 \rangle = \langle 6 \rangle,\end{equation*}
$$

where $2 + \langle 6 \rangle \neq \langle 6 \rangle$ and $3 + \langle 6 \rangle \neq \langle 6 \rangle$. Hence $2 + \langle 6 \rangle$ is a zero divisor of $\mathbb{Z}_{12}/\langle 6 \rangle$, so $\mathbb{Z}_{12}/\langle 6 \rangle$ is not an integral domain and therefore not a field.

$\therefore$ $\langle 6 \rangle$ is not a prime ideal of $\mathbb{Z}_{12}$.

$\therefore$ $\langle 6 \rangle$ is not a maximal ideal of $\mathbb{Z}_{12}$. $\blacksquare$$q$
  ),
  (
    '7d449fa5-babc-436b-8efd-96a5ea3747c3',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    'Is $\langle 3 \rangle$ a Maximal or Prime Ideal of $\mathbb{Z}_{12}$?',
    $q$Consider the ring $\mathbb{Z}_{12}$. Is $\langle 3 \rangle$ a maximal ideal of $\mathbb{Z}_{12}$? Is it a prime ideal of $\mathbb{Z}_{12}$? $q$,
    'medium',
    2023,
    'Exercise 12',
    2,
    $q$Compute $\mathbb{Z}_{12}/\langle 3 \rangle$. How many elements does it have? Show every nonzero element is a unit.$q$,
    $q$**Both.** $\langle 3 \rangle$ is a maximal ideal and a prime ideal of $\mathbb{Z}_{12}$.$q$,
    $q$$\langle 3 \rangle = \{0, 3, 6, 9\} \subseteq \mathbb{Z}_{12}$ is the principal ideal generated by $3$. The quotient $\mathbb{Z}_{12}/\langle 3 \rangle$ is a commutative ring with unity $1 + \langle 3 \rangle$.

Since every nonzero element has an inverse:

$$

\begin{equation*}(1 + \langle 3 \rangle)^{-1} = 1 + \langle 3 \rangle, \qquad (2 + \langle 3 \rangle)^{-1} = 2 + \langle 3 \rangle,\end{equation*}
$$

because $2 \cdot 2 = 4 \equiv 1 \pmod{3}$. Therefore $\mathbb{Z}_{12}/\langle 3 \rangle$ is a field, and is therefore an integral domain.

$\therefore$ $\langle 3 \rangle$ is a maximal ideal of $\mathbb{Z}_{12}$.

$\therefore$ $\langle 3 \rangle$ is a prime ideal of $\mathbb{Z}_{12}$. $\blacksquare$$q$
  ),
  (
    'fb999b3e-a466-4bc9-bbf0-e986bd44482c',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    'Is $\langle 6 \rangle$ a Maximal or Prime Ideal of $\langle 3 \rangle$?',
    $q$Consider the ring $\mathbb{Z}_{12}$ with $\langle 3 \rangle = \{0, 3, 6, 9\}$. Is $\langle 6 \rangle$ a maximal ideal of the ring $\langle 3 \rangle$? Is it a prime ideal of $\langle 3 \rangle$? $q$,
    'medium',
    2023,
    'Exercise 12',
    3,
    $q$First show $\langle 6 \rangle$ is an ideal of $\langle 3 \rangle$ using the ideal subring test, then compute the quotient and check if it is a field.$q$,
    $q$**Both.** $\langle 6 \rangle$ is a maximal ideal and a prime ideal of $\langle 3 \rangle$.$q$,
    $q$**Ideal subring test.** Clearly $\langle 6 \rangle = \{0, 6\} \neq \{0\}$ and $\langle 6 \rangle \subseteq \{0, 3, 6, 9\} = \langle 3 \rangle$. Since $\langle 6 \rangle$ is an ideal of $\mathbb{Z}_{12} \supseteq \langle 3 \rangle$, it is closed under subtraction and under multiplication by every element of $\mathbb{Z}_{12}$, hence by every element of $\langle 3 \rangle$. So $\langle 6 \rangle$ is an ideal of $\langle 3 \rangle$.

The quotient ring

$$

\begin{equation*}\langle 3 \rangle / \langle 6 \rangle = \{\langle 6 \rangle,\ 3 + \langle 6 \rangle\}\end{equation*}
$$

is a commutative ring with unity $3 + \langle 6 \rangle$ (note $9 + \langle 6 \rangle = 3 + \langle 6 \rangle$ since $9 - 3 = 6 \in \langle 6 \rangle$). Since $\langle 3 \rangle / \langle 6 \rangle$ has exactly two elements, it is isomorphic to $\mathbb{Z}_2$, which is a field.

$\therefore$ $\langle 6 \rangle$ is a maximal ideal of $\langle 3 \rangle$.

$\therefore$ $\langle 6 \rangle$ is a prime ideal of $\langle 3 \rangle$. $\blacksquare$$q$
  ),
  (
    '3d7084c1-6e36-41b6-bed9-4483375d0d81',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    '$S = \{(a, 0) \mid a \in \mathbb{Z}\}$ is an Ideal of $\mathbb{Z} \times \mathbb{Z}$',
    $q$Consider the ring $R = \mathbb{Z} \times \mathbb{Z}$ under coordinate-wise addition and multiplication. Let $S = \{(a, 0) \mid a \in \mathbb{Z}\}$. Show that $S$ is an ideal of $R$.$q$,
    'medium',
    2023,
    'Exercise 12',
    4,
    $q$Use the ideal subring test: (i) closed under subtraction, (ii) absorbs multiplication by all of $R$ from both sides.$q$,
    $q$**$S$ is an ideal of $\mathbb{Z} \times \mathbb{Z}$.** Verified via the ideal test.$q$,
    $q$**Ideal subring test.** Clearly by definition $S \neq \emptyset$ and $S \subseteq R$.

**(i)** Let $(a, 0), (b, 0) \in S$ for some $a, b \in \mathbb{Z}$. Then

$$

\begin{equation*}(a, 0) - (b, 0) = (a - b, 0) \in S,\end{equation*}
$$

since $a - b \in \mathbb{Z}$. So $S$ is an additive subgroup of $R$.

**(ii)** Let $(r, s) \in R$ and $(a, 0) \in S$ for some $a, r, s \in \mathbb{Z}$. Then

$$

\begin{equation*}(r, s)(a, 0) = (ra, 0) \in S, \qquad (a, 0)(r, s) = (ar, 0) \in S,\end{equation*}
$$

since $ra, ar \in \mathbb{Z}$.

$\therefore$ $S$ is an ideal of $R$. $\blacksquare$$q$
  ),
  (
    '2b8982b3-ded8-42e6-b50b-7627e64f2c56',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    '$S = \{(a, 0)\}$ is a Prime Ideal of $\mathbb{Z} \times \mathbb{Z}$',
    $q$Consider $R = \mathbb{Z} \times \mathbb{Z}$ and $S = \{(a, 0) \mid a \in \mathbb{Z}\}$, which is an ideal of $R$. Prove that $S$ is a prime ideal of $R$.$q$,
    'hard',
    2023,
    'Exercise 12',
    5,
    $q$Show $R/S$ is an integral domain. Identify the cosets and show there are no zero divisors in the quotient.$q$,
    $q$**$S$ is a prime ideal of $\mathbb{Z} \times \mathbb{Z}$.**$q$,
    $q$By the previous result, $S$ is a proper ideal of $R$. Consider the factor ring $R/S$, which is commutative with unity $(0,1) + S$:

$$

\begin{equation*}R/S = \{\ldots,\; (0,-2)+S,\; (0,-1)+S,\; S,\; (0,1)+S,\; (0,2)+S,\; \ldots\}.\end{equation*}
$$

Let $(0,a) + S$ be a nonzero element of $R/S$ (so $a \neq 0$). Suppose

$$

\begin{equation*}[(0,a) + S]\,[(0,b) + S] = S\end{equation*}
$$

for some $(0,b) + S \in R/S$. Since

$$

\begin{equation*}[(0,a) + S]\,[(0,b) + S] = (0, ab) + S,\end{equation*}
$$

we get $(0, ab) \in S$, i.e. $ab = 0$. As $\mathbb{Z}$ is an integral domain and $a \neq 0$, it follows that $b = 0$, so $(0,b) + S = S$.

Hence $R/S$ has no zero divisors. Therefore $R/S$ is an integral domain.

$\therefore$ $S$ is a prime ideal of $R$. $\blacksquare$$q$
  ),
  (
    '61e25c38-7d7c-4370-aa70-5cfd097e2469',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    '$S = \{(a, 0)\}$ is NOT a Maximal Ideal of $\mathbb{Z} \times \mathbb{Z}$',
    $q$Consider $R = \mathbb{Z} \times \mathbb{Z}$ and $S = \{(a, 0) \mid a \in \mathbb{Z}\}$. Is $S$ a maximal ideal of $R$? Justify your answer.$q$,
    'medium',
    2023,
    'Exercise 12',
    6,
    $q$An ideal is maximal iff the quotient is a field. Show some nonzero element of $R/S$ has no inverse.$q$,
    $q$**No.** $S$ is not a maximal ideal of $\mathbb{Z} \times \mathbb{Z}$.$q$,
    $q$Consider the factor ring $R/S$. Take $(0,2) + S \in R/S$, which is nonzero. We show it has no multiplicative inverse: there is no $(0,c) + S \in R/S$ with

$$

\begin{equation*}[(0,2) + S]\,[(0,c) + S] = (0, 2c) + S = (0, 1) + S,\end{equation*}
$$

because that would require $2c = 1$ for some integer $c$, which is impossible in $\mathbb{Z}$.

Hence $R/S$ is not a field. Therefore $S$ is not a maximal ideal of $R$. $\blacksquare$$q$
  ),
  (
    '17b9ae9e-445d-4653-83d5-77b8f908924b',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    'Kernel of an Epimorphism is Prime',
    $q$Let $R$ and $R'$ be rings and $\varphi: R \to R'$ a ring epimorphism. Prove that if $R$ is a commutative ring with unity and $R'$ is an integral domain, then $\ker \varphi$ is a prime ideal of $R$.$q$,
    'hard',
    2023,
    'Exercise 12',
    7,
    $q$Apply the First Isomorphism Theorem: $R/\ker\varphi \cong \varphi(R) = R'$. An ideal $P$ is prime iff $R/P$ is an integral domain.$q$,
    $q$**$\ker \varphi$ is a prime ideal of $R$.**$q$,
    $q$Suppose $R$ is a commutative ring with unity and $R'$ is an integral domain.

By a standard theorem, $\ker \varphi$ is an ideal of $R$. Consider the factor ring $R/\ker \varphi$. By the First Isomorphism Theorem for rings,

$$

\begin{equation*}R / \ker \varphi \cong \varphi(R).\end{equation*}
$$

Since $\varphi$ is a ring epimorphism, it is surjective, so $\varphi(R) = R'$. Hence

$$

\begin{equation*}R / \ker \varphi \cong R'.\end{equation*}
$$

Since $R'$ is an integral domain and the property of being an integral domain is preserved under ring isomorphism, $R/\ker \varphi$ is also an integral domain.

A proper ideal $P$ of a commutative ring is prime exactly when $R/P$ is an integral domain. (Since $R'$ is an integral domain, $R' \neq \{0\}$, and surjectivity forces $\ker \varphi \neq R$.)

$\therefore$ $\ker \varphi$ is a prime ideal of $R$. $\blacksquare$$q$
  ),
  (
    '3fd69615-ead3-4f4a-b4c3-57512a7e6b7f',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '656800c1-6424-48fd-b98d-0e1869bc0993',
    'Prime Element in an Integral Domain $D$',
    $q$Let $D$ be an integral domain and $0 \neq p \in D$. Suppose the principal ideal $\langle p \rangle$ is a prime ideal of $D$. Prove that if $p = ab$, then either $a$ is a unit of $D$ or $b$ is a unit of $D$.$q$,
    'hard',
    2023,
    'Exercise 12',
    8,
    $q$From $ab = p \in \langle p \rangle$ and primeness, one factor lies in $\langle p \rangle$; write it as $pk$ and cancel $p$ using the cancellation law (valid in an integral domain).$q$,
    $q$Either $a$ is a unit or $b$ is a unit of $D$.$q$,
    $q$Suppose $p = ab$. Then $0 \neq a, b \in D$.

Since $\langle p \rangle$ is a prime ideal,

$$

\begin{equation*}p = ab \in \langle p \rangle \implies a \in \langle p \rangle \;\text{or}\; b \in \langle p \rangle.\end{equation*}
$$

**Case 1:** $a \in \langle p \rangle$. Then $a = pk$ for some $0 \neq k \in D$, and

$$

\begin{equation*}p = ab \implies p = pkb \implies 1 = kb\end{equation*}
$$

by the cancellation law ($D$ is an integral domain and $p \neq 0$). Hence $b$ is a unit.

**Case 2:** $b \in \langle p \rangle$. Then $b = \ell p$ for some $\ell \in D$, and

$$

\begin{equation*}p = ab \implies p = a\ell p \implies 1 = a\ell\end{equation*}
$$

by the cancellation law. Hence $a$ is a unit.

$\therefore$ Either $a$ is a unit or $b$ is a unit of $D$. $\blacksquare$$q$
  ),
  (
    '8fe2cde7-4dc1-4925-88cd-c77d1d1e34d3',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '7977cbab-91ae-4b90-ac11-632565468414',
    'Equivalence in the Field of Quotients',
    $q$Given an integral domain $D$ and its field of quotients $F = \{[a, b] \mid a, b \in D,\; b \neq 0\}$. Show that if $0 \neq k \in D$ and $[a,b] \in F$, then $[ka, kb] = [a, b]$.$q$,
    'easy',
    2023,
    'Exercise 12',
    9,
    $q$Recall the definition: $[x, y] = [u, v]$ in $F$ iff $xv = yu$. Compute $(ka)b$ and $(kb)a$.$q$,
    $q$**$[ka, kb] = [a, b]$.**$q$,
    $q$Suppose $0 \neq k \in D$ and $[a, b] \in F$, so $a, b \in D$ with $b \neq 0$. Then

$$

\begin{equation*}(ka) b = k a b = (kb) a,\end{equation*}
$$

which is precisely the condition for $[ka, kb] = [a, b]$ in $F$. $\blacksquare$$q$
  ),
  (
    '920336fe-7ab1-48dc-b926-04d1ca128533',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '7977cbab-91ae-4b90-ac11-632565468414',
    'Left Distributivity in $F$',
    $q$Given an integral domain $D$ with field of quotients $F = \{[a, b] \mid a, b \in D,\; b \neq 0\}$, verify that $F$ satisfies the left distributivity law.$q$,
    'medium',
    2023,
    'Exercise 12',
    10,
    $q$Expand both sides using $[c,d]+[e,f] = [cf+de,\ df]$ and $[x,y][u,v] = [xu,yv]$, then multiply numerator and denominator by $b$ to reach a common form.$q$,
    $q$**$[a,b]\big([c,d]+[e,f]\big) = [a,b][c,d] + [a,b][e,f]$.**$q$,
    $q$Let $[a,b], [c,d], [e,f] \in F$ with $b, d, f \neq 0$.

$$

\begin{aligned}
[a,b]\big([c,d]+[e,f]\big) &= [a,b][cf+de,\ df] \\
  &= [a(cf+de),\ bdf] \\
  &= [acf + ade,\ bdf] \\
  &= [b(acf + ade),\ b(bdf)] \\
  &= [acbf + aebd,\ b^2df] \\
  &= [(ac)(bf) + (ab)(de),\ (bd)(bf)] \\
  &= [ac, bd] + [ae, bf] \\
  &= [a,b][c,d] + [a,b][e,f].
\end{aligned}
$$

The step from line 2 to line 3 uses the result $[kx,ky] = [x,y]$ (with $k=b$) to multiply numerator and denominator by $b$. The step from line 5 to line 6 uses the addition rule for a common denominator.

$\therefore$ $F$ satisfies the left distributive law. $\blacksquare$$q$
  ),
  (
    '7a1279c5-9bb3-4005-8b74-b0dd61ec13c7',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '7977cbab-91ae-4b90-ac11-632565468414',
    'Zero Element and Unity in $F$',
    $q$Given an integral domain $D$ with field of quotients $F = \{[a, b] \mid a, b \in D,\; b \neq 0\}$. Identify the zero element (additive identity) and the unity (multiplicative identity) in $F$.$q$,
    'easy',
    2023,
    'Exercise 12',
    11,
    $q$Try $[0,1]$ for the additive identity and $[1,1]$ for the multiplicative identity. Verify each using the definitions of addition and multiplication in $F$.$q$,
    $q$**Zero element: $[0,1]$. Unity: $[1,1]$.**$q$,
    $q$Let $[a, b] \in F$ with $b \neq 0$.

**Zero element:** Consider $[0, 1] \in F$. Then

$$

\begin{equation*}[a, b] + [0, 1] = [a \cdot 1 + 0 \cdot b,\; b \cdot 1] = [a, b].\end{equation*}
$$

$\therefore$ $[0,1]$ is the additive identity.

**Unity:** Consider $[1, 1] \in F$. Then

$$

\begin{equation*}[a, b][1, 1] = [a \cdot 1,\; b \cdot 1] = [a, b].\end{equation*}
$$

$\therefore$ $[1,1]$ is the multiplicative identity. $\blacksquare$$q$
  ),
  (
    '19a9c792-b223-4011-9469-17447752428a',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '7977cbab-91ae-4b90-ac11-632565468414',
    'Additive Inverse in $F$',
    $q$Given an integral domain $D$ with field of quotients $F = \{[a, b] \mid a, b \in D,\; b \neq 0\}$. Give the additive inverse of an element $[a, b] \in F$.$q$,
    'easy',
    2023,
    'Exercise 12',
    12,
    $q$Try $[-a, b]$ and compute $[a,b]+[-a,b]$. Use $[kx,ky] = [x,y]$ to simplify the result.$q$,
    $q$**The additive inverse of $[a,b]$ is $[-a, b]$.**$q$,
    $q$Let $[a, b] \in F$ with $b \neq 0$. Since $D$ is a ring, $-a \in D$, so $[-a, b] \in F$. Then

$$

\begin{equation*}[a, b] + [-a, b] = [a \cdot b + (-a) \cdot b,\; b \cdot b] = [ab - ab,\; b^2] = [0, b^2].\end{equation*}
$$

By the result $[kx, ky] = [x, y]$ with $k = b$, $x = 0$, $y = b$, we get $[0, b^2] = [0, 1]$.

$\therefore$ $[-a, b]$ is the additive inverse of $[a, b]$. $\blacksquare$$q$
  ),
  (
    '690f37c2-f44b-4c0f-a1d2-083ad0f25879',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '7977cbab-91ae-4b90-ac11-632565468414',
    'Multiplicative Inverse in $F$',
    $q$Given an integral domain $D$ with field of quotients $F = \{[a, b] \mid a, b \in D,\; b \neq 0\}$. Identify the multiplicative inverse of a nonzero element $[a, b] \in F$.$q$,
    'easy',
    2023,
    'Exercise 12',
    13,
    $q$Try $[b, a]$ (note: nonzero means $a \neq 0$, so $[b,a] \in F$). Compute $[a,b][b,a]$ and use $[kx,ky] = [x,y]$.$q$,
    $q$**The multiplicative inverse of $[a,b]$ is $[b, a]$.**$q$,
    $q$Let $[a, b] \in F$ be nonzero, so $a, b \in D$ with $a, b \neq 0$. Then $[b, a] \in F$, and

$$

\begin{equation*}[a, b][b, a] = [a \cdot b,\; b \cdot a] = [ab, ab].\end{equation*}
$$

By the result $[kx, ky] = [x, y]$ with $k = ab$, $x = 1$, $y = 1$, we get $[ab, ab] = [1, 1]$, which is the unity of $F$.

$\therefore$ $[b, a]$ is the multiplicative inverse of $[a, b]$. $\blacksquare$$q$
  ),
  (
    '26ef19a5-e9ab-4149-b015-a58b0bc76052',
    'cd574181-02fb-4093-9e23-f268fea6baff',
    '7977cbab-91ae-4b90-ac11-632565468414',
    'Subring of $F$ Isomorphic to $D$',
    $q$Given an integral domain $D$ with field of quotients $F = \{[a, b] \mid a, b \in D,\; b \neq 0\}$. Give explicitly the subring of $F$ which is isomorphic to $D$.$q$,
    'medium',
    2023,
    'Exercise 12',
    14,
    $q$Consider the map $\varphi: D \to F$ given by $\varphi(a) = [a, 1]$. Compute $\ker \varphi$ and apply the First Isomorphism Theorem.$q$,
    $q$**The subring $\{[a, 1] \mid a \in D\}$ is isomorphic to $D$ via $a \mapsto [a, 1]$.**$q$,
    $q$Consider the mapping $\varphi: D \to F$ given by $\varphi(a) = [a, 1]$.

For $a, b \in D$:

$$

\begin{equation*}\varphi(a) + \varphi(b) = [a, 1] + [b, 1] = [a + b, 1] = \varphi(a + b),\end{equation*}
$$

$$

\begin{equation*}\varphi(a)\,\varphi(b) = [a, 1][b, 1] = [ab, 1] = \varphi(ab).\end{equation*}
$$

So $\varphi$ is a ring homomorphism.

**Kernel:**

$$

\begin{equation*}\ker \varphi = \{a \in D \mid \varphi(a) = [0, 1]\} = \{a \in D \mid [a, 1] = [0, 1]\}.\end{equation*}
$$

Now $[a, 1] = [0, 1] \iff a \cdot 1 = 1 \cdot 0 \iff a = 0$, so $\ker \varphi = \{0\}$.

By the First Isomorphism Theorem for rings,

$$

\begin{equation*}\varphi(D) \cong D / \ker \varphi = D / \{0\} \cong D.\end{equation*}
$$

$\therefore$ $D$ is isomorphic to $\varphi(D) = \{[a, 1] \mid a \in D\}$, which is a subring of $F$. $\blacksquare$$q$
  )
on conflict (id) do nothing;


