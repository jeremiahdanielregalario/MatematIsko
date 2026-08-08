-- ============================================================================
-- Math 20 Precalculus — Third Long Examination, 1st Sem A.Y. 2024-2025
-- 13 problems (split into individual questions where possible).
--
-- All items verified against the live database — no duplicates skipped.
-- New topics introduced:
--   • Trigonometric Functions
--   • Trigonometric Identities
--   • Graphs of Trigonometric Functions
-- ============================================================================

insert into public.topics (id, course_id, name, description)
values
  (
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Trigonometric Functions',
    'Trigonometric values, reference angles, and circular functions.'
  ),
  (
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Trigonometric Identities',
    'Trigonometric identities and their proofs.'
  ),
  (
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'Graphs of Trigonometric Functions',
    'Amplitude, period, phase shift, and graphing of sinusoidal functions.'
  )
on conflict (course_id, name) do nothing;

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — cos(89π/6)
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Exact Value of $\cos\left(\frac{89\pi}{6}\right)$',
    $BODY$Use special values and trigonometric identities to determine the exact value of the expression.
$$\cos\left(\frac{89\pi}{6}\right)$$$BODY$,
    'medium',
    2024,
    'Third Long Examination',
    1,
    $BODY$Reduce $89\pi/6$ modulo $2\pi$: subtract $7 \cdot 2\pi = 84\pi/6$ to reach $5\pi/6$.$BODY$,
    $BODY$-\frac{\sqrt{3}}{2}$BODY$,
    $BODY$Cosine has period $2\pi = \frac{12\pi}{6}$. Subtracting $7 \cdot \frac{12\pi}{6} = \frac{84\pi}{6}$:
$$\cos\frac{89\pi}{6} = \cos\left(\frac{89\pi}{6} - \frac{84\pi}{6}\right) = \cos\frac{5\pi}{6}.$$
Since $\frac{5\pi}{6} = 150^{\circ}$ is in QII with reference angle $30^{\circ}$, and cosine is negative there,
$$\cos\frac{89\pi}{6} = \cos\frac{5\pi}{6} = -\frac{\sqrt{3}}{2}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — cos difference identity
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Exact Value of $\cos 64^{\circ}\cos(-19^{\circ}) + \sin 64^{\circ}\sin 19^{\circ}$',
    $BODY$Use special values and trigonometric identities to determine the exact value of the expression.
$$\cos 64^{\circ}\cos(-19^{\circ}) + \sin 64^{\circ}\sin 19^{\circ}$$$BODY$,
    'medium',
    2024,
    'Third Long Examination',
    2,
    $BODY$Use $\cos(-19^{\circ}) = \cos 19^{\circ}$ and the identity $\cos(A - B) = \cos A \cos B + \sin A \sin B$ with $A = 64^{\circ}$, $B = 19^{\circ}$.$BODY$,
    $BODY$\frac{\sqrt{2}}{2}$BODY$,
    $BODY$Since cosine is even, $\cos(-19^{\circ}) = \cos 19^{\circ}$. Hence
$$\cos 64^{\circ}\cos(-19^{\circ}) + \sin 64^{\circ}\sin 19^{\circ} = \cos 64^{\circ}\cos 19^{\circ} + \sin 64^{\circ}\sin 19^{\circ} = \cos(64^{\circ} - 19^{\circ}) = \cos 45^{\circ}.$$
Therefore the exact value is
$$\cos 45^{\circ} = \frac{\sqrt{2}}{2}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — cos α and tan α from a point
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    '$\cos\alpha$ and $\tan\alpha$ for an Angle Through $(-1, -\sqrt{3})$',
    $BODY$Let $\alpha > 0$ be an angle in standard position such that the terminal side contains the point $(-1, -\sqrt{3})$. Find the values of $\cos\alpha$ and $\tan\alpha$.$BODY$,
    'easy',
    2024,
    'Third Long Examination',
    3,
    $BODY$Compute $r = \sqrt{x^2 + y^2}$, then $\cos\alpha = x/r$ and $\tan\alpha = y/x$.$BODY$,
    $BODY$\cos\alpha = -\frac{1}{2}$ and $\tan\alpha = \sqrt{3}$.$BODY$,
    $BODY$With $x = -1$ and $y = -\sqrt{3}$,
