# Exam-review app review — 2026-09-11

## Improvements implemented

- Question card bookmark/mastery/report controls are no longer covered by the full-card link.
- Math titles cannot create nested links or Markdown block elements inside headings. KaTeX and its accessible MathML are retained.
- Long inline equations and tables can scroll inside content; theorem action rows wrap on narrow screens.
- Tablet widths use the bottom navigation rather than squeezing six desktop links into the header. Nested routes retain their active mobile section. Keyboard users can skip to study content.
- Students can hide hints or answers immediately. Dialog/menu interactions and composing/repeated keys do not accidentally reveal answers.
- Next-question navigation stays inside the chosen course/topic; no matching alternative means a disabled control. Mastery updates prefer the current detail record over a possibly unfinished list fetch.
- An explicitly empty course selection returns no questions/theorems, including detail queries, without requesting the unrestricted collection.
- The service worker only caches two public static resources, uses the network for pages/data, and clears legacy app caches on activation.

## Remaining priorities

| Priority | Pain point | Recommended next work |
| --- | --- | --- |
| High | Failed progress/bookmark saves are silent; attempt writes can overwrite concurrent updates | Visible save errors, retry/reconciliation and atomic retry-safe attempt persistence; verify against a disposable database |
| High | Course replacement deletes then inserts; provider can retain stale scope across async work | Transactional replacement and identity-scoped loading/error recovery |
| High | Blog author policies do not enforce all moderation fields | New SQL migration with direct-request permission tests; never rewrite applied migrations |
| High | Large lists fetch full questions/solutions, and API row caps can truncate study content | Server-side filtering/pagination, separate detail loading, full-dataset stats and practice sampling |
| Next | Eager page imports bring admin/editor code into the initial bundle | Split routes and measure first study-page load on a slow mobile connection |
| Next | Students cannot resume an interrupted practice session | Define saved-session ownership and expiration before adding persistence |
| Operational | Actual backups, restore process, production capacity and query timings are unknown | Verify backups and rehearse restore; record usage and latency before choosing a new database |

## Verification scope

Browser checks used the signed-out local app at 375px in both themes, including the sample answer/hide interaction. Protected routes were reviewed in code, not exercised using a real student account. Tests use mocks and do not establish deployed RLS or persistence correctness. No SQL migrations, production records or credentials were changed.

The shell has no npm executable on PATH. The installed package-script executables were invoked directly with bundled Node: `tsc --noEmit`, `eslint .`, `vitest run --coverage`, and `rsbuild build`. Initial sandbox runs could not read some installed dependencies; verification was retried with approved local access. Final results are recorded in the task response.

Final checks: typecheck passed; lint passed; production build passed; 20 test files / 140 tests passed. Configured coverage thresholds passed (85.53% statements, 77.51% branches, 94.11% functions, 95.57% lines). These percentages apply only to the configured coverage subset.
