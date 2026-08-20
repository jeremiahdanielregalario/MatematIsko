-- ============================================================================
-- Math 20 Precalculus — Sample 3rd Long Exam, A.Y. 2023-2024
-- 6 problems (trig values, circular motion, sinusoidal graphing,
-- trig identities, half-angle/sum identities, sum-to-product).
--
-- All items verified against the live database — no duplicates skipped.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Quadrant and six trig values
    '7b8c9d0e-1f2a-4b3c-8d4e-5f6a7b8c9d01',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Quadrant and Trigonometric Values of Angles',
    $BODY$Find the quadrant and six trigonometric function values of the following angles:

**(a)** $\theta = -\dfrac{67\pi}{4}$ radians

**(b)** $\theta = 1230°$$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    1,
    $BODY$For each angle, find a coterminal angle $\theta_0$ in $[0, 2\pi)$ (or $[0°, 360°)$), identify the quadrant, determine the reference angle, and compute the six trig values using the reference angle and the signs in that quadrant.$BODY$,
    $BODY$**(a)** QIII; $\sin = -\frac{\sqrt{2}}{2}$, $\cos = -\frac{\sqrt{2}}{2}$, $\tan = 1$, $\csc = -\sqrt{2}$, $\sec = -\sqrt{2}$, $\cot = 1$.

**(b)** QII; $\sin = \frac{1}{2}$, $\cos = -\frac{\sqrt{3}}{2}$, $\tan = -\frac{1}{\sqrt{3}}$, $\csc = 2$, $\sec = -\frac{2}{\sqrt{3}}$, $\cot = -\sqrt{3}$.$BODY$,
    $BODY$**(a)** Find a coterminal angle $\theta_0 \in [0, 2\pi)$:

$$\theta_0 = -\frac{67\pi}{4} + 9(2\pi) = -\frac{67\pi}{4} + \frac{72\pi}{4} = \frac{5\pi}{4}.$$

Since $\pi < \frac{5\pi}{4} < \frac{3\pi}{2}$, the angle is in **Quadrant III** with reference angle $\frac{\pi}{4}$.

$$\begin{array}{|c|c|c|c|c|c|}
\hline
\sin\left(-\frac{67\pi}{4}\right) & \cos\left(-\frac{67\pi}{4}\right) & \tan\left(-\frac{67\pi}{4}\right) & \csc\left(-\frac{67\pi}{4}\right) & \sec\left(-\frac{67\pi}{4}\right) & \cot\left(-\frac{67\pi}{4}\right) \\
\hline
-\frac{\sqrt{2}}{2} & -\frac{\sqrt{2}}{2} & 1 & -\sqrt{2} & -\sqrt{2} & 1 \\
\hline
\end{array}$$

$\blacksquare$

---

**(b)** Find a coterminal angle $\theta_0 \in [0°, 360°)$:

$$\theta_0 = 1230° - 3(360°) = 1230° - 1080° = 150°.$$

Since $90° < 150° < 180°$, the angle is in **Quadrant II** with reference angle $30°$.

$$\begin{array}{|c|c|c|c|c|c|}
\hline
\sin 1230° & \cos 1230° & \tan 1230° & \csc 1230° & \sec 1230° & \cot 1230° \\
\hline
\frac{1}{2} & -\frac{\sqrt{3}}{2} & -\frac{1}{\sqrt{3}} & 2 & -\frac{2}{\sqrt{3}} & -\sqrt{3} \\
\hline
\end{array}$$

