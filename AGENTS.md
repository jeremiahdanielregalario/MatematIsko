# Contributor instructions

Read `PROJECT_MEMORY.md` before planning or changing this application. It records product identity, architecture, current behavior, known gaps, and scaling priorities.

- Verify relevant facts in code and ordered SQL migrations; distinguish current behavior from proposed work.
- Preserve the study experience, stable content identity, math rendering, and user-data boundaries described there.
- Update the affected sections of `PROJECT_MEMORY.md` in the same change when routes, domain models, permissions, workflows, architecture, or deployment behavior change. Record significant decisions and their rationale.
- Use the existing package scripts and run checks appropriate to the change. Report what actually ran.
- Never edit already-applied migrations or include secrets/user records in documentation.
