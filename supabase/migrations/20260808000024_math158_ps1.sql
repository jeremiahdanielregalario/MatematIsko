-- ============================================================================
-- Math 158 Problem Set 1 — combinatorics (A.Y. 2024-2025, 2nd semester)
-- Adds a new "Combinatorics" topic and 7 problems with solutions.
-- Converted from Typst to Markdown + LaTeX. Fixed arithmetic typo (56 -> 1296).
-- ============================================================================

insert into public.courses (id, code, name, description)
values ('b2e10744-de71-405d-a6f9-e7f23a1bcab7', 'MATH 158', 'Introduction to Discrete Mathematics', null)
on conflict (id) do nothing;

insert into public.topics (id, course_id, name, description)
values
  (
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    'Combinatorics',
    'Multiplication and addition principles, permutations, combinations, and circular arrangements.'
  )
on conflict (id) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    '6ef07c3f-fd37-4f2d-aef0-fe30354f423e',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Picking Two Cards From a Deck',
    $BODY$Find the number of ways to pick two different cards from a standard 52-card deck such that

**(a)** the first card is a jack and the second card is not a king.

**(b)** the first card is a spade and the second card is not a queen.$BODY$,
    'easy',
    2024,
    'Problem Set 1',
    1,
    $BODY$Use the multiplication principle. For (b), split into two cases: the first card is the queen of spades, or it is a spade that is not the queen of spades.$BODY$,
    $BODY$**(a)** $4 \cdot 47 = 188$ ways. **(b)** $1 \cdot 48 + 12 \cdot 47 = 612$ ways.$BODY$,
    $BODY$**(a)** Note that there are $4$ jacks and $4$ kings in a standard 52-card deck.

- Choose a jack from the cards: $4$ ways (a jack card is not a king card).
- Choose a card that is not a king from the remaining cards: $(52 - 1) - 4 = 47$ ways.

Hence, by the Multiplication Principle, $4 \cdot 47 = \boxed{188}$ ways.

---

**(b)** Note that there are $13$ spade cards. We consider two cases:

- **Case 1:** The first card is the queen of spades: $1$ way. Then choose any card that is not a queen: $51 - 3 = 48$ ways. By MP, $1 \cdot 48 = 48$ ways.

- **Case 2:** The first card is a spade but is not the queen of spades: $12$ ways. Then choose a non-queen card from the remaining cards: $51 - 4 = 47$ ways. By MP, $12 \cdot 47 = 564$ ways.