$\blacksquare$$BODY$
  ),
  (
    -- Q2 — Circular motion
    '7b8c9d0e-1f2a-4b3c-8d4e-5f6a7b8c9d02',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Circular Motion: A Rolling Tumbleweed',
    $BODY$A circular tumbleweed with radius $30$ cm was seen rolling in the desert at $\frac{900}{\pi}$ revolutions per hour.

**(a)** How far does it travel after $4$ hours?

**(b)** How many degrees has it turned after $4$ hours?$BODY$,
    'easy',
    2023,
    'Sample 3rd Long Exam',
    2,
    $BODY$For (a), convert revolutions to radians, then use $s = r\theta$. For (b), convert the total radians to degrees.$BODY$,
    $BODY$**(a)** $216{,}000$ cm. **(b)** $\frac{1{,}296{,}000°}{\pi}$.$BODY$,
    $BODY$**(a)** First, find the total angle turned in radians after $4$ hours:

$$\frac{900/\pi \text{ rev}}{1 \text{ hr}} \times \frac{2\pi \text{ rad}}{1 \text{ rev}} \times 4 \text{ hr} = \frac{900}{\pi} \times 2\pi \times 4 = 7200 \text{ rad}.$$

The distance travelled is the arc length $s = r\theta$:

$$s = 30 \text{ cm} \times 7200 \text{ rad} = 216{,}000 \text{ cm}. \;\blacksquare$$

---

**(b)** Convert $7200$ rad to degrees:

$$7200 \text{ rad} \times \frac{360°}{2\pi \text{ rad}} = \frac{7200 \times 360}{2\pi} = \frac{1{,}296{,}000°}{\pi}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Sinusoidal graphing
    '7b8c9d0e-1f2a-4b3c-8d4e-5f6a7b8c9d03',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b03',
    'Graphing $y = -2\left[\sin\left(3\pi - \frac{x}{2}\right) - \frac{1}{4}\right]$',
    $BODY$Let $y = -2\left[\sin\left(3\pi-\dfrac{x}{2}\right)-\dfrac{1}{4}\right]$.

**(a)** Identify its amplitude, period, phase shift, and vertical shift.

**(b)** Sketch one cycle of the graph of $y$. Label its endpoints, crest(s), and trough(s).$BODY$,
    'hard',
    2023,
    'Sample 3rd Long Exam',
    3,
    $BODY$First rewrite in the form $y = a\sin(b(x - c)) + d$ using $\sin(-k) = -\sin k$. Then read off the parameters. For the sketch, transform the key points of one standard sine cycle using $\left(\frac{x}{b} + c,\; ax + d\right)$.$BODY$,
    $BODY$**(a)** Amplitude $2$, period $4\pi$, phase shift $6\pi$ to the right, vertical shift $\frac{1}{2}$ upward.

**(b)** One cycle spans $[6\pi, 10\pi]$. Key points: $(6\pi, \frac{1}{2})$, $(7\pi, \frac{5}{2})$, $(8\pi, \frac{1}{2})$, $(9\pi, -\frac{3}{2})$, $(10\pi, \frac{1}{2})$.$BODY$,
    $BODY$**(a)** Rewrite in the form $y = a\sin(b(x - c)) + d$:

$$y = -2\left[\sin\left(3\pi - \frac{x}{2}\right) - \frac{1}{4}\right] = -2\sin\left(-\frac{1}{2}(x - 6\pi)\right) + \frac{1}{2} = 2\sin\left(\frac{1}{2}(x - 6\pi)\right) + \frac{1}{2}.$$

(Using $\sin(-k) = -\sin k$.)

So $a = 2$, $b = \frac{1}{2}$, $c = 6\pi$, $d = \frac{1}{2}$.

- **Amplitude:** $|a| = 2$. Since $a > 0$, the graph has the typical sine orientation.
- **Period:** $\frac{2\pi}{|b|} = \frac{2\pi}{1/2} = 4\pi$.
- **Phase shift:** $c = 6\pi$ units to the right.
- **Vertical shift:** $d = \frac{1}{2}$ units upward.

---

**(b)** One cycle of the standard sine function $y = \sin x$ on $[0, 2\pi]$ has key points at $(0, 0)$, $(\frac{\pi}{2}, 1)$, $(\pi, 0)$, $(\frac{3\pi}{2}, -1)$, $(2\pi, 0)$.

Transform each point $(x, y)$ using $\left(\frac{x}{b} + c,\; ay + d\right) = (2x + 6\pi,\; 2y + \frac{1}{2})$:

$$\begin{array}{|c|c|}
\hline
\text{Standard} & \text{Transformed} \\
\hline
(0, 0) & (6\pi, \frac{1}{2}) \\
(\frac{\pi}{2}, 1) & (7\pi, \frac{5}{2}) \\
(\pi, 0) & (8\pi, \frac{1}{2}) \\
(\frac{3\pi}{2}, -1) & (9\pi, -\frac{3}{2}) \\
(2\pi, 0) & (10\pi, \frac{1}{2}) \\
\hline
\end{array}$$

One cycle spans $[6\pi, 10\pi]$. The **crest** (maximum) is at $(7\pi, \frac{5}{2})$ and the **trough** (minimum) is at $(9\pi, -\frac{3}{2})$. The endpoints are $(6\pi, \frac{1}{2})$ and $(10\pi, \frac{1}{2})$. $\blacksquare$$BODY$
  ),
  (
    -- Q4 — Trigonometric identities
    '7b8c9d0e-1f2a-4b3c-8d4e-5f6a7b8c9d04',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b02',
    'Proving Trigonometric Identities',
    $BODY$Prove the following trigonometric identities.

**(a)** $\dfrac{\sec{x} - \sin{x}\tan{x}}{\cot{x}} = \sin{x}$

**(b)** $\dfrac{\tan{2x}-\sec{2x}}{\sin{x}-\cos{x}} = \dfrac{1}{\sin{x}+\cos{x}}$

**(c)** $\tan\left(\dfrac{x}{2}\right)=\dfrac{\sin{2x}}{\cos{2x}+2\cos{x}+1}$$BODY$,
    'medium',
    2023,
    'Sample 3rd Long Exam',
    4,
    $BODY$For (a), express everything in terms of $\sin$ and $\cos$. For (b), combine the numerator, use double-angle identities, and factor. For (c), simplify the right side using double-angle identities and compare with the half-angle formula.$BODY$,
    $BODY$All three identities are verified.$BODY$,
    $BODY$**(a)** Manipulate the left side:

$$\frac{\sec x - \sin x\tan x}{\cot x} = \frac{\frac{1}{\cos x} - \frac{\sin^2 x}{\cos x}}{\frac{\cos x}{\sin x}} = \frac{\frac{1 - \sin^2 x}{\cos x}}{\frac{\cos x}{\sin x}} = \frac{\cos^2 x}{\cos x} \cdot \frac{\sin x}{\cos x} = \frac{\cos^2 x \cdot \sin x}{\cos^2 x} = \sin x. \;\blacksquare$$

---

**(b)** Manipulate the left side:

$$\frac{\tan 2x - \sec 2x}{\sin x - \cos x} = \frac{\frac{\sin 2x}{\cos 2x} - \frac{1}{\cos 2x}}{\sin x - \cos x} = \frac{\frac{2\sin x\cos x - 1}{\cos^2 x - \sin^2 x}}{\sin x - \cos x}.$$

$$= \frac{2\sin x\cos x - 1}{-(\sin x - \cos x)(\sin x + \cos x)} \cdot \frac{1}{\sin x - \cos x} = \frac{1 - 2\sin x\cos x}{(\sin x - \cos x)^2(\sin x + \cos x)}.$$

$$= \frac{1 - 2\sin x\cos x}{(1 - 2\sin x\cos x)(\sin x + \cos x)} = \frac{1}{\sin x + \cos x}. \;\blacksquare$$

---

**(c)** Simplify the right side:

$$\frac{\sin 2x}{\cos 2x + 2\cos x + 1} = \frac{2\sin x\cos x}{(2\cos^2 x - 1) + 2\cos x + 1} = \frac{2\sin x\cos x}{2\cos^2 x + 2\cos x} = \frac{2\sin x\cos x}{2\cos x(\cos x + 1)} = \frac{\sin x}{\cos x + 1}.$$

By the half-angle identity, $\tan\frac{x}{2} = \frac{\sin x}{\cos x + 1}$. Therefore both sides equal $\frac{\sin x}{\cos x + 1}$. $\blacksquare$$BODY$
  ),
  (
    -- Q5 — Trig values with half-angle and sum identities
    '7b8c9d0e-1f2a-4b3c-8d4e-5f6a7b8c9d05',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b01',
    'Trigonometric Values Using Half-Angle and Sum Identities',
    $BODY$Suppose $\alpha, \beta \in [0, 2\pi)$. Given $\sec\alpha = \frac{5}{4}$ with $\csc\alpha < 0$, and $\cot\beta = -\frac{12}{5}$ with $\cos\beta < 0$, find the following:

**(a)** $\sin^2\left(\frac{\alpha}{4}\right)$

**(b)** $\csc\left(\beta - \frac{3\pi}{4}\right)$

**(c)** $\sqrt{(1+\sin(\alpha+\beta))(1-\sin(\alpha+\beta))}$

**(d)** $\tan(\alpha + 2\beta)$$BODY$,
    'hard',
    2023,
    'Sample 3rd Long Exam',
    5,
    $BODY$First determine $\sin\alpha$, $\cos\alpha$, $\tan\alpha$ (QIV) and $\sin\beta$, $\cos\beta$, $\tan\beta$ (QII). For (a), use the half-angle formula twice. For (b), use the difference identity for sine. For (c), simplify to $|\cos(\alpha+\beta)|$. For (d), find $\tan 2\beta$ first, then use the sum identity.$BODY$,
    $BODY$**(a)** $\frac{10 + 3\sqrt{10}}{20}$. **(b)** $\frac{13\sqrt{2}}{7}$. **(c)** $\frac{33}{65}$. **(d)** $-\frac{837}{116}$.$BODY$,
    $BODY$First, determine the trig values of $\alpha$ and $\beta$.

Since $\sec\alpha = \frac{5}{4}$ and $\csc\alpha < 0$: $\cos\alpha = \frac{4}{5} > 0$ and $\sin\alpha < 0$, so $\alpha$ is in QIV. Thus $\sin\alpha = -\frac{3}{5}$ and $\tan\alpha = -\frac{3}{4}$.

Since $\cot\beta = -\frac{12}{5}$ and $\cos\beta < 0$: $\tan\beta = -\frac{5}{12} < 0$ and $\sin\beta > 0$, so $\beta$ is in QII. Thus $\cos\beta = -\frac{12}{13}$ and $\sin\beta = \frac{5}{13}$.

---

**(a)** Since $\alpha$ is in QIV: $\frac{3\pi}{2} < \alpha < 2\pi \implies \frac{3\pi}{4} < \frac{\alpha}{2} < \pi$ (QII) $\implies \frac{3\pi}{8} < \frac{\alpha}{4} < \frac{\pi}{2}$ (QI). So $\cos\frac{\alpha}{2} < 0$ and $\sin\frac{\alpha}{4} > 0$.

$$\cos\frac{\alpha}{2} = -\sqrt{\frac{1 + \cos\alpha}{2}} = -\sqrt{\frac{1 + 4/5}{2}} = -\frac{3\sqrt{10}}{10}.$$

$$\sin^2\frac{\alpha}{4} = \frac{1 - \cos(\alpha/2)}{2} = \frac{1 + \frac{3\sqrt{10}}{10}}{2} = \frac{10 + 3\sqrt{10}}{20}. \;\blacksquare$$

---

**(b)** Using $\sin\frac{3\pi}{4} = \frac{\sqrt{2}}{2}$ and $\cos\frac{3\pi}{4} = -\frac{\sqrt{2}}{2}$:

$$\sin\left(\beta - \frac{3\pi}{4}\right) = \sin\beta\cos\frac{3\pi}{4} - \cos\beta\sin\frac{3\pi}{4} = \frac{5}{13}\left(-\frac{\sqrt{2}}{2}\right) - \left(-\frac{12}{13}\right)\left(\frac{\sqrt{2}}{2}\right) = \frac{7\sqrt{2}}{26}.$$

$$\csc\left(\beta - \frac{3\pi}{4}\right) = \frac{26}{7\sqrt{2}} = \frac{13\sqrt{2}}{7}. \;\blacksquare$$

---

**(c)** Simplify:

$$\sqrt{(1+\sin(\alpha+\beta))(1-\sin(\alpha+\beta))} = \sqrt{1 - \sin^2(\alpha+\beta)} = \sqrt{\cos^2(\alpha+\beta)} = |\cos(\alpha+\beta)|.$$

$$\cos(\alpha+\beta) = \cos\alpha\cos\beta - \sin\alpha\sin\beta = \frac{4}{5}\left(-\frac{12}{13}\right) - \left(-\frac{3}{5}\right)\left(\frac{5}{13}\right) = -\frac{48}{65} + \frac{15}{65} = -\frac{33}{65}.$$

$$|\cos(\alpha+\beta)| = \frac{33}{65}. \;\blacksquare$$

---

**(d)** First find $\tan 2\beta$:

$$\tan 2\beta = \frac{2\tan\beta}{1 - \tan^2\beta} = \frac{2(-5/12)}{1 - 25/144} = \frac{-5/6}{119/144} = -\frac{5}{6} \cdot \frac{144}{119} = -\frac{120}{119}.$$

Then:

$$\tan(\alpha + 2\beta) = \frac{\tan\alpha + \tan 2\beta}{1 - \tan\alpha\tan 2\beta} = \frac{-\frac{3}{4} + (-\frac{120}{119})}{1 - (-\frac{3}{4})(-\frac{120}{119})} = \frac{-\frac{357}{476} - \frac{480}{476}}{1 - \frac{360}{476}} = \frac{-\frac{837}{476}}{\frac{116}{476}} = -\frac{837}{116}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Expressing sum of sines
    '7b8c9d0e-1f2a-4b3c-8d4e-5f6a7b8c9d06',
    '789feaf3-7a97-4b89-b15a-8df1c829f3d5',
    'f5a6b7c8-9d0e-4f1a-8b2c-3d4e5f6a7b02',
    'Expressing $\sin 70° + \sin 54°$ in Terms of Given Variables',
    $BODY$Express the value of $\sin 70° + \sin 54°$ in terms of the following variables:

**(a)** with $a = \sin 53°$, $b = \sin 17°$, $c = \cos 53°$, and $d = \cos 17°$

**(b)** with $u = \sin 62°$ and $v = \cos 16°$$BODY$,
    'hard',
    2023,
    'Sample 3rd Long Exam',
    6,
    $BODY$For (a), use sum and cofunction identities to express $\sin 70° = \sin(17° + 53°)$ and $\sin 54° = \cos 36° = \cos(53° - 17°)$, then factor. For (b), use the sum-to-product identity and the half-angle identity for cosine.$BODY$,
    $BODY$**(a)** $(a + c)(b + d)$. **(b)** $2u\sqrt{\frac{1+v}{2}}$.$BODY$,
    $BODY$**(a)** Use sum and cofunction identities:

$$\sin 70° = \sin(17° + 53°) = \sin 17°\cos 53° + \cos 17°\sin 53° = bc + da.$$

$$\sin 54° = \cos 36° = \cos(53° - 17°) = \cos 53°\cos 17° + \sin 53°\sin 17° = cd + ab.$$

Therefore:

$$\sin 70° + \sin 54° = bc + da + cd + ab = (a + c)(b + d). \;\blacksquare$$

---

**(b)** Use the sum-to-product identity:

$$\sin 70° + \sin 54° = 2\sin\left(\frac{70° + 54°}{2}\right)\cos\left(\frac{70° - 54°}{2}\right) = 2\sin 62°\cos 8°.$$

Since $8° = \frac{16°}{2}$, use the half-angle identity:

$$\cos 8° = \cos\frac{16°}{2} = \sqrt{\frac{1 + \cos 16°}{2}} = \sqrt{\frac{1 + v}{2}}.$$

Therefore:

$$\sin 70° + \sin 54° = 2u\sqrt{\frac{1 + v}{2}}. \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
