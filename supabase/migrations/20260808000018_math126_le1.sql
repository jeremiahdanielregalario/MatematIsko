-- ============================================================================
-- Math 126 Long Exam 1 — Lebesgue measure and measurable functions
-- Adds a new "Lebesgue Measure" topic and 4 questions with solutions.
-- Converted from Typst to Markdown + LaTeX.
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'c0000000-0000-4000-8000-000000000004',
    'Lebesgue Measure',
    'Outer measure, measurable sets, measurable functions, and characteristic functions.'
  )
on conflict (id) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '96da6fb8-494f-4e10-aa1e-5eb7bc7e1dcb',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'State the Definitions',
    $BODY$State the following definitions: _(1 point each)_

**(a)** the (Lebesgue) outer measure $m^*$ of a set $E$.

**(b)** a (Lebesgue) measurable set $E$.

**(c)** the countable additivity of the (Lebesgue) measure $m$.

**(d)** a measurable function $f$ defined on a measurable set $E$.$BODY$,
    'easy',
    2024,
    'Long Exam 1',
    1,
    $BODY$For (a), recall the infimum over all countable coverings of $E$ by open bounded intervals. For (b), use the Carathéodory condition $m^*(A) = m^*(A \cap E) + m^*(A \cap E^c)$. For (c), state the additivity of $m$ over pairwise disjoint measurable sets. For (d), the preimages $\{x \in E : f(x) < c\}$ must be measurable for every $c \in \mathbb{R}$.$BODY$,
    $BODY$Definitions for outer measure, measurable set, countable additivity, and measurable function (see solution).$BODY$,
    $BODY$**(a)** The outer measure of $E$ is

$$
\begin{equation*}m^*(E) = \inf\left\{ \sum_{k=1}^{\infty} \ell(I_k) \;\middle|\; E \subseteq \bigcup_{k=1}^{\infty} I_k,\ I_k \text{ open and bounded intervals} \right\}.\end{equation*}
$$

---

**(b)** A set $E$ is said to be (Lebesgue) measurable if for any $A \subseteq \mathbb{R}$,

$$
\begin{equation*}m^*(A) = m^*(A \cap E) + m^*(A \cap E^c).\end{equation*}
$$

---

**(c)** The union of a countable collection of pairwise disjoint measurable sets $\{E_k\}_{k=1}^{\infty}$ is measurable and

$$
\begin{equation*}m\left( \bigcup_{k=1}^{\infty} E_k \right) = \sum_{k=1}^{\infty} m(E_k).\end{equation*}
$$

---

**(d)** A function $f$ defined on $E$ is said to be measurable if

- $\operatorname{dom} f = E$ is measurable, and
- for any $c \in \mathbb{R}$, the set $\{x \in E : f(x) < c\}$ is measurable.

