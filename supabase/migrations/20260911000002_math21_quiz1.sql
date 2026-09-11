-- ============================================================================
-- Math 21 Elementary Analysis I — Quiz 1, A.Y. 2026
-- 3 standalone trigonometric differentiation (chain rule) problems.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — D_x[5 tan(3x) + sec(2x)]
    '9a0b1c2d-3e4f-4a5b-8c9d-0e1f2a3b4c01',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Derivative of $5\tan(3x) + \sec(2x)$',
    $BODY$Differentiate with respect to $x$:
$$D_x\left[5\tan(3x) + \sec(2x)\right]$$ $BODY$,
    'medium',
    2026,
    'Quiz 1',
    1,
    $BODY$Differentiate term by term. Each term needs the chain rule: $D_x[\tan(3x)] = \sec^2(3x)\cdot 3$ and $D_x[\sec(2x)] = \sec(2x)\tan(2x)\cdot 2$.$BODY$,
    $BODY$D_x\left[5\tan(3x) + \sec(2x)\right] = 15\sec^2(3x) + 2\sec(2x)\tan(2x)$BODY$,
    $BODY$Differentiate term by term, applying the chain rule in each term:

$$D_x\left[5\tan(3x) + \sec(2x)\right] = 5D_x\left[\tan(3x)\right] + D_x\left[\sec(2x)\right].$$

$$= 5\sec^2(3x)\cdot D_x[3x] + \sec(2x)\tan(2x)\cdot D_x[2x].$$

$$= \boxed{15\sec^2(3x) + 2\sec(2x)\tan(2x)}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — D_x[csc^2(cot x)]
    '9a0b1c2d-3e4f-4a5b-8c9d-0e1f2a3b4c02',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Derivative of $\csc^2(\cot x)$',
    $BODY$Differentiate with respect to $x$:
$$D_x\left[\csc^2(\cot x)\right]$$ $BODY$,
    'hard',
    2026,
    'Quiz 1',
    2,
    $BODY$Apply the chain rule twice: first $\frac{d}{du}[u^2] = 2u$ with $u = \csc(\cot x)$, then $D_x[\csc(\cot x)] = -\csc(\cot x)\cot(\cot x)\cdot D_x[\cot x]$. Recall $D_x[\cot x] = -\csc^2 x$.$BODY$,
    $BODY$D_x\left[\csc^2(\cot x)\right] = 2\csc^2(\cot x)\cot(\cot x)\csc^2 x$BODY$,
    $BODY$Apply the chain rule repeatedly:

$$D_x\left[\csc^2(\cot x)\right] = 2\csc(\cot x)\cdot D_x\left[\csc(\cot x)\right].$$

$$= 2\csc(\cot x)\cdot \left[-\csc(\cot x)\cot(\cot x)\right]\cdot D_x[\cot x].$$

Since $D_x[\cot x] = -\csc^2 x$,

$$= -2\csc^2(\cot x)\cot(\cot x)\cdot\left(-\csc^2 x\right).$$

$$= \boxed{2\csc^2(\cot x)\cot(\cot x)\csc^2 x}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — D_x[arctan(tan x)]
    '9a0b1c2d-3e4f-4a5b-8c9d-0e1f2a3b4c03',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Derivative of $\arctan(\tan x)$',
    $BODY$Differentiate with respect to $x$:
$$D_x\left[\arctan(\tan x)\right]$$ $BODY$,
    'easy',
    2026,
    'Quiz 1',
    3,
    $BODY$Use $\frac{d}{du}[\arctan u] = \frac{1}{1 + u^2}$, then apply the chain rule with $u = \tan x$.$BODY$,
    $BODY$D_x\left[\arctan(\tan x)\right] = \frac{\sec^2 x}{1 + \tan^2 x}$BODY$,
    $BODY$Since $\frac{d}{du}[\arctan u] = \frac{1}{1 + u^2}$, the chain rule with $u = \tan x$ gives

$$D_x\left[\arctan(\tan x)\right] = \frac{1}{1 + \tan^2 x}\cdot D_x[\tan x] = \frac{1}{1 + \tan^2 x}\cdot \sec^2 x.$$

$$= \boxed{\frac{\sec^2 x}{1 + \tan^2 x}}. \;\blacksquare$$ $BODY$
  )
on conflict (id) do nothing;