$$r = \sqrt{(-1)^2 + (-\sqrt{3})^2} = \sqrt{1 + 3} = 2.$$
Therefore
$$\cos\alpha = \frac{x}{r} = -\frac{1}{2}, \qquad \tan\alpha = \frac{y}{x} = \frac{-\sqrt{3}}{-1} = \sqrt{3}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — cos(α/2)
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Exact Value of $\cos\left(\frac{\alpha}{2}\right)$ for the Angle Through $(-1, -\sqrt{3})$',
    $BODY$Let $\alpha > 0$ be an angle in standard position such that the terminal side contains the point $(-1, -\sqrt{3})$. Determine the value of $\cos\left(\frac{\alpha}{2}\right)$.$BODY$,
    'medium',
    2024,
    'Third Long Examination',
    4,
    $BODY$The point lies in QIII with reference angle $60^{\circ}$, so $\alpha = 240^{\circ} = \frac{4\pi}{3}$; then use the half-angle value $\cos\frac{2\pi}{3}$.$BODY$,
    $BODY$-\frac{1}{2}$BODY$,
    $BODY$From the coordinates $(-1, -\sqrt{3})$ the angle is in QIII and $\tan\alpha = \sqrt{3}$, so $\alpha = 240^{\circ} = \frac{4\pi}{3}$. Thus
$$\frac{\alpha}{2} = \frac{2\pi}{3} = 120^{\circ},$$
and
$$\cos\frac{\alpha}{2} = \cos\frac{2\pi}{3} = -\frac{1}{2}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — cot θ = -3, sin θ > 0
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    '$\csc\theta$ and $\cos\theta$ Given $\cot\theta = -3$ and $\sin\theta > 0$',
    $BODY$Let $\cot\theta = -3$ and $\sin\theta > 0$. Find $\csc\theta$ and $\cos\theta$.$BODY$,
    'medium',
    2024,
    'Third Long Examination',
    5,
    $BODY$Use $\csc^2\theta = 1 + \cot^2\theta$ with $\csc\theta > 0$ (since $\sin\theta > 0$), then $\cos\theta = \cot\theta \sin\theta$.$BODY$,
    $BODY$\csc\theta = \sqrt{10}$ and $\cos\theta = -\frac{3}{\sqrt{10}}$ (i.e. $-\frac{3\sqrt{10}}{10}$).$BODY$,
    $BODY$Since $\sin\theta > 0$ and $\cot\theta = \frac{\cos\theta}{\sin\theta} = -3 < 0$, we have $\cos\theta < 0$, so $\theta$ is in QII. From $\csc^2\theta = 1 + \cot^2\theta$:
$$\csc^2\theta = 1 + 9 = 10 \implies \csc\theta = \sqrt{10}$$
(because $\sin\theta > 0$). Hence $\sin\theta = \frac{1}{\sqrt{10}}$ and
$$\cos\theta = \cot\theta \cdot \sin\theta = -3 \cdot \frac{1}{\sqrt{10}} = -\frac{3}{\sqrt{10}} = -\frac{3\sqrt{10}}{10}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Prove identity
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b02',
    'Prove: $\sec x(\sin x + \cos x)^2 = \frac{1 + \sin 2x}{\cos x}$',
    $BODY$Prove the identity:
$$\sec x(\sin x + \cos x)^2 = \frac{1 + \sin(2x)}{\cos x}.$$$BODY$,
    'medium',
    2024,
    'Third Long Examination',
    6,
    $BODY$Expand $(\sin x + \cos x)^2$, use $\sin^2 x + \cos^2 x = 1$ and the double-angle identity $\sin 2x = 2\sin x\cos x$, then write $\sec x = 1/\cos x$.$BODY$,
    $BODY$Both sides equal $\frac{1 + \sin 2x}{\cos x}$.$BODY$,
    $BODY$Start with the left-hand side and expand:
