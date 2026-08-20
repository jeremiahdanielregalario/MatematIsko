-- ============================================================================
-- Math 21 Sample 1st Long Exam — split the combined "Six Limit Calculations"
-- question into six separate questions.
--
--   • Deletes the combined question.
--   • Inserts six standalone limit questions.
--   • Renumbers the remaining questions so the exam becomes 1–9.
-- ============================================================================

delete from public.questions
where id = '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c01';

update public.questions
set question_number = 7
where id = '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c02';

update public.questions
set question_number = 8
where id = '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c03';

update public.questions
set question_number = 9
where id = '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c04';

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1a — Factor and cancel
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c0a',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Limit: Factoring and Canceling',
    $BODY$Calculate the limit:
$$\lim_{x \to 4}\frac{x^2-16}{4-x}$$ $BODY$,
    'easy',
    2023,
    'Sample 1st Long Exam',
    1,
    $BODY$Factor the numerator as $(x-4)(x+4)$ and cancel the common factor with the denominator (noting $4-x = -(x-4)$).$BODY$,
    $BODY$-8$.$BODY$,
    $BODY$Factor and cancel:

$$\lim_{x \to 4}\frac{x^2-16}{4-x} = \lim_{x \to 4}\frac{(x-4)(x+4)}{-(x-4)} = \lim_{x \to 4}-(x+4) = -8. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q1b — Combining fractions with one-sided limit
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c0b',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Limit: Combining Fractions With One-Sided Limit',
    $BODY$Calculate the limit:
$$\lim_{x \to -1^-}\frac{-x}{3x^2+10x+7}+\frac{1}{(x+1)^2}$$ $BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    2,
    $BODY$Factor the denominator $3x^2+10x+7 = (3x+7)(x+1)$, combine the two fractions over a common denominator, and analyze the sign of each factor as $x \to -1^-$.$BODY$,
    $BODY$+\infty$.$BODY$,
    $BODY$Factor the denominator $3x^2 + 10x + 7 = (3x + 7)(x + 1)$:

$$\lim_{x \to -1^-}\frac{-x}{(3x+7)(x+1)}+\frac{1}{(x+1)^2} = \lim_{x \to -1^-}\frac{-x(x+1) + (3x+7)}{(3x+7)(x+1)^2} = \lim_{x \to -1^-}\frac{-x^2+2x+7}{(3x+7)(x+1)^2}.$$

As $x \to -1^-$, the numerator approaches $-1 - 2 + 7 = 4 > 0$, and the denominator approaches $(4)(0^+)^2 = 0^+$. Therefore the limit is $+\infty$. $\blacksquare$$BODY$
  ),
  (
    -- Q1c — Rationalizing with conjugate
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c0c',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Limit at Infinity: Rationalizing With Conjugate',
    $BODY$Calculate the limit:
$$\lim_{x \to -\infty}\sqrt{4x^2+3x}+2x$$ $BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    3,
    $BODY$Multiply by the conjugate $\frac{\sqrt{4x^2+3x}-2x}{\sqrt{4x^2+3x}-2x}$. When $x \to -\infty$, note that $|x| = -x$.$BODY$,
    $BODY$-\frac{3}{4}$.$BODY$,
    $BODY$Rationalize by multiplying by the conjugate:

$$\lim_{x \to -\infty}\sqrt{4x^2+3x}+2x = \lim_{x \to -\infty}\frac{(\sqrt{4x^2+3x}+2x)(\sqrt{4x^2+3x}-2x)}{\sqrt{4x^2+3x}-2x} = \lim_{x \to -\infty}\frac{4x^2+3x-4x^2}{\sqrt{4x^2+3x}-2x}.$$

$$= \lim_{x \to -\infty}\frac{3x}{\sqrt{4x^2+3x}-2x} = \lim_{x \to -\infty}\frac{3x}{|x|\sqrt{4+\frac{3}{x}}-2x}.$$

Since $x \to -\infty$, $|x| = -x$, so

$$= \lim_{x \to -\infty}\frac{3x}{-x\sqrt{4+\frac{3}{x}}-2x} = \lim_{x \to -\infty}\frac{3x}{x\left(-\sqrt{4+\frac{3}{x}}-2\right)} = \frac{3}{-\sqrt{4}-2} = -\frac{3}{4}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q1d — Inverse trig limit
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c0d',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Limit: Inverse Trigonometric Function',
    $BODY$Calculate the limit:
$$\lim_{x \to 0^+}\cos^{-1}\left(\frac{1}{\ln(x)}\right)$$ $BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    4,
    $BODY$Note that $\lim_{x \to 0^+}\ln(x) = -\infty$, so $\frac{1}{\ln(x)} \to 0^-$. Then use $\cos^{-1}(0) = \frac{\pi}{2}$.$BODY$,
    $BODY$\frac{\pi}{2}$.$BODY$,
    $BODY$Note that $\lim_{x \to 0^+}\ln(x) = -\infty$, so $\lim_{x \to 0^+}\frac{1}{\ln(x)} = 0^-$. Therefore

$$\lim_{x \to 0^+}\cos^{-1}\left(\frac{1}{\ln(x)}\right) = \cos^{-1}(0) = \frac{\pi}{2}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q1e — Standard limits and LHR
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c0e',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Limit: Standard Trigonometric Limits',
    $BODY$Calculate the limit:
$$\lim_{x \to 0}\frac{x\cos^2(5x)}{\sin(-3x)}+\frac{1-\cos(x)}{x}$$ $BODY$,
    'medium',
    2023,
    'Sample 1st Long Exam',
    5,
    $BODY$Split into two limits. The second is a standard result ($0$). For the first, multiply numerator and denominator by $\frac{-3}{-3}$ and use $\lim_{x \to 0}\frac{\sin x}{x} = 1$.$BODY$,
    $BODY$-\frac{1}{3}$.$BODY$,
    $BODY$Split the limit:

$$\lim_{x \to 0}\frac{x\cos^2(5x)}{\sin(-3x)}+\lim_{x \to 0}\frac{1-\cos(x)}{x}.$$

The second limit is $0$ (a standard result). For the first, multiply by $\frac{-3}{-3}$:

$$\lim_{x \to 0}\frac{-3x}{\sin(-3x)}\cdot\frac{\cos^2(5x)}{-3} = 1 \cdot \frac{\cos^2(0)}{-3} = -\frac{1}{3}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q1f — Squeeze Theorem
    '4e5f6a7b-8c9d-4e0f-9a1b-2c3d4e5f6c0f',
    'c0000000-0000-4000-8000-000000000001',
    'd054d6e8-b7f0-5b51-bee3-077535bcff12',
    'Limit at Infinity: Squeeze Theorem',
    $BODY$Calculate the limit:
$$\lim_{x \to +\infty} \frac{\sin(2x-3)}{xe^x}$$ $BODY$,
    'easy',
    2023,
    'Sample 1st Long Exam',
    6,
    $BODY$Bound the numerator using $-1 \leq \sin(2x-3) \leq 1$, then show both bounding functions approach $0$ as $x \to +\infty$.$BODY$,
    $BODY$0$.$BODY$,
    $BODY$Since $-1 \leq \sin(2x - 3) \leq 1$, we have

$$-\frac{1}{xe^x} \leq \frac{\sin(2x-3)}{xe^x} \leq \frac{1}{xe^x}.$$

Since $\lim_{x \to +\infty}\frac{1}{xe^x} = 0$, the Squeeze Theorem gives

$$\lim_{x \to +\infty}\frac{\sin(2x-3)}{xe^x} = 0. \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;
