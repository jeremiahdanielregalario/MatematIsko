-- ============================================================================
-- Math 20 Precalculus — Fourth Long Examination, 1st Sem A.Y. 2024-2025
-- 8 problems (split into individual questions where possible).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced:
--   • Inverse Trigonometric Functions
--   • Applications of Trigonometry
--   • Trigonometric Equations
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Inverse Trigonometric Functions',
    'Inverse trigonometric functions and equations involving them.'
  ),
  (
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Applications of Trigonometry',
    'Right triangles, the sine law, and the cosine law.'
  ),
  (
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Trigonometric Equations',
    'Solving equations involving trigonometric functions.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — sin^-1(sin 5π/4)
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d01',
    'Exact Value of $\sin^{-1}\left(\sin\frac{5\pi}{4}\right)$',
    $BODY$Compute the exact value of the expression.
$$\sin^{-1}\left(\sin\frac{5\pi}{4}\right)$$$BODY$,
    'medium',
    2024,
    'Fourth Long Examination',
    1,
    $BODY$First $\sin\frac{5\pi}{4} = -\frac{\sqrt{2}}{2}$; then $\sin^{-1}\left(-\frac{\sqrt{2}}{2}\right)$ is the principal angle in $\left[-\frac{\pi}{2}, \frac{\pi}{2}\right]$ with that sine.$BODY$,
    $BODY$-\frac{\pi}{4}$BODY$,
    $BODY$Compute the inner value:
$$\sin\frac{5\pi}{4} = \sin 225^{\circ} = -\frac{\sqrt{2}}{2}.$$
The principal value of $\sin^{-1}$ lies in $\left[-\frac{\pi}{2}, \frac{\pi}{2}\right]$. The unique angle in that interval with sine $-\frac{\sqrt{2}}{2}$ is $-\frac{\pi}{4}$. Hence
$$\sin^{-1}\left(\sin\frac{5\pi}{4}\right) = -\frac{\pi}{4}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — cos^2(sin^-1(1/√7))
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d01',
    'Exact Value of $\cos^2\left(\sin^{-1}\frac{1}{\sqrt{7}}\right)$',
    $BODY$Compute the exact value of the expression.
$$\cos^2\left(\sin^{-1}\frac{1}{\sqrt{7}}\right)$$$BODY$,
    'medium',
    2024,
    'Fourth Long Examination',
    2,
    $BODY$Let $\theta = \sin^{-1}\frac{1}{\sqrt{7}}$; then $\sin\theta = \frac{1}{\sqrt{7}}$ and use $\cos^2\theta = 1 - \sin^2\theta$.$BODY$,
    $BODY$\frac{6}{7}$BODY$,
    $BODY$Let $\theta = \sin^{-1}\frac{1}{\sqrt{7}}$, so $\sin\theta = \frac{1}{\sqrt{7}}$. Then
$$\cos^2\left(\sin^{-1}\frac{1}{\sqrt{7}}\right) = \cos^2\theta = 1 - \sin^2\theta = 1 - \frac{1}{7} = \frac{6}{7}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Right triangle, find a
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    'Finding Side $a$ in a Right Triangle With $b = 4$ and $\alpha = 30^{\circ}$',
    $BODY$Given: right triangle with interior angles $\alpha$, $\beta$, and $\gamma$, and sides $a$, $b$, and $c$ as shown (right angle at $\gamma$, side $a$ opposite $\alpha$). If $b = 4$, $\alpha = 30^{\circ}$, and $\gamma = 90^{\circ}$, find the length of side $a$.$BODY$,
    'easy',
    2024,
    'Fourth Long Examination',
    3,
    $BODY$In the right triangle, $\tan\alpha = \frac{\text{opposite}}{\text{adjacent}} = \frac{a}{b}$.$BODY$,
    $BODY$a = \frac{4\sqrt{3}}{3}$BODY$,
    $BODY$In the right triangle, side $a$ is opposite angle $\alpha$ and side $b$ is adjacent to $\alpha$, so
$$\tan\alpha = \frac{a}{b} \implies a = b\tan\alpha = 4\tan 30^{\circ} = 4 \cdot \frac{1}{\sqrt{3}} = \frac{4\sqrt{3}}{3}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Law of cosines, find b
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    'Finding Side $b$ by the Cosine Law ($a = 4$, $c = 6$, $\beta = 120^{\circ}$)',
    $BODY$Given: triangle with interior angles $\alpha$, $\beta$, and $\gamma$, and sides $a$, $b$, and $c$. If $a = 4$, $c = 6$, and $\beta = 120^{\circ}$, find the length of side $b$.$BODY$,
    'medium',
    2024,
    'Fourth Long Examination',
    4,
    $BODY$Use the cosine law: $b^2 = a^2 + c^2 - 2ac\cos\beta$ (side $b$ is opposite angle $\beta$).$BODY$,
    $BODY$b = 2\sqrt{19}$BODY$,
    $BODY$By the cosine law, with $b$ opposite $\beta$:
$$b^2 = a^2 + c^2 - 2ac\cos\beta = 4^2 + 6^2 - 2(4)(6)\cos 120^{\circ}.$$
Since $\cos 120^{\circ} = -\frac{1}{2}$,
$$b^2 = 16 + 36 - 48\left(-\frac{1}{2}\right) = 52 + 24 = 76.$$
Therefore $b = \sqrt{76} = 2\sqrt{19}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q5 — (sin3x)(tanx) + tanx = 0
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d03',
    'Solution Set of $(\sin 3x)(\tan x) + \tan x = 0$ on $[0, 2\pi)$',
    $BODY$Find the solution set of the equation, where $x \in [0, 2\pi)$.
$$(\sin 3x)(\tan x) + \tan x = 0.$$$BODY$,
    'hard',
    2024,
    'Fourth Long Examination',
    5,
    $BODY$Factor $\tan x(\sin 3x + 1) = 0$, solve $\tan x = 0$ and $\sin 3x = -1$, then exclude values where $\tan x$ is undefined.$BODY$,
    $BODY$\left\{0, \pi, \frac{7\pi}{6}, \frac{11\pi}{6}\right\}$BODY$,
    $BODY$Factor the equation:
$$\tan x(\sin 3x + 1) = 0.$$

**Case 1: $\tan x = 0$.** Then $x = 0$ or $x = \pi$ in $[0, 2\pi)$.

**Case 2: $\sin 3x = -1$.** Then $3x = \frac{3\pi}{2} + 2\pi k$, so
$$x = \frac{\pi}{2} + \frac{2\pi}{3}k.$$
For $x \in [0, 2\pi)$: $k = 0$ gives $\frac{\pi}{2}$, $k = 1$ gives $\frac{7\pi}{6}$, $k = 2$ gives $\frac{11\pi}{6}$. However, $\tan x$ is undefined at $x = \frac{\pi}{2}$, so $x = \frac{\pi}{2}$ must be excluded.

Therefore the solution set is
$$\left\{0, \pi, \frac{7\pi}{6}, \frac{11\pi}{6}\right\}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — cot^-1(-1) - sec^-1(9x) = -π/2
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d01',
    'Solving $\cot^{-1}(-1) - \sec^{-1}(9x) = -\frac{\pi}{2}$',
    $BODY$Find the solution set of the equation.
$$\cot^{-1}(-1) - \sec^{-1}(9x) = -\frac{\pi}{2}.$$$BODY$,
    'hard',
    2024,
    'Fourth Long Examination',
    6,
    $BODY$Use $\cot^{-1}(-1) = \frac{3\pi}{4}$, solve for $\sec^{-1}(9x) = \frac{5\pi}{4}$, and take secant: $9x = \sec\frac{5\pi}{4}$.$BODY$,
    $BODY$\left\{-\frac{\sqrt{2}}{9}\right\}$BODY$,
    $BODY$The principal value $\cot^{-1}(-1) = \frac{3\pi}{4}$ (cotangent is $-1$ in QII). Substituting:
$$\frac{3\pi}{4} - \sec^{-1}(9x) = -\frac{\pi}{2} \implies \sec^{-1}(9x) = \frac{3\pi}{4} + \frac{\pi}{2} = \frac{5\pi}{4}.$$
Taking the secant of both sides (using the branch of $\sec^{-1}$ whose values include $\frac{5\pi}{4}$):
$$9x = \sec\frac{5\pi}{4} = \frac{1}{\cos(5\pi/4)} = \frac{1}{-\sqrt{2}/2} = -\sqrt{2}.$$
Hence
$$x = -\frac{\sqrt{2}}{9},$$
which satisfies $|9x| = \sqrt{2} \ge 1$ as required. The solution set is $\left\{-\frac{\sqrt{2}}{9}\right\}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q7 — Which figure
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e07',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    'Which Figure Best Illustrates the Eagle Problem?',
    $BODY$Bob spotted an eagle $18\sqrt{3}$ meters away at an angle of elevation of $30^{\circ}$. At the same time, Carl also spotted the same eagle $18$ meters away. Assume Bob and Carl have the same height, are both standing on flat ground, and are $x$ meters apart.

Which of the following figures best illustrates the situation described above? Write either *Figure 1* or *Figure 2* only.

- **Figure 1:** Bob and Carl stand on the ground (the segment between them is $x$), the eagle sits above the point on the ground between them, with the $30^{\circ}$ angle at Bob and the distances $18\sqrt{3}$ (Bob to eagle) and $18$ (Carl to eagle) as the two slant sides of a triangle.
- **Figure 2:** Bob and Carl stand on the ground, and the eagle is directly above a marked point on the ground, with a dashed vertical segment from the eagle to the ground and the $30^{\circ}$ angle drawn near the top of that vertical segment.$BODY$,
    'medium',
    2024,
    'Fourth Long Examination',
    7,
    $BODY$The angle of elevation is measured at Bob, between the ground and the line of sight to the eagle, and both given distances are the observers' line-of-sight distances to the eagle.$BODY$,
    $BODY$Figure 1.$BODY$,
    $BODY$In the described situation, Bob's angle of elevation of $30^{\circ}$ is the angle at Bob between the ground (the segment to Carl) and the line of sight to the eagle, and the distances $18\sqrt{3}$ and $18$ are the line-of-sight distances from Bob and Carl to the eagle. This is exactly the triangle in **Figure 1**, where the $30^{\circ}$ angle sits at Bob's position on the ground and the two slant sides are the given distances. (In Figure 2 the angle is not placed at Bob's position on the ground.) Hence the answer is **Figure 1**. $\blacksquare$ $BODY$
  ),
  (
    -- Q8 — Sine law to find x
    '2c3d4e5f-6a7b-4c8d-9e0f-1a2b3c4d5e08',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    'Using the Sine Law to Find the Distance $x$ Between Bob and Carl',
    $BODY$Bob spotted an eagle $18\sqrt{3}$ meters away at an angle of elevation of $30^{\circ}$. At the same time, Carl also spotted the same eagle $18$ meters away. Assume Bob and Carl have the same height, are both standing on flat ground, and are $x$ meters apart. Use the sine law to determine $x$.$BODY$,
    'hard',
    2024,
    'Fourth Long Examination',
    8,
    $BODY$In the triangle Bob-Carl-Eagle, the angle at Bob is $30^{\circ}$, the side opposite it is $18$, and the side opposite Carl is $18\sqrt{3}$; use the sine law to find the angle at Carl, then the angle at the eagle, and finally $x$ (the side opposite the eagle).$BODY$,
    $BODY$x = 36$ meters.$BODY$,
    $BODY$Consider the triangle with vertices Bob ($B$), Carl ($C$), and the Eagle ($E$). The angle at Bob is $30^{\circ}$; the side $CE$ opposite it has length $18$; the side $BE$ opposite Carl has length $18\sqrt{3}$; the side $BC = x$ is opposite the eagle.

By the sine law,
$$\frac{18}{\sin 30^{\circ}} = \frac{18\sqrt{3}}{\sin\angle C}.$$
So $\sin\angle C = \frac{18\sqrt{3}\sin 30^{\circ}}{18} = \frac{18\sqrt{3} \cdot \frac{1}{2}}{18} = \frac{\sqrt{3}}{2}$. The relevant configuration (Figure 1, with the eagle between the observers) gives $\angle C = 60^{\circ}$. Then the angle at the eagle is
$$\angle E = 180^{\circ} - 30^{\circ} - 60^{\circ} = 90^{\circ}.$$
Applying the sine law again (or the cosine law),
$$\frac{x}{\sin 90^{\circ}} = \frac{18}{\sin 30^{\circ}} \implies x = 18 \cdot 2 = 36.$$
Therefore Bob and Carl are $x = 36$ meters apart. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