Hence, by the Addition Principle, $1 \cdot 48 + 12 \cdot 47 = \boxed{612}$ ways. $\blacksquare$$BODY$
  ),
  (
    '3cb5fa23-2370-4ef1-9f54-865d23df71a0',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Four-Digit Integers Containing 7 and Divisible by 5',
    $BODY$How many four-digit positive integers are there that contain the digit $7$ and are divisible by $5$?$BODY$,
    'medium',
    2024,
    'Problem Set 1',
    2,
    $BODY$Count all four-digit multiples of $5$ ($9 \cdot 10 \cdot 10 \cdot 2 = 1800$), subtract those that do not contain the digit $7$ ($8 \cdot 9 \cdot 9 \cdot 2 = 1296$).$BODY$,
    $BODY$Total multiples of $5$ minus those without a $7$: $1800 - 1296 = 504$.$BODY$,
    $BODY$Let $S = \{0, 1, 2, \dots, 9\}$. The desired integer is of the form $\overline{ABCD}$, where

- $A \in S \setminus \{0\}$ (four-digit), so $|S \setminus \{0\}| = 9$;
- $B, C \in S$, so $|S| = 10$;
- $D \in \{0, 5\}$ (divisible by $5$), so $|\{0, 5\}| = 2$.

By the Multiplication Principle, there are $9 \cdot 10 \cdot 10 \cdot 2 = 1800$ four-digit positive integers divisible by $5$.

Now count the four-digit multiples of $5$ that do **not** contain the digit $7$:

- $A \in S \setminus \{7\}$, so $9 - 1 = 8$ choices;
- $B, C \in S \setminus \{7\}$, so $10 - 1 = 9$ choices each;
- $D \in \{0, 5\}$, so $2$ choices.

Hence, there are $8 \cdot 9 \cdot 9 \cdot 2 = 1296$ such integers. By the Principle of Complementation,

$$
\begin{equation*}1800 - 1296 = \boxed{504}\end{equation*}
$$

four-digit positive integers that contain the digit $7$ and are divisible by $5$. $\blacksquare$$BODY$
  ),
  (
    'a8198cb3-cca1-4661-bdbf-e0d7aa4eacc0',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Seven-Letter Codes With $a$ and $b$ Not Adjacent',
    $BODY$Find the number of seven-letter codes such that no letters (from the English alphabet) are repeated in the code, and letters $a$ and $b$ are not next to each other.$BODY$,
    'medium',
    2024,
    'Problem Set 1',
    3,
    $BODY$Start from all codes with no repeated letters, $P(26, 7)$, and subtract those where $a$ and $b$ are adjacent (treat $ab$/$ba$ as one block).$BODY$,
    $BODY$$P(26,7) - \binom{24}{5} \cdot 2! \cdot 6! = 3,254,106,240$ codes.$BODY$,
    $BODY$First, we count the number of seven-letter codes where no letters are repeated in the code, which is

$$
\begin{equation*}P(26, 7) = 3,315,312,000.\end{equation*}
$$

Now count the seven-letter codes with no repeated letters where $a$ and $b$ are next to each other.

- Choose $a$ and $b$: $1$ way.
- Choose $5$ other letters from the remaining $24$: $\binom{24}{5}$ ways.
- Treat $a$ and $b$ as one entity, with $2!$ internal arrangements.
- Arrange the $6$ objects in a row: $6!$ ways.

Hence, by the Multiplication Principle, there are $1 \cdot \binom{24}{5} \cdot 2! \cdot 6! = 61,205,760$ codes with $a, b$ adjacent.

By the Principle of Complementation,

$$
\begin{equation*}P(26, 7) - \binom{24}{5} \cdot 2! \cdot 6! = \boxed{3,254,106,240 \text{ codes}}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '5ff1dddc-552e-4dfc-b380-8a14c60f84b2',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Seating Around a Circular Table',
    $BODY$Six boys and five girls are to be seated around a circular table. Find the number of ways that this can be done in each of the following cases.

**(a)** There are no restrictions.

**(b)** All girls form a single block.

**(c)** A particular girl $G$ is adjacent to two particular boys $B_1$ and $B_2$.$BODY$,
    'medium',
    2024,
    'Problem Set 1',
    4,
    $BODY$For circular arrangements of $n$ people use $(n-1)!$. For (b), treat the five girls as one block. For (c), treat $B_1 G B_2$ as one block, with $2!$ arrangements of the boys.$BODY$,
    $BODY$**(a)** $10! = 3,628,800$. **(b)** $5! \cdot 6! = 86,400$. **(c)** $2! \cdot 8! = 80,640$.$BODY$,
    $BODY$**(a)** There are $6 + 5 = 11$ people to place around the circular table, so the number of arrangements is

$$
\begin{equation*}(11 - 1)! = 10! = \boxed{3,628,800 \text{ ways}}.\end{equation*}
$$

---

**(b)** Treat the five girls as a single block: $5! = 120$ ways. Then place the six boys and the block of girls around the table: $(6 + 1 - 1)! = 6! = 720$ ways. Hence, by the Multiplication Principle,

$$
\begin{equation*}5! \cdot 6! = \boxed{86,400 \text{ ways}}.\end{equation*}
$$

---

**(c)** Treat $B_1, G, B_2$ as a single block, where only $B_1$ and $B_2$ can interchange (since $G$ must be adjacent to both): $2! = 2$ ways.

Arrange the remaining $6 - 2 = 4$ boys, $5 - 1 = 4$ girls, and the block around the table:

$$
\begin{equation*}(4 + 4 + 1 - 1)! = 8! = 40,320 \text{ ways}.\end{equation*}
$$

Hence, by the Multiplication Principle,

$$
\begin{equation*}2! \cdot 8! = 2 \cdot 40,320 = \boxed{80,640 \text{ ways}}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '0df15003-3c52-492d-b766-40387286390d',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Bridge Hands With Exactly Two Suits',
    $BODY$How many (13-card) bridge hands contain exactly two suits?$BODY$,
    'hard',
    2024,
    'Problem Set 1',
    5,
    $BODY$Choose the two suits ($\binom{4}{2}$), then take $13$ cards from the $26$ cards of those suits, excluding the two hands that use only one suit. Verify with $\binom{4}{2}\sum_{n=1}^{12}\binom{13}{n}^2$.$BODY$,
    $BODY$$\binom{4}{2}\left[\binom{26}{13} - 2\right] = 62,403,588$ hands.$BODY$,
    $BODY$First, choose $2$ out of $4$ possible suits: $\binom{4}{2}$ ways. Then collect all $26$ cards from the chosen two suits and take $13$ cards from here: $\binom{26}{13}$ ways. Subtract the $2$ cases where all the cards are from the same suit.

Therefore,

$$
\begin{equation*}\binom{4}{2}\left[ \binom{26}{13} - 2 \right] = 6 \cdot (10,400,600 - 2) = \boxed{62,403,588 \text{ hands}}.\end{equation*}
$$

**Alternative:** For the chosen two suits, sum over the split sizes, ensuring both suits appear:

$$
\begin{equation*}\binom{4}{2} \sum_{n=1}^{12} \binom{13}{n}\binom{13}{13-n} = \binom{4}{2} \sum_{n=1}^{12} \binom{13}{n}^2 = \binom{4}{2} \left( \binom{26}{13} - 2 \right) = \boxed{62,403,588 \text{ hands}}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    '4a5f185a-f93c-455a-944b-98528a218b6e',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Two Rows With Particular Students in Front and Back',
    $BODY$A group of 20 students, including 3 particular girls and 4 particular boys, are to be lined up in two rows with 10 students each. In how many ways can this be done if the 3 particular girls must be in the front row while the 4 particular boys must be in the back?$BODY$,
    'hard',
    2024,
    'Problem Set 1',
    6,
    $BODY$Front row: $3$ girls + $7$ of the remaining $13$ students, arranged in $10!$ ways. The remaining $10$ students (including the $4$ boys) fill the back row in $10!$ ways.$BODY$,
    $BODY$\binom{3}{3}\binom{13}{7} \cdot 10! \cdot 10! = 22,596,613,079,040,000$ ways.$BODY$,
    $BODY$Choose the $3$ particular girls for the front row: $1$ way. Choose $7$ students other than the $4$ particular boys for the front row:

$$
\begin{equation*}\binom{20 - 3 - 4}{7} = \binom{13}{7} = 1716 \text{ ways}.\end{equation*}
$$

Arrange the $10$ front-row students in a row: $10!$ ways. The remaining $10$ students (which include the $4$ particular boys) go to the back row, arranged in $10!$ ways.

Alternatively, choose the $4$ particular boys for the back row first, then $6$ of the remaining students. By the Multiplication Principle,

$$
\begin{equation*}\binom{3}{3}\binom{13}{7} \cdot 10! \cdot 10! = \binom{4}{4}\binom{13}{6} \cdot 10! \cdot 10! = \boxed{22,596,613,079,040,000 \text{ ways}}.\end{equation*}
$$

$\blacksquare$$BODY$
  ),
  (
    'ebbba8dd-16d9-4bda-a400-f41b38ed9b35',
    'b2e10744-de71-405d-a6f9-e7f23a1bcab7',
    '5d895c91-2b19-42a8-a1b8-d07be0adf5e5',
    'Ordered Pairs With Given LCM',
    $BODY$Determine the number of ordered pairs of positive integers $(a, b)$ such that the least common multiple of $a$ and $b$ is $2^3 5^7 11^{13}$.$BODY$,
    'hard',
    2024,
    'Problem Set 1',
    7,
    $BODY$For each prime $p^e$, the two exponents must satisfy $\max\{\alpha_1, \alpha_2\} = e$, which gives $(e+1)^2 - e^2 = 2e + 1$ ordered pairs. Multiply over $e = 3, 7, 13$.$BODY$,
    $BODY$$(2 \cdot 3 + 1)(2 \cdot 7 + 1)(2 \cdot 13 + 1) = 7 \cdot 15 \cdot 27 = 2835$ ordered pairs.$BODY$,
    $BODY$Write

$$
\begin{equation*}a = 2^{\alpha_1} 5^{\beta_1} 11^{\gamma_1}, \qquad b = 2^{\alpha_2} 5^{\beta_2} 11^{\gamma_2},\end{equation*}
$$

with $\alpha_i \in \{0, 1, 2, 3\}$, $\beta_i \in \{0, 1, \dots, 7\}$, and $\gamma_i \in \{0, 1, \dots, 13\}$. For $\mathrm{lcm}(a, b) = 2^3 5^7 11^{13}$, we need

$$
\begin{equation*}\max\{\alpha_1, \alpha_2\} = 3, \qquad \max\{\beta_1, \beta_2\} = 7, \qquad \max\{\gamma_1, \gamma_2\} = 13.\end{equation*}
$$

- To achieve $\max\{\alpha_1, \alpha_2\} = 3$: either $\alpha_1 = 3$ (then $\alpha_2 \in \{0,1,2,3\}$: $4$ pairs) or $\alpha_2 = 3$ with $\alpha_1 \in \{0,1,2\}$ ($3$ pairs). Total $4 + 3 = 7$ pairs.
- For $\max\{\beta_1, \beta_2\} = 7$: $8 + 7 = 15$ pairs.
- For $\max\{\gamma_1, \gamma_2\} = 13$: $14 + 13 = 27$ pairs.

By the Multiplication Principle,

$$
\begin{equation*}7 \cdot 15 \cdot 27 = \boxed{2835}\end{equation*}
$$

ordered pairs. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
