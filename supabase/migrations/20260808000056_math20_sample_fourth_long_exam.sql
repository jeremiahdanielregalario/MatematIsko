-- ============================================================================
-- Math 20 Precalculus — Sample 4th Long Exam, A.Y. 2023-2024
-- 6 problems (trig equations, inverse trig values, inverse trig equations,
-- ambiguous case, right triangle applications, law of cosines/sines).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Trig equations in [0, 2pi)
    '8c9d0e1f-2a3b-4c4d-8e5f-6a7b8c9d0e01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d03',
    'Trigonometric Equations in $[0, 2\pi)$',
    $BODY$Find the solution set of the following equations in the interval $[0, 2\pi)$.

**(a)** $\cos(6\theta) = \sin(3\theta)$

**(b)** $3\sec^2\left(x-\dfrac{\pi}{6}\right)-6=2\sqrt{3}\tan\left(x-\dfrac{\pi}{6}\right)$$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    1,
    $BODY$For (a), use the identity $\cos(6\theta) = 1 - 2\sin^2(3\theta)$ to get a quadratic in $\sin(3\theta)$, then find all values of $3\theta \in [0, 6\pi)$. For (b), use $\sec^2 = \tan^2 + 1$ to get a quadratic in $\tan(x - \pi/6)$, then solve for $x \in [0, 2\pi)$.$BODY$,
    $BODY$**(a)** $\left\{\frac{\pi}{18}, \frac{5\pi}{18}, \frac{\pi}{2}, \frac{13\pi}{18}, \frac{17\pi}{18}, \frac{7\pi}{6}, \frac{25\pi}{18}, \frac{29\pi}{18}, \frac{11\pi}{6}\right\}$.

**(b)** $\left\{0, \frac{\pi}{2}, \pi, \frac{3\pi}{2}\right\}$.$BODY$,
    $BODY$**(a)** Use $\cos(6\theta) = 1 - 2\sin^2(3\theta)$:

$$1 - 2\sin^2(3\theta) = \sin(3\theta) \implies 2\sin^2(3\theta) + \sin(3\theta) - 1 = 0 \implies (2\sin(3\theta) - 1)(\sin(3\theta) + 1) = 0.$$

Since $\theta \in [0, 2\pi)$, we have $3\theta \in [0, 6\pi)$.

From $\sin(3\theta) = \frac{1}{2}$: $3\theta = \frac{\pi}{6}, \frac{5\pi}{6}, \frac{13\pi}{6}, \frac{17\pi}{6}, \frac{25\pi}{6}, \frac{29\pi}{6}$.

From $\sin(3\theta) = -1$: $3\theta = \frac{3\pi}{2}, \frac{7\pi}{2}, \frac{11\pi}{2}$.

Dividing by 3:

$$\left\{\frac{\pi}{18}, \frac{5\pi}{18}, \frac{\pi}{2}, \frac{13\pi}{18}, \frac{17\pi}{18}, \frac{7\pi}{6}, \frac{25\pi}{18}, \frac{29\pi}{18}, \frac{11\pi}{6}\right\}. \;\blacksquare$$

---

**(b)** Use $\sec^2 = \tan^2 + 1$:

$$3\left[\tan^2\left(x - \frac{\pi}{6}\right) + 1\right] - 6 = 2\sqrt{3}\tan\left(x - \frac{\pi}{6}\right).$$

Let $u = \tan\left(x - \frac{\pi}{6}\right)$: $3u^2 - 2\sqrt{3}u - 3 = 0$. By the quadratic formula: $u = \frac{2\sqrt{3} \pm \sqrt{12 + 36}}{6} = \frac{2\sqrt{3} \pm 4\sqrt{3}}{6}$, giving $u = \sqrt{3}$ or $u = -\frac{\sqrt{3}}{3}$.

Since $x \in [0, 2\pi)$, $x - \frac{\pi}{6} \in \left[-\frac{\pi}{6}, \frac{11\pi}{6}\right)$.

From $\tan\left(x - \frac{\pi}{6}\right) = -\frac{\sqrt{3}}{3}$: $x - \frac{\pi}{6} = -\frac{\pi}{6}, \frac{5\pi}{6}$, so $x = 0, \pi$.

From $\tan\left(x - \frac{\pi}{6}\right) = \sqrt{3}$: $x - \frac{\pi}{6} = \frac{\pi}{3}, \frac{4\pi}{3}$, so $x = \frac{\pi}{2}, \frac{3\pi}{2}$.