$$\sec x(\sin x + \cos x)^2 = \frac{1}{\cos x}\left(\sin^2 x + 2\sin x\cos x + \cos^2 x\right).$$
Using $\sin^2 x + \cos^2 x = 1$ and $\sin 2x = 2\sin x\cos x$:
$$= \frac{1}{\cos x}\left(1 + \sin 2x\right) = \frac{1 + \sin 2x}{\cos x},$$
which equals the right-hand side. Hence the identity holds for all $x$ where both sides are defined. $\blacksquare$ $BODY$
  ),
  (
    -- Q7 — Amplitude, period, phase shift, vertical shift
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e07',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b03',
    'Amplitude, Period, Phase Shift, and Vertical Shift of $f(x) = 2\cos\left(\frac{x}{4} - \frac{\pi}{8}\right) - 3$',
    $BODY$Consider the function defined by $f(x) = 2\cos\left(\frac{x}{4} - \frac{\pi}{8}\right) - 3$. Identify the amplitude, period, phase shift, and vertical shift of $f$.$BODY$,
    'easy',
    2024,
    'Third Long Examination',
    7,
    $BODY$For $A\cos(Bx - C) + D$: amplitude $|A|$, period $\frac{2\pi}{B}$, phase shift $\frac{C}{B}$, vertical shift $D$.$BODY$,
    $BODY$Amplitude $2$, period $8\pi$, phase shift $\frac{\pi}{2}$ to the right, vertical shift $3$ units downward.$BODY$,
    $BODY$Comparing $f(x) = 2\cos\left(\frac{1}{4}x - \frac{\pi}{8}\right) - 3$ with $A\cos(Bx - C) + D$ gives $A = 2$, $B = \frac{1}{4}$, $C = \frac{\pi}{8}$, $D = -3$. Therefore:
- **Amplitude:** $|A| = 2$.
- **Period:** $\frac{2\pi}{B} = \frac{2\pi}{1/4} = 8\pi$.
- **Phase shift:** $\frac{C}{B} = \frac{\pi/8}{1/4} = \frac{\pi}{2}$, to the right.
- **Vertical shift:** $D = -3$, i.e. $3$ units downward. $\blacksquare$ $BODY$
  ),
  (
    -- Q8 — Sketch one cycle
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e08',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b03',
    'Sketching One Cycle of $f(x) = 2\cos\left(\frac{x}{4} - \frac{\pi}{8}\right) - 3$',
    $BODY$Consider the function defined by $f(x) = 2\cos\left(\frac{x}{4} - \frac{\pi}{8}\right) - 3$. Sketch one cycle of the graph of $f$. Label the endpoints and the maximum and minimum points of the graph.$BODY$,
    'hard',
    2024,
    'Third Long Examination',
    8,
    $BODY$One cycle runs from $x = \frac{\pi}{2}$ to $x = \frac{\pi}{2} + 8\pi = \frac{17\pi}{2}$. Maximum value $-1$, minimum value $-5$.$BODY$,
    $BODY$One cycle: $x \in \left[\frac{\pi}{2}, \frac{17\pi}{2}\right]$, maximum point $\left(\frac{\pi}{2}, -1\right)$, minimum point $\left(\frac{9\pi}{2}, -5\right)$, ending at $\left(\frac{17\pi}{2}, -1\right)$.$BODY$,
    $BODY$The function starts a cosine cycle at the phase shift $x = \frac{\pi}{2}$ and has period $8\pi$, so one cycle spans $\left[\frac{\pi}{2}, \frac{17\pi}{2}\right]$.

- **Maximum:** cosine starts at its maximum; $f\left(\frac{\pi}{2}\right) = 2\cos 0 - 3 = -1$. Maximum point $\left(\frac{\pi}{2}, -1\right)$.
- **Minimum:** one half-period later, at $x = \frac{\pi}{2} + 4\pi = \frac{9\pi}{2}$: $f = 2\cos\pi - 3 = -5$. Minimum point $\left(\frac{9\pi}{2}, -5\right)$.
- **Endpoints:** the cycle ends at $x = \frac{\pi}{2} + 8\pi = \frac{17\pi}{2}$ with $f\left(\frac{17\pi}{2}\right) = -1$, i.e. the endpoint $\left(\frac{17\pi}{2}, -1\right)$.
- **Midpoints:** the graph crosses the midline $y = -3$ at $x = \frac{3\pi}{2}$ (going down) and $x = \frac{11\pi}{2}$ (going up).

The curve oscillates between $y = -5$ and $y = -1$ around the midline $y = -3$. $\blacksquare$ $BODY$
  ),
  (
    -- Q9 — Range of f
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e09',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b03',
    'Range of $f(x) = 2\cos\left(\frac{x}{4} - \frac{\pi}{8}\right) - 3$',
    $BODY$Consider the function defined by $f(x) = 2\cos\left(\frac{x}{4} - \frac{\pi}{8}\right) - 3$. Based on the graph of $f$, what is the range of $f$?$BODY$,
    'easy',
    2024,
    'Third Long Examination',
    9,
    $BODY$The cosine factor ranges from $-1$ to $1$; shift by $2$ and $-3$.$BODY$,
    $BODY$The range is $[-5, -1]$ (or $[-5, -1]$ with all values attained).$BODY$,
    $BODY$For every $x$, $-1 \le \cos\left(\frac{x}{4} - \frac{\pi}{8}\right) \le 1$. Multiplying by $2$ and subtracting $3$:
$$-5 \le 2\cos\left(\frac{x}{4} - \frac{\pi}{8}\right) - 3 \le -1.$$
Both extremes are attained (e.g., the maximum $-1$ at $x = \frac{\pi}{2}$ and the minimum $-5$ at $x = \frac{9\pi}{2}$), and by continuity every intermediate value is attained. Hence the range is $[-5, -1]$. $\blacksquare$ $BODY$
  ),
  (
    -- Q10 — MC: quadrant
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e10',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Multiple Choice: Quadrant of $P\left(\frac{20\pi}{13}\right)$',
    $BODY$Multiple choice: In which quadrant will $P\left(\frac{20\pi}{13}\right)$ lie?

A) QI  B) QII  C) QIII  D) QIV$BODY$,
    'easy',
    2024,
    'Third Long Examination',
    10,
    $BODY$Convert $\frac{20\pi}{13}$ to degrees: $\frac{20}{13} \cdot 180^{\circ} \approx 276.9^{\circ}$, which lies in QIV.$BODY$,
    $BODY$D) QIV$BODY$,
    $BODY$Compute the angle in degrees:
