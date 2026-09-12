# Contributor instructions

Read `PROJECT_MEMORY.md` before planning or changing this application. It records product identity, architecture, current behavior, known gaps, and scaling priorities.

- Verify relevant facts in code and ordered SQL migrations; distinguish current behavior from proposed work.
- Preserve the study experience, stable content identity, math rendering, and user-data boundaries described there.
- Update the affected sections of `PROJECT_MEMORY.md` in the same change when routes, domain models, permissions, workflows, architecture, or deployment behavior change. Record significant decisions and their rationale.
- Use the existing package scripts and run checks appropriate to the change. Report what actually ran.
- Never edit already-applied migrations or include secrets/user records in documentation.

## Required math Markdown authoring (including OpenCode)

Apply these rules to problems, hints, answers, solutions, theorems, and course notes, including Markdown embedded in new SQL migrations or JSON payloads.

- Use `$...$` only for inline math within prose, such as `Let $f(x) = x^2$.`
- Every display equation MUST have its opening `$$` and closing `$$` on separate lines, with only the delimiter on each line. Put a blank line before and after the complete block when surrounded by prose.
- Never write same-line display math such as `$$f(x) = x^2$$`, or place prose on a display delimiter line. Do not use `\[...\]`, HTML centering, or code fences for actual equations.
- For several aligned steps, use `\begin{aligned} ... \end{aligned}` inside ONE display block; use `&` for alignment and `\\` for row breaks.
- Keep math in titles and table cells inline. Put display equations in the body outside Markdown tables. Preserve list/blockquote indentation when nesting a display block.
- Preserve mathematical meaning, hypotheses, numbering, labels and stable content IDs. Do not invent unreadable source material; identify uncertainty.
- Before saving or returning content, inspect every display delimiter in the final decoded Markdown. Fix same-line delimiters, unmatched pairs, and accidental literal `\n` text. Preview representative equations with the app's MathRenderer when available; report what was actually checked.
- In raw Markdown use actual newlines and single LaTeX backslashes. In JSON encode newlines as `\n` and backslashes as `\\`; check the decoded string. For SQL use a distinct tagged dollar quote such as `$md$...$md$`, never outer `$$...$$` around Markdown containing math delimiters. Never rewrite applied migrations to fix old content.

Correct standalone display:

```markdown
Consider the function

$$
f(x) = x^2
$$

Its derivative is $f'(x) = 2x$.
```

Correct aligned display:

```markdown
$$
\begin{aligned}
f'(x) &= \lim_{h \to 0} \frac{(x+h)^2-x^2}{h} \\
      &= 2x.
\end{aligned}
$$
```