$\blacksquare$$BODY$
  ),
  (
    '2906c044-c499-4d07-b607-db5bb2be15cc',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'True or False: Measurability Statements',
    $BODY$Determine whether the statement is true or false. Justify your answer. All sets below are subsets of the set of real numbers $\mathbb{R}$. _(2 points each)_

**(a)** If $E$ is a measurable set such that $\mathbb{Q} \subseteq E$, then $m(E) > 0$.

**(b)** All bounded sets have finite measure.

**(c)** The set of irrational numbers $\mathbb{Q}'$ has infinite measure.

**(d)** Every function defined on a set of measure zero is measurable.$BODY$,
    'medium',
    2024,
    'Long Exam 1',
    2,
    $BODY$For (a), take a countable set containing $\mathbb{Q}$. For (b), use $A \subseteq [-M, M]$. For (c), use measurability of $\mathbb{Q}$ and $m^*(\mathbb{R}) = \infty$. For (d), any subset of a null set has measure zero.$BODY$,
    $BODY$**(a)** FALSE — $E = \mathbb{Q} \cup \{\pi\}$ is countable with $m(E) = 0$. **(b)** TRUE. **(c)** TRUE. **(d)** TRUE.$BODY$,
    $BODY$**(a)** **FALSE.** Take $E = \mathbb{Q} \cup \{\pi\}$, which is measurable and $\mathbb{Q} \subseteq E$. However, $m(E) = 0$ since $E$ is countable. $\blacksquare$

---

**(b)** **TRUE.** Note that $A$ is bounded $\iff$ there exists $M > 0$ such that $|x| \le M$ for all $x \in A$. It follows that

$$
\begin{equation*}A \subseteq [-M, M] \quad \implies \quad m^*(A) \le 2M < \infty.\end{equation*}
$$

$\blacksquare$

---

**(c)** **TRUE.** By the measurability of $\mathbb{Q}$,

$$
\begin{equation*}m^*(\mathbb{R}) = m^*(\mathbb{Q}) + m^*(\mathbb{Q}') \implies \infty = 0 + m^*(\mathbb{Q}') \implies m^*(\mathbb{Q}') = \infty.\end{equation*}
$$

$\blacksquare$

---

**(d)** **TRUE.** Let $f$ be defined on a measurable set $E$ with $m(E) = 0$. For any $c \in \mathbb{R}$, the set $\{x \in E : f(x) > c\} \subseteq E$, so by monotonicity of $m^*$,

$$
\begin{equation*}0 \le m^*(\{x \in E : f(x) > c\}) \le m^*(E) = 0 \implies m^*(\{x \in E : f(x) > c\}) = 0.\end{equation*}
$$

So $\{x \in E : f(x) > c\}$ is measurable for any $c \in \mathbb{R}$. Hence, $f$ is measurable. $\blacksquare$$BODY$
  ),
  (
    '46ef7654-3659-4be7-9cbf-9988c3e21544',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Using Outer Measure to Show $[0,1]$ is Uncountable',
    $BODY$Using the properties of outer measure, show that the interval $[0, 1]$ is uncountable. _(2 points)_$BODY$,
    'easy',
    2024,
    'Long Exam 1',
    3,
    $BODY$Recall that countable sets have outer measure zero. Show $m^*([0, 1]) = \ell([0, 1]) = 1 > 0$ and conclude by the contrapositive.$BODY$,
    $BODY$Since $m^*([0,1]) = 1 > 0$, the interval $[0,1]$ cannot be countable and is therefore uncountable.$BODY$,
    $BODY$Recall that if a set is countable, then its outer measure is zero. Hence, by the contrapositive, a positive outer measure implies the set is uncountable. Now,

$$
\begin{equation*}m^*([0, 1]) = \ell([0, 1]) = 1 > 0.\end{equation*}
$$

It follows that $[0, 1]$ must be uncountable. $\blacksquare$$BODY$
  ),
  (
    '9ec57045-4cef-481d-965a-b885b2303f70',
    'c0000000-0000-4000-8000-000000000004',
    '22b18b44-b14a-4480-8614-c090fefcc296',
    'Measurability of $A$ and its Characteristic Function',
    $BODY$For any subset $A$ of $\mathbb{R}$, define the function $\chi_A : \mathbb{R} \to \mathbb{R}$ by

$$\chi_A(x) = \begin{cases} 1, & \text{if } x \in A, \\ 0, & \text{if } x \notin A. \end{cases}$$

**(a)** Show that $A$ is measurable if and only if $\chi_A$ is a measurable function. _(4 points)_

**(b)** Use this result to give an example of a nonmeasurable function. _(2 points)_$BODY$,
    'hard',
    2024,
    'Long Exam 1',
    4,
    $BODY$For $(\Rightarrow)$, consider the cases $c < 0$, $0 \le c < 1$, and $c \ge 1$ for the set $\{x : \chi_A(x) \le c\}$. For $(\Leftarrow)$, observe $\{x : \chi_A(x) \ge 1\} = A$. For (b), use a nonmeasurable set — the Vitali choice set — with its characteristic function.$BODY$,
    $BODY$**(a)** $A$ measurable $\iff \chi_A$ measurable. **(b)** $\chi_{C_E}$ is nonmeasurable where $C_E$ is a (nonmeasurable) choice set in $\mathbb{R}$.$BODY$,
    $BODY$**(a)** $(\Rightarrow)$ Suppose $A$ is measurable. Note that $\operatorname{dom}(\chi_A) = \mathbb{R} = (-\infty, \infty)$ is measurable. Let $c \in \mathbb{R}$.

- If $c < 0$, then $\{x \in \mathbb{R} : \chi_A(x) \le c\} = \varnothing$, which is measurable.
- If $0 \le c < 1$, then $\{x \in \mathbb{R} : \chi_A(x) \le c\} = A^c$, which is measurable.
- If $c \ge 1$, then $\{x \in \mathbb{R} : \chi_A(x) \le c\} = \mathbb{R}$, which is measurable.

Hence, for any $c \in \mathbb{R}$, the set $\{x \in \mathbb{R} : \chi_A(x) < c\}$ is measurable. So $\chi_A$ is measurable.

$(\Leftarrow)$ Suppose $\chi_A$ is measurable. Then, for any $c \in \mathbb{R}$, the set $\{x \in \mathbb{R} : \chi_A(x) \ge c\}$ is measurable. Therefore, the set

$$
\begin{equation*}\{x \in \mathbb{R} : \chi_A(x) \ge 1\} = A\end{equation*}
$$

is measurable. $\blacksquare$

---

**(b)** Since $A$ measurable $\iff \chi_A$ is a measurable function, then

$$
\begin{equation*}A \text{ nonmeasurable } \iff \chi_A \text{ is a nonmeasurable function}.\end{equation*}
$$

So we take the choice set $C_E$ on $E = \mathbb{R}$, which is nonmeasurable (a Vitali-type set). It follows that $\chi_{C_E}$ is a nonmeasurable function. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