$$\frac{20\pi}{13} = \frac{20}{13} \cdot 180^{\circ} \approx 276.92^{\circ}.$$
An angle between $270^{\circ}$ and $360^{\circ}$ lies in the fourth quadrant. Hence the point $P\left(\frac{20\pi}{13}\right)$ lies in **QIV (D)**. $\blacksquare$ $BODY$
  ),
  (
    -- Q11 — MC: reference angle
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e11',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Multiple Choice: Reference Angle for $\theta = 125^{\circ}$',
    $BODY$Multiple choice: What is the reference angle for $\theta = 125^{\circ}$?

A) $35^{\circ}$  B) $55^{\circ}$  C) $75^{\circ}$  D) $125^{\circ}$ $BODY$,
    'easy',
    2024,
    'Third Long Examination',
    11,
    $BODY$For a QII angle, the reference angle is $180^{\circ} - \theta$.$BODY$,
    $BODY$B) $55^{\circ}$$BODY$,
    $BODY$The angle $125^{\circ}$ lies in QII, so its reference angle is the acute angle it makes with the negative $x$-axis:
$$180^{\circ} - 125^{\circ} = 55^{\circ}.$$
The answer is **B) $55^{\circ}$**. $\blacksquare$ $BODY$
  ),
  (
    -- Q12 — MC: sec undefined
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e12',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Multiple Choice: Where Is $\sec\theta$ Undefined?',
    $BODY$Multiple choice: The value of $\sec\theta$ is undefined at

A) $\frac{\pi}{4}$  B) $\frac{\pi}{3}$  C) $\frac{\pi}{2}$  D) $\pi$ $BODY$,
    'easy',
    2024,
    'Third Long Examination',
    12,
    $BODY$Recall $\sec\theta = \frac{1}{\cos\theta}$, undefined where $\cos\theta = 0$.$BODY$,
    $BODY$C) $\frac{\pi}{2}$$BODY$,
    $BODY$Since $\sec\theta = \frac{1}{\cos\theta}$, it is undefined precisely when $\cos\theta = 0$. Among the choices, $\cos\theta = 0$ only at $\theta = \frac{\pi}{2}$. The answer is **C) $\frac{\pi}{2}$**. $\blacksquare$ $BODY$
  ),
  (
    -- Q13 — MC: tan(5π/6)
    '6c7d8e9f-0a1b-4c2d-8e3f-4a5b6c7d8e13',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Multiple Choice: The Value of $\tan\left(\frac{5\pi}{6}\right)$',
    $BODY$Multiple choice: The value of $\tan\left(\frac{5\pi}{6}\right)$ is equal to

A) $\tan\frac{5\pi}{6}$  B) $\cot\frac{5\pi}{6}$  C) $\tan\frac{4\pi}{3}$  D) $\cot\frac{4\pi}{3}$ $BODY$,
    'medium',
    2024,
    'Third Long Examination',
    13,
    $BODY$Compute $\tan\frac{5\pi}{6} = -\tan\frac{\pi}{6} = -\frac{\sqrt{3}}{3}$, then check which option gives the same value.$BODY$,
    $BODY$A) $\tan\frac{5\pi}{6}$ — the value is $-\frac{\sqrt{3}}{3}$ (the other options give $-\sqrt{3}$, $\sqrt{3}$, $\frac{1}{\sqrt{3}}$).$BODY$,
    $BODY$The angle $\frac{5\pi}{6} = 150^{\circ}$ has reference angle $\frac{\pi}{6}$ and lies in QII, where tangent is negative:
$$\tan\frac{5\pi}{6} = -\tan\frac{\pi}{6} = -\frac{1}{\sqrt{3}} = -\frac{\sqrt{3}}{3}.$$
Now check the options:
- B) $\cot\frac{5\pi}{6} = \frac{\cos 150^{\circ}}{\sin 150^{\circ}} = \frac{-\sqrt{3}/2}{1/2} = -\sqrt{3} \ne -\frac{\sqrt{3}}{3}$.
- C) $\tan\frac{4\pi}{3} = \tan 240^{\circ} = \tan 60^{\circ} = \sqrt{3}$.
- D) $\cot\frac{4\pi}{3} = \cot 240^{\circ} = \frac{-1/2}{-\sqrt{3}/2} = \frac{1}{\sqrt{3}}$.

Only A) $\tan\frac{5\pi}{6}$ is equal to the given value (the expression itself). $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;
