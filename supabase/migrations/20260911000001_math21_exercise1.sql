-- ============================================================================
-- Math 21 Elementary Analysis I — Exercise 1, A.Y. 2026
-- 9 standalone differentiation problems (chain rule, higher-order derivatives,
-- implicit differentiation, and a velocity/acceleration application).
--
-- Each original exam item is its own question card: the three chain-rule items,
-- the two higher-order items, the two implicit-differentiation items, and the
-- two application items are independent questions.
-- ============================================================================

insert into public.questions
  (id, course_id, topic_id, title, question_text, difficulty, year, exam_name, question_number, hint, answer, solution)
values
  (
    -- Q1 — Chain rule: f(x) = (9x^5 - 4x^3 + 3x - 15/x^2)^3
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b01',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Chain Rule: Derivative of $\left(9x^5 - 4x^3 + 3x - \frac{15}{x^2}\right)^3$',
    $BODY$Use the chain rule to find the derivative of
$$f(x) = \left(9x^5 - 4x^3 + 3x - \frac{15}{x^2}\right)^3.$$ $BODY$,
    'medium',
    2026,
    'Exercise 1',
    1,
    $BODY$Let $u = 9x^5 - 4x^3 + 3x - \frac{15}{x^2}$ and apply $\frac{d}{dx}[u^3] = 3u^2\frac{du}{dx}$. Rewrite $\frac{15}{x^2}$ as $15x^{-2}$ when differentiating.$BODY$,
    $BODY$f'(x) = 3\left(9x^5 - 4x^3 + 3x - \frac{15}{x^2}\right)^2\left(45x^4 - 12x^2 + 3 + \frac{30}{x^3}\right)$BODY$,
    $BODY$Rewrite $15/x^2$ as $15x^{-2}$ and apply the chain rule:

$$\frac{d}{dx}\left(9x^5 - 4x^3 + 3x - \frac{15}{x^2}\right)^3 = 3\left(9x^5 - 4x^3 + 3x - \frac{15}{x^2}\right)^2\cdot \frac{d}{dx}\left(9x^5 - 4x^3 + 3x - 15x^{-2}\right).$$

Differentiating the inner function, $\frac{du}{dx} = 45x^4 - 12x^2 + 3 + 30x^{-3}$. Hence

$$f'(x) = \boxed{3\left(9x^5 - 4x^3 + 3x - \frac{15}{x^2}\right)^2\left(45x^4 - 12x^2 + 3 + \frac{30}{x^3}\right)}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q2 — Chain rule: h(x) = (x^{2/3} - 2x)/(x^3 + 1)^2
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b02',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Chain Rule: Derivative of $\frac{x^{2/3} - 2x}{(x^3 + 1)^2}$',
    $BODY$Use the chain rule to find the derivative of
$$h(x) = \frac{x^{2/3} - 2x}{(x^3 + 1)^2}.$$ $BODY$,
    'hard',
    2026,
    'Exercise 1',
    2,
    $BODY$Apply the quotient rule. To differentiate the denominator $(x^3 + 1)^2$, use the chain rule: $\frac{d}{dx}[(x^3+1)^2] = 2(x^3+1)\cdot 3x^2$.$BODY$,
    $BODY$h'(x) = \frac{(x^3 + 1)^2\left(\frac{2}{3}x^{-1/3} - 2\right) - 6x^2(x^{2/3} - 2x)(x^3 + 1)}{(x^3 + 1)^4}$BODY$,
    $BODY$By the quotient rule,

$$h'(x) = \frac{(x^3 + 1)^2\,\frac{d}{dx}(x^{2/3} - 2x) - (x^{2/3} - 2x)\,\frac{d}{dx}(x^3 + 1)^2}{\left((x^3 + 1)^2\right)^2}.$$

Now $\frac{d}{dx}(x^{2/3} - 2x) = \frac{2}{3}x^{-1/3} - 2$, and by the chain rule $\frac{d}{dx}(x^3 + 1)^2 = 2(x^3 + 1)\cdot 3x^2 = 6x^2(x^3 + 1)$. Therefore

$$h'(x) = \boxed{\frac{(x^3 + 1)^2\left(\frac{2}{3}x^{-1/3} - 2\right) - 6x^2(x^{2/3} - 2x)(x^3 + 1)}{(x^3 + 1)^4}}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q3 — Chain rule: g(x) = sqrt(x+3)(x^2 - 5)
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b03',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Product Rule: Derivative of $\sqrt{x + 3}\,(x^2 - 5)$',
    $BODY$Use the chain rule to find the derivative of
$$g(x) = \sqrt{x + 3}\,(x^2 - 5).$$ $BODY$,
    'easy',
    2026,
    'Exercise 1',
    3,
    $BODY$Rewrite $\sqrt{x + 3}$ as $(x + 3)^{1/2}$ and apply the product rule; the derivative of $(x + 3)^{1/2}$ uses the chain rule.$BODY$,
    $BODY$g'(x) = 2x\sqrt{x + 3} + \frac{x^2 - 5}{2\sqrt{x + 3}}$BODY$,
    $BODY$Rewrite the function as $g(x) = (x + 3)^{1/2}(x^2 - 5)$ and apply the product rule:

$$g'(x) = (x + 3)^{1/2}\cdot 2x + (x^2 - 5)\cdot \frac{1}{2}(x + 3)^{-1/2}.$$

Writing the fractional power back as a square root,

$$g'(x) = \boxed{2x\sqrt{x + 3} + \frac{x^2 - 5}{2\sqrt{x + 3}}}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q4 — Higher-order: y = 10x^5 + 6/x^4 - 7x^2
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b04',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Higher-Order Derivatives: $y = 10x^5 + \frac{6}{x^4} - 7x^2$',
    $BODY$Find the $n$-th order derivative of $y$ where $n = 1, 2, 3$:
$$y = 10x^5 + \frac{6}{x^4} - 7x^2.$$ $BODY$,
    'easy',
    2026,
    'Exercise 1',
    4,
    $BODY$Write $\frac{6}{x^4}$ as $6x^{-4}$ and differentiate term by term three times, applying the power rule at each step.$BODY$,
    $BODY$y' = 50x^4 - \frac{24}{x^5} - 14x, \qquad y'' = 200x^3 + \frac{120}{x^6} - 14, \qquad y''' = 600x^2 - \frac{720}{x^7}$BODY$,
    $BODY$Rewrite $\frac{6}{x^4}$ as $6x^{-4}$ and differentiate term by term.

**First derivative:**

$$\frac{dy}{dx} = 5\cdot 10x^{4} + (-4)\cdot 6x^{-5} - 2\cdot 7x^{1} = \boxed{50x^4 - \frac{24}{x^5} - 14x}.$$

**Second derivative:**

$$\frac{d^2y}{dx^2} = 4\cdot 50x^{3} + (-5)\cdot (-24)x^{-6} - 14 = \boxed{200x^3 + \frac{120}{x^6} - 14}.$$

**Third derivative:**

$$\frac{d^3y}{dx^3} = 3\cdot 200x^{2} + (-6)\cdot 120x^{-7} = \boxed{600x^2 - \frac{720}{x^7}}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q5 — Higher-order: y = (x^3 - 2)^10
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b05',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Higher-Order Derivatives: $y = (x^3 - 2)^{10}$',
    $BODY$Find the $n$-th order derivative of $y$ where $n = 1, 2, 3$:
$$y = (x^3 - 2)^{10}.$$ $BODY$,
    'medium',
    2026,
    'Exercise 1',
    5,
    $BODY$Apply the chain rule for $y'$. From the second derivative onward, use the product rule together with the chain rule, and collect like terms.$BODY$,
    $BODY$y' = 30x^2(x^3 - 2)^9, \qquad y'' = 810x^4(x^3 - 2)^8 + 60x(x^3 - 2)^9, \qquad y''' = 19440x^6(x^3 - 2)^7 + 4860x^3(x^3 - 2)^8 + 60(x^3 - 2)^9$BODY$,
    $BODY$**First derivative:**

$$\frac{dy}{dx} = 10(x^3 - 2)^9\cdot 3x^2 = \boxed{30x^2(x^3 - 2)^9}.$$

**Second derivative** (product rule):

$$\frac{d^2y}{dx^2} = 30x^2\cdot 9(x^3 - 2)^8\cdot 3x^2 + 60x(x^3 - 2)^9 = \boxed{810x^4(x^3 - 2)^8 + 60x(x^3 - 2)^9}.$$

**Third derivative:**

$$\frac{d^3y}{dx^3} = \frac{d}{dx}\left[810x^4(x^3 - 2)^8\right] + \frac{d}{dx}\left[60x(x^3 - 2)^9\right].$$

Using the product and chain rules on each term,

$$= 810x^4\cdot 8(x^3 - 2)^7\cdot 3x^2 + 3240x^3(x^3 - 2)^8 + 60x\cdot 9(x^3 - 2)^8\cdot 3x^2 + 60(x^3 - 2)^9$$

$$= 19440x^6(x^3 - 2)^7 + 3240x^3(x^3 - 2)^8 + 1620x^3(x^3 - 2)^8 + 60(x^3 - 2)^9$$

$$= \boxed{19440x^6(x^3 - 2)^7 + 4860x^3(x^3 - 2)^8 + 60(x^3 - 2)^9}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q6 — Implicit: x^2 + 4x - 5y = 6y^2 + 8
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b06',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Implicit Differentiation: $x^2 + 4x - 5y = 6y^2 + 8$',
    $BODY$Use implicit differentiation to find $\dfrac{dy}{dx}$:
$$x^2 + 4x - 5y = 6y^2 + 8.$$ $BODY$,
    'easy',
    2026,
    'Exercise 1',
    6,
    $BODY$Differentiate both sides with respect to $x$, treating $y$ as a function of $x$ (so each $y$ term contributes a factor of $\frac{dy}{dx}$). Then collect the $\frac{dy}{dx}$ terms and solve.$BODY$,
    $BODY$\frac{dy}{dx} = \frac{2x + 4}{12y + 5}$BODY$,
    $BODY$Differentiate both sides with respect to $x$:

$$2x + 4 - 5\frac{dy}{dx} = 12y\frac{dy}{dx}.$$

Collect the $\frac{dy}{dx}$ terms on one side:

$$-(5 + 12y)\frac{dy}{dx} = -(2x + 4).$$

Therefore

$$\frac{dy}{dx} = \boxed{\frac{2x + 4}{12y + 5}}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q7 — Implicit: 15xy = y^3 + 25/x
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b07',
    'c0000000-0000-4000-8000-000000000001',
    'e0fcbbef-0a2b-5e34-8ea3-a814bec15036',
    'Implicit Differentiation: $15xy = y^3 + \frac{25}{x}$',
    $BODY$Use implicit differentiation to find $\dfrac{dy}{dx}$:
$$15xy = y^3 + \frac{25}{x}.$$ $BODY$,
    'medium',
    2026,
    'Exercise 1',
    7,
    $BODY$The left side needs the product rule, and rewrite $\frac{25}{x}$ as $25x^{-1}$. Then collect the $\frac{dy}{dx}$ terms and solve.$BODY$,
    $BODY$\frac{dy}{dx} = \frac{\frac{25}{x^2} + 15y}{3y^2 - 15x}$BODY$,
    $BODY$Rewrite $\frac{25}{x}$ as $25x^{-1}$ and differentiate both sides with respect to $x$. The left side uses the product rule:

$$15x\frac{dy}{dx} + 15y = 3y^2\frac{dy}{dx} - 25x^{-2}.$$

Collect the $\frac{dy}{dx}$ terms:

$$\left(15x - 3y^2\right)\frac{dy}{dx} = -\frac{25}{x^2} - 15y.$$

Multiplying numerator and denominator by $-1$,

$$\frac{dy}{dx} = \boxed{\frac{\frac{25}{x^2} + 15y}{3y^2 - 15x}}. \;\blacksquare$$ $BODY$
  ),
  (
    -- Q8 — Application: velocity
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b08',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Application: Velocity of a Particle',
    $BODY$The displacement (in meters) of a particle moving in a straight line is given by the equation of motion
$$s(t) = \frac{2}{3}t^3 - t^2 + 10t,$$
where $t$ is measured in seconds. Find its velocity after $t = 3$ seconds.$BODY$,
    'easy',
    2026,
    'Exercise 1',
    8,
    $BODY$The velocity after $t$ seconds is $v(t) = s'(t)$. Differentiate, then substitute $t = 3$.$BODY$,
    $BODY$v(3) = 22 \text{ m/s}$BODY$,
    $BODY$The velocity after $t$ seconds is $v(t) = s'(t)$:

$$v(t) = \left(\frac{2}{3}t^3 - t^2 + 10t\right)' = 2t^2 - 2t + 10.$$

At $t = 3$:

$$v(3) = 2(3)^2 - 2(3) + 10 = 18 - 6 + 10 = 22.$$

Hence its velocity after $t = 3$ seconds is $\boxed{22 \text{ m/s}}$. $\blacksquare$ $BODY$
  ),
  (
    -- Q9 — Application: acceleration
    '8f9a0b1c-2d3e-4f5a-8b9c-0d1e2f3a4b09',
    'c0000000-0000-4000-8000-000000000001',
    '891e6378-0089-560a-b6e3-a958bc2ff569',
    'Application: Acceleration of a Particle',
    $BODY$The displacement (in meters) of a particle moving in a straight line is given by the equation of motion
$$s(t) = \frac{2}{3}t^3 - t^2 + 10t,$$
where $t$ is measured in seconds. Find its acceleration after $t = 3$ seconds.$BODY$,
    'easy',
    2026,
    'Exercise 1',
    9,
    $BODY$The acceleration after $t$ seconds is $a(t) = v'(t) = s''(t)$. Differentiate twice, then substitute $t = 3$.$BODY$,
    $BODY$a(3) = 10 \text{ m/s}^2$BODY$,
    $BODY$The acceleration after $t$ seconds is $a(t) = v'(t) = s''(t)$. From $v(t) = 2t^2 - 2t + 10$,

$$a(t) = v'(t) = 4t - 2.$$

At $t = 3$:

$$a(3) = 4(3) - 2 = 12 - 2 = 10.$$

Hence its acceleration after $t = 3$ seconds is $\boxed{10 \text{ m/s}^2}$. $\blacksquare$ $BODY$
  )
on conflict (id) do nothing;