Solution set: $\left\{0, \frac{\pi}{2}, \pi, \frac{3\pi}{2}\right\}$. $\blacksquare$$BODY$
  ),
  (
    -- Q2 — Exact values of inverse trig
    '8c9d0e1f-2a3b-4c4d-8e5f-6a7b8c9d0e02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d01',
    'Exact Values of Inverse Trigonometric Expressions',
    $BODY$Find the exact value of the following.

**(a)** $\sin^{-1}\left(\cos\frac{\pi}{6}\right)$

**(b)** $\cos^{-1}(\cos 230°)$

**(c)** $\sec(\tan^{-1}(5))$

**(d)** $\tan\left(\frac{\sec^{-1}(5)}{2}\right)$

**(e)** $\sin\left(\csc^{-1}(-3) + \cot^{-1}\frac{3}{4}\right)$$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    2,
    $BODY$For (a), use the cofunction identity $\cos\theta = \sin(\pi/2 - \theta)$. For (b), find a coterminal angle in $[0°, 180°]$. For (c)–(e), draw reference triangles and use identities.$BODY$,
    $BODY$**(a)** $\frac{\pi}{3}$. **(b)** $130°$. **(c)** $\sqrt{26}$. **(d)** $\sqrt{\frac{2}{3}}$. **(e)** $\frac{-3 - 8\sqrt{2}}{15}$.$BODY$,
    $BODY$**(a)** Using $\cos\theta = \sin\left(\frac{\pi}{2} - \theta\right)$: $\cos\frac{\pi}{6} = \sin\frac{\pi}{3}$. Since $\frac{\pi}{3} \in \left[-\frac{\pi}{2}, \frac{\pi}{2}\right]$:

$$\sin^{-1}\left(\cos\frac{\pi}{6}\right) = \sin^{-1}\left(\sin\frac{\pi}{3}\right) = \frac{\pi}{3}. \;\blacksquare$$

---

**(b)** $\cos 230° = \cos(360° - 230°) = \cos 130°$. Since $130° \in [0°, 180°]$:

$$\cos^{-1}(\cos 230°) = \cos^{-1}(\cos 130°) = 130°. \;\blacksquare$$

---

**(c)** Let $\theta = \tan^{-1}(5)$. Then $\tan\theta = 5 > 0$, so $\theta$ is in QI. Thus

$$\sec\theta = \sqrt{\tan^2\theta + 1} = \sqrt{25 + 1} = \sqrt{26}. \;\blacksquare$$

---

**(d)** Let $\theta = \sec^{-1}(5)$. Then $\sec\theta = 5$, $\cos\theta = \frac{1}{5} > 0$, so $\theta$ is in QI. By the half-angle identity:

$$\tan\frac{\theta}{2} = \sqrt{\frac{1 - \cos\theta}{1 + \cos\theta}} = \sqrt{\frac{1 - 1/5}{1 + 1/5}} = \sqrt{\frac{4/5}{6/5}} = \sqrt{\frac{2}{3}}. \;\blacksquare$$

---

**(e)** Let $A = \csc^{-1}(-3)$ and $B = \cot^{-1}\frac{3}{4}$. Then $\csc A = -3$, $\sin A = -\frac{1}{3}$, $\cos A = -\frac{2\sqrt{2}}{3}$ (QIII). Also $\cot B = \frac{3}{4}$, $\sin B = \frac{4}{5}$, $\cos B = \frac{3}{5}$ (QI).

$$\sin(A+B) = \sin A\cos B + \cos A\sin B = \left(-\frac{1}{3}\right)\left(\frac{3}{5}\right) + \left(-\frac{2\sqrt{2}}{3}\right)\left(\frac{4}{5}\right) = \frac{-3 - 8\sqrt{2}}{15}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Inverse trig equations
    '8c9d0e1f-2a3b-4c4d-8e5f-6a7b8c9d0e03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d03',
    'Solving Equations With Inverse Trigonometric Functions',
    $BODY$Find the solution set of the following equations.

**(a)** $\sin^{-1}\left(\dfrac{x}{3}\right) + \dfrac{1}{2}\sin^{-1}\left(\dfrac{\sqrt{3}}{2}\right) = 2\cot^{-1}(1)$

**(b)** $\tan^{-1}(2x)+\tan^{-1}(x)=\dfrac{\pi}{4}$$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    3,
    $BODY$For (a), evaluate the known inverse trig values, isolate $\sin^{-1}(x/3)$, and solve. For (b), take tangent of both sides, use the tangent addition formula, solve the resulting quadratic, and reject the extraneous root.$BODY$,
    $BODY$**(a)** $\left\{\frac{3\sqrt{3}}{2}\right\}$. **(b)** $\left\{\frac{-3 + \sqrt{17}}{4}\right\}$.$BODY$,
    $BODY$**(a)** Evaluate: $\sin^{-1}\frac{\sqrt{3}}{2} = \frac{\pi}{3}$ and $\cot^{-1}(1) = \frac{\pi}{4}$. The equation becomes

$$\sin^{-1}\left(\frac{x}{3}\right) + \frac{\pi}{6} = \frac{\pi}{2} \implies \sin^{-1}\left(\frac{x}{3}\right) = \frac{\pi}{3} \implies \frac{x}{3} = \sin\frac{\pi}{3} = \frac{\sqrt{3}}{2} \implies x = \frac{3\sqrt{3}}{2}. \;\blacksquare$$

---

**(b)** Take tangent of both sides. Let $A = \tan^{-1}(2x)$, $B = \tan^{-1}(x)$. Then

$$\tan(A+B) = 1 \implies \frac{\tan A + \tan B}{1 - \tan A\tan B} = 1 \implies \frac{2x + x}{1 - 2x^2} = 1 \implies 3x = 1 - 2x^2 \implies 2x^2 + 3x - 1 = 0.$$

$$x = \frac{-3 \pm \sqrt{9 + 8}}{4} = \frac{-3 \pm \sqrt{17}}{4}.$$

Check: if $x = \frac{-3 - \sqrt{17}}{4} < 0$, then $\tan^{-1}(2x) + \tan^{-1}(x) < 0 < \frac{\pi}{4}$, so this is extraneous. The solution is

$$x = \frac{-3 + \sqrt{17}}{4}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Number of triangles (ambiguous case)
    '8c9d0e1f-2a3b-4c4d-8e5f-6a7b8c9d0e04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    'Number of Triangles: SSS, SSA, and ASA',
    $BODY$Determine the number of triangles that can be created given the following information.

**(a)** $a=1$, $b=2$, $c=2\sqrt{2}$

**(b)** $a=3$, $b=5$, $\alpha=\frac{\pi}{6}$

**(c)** $\beta = 85°$, $\gamma = 96°$, $a=6$$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    4,
    $BODY$For (a), verify the triangle inequality. For (b), use the SSA ambiguous case: check if $a < b$, then compare $a$ with $h = b\sin\alpha$. For (c), check if the two given angles sum to less than $180°$.$BODY$,
    $BODY$**(a)** One triangle (triangle inequality satisfied). **(b)** Two triangles (SSA ambiguous case: $h < a < b$). **(c)** No triangle (angle sum $\geq 180°$).$BODY$,
    $BODY$**(a)** Three sides are given. Verify the triangle inequality:

$$a + b = 3 > 2\sqrt{2} \approx 2.83 = c, \quad b + c = 2 + 2\sqrt{2} > 1 = a, \quad a + c = 1 + 2\sqrt{2} > 2 = b.$$

All three conditions hold, so **one triangle** can be formed. $\blacksquare$

---

**(b)** Two sides and an opposite angle (SSA). Since $a = 3 < 5 = b$ and $\alpha = \frac{\pi}{6} < \frac{\pi}{2}$, compute the height:

$$h = b\sin\alpha = 5\sin\frac{\pi}{6} = \frac{5}{2} = 2.5.$$

Since $h < a < b$ (i.e., $2.5 < 3 < 5$), **two triangles** can be formed. $\blacksquare$

---

**(c)** One side and two angles. Check: $\beta + \gamma = 85° + 96° = 181° > 180°$. Since the sum of the two given angles exceeds $180°$, **no triangle** can be formed. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Angle of elevation/depression word problem
    '8c9d0e1f-2a3b-4c4d-8e5f-6a7b8c9d0e05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    'Right Triangle Application: Angle of Depression and Elevation',
    $BODY$Bathy Kernando looks down on Pan Dallida at an angle of depression of $60°$ from the top of her house. Pan runs $4$ meters away from the house and looks back at Bathy with an angle of elevation of $30°$. What is the height of Bathy's house?$BODY$,
    'medium',
    2023,
    'Sample 4th Long Exam',
    5,
    $BODY$Draw two right triangles sharing the height $h$. The angle of depression $60°$ equals the angle of elevation from Pan's initial position. Use $\tan 60° = h/x$ and $\tan 30° = h/(x+4)$ to solve for $h$.$BODY$,
    $BODY$h = 2\sqrt{3}$ meters.$BODY$,
    $BODY$Let $h$ be the height of the house and $x$ the distance from the base of the house to Pan's initial position.

From the angle of depression of $60°$ (which equals the angle of elevation from Pan's initial position):

$$\tan 60° = \frac{h}{x} \implies x = \frac{h}{\sqrt{3}}.$$

From Pan's position after running 4 meters, the angle of elevation is $30°$:

$$\tan 30° = \frac{h}{x + 4} \implies \frac{1}{\sqrt{3}} = \frac{h}{\frac{h}{\sqrt{3}} + 4}.$$

Solving:

$$\frac{h}{\sqrt{3}} + 4 = h\sqrt{3} \implies 4 = h\sqrt{3} - \frac{h}{\sqrt{3}} = \frac{3h - h}{\sqrt{3}} = \frac{2h}{\sqrt{3}}.$$

$$h = \frac{4\sqrt{3}}{2} = 2\sqrt{3} \text{ meters}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Ship and coral reef (cosine/sine law, bearing)
    '8c9d0e1f-2a3b-4c4d-8e5f-6a7b8c9d0e06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'b1c2d3e4-f5a6-4b7c-8d9e-0f1a2b3c4d02',
    'Law of Cosines/Sines: Ship and Coral Reef',
    $BODY$A ship is anchored $6$ miles S$30°$W from a lighthouse, and a coral reef is located $3\sqrt{2} + \sqrt{6}$ miles away in the S$15°$E direction from the lighthouse.

**(a)** What is the distance between the ship and the coral reef?

**(b)** Where is the coral reef located with respect to the ship? Express your answer using distance in miles and the direction in bearing.$BODY$,
    'hard',
    2023,
    'Sample 4th Long Exam',
    6,
    $BODY$For (a), identify the angle between the two given directions at the lighthouse ($30° + 15° = 45°$), then apply the law of cosines. For (b), use the law of sines to find an interior angle, then convert to a bearing.$BODY$,
    $BODY$**(a)** $2\sqrt{6}$ miles. **(b)** The coral reef is $2\sqrt{6}$ miles S$75°$E from the ship.$BODY$,
    $BODY$**(a)** Let $L$ be the lighthouse, $S$ the ship, and $R$ the reef. The angle at $L$ between the two directions is $30° + 15° = 45°$. Apply the law of cosines with $a = 6$, $b = 3\sqrt{2} + \sqrt{6}$, $\gamma = 45°$:

$$c^2 = 6^2 + (3\sqrt{2}+\sqrt{6})^2 - 2(6)(3\sqrt{2}+\sqrt{6})\cos 45°.$$

$$(3\sqrt{2}+\sqrt{6})^2 = 18 + 2(3\sqrt{12}) + 6 = 24 + 6\sqrt{12} = 24 + 12\sqrt{3}.$$

$$c^2 = 36 + 24 + 12\sqrt{3} - 12(3\sqrt{2}+\sqrt{6})\cdot\frac{\sqrt{2}}{2} = 60 + 12\sqrt{3} - 6(3\cdot 2 + \sqrt{12}) = 60 + 12\sqrt{3} - 36 - 12\sqrt{3} = 24.$$

$$c = 2\sqrt{6} \text{ miles}. \;\blacksquare$$

---

**(b)** Use the law of sines to find $\alpha$ (the angle at $S$ in triangle $SLR$):

$$\frac{\sin\alpha}{a} = \frac{\sin\gamma}{c} \implies \sin\alpha = \frac{6\sin 45°}{2\sqrt{6}} = \frac{6 \cdot \frac{\sqrt{2}}{2}}{2\sqrt{6}} = \frac{3\sqrt{2}}{2\sqrt{6}} = \frac{\sqrt{3}}{2}.$$

So $\alpha = 60°$. Since $\alpha + \beta + \gamma = 180°$, we get $\beta = 75°$.

By alternate angles, the angle from the south-line at $S$ to segment $SL$ is $30°$. Therefore the angle from the south-line at $S$ to segment $SR$ is $180° - 30° - 75° = 75°$.

The coral reef is $2\sqrt{6}$ miles **S$75°$E** from the ship. $\blacksquare$$BODY$
  )
on conflict (id) do nothing;
