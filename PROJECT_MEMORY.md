# MatematIsko — Project Memory and Scaling Guide

Last verified: 2026-09-10. Source baseline: `4df00c3` (local checkout).

This is the maintained reference for preserving the app's identity and behavior as it grows. Read it before planning a feature or refactor; update it in the same change whenever architecture, access, data, or user behavior changes. It records repository evidence, not a guarantee about the deployed database. Production configuration, traffic, backups, and migration status were not inspected.

## 1. Product identity

MatematIsko is an interactive mathematics exam-review platform for University of the Philippines students. Its tagline is **Review smarter. Solve better.** The central learning loop is: choose a course, attempt a problem, reveal support, assess understanding, and return to weak areas.

Preserve these principles when extending the product:

- Keep mathematics and active problem-solving central. Answers and solutions should support an attempt, with deliberate reveal controls.
- Keep course/topic context and exam provenance visible. Questions, theorems, notes, and practice should form one study experience.
- Preserve personal bookmarks and mastery across content updates. Stable content IDs matter.
- Treat mastery as the student's self-assessment, not verified examination performance.
- Keep mobile use, keyboard access, readable equations, and both color themes first-class.
- Community writing complements study; submitted material has a moderation workflow.

These principles summarize the current product; new audiences, grading models, or access models need an explicit recorded decision.

## 2. Source-of-truth map

| Concern | Authoritative starting point |
|---|---|
| Runtime dependencies and commands | `package.json`; inspect lockfiles for resolved versions |
| Routes and provider order | `src/app.tsx`, `src/index.tsx` |
| Shared domain shapes | `src/types/index.ts` |
| Database schema, constraints, policies, RPCs, seeded content | Ordered `supabase/migrations/` history |
| Supabase client and build-time environment | `src/lib/supabase.ts`, `rsbuild.config.ts`, `.env.example` |
| Authentication and admin identification | `src/hooks/useAuth.tsx`, `src/lib/auth.ts`, SQL trigger and `is_admin()` |
| Course selection and onboarding | `src/hooks/useCourseScope.tsx`, `src/features/auth/RequireOnboarding.tsx`, `src/pages/OnboardingPage.tsx` |
| Queries and writes | `src/lib/db.ts`, `src/lib/admin.ts`, `src/lib/reports.ts` |
| Study behavior | `src/hooks/useReveal.ts`, `src/hooks/useQuestionMutations.ts`, `src/hooks/useTheoremMutations.ts`, `src/lib/practice.ts` |
| Filtering, recommendations, aggregate statistics | `src/lib/questionFilter.ts`, `src/lib/recommendations.ts`, `src/lib/stats.ts` |
| Visual language and math | `src/index.css`, `src/components/ui/`, `src/components/math/MathRenderer.tsx` |
| Hosting and browser caching | `vercel.json`, `public/sw.js`, `public/manifest.json` |
| Test scope and thresholds | `vitest.config.ts`, `src/test/setup.ts`, colocated `*.test.*` |

Code and ordered SQL take precedence over old prose when describing current behavior. SQL comments and TypeScript comments can also drift: verify the implementation. Record contradictions instead of silently treating intended behavior as enforced behavior. Do not copy secrets, student records, or entire chat transcripts into this document.

## 3. Current architecture

The app is a React 19 / TypeScript 6 client-side SPA, built by Rsbuild. It uses React Router 7, Tailwind CSS 4, Radix primitives, Lucide icons, and Supabase Auth/Postgres. There is no separate application server in this checkout. Browser queries reach Supabase directly; privileged operations use database RPCs.

Data flow:

```text
Page / feature -> domain hook -> query or RPC wrapper -> Supabase -> Postgres policies/functions
                       |
                       +-> local React state and optimistic overlays -> rendered UI
```

Provider order is `ThemeProvider -> BrowserRouter -> AuthProvider -> CourseScopeProvider -> Routes`. `AppShell` wraps blogs and the signed-in application. `RequireAuth`, `RequireOnboarding`, and `RequireAdmin` handle route-level UX.

Directory boundaries:

- `pages/`: route composition and page-specific state.
- `features/`: multi-step auth and practice workflows.
- `components/ui/`: reusable primitives; domain components live in their named folders.
- `hooks/`: async loading, context, study interactions, and mutation state.
- `lib/`: data access and independently testable domain helpers.
- `types/`: shared application interfaces.
- `supabase/migrations/`: append-only database and content history.
- `public/`: static assets, manifest, service worker.

Most reads use `db.ts`; course notes, blog pages, and blog administration also contain direct Supabase queries. Do not assume all access is centralized. `useAsync` exposes data/loading/error/reload and reruns on callback identity or reload count changes; memoize callbacks. It has no shared cross-page query cache.

## 4. Routes and feature inventory

| Access | Routes | Responsibility |
|---|---|---|
| Public | `/`, `/auth/callback` | Landing and authentication callback |
| Public within shell | `/blogs`, `/blogs/:slug` | Approved, published community content |
| Signed in | `/onboarding` | Profile completion and course selection |
| Signed in + onboarding | `/dashboard` | Study overview and recommendations |
| Signed in + onboarding | `/courses`, `/courses/:courseId` | Course catalog and course study content |
| Signed in + onboarding | `/courses/:courseId/notes/:noteId` | Course-note reading |
| Signed in + onboarding | `/questions/:id` | Question, reveals, bookmark, mastery, reports |
| Signed in + onboarding | `/theorems`, `/theorems/:id`, `/theorems/flashcards` | Theorem study and flashcards |
| Signed in + onboarding | `/practice`, `/bookmarks` | Practice sessions and saved questions |
| Signed in + onboarding | `/practice/exam` | Topic-based timed quiz/exam papers, locked responses, and post-exam self-review |
| Signed in + onboarding | `/blogs/new`, `/profile` | Community submission and profile |
| Above + admin | `/admin` | Courses, questions/topics, theorems, notes, blogs, reports, app users, course/progress monitoring and resets, and admin grants |
| Fallback | `*` | Not-found page |

Do not resurrect README-only page names as if routes exist. The current router has no standalone `/question-bank` or `/progress` page.

## 5. Domain and persistence contracts

| Entity | Relationship and meaning |
|---|---|
| `admin_roles` | Protected delegated admin membership, original grantor and grant time; writable only through the admin grant RPC |
| `profiles` | Linked to `auth.users`; email/name/avatar plus degree program, year level, UPMMC membership |
| `courses`, `topics` | Topics belong to a course |
| `user_courses` | Student's selected courses; pair of user and course |
| `questions` | Course/topic, title, Markdown question/hint/answer/solution, difficulty, year, exam name, question number |
| `bookmarks` | Per-user/per-question saved state |
| `progress` | Per-user/per-question status, attempts, last attempt, mastery timestamp |
| `theorems` | Course/topic, name/reference, statement, optional formal notation |
| `theorem_progress` | Per-user/per-theorem status and review/mastery timestamps |
| `course_notes` | Course, title, Markdown content, ordering |
| `question_reports`, `theorem_reports` | User-submitted category/description; open or resolved |
| `blog_posts` | Unique slug, title/excerpt/content, author, optional image, publication flag, approval status |

Shared enums: difficulty = `easy | medium | hard`; progress = `unseen | learning | mastered`; blog approval = `pending | approved | rejected`.

Questions and theorems use distinct progress records. An absent progress row is interpreted as unseen in study logic. Questions reference course and topic independently: maintain consistency when authoring or moving content. Review foreign-key cascades before deleting courses, topics, or questions; deletion can remove dependent study records.

Persisted in Supabase: profiles, course selections, content, bookmarks, progress, reports, blogs. Local browser state includes theme (`matematisko-theme`), the client session-start timestamp (`matematisko_session_started_at`), and Supabase's persisted auth session. Practice phase, answer summary, reveal state, and mutation overlays are React state; a full resumable practice history is not implemented.

Quiz/exam papers additionally use per-user sessionStorage (`matematisko-exam-v1:<user-id>`) for one current paper in the browser tab: question IDs, absolute start/deadline, completion/reveal state, optional working notes, attempted/flagged IDs, and self-ratings. Question content, answers, and solutions are not stored there. Papers can resume after refresh or route navigation, but are not synced to Supabase or other devices. Storage failures show an explicit warning. User/scope changes remount the exam workspace; missing or out-of-scope saved questions block resuming rather than silently changing the paper.

Migrations reproduce schema and seeded content. Admin-created/edited production content is additional live data, so migrations alone are not a complete backup.

## 6. Behavior to preserve

### Authentication and course scope

Google OAuth and email/password sign-in exist. Approved access means an exact `up.edu.ph` domain or the explicit admin exception in `src/lib/auth.ts`. The initial SQL user trigger also contains an admin exception. Admin authorization uses database `is_admin()`: the super admin identified from the current Auth account email, or a protected `admin_roles` row keyed to Auth user ID. Only the super admin can revoke roles; super-admin access cannot be revoked through the app. The auth provider checks this RPC on session changes and window focus; admin routes, menu and course scope consume that result. The fixed email exception in `src/lib/auth.ts` now controls sign-in eligibility only. Granting a role does not change the UP-domain onboarding/sign-in policy.

The client imposes an eight-hour session window through localStorage and a sign-out timer (`src/lib/constants.ts`). This is client behavior, not proof of a server-enforced eight-hour expiry. Onboarding is considered complete when degree program and year level are present.

Course scope represents selected courses; `null` means unrestricted and `[]` represents no selected courses. Question/theorem list and detail queries now return empty/null for `[]` without making a request. Omitted scope remains unrestricted. Provider loading, failed scope recovery, and account-switch races still need a separate audit. Course selection is not database authorization: baseline content read policies allow authenticated users to read content regardless of enrollment.

### Study and practice

Reveal levels are `hidden -> hint -> answer -> solution`; revealing can advance directly to a later level and does not move backward until reset. `H`, `A`, and `S` provide shortcuts through `useRevealKeyboard`; preserve typing suppression and reset between questions.

Practice is randomized, self-rated as correct/incorrect/unsure, and summarized locally. Correct marks mastered; incorrect and unsure mark learning through the boolean mutation callback. Accuracy is rounded correct / attempted, with zero when no answers exist. Review includes incorrect and unsure answers. Do not change that denominator or imply automated answer grading without recording a product change.

Quiz/exam mode is a separate workflow linked from Practice. Students select a course, multiple topics (or no topics for a random mix), 1–30 questions, and 5–90 minutes; presets are 5/20, 10/45, and 15/75 questions/minutes. Papers sample existing loaded questions without replacement, balancing across shuffled topic groups. Explicit topic choices require enough questions to cover each topic. The UI shows when the available bank yields fewer questions than requested. This inherits the current question-bank loading/API row-cap limitation; durations are student-selected budgets, not calibrated problem-time estimates.

The entire paper is available for navigation, optional notes, attempted markers, and flags. Hints, answers, solutions, and reveal shortcuts are absent during the attempt. Finishing requires confirmation; deadline expiry locks edits automatically, including edit events arriving before the next timer tick. Students separately choose to reveal answers after completion. This is a client-side self-study lock, not a proctored assessment or server-enforced answer secrecy: existing authenticated question reads still include solutions. Self-checks count correct/incorrect/unsure, explicitly separate unchecked questions, and do not write mastery or attempt records. After all questions are checked, students can retry only incorrect/unsure questions as a fresh locked paper with the same time budget. Starting another paper or retry replaces the tab's previous paper. Timer updates do not rerender the memoized question body each second.

Question mutations apply optimistic overlays. Bookmark and status operations attempt rollback, but `recordAttempt` currently swallows errors without reverting its local status/attempt overlay. Attempt counts are calculated from loaded state and written as absolute values, so concurrent/repeated writes deserve explicit handling.

### Content rendering and design

Use `MathRenderer` for Markdown/LaTeX: `$...$` inline, `$$...$$` display. It decodes Unicode escapes and uses remark-math, remark-gfm, and rehype-katex with non-throwing math errors. Raw HTML is not enabled. Preserve readable long equations, inline rendering inside titles, preview rendering, and light/dark readability.

Math overflow (verified 2026-09-11): `MathRenderer` measures visible formula width and uses ResizeObserver to recheck after layout/font changes. Only formulas exceeding their container width by more than one pixel receive horizontal scrolling; short formulas retain visible overflow so glyph overhang does not create distracting scrollbars. Inline and display formulas stay unbroken, with oversized display formulas aligned left so their beginning remains reachable. Hidden accessible MathML is preserved.

Canvas visualization components and `remark-math-viz.ts` exist, but the current `MathRenderer` does not wire that plugin or `MathViz` into its rendering pipeline. Their presence alone does not mean embedded visualizations are enabled.

The visual identity uses a maroon brand palette (brand-900 `#7b1113`), stone neutrals, Inter UI text, and Source Serif 4 for reading/headings. Reuse existing theme tokens, primitives, layout, loading/error/empty states, focus treatment, and responsive patterns.

### Community and moderation

Submission uses `submit_blog_post`; author edits use `update_own_blog_post` and reset approval to pending. Admin approval and publication are separate fields/operations. Public visibility requires both published and approved; the anonymous read policy is added by `20260817000001_anon_blog_read.sql`.

**Enforcement gap:** migration `20260808000056_community_blogs.sql` grants author insert/update policies that constrain ownership but not approval/publication fields. The update policy's name/comment promises more than its SQL enforces. Audit direct table writes and column privileges before relying on moderation as a strict boundary; an RPC's constraints do not automatically constrain a direct table request.

## 7. Scaling priorities — proposed work, not completed features

### Admin progress monitoring (2026-09-12)

App users opens a per-user Courses and progress dialog. `admin_user_progress` computes complete database aggregates for selected courses plus courses with saved question/theorem progress, including deselected courses. It returns separate mastered/learning/total counts, question attempts, and the latest recorded attempt/review/mastery timestamp. Missing records count as unseen. These are self-assessed study indicators, not verified grades, current online presence, or a full activity history. Exam papers and self-checks in browser sessionStorage remain outside this view.

`admin_reset_user_progress` transactionally deletes question and theorem progress for one user, scoped to a course or all courses. The UI names the target and scope, requires explicit confirmation, prevents duplicate pending submissions, retains failures for retry, and reloads aggregates after success. Bookmarks, course selections, profiles, content and Auth identities remain intact. Open student pages are not pushed an invalidation; they should refresh, and subsequent study writes can create progress again. Resets are permanent and do not introduce an audit/history store.

Both RPCs in append-only migration `20260912000004_admin_user_progress.sql` enforce database admin authorization, including delegated admins; anonymous execution is revoked and student table RLS remains unchanged. Aggregating server-side avoids browser row-cap truncation without exposing private progress through broader table policies.

Validation: isolated PGlite upgrade and clean replay of 77 ordered migrations passed with synthetic Auth helpers, including admin/delegated access, anonymous/student denial, course/all/repeated resets, other-user isolation and retained bookmarks/enrollment/profile. TypeScript, affected-file lint and production build passed through installed package executables (npm unavailable; TypeScript/lint needed access outside sandbox dependency restrictions). All 16 targeted admin UI tests passed, covering scope confirmation/cancellation, reset success and reload, failed resets and load retries, empty-progress controls, and existing user administration. This feature is local; apply its migration and deploy the frontend before hosted use. No live user progress was read or reset.

Address correctness before using faster infrastructure to serve more requests.

| Priority | Evidence / risk | Next change and acceptance evidence |
|---|---|---|
| Operational | Service worker now caches only the same-origin manifest and app icon; legacy app caches are removed on activation | Verify worker activation on deployed clients. Full offline study is not implemented; HTML, scripts and API requests use the network |
| First | Empty query scope is fixed, but course-scope provider loading and account-switch handling remain unverified | Audit failed scope load, refresh races, admin and account switch; provide actionable recovery |
| First | Blog ownership policies do not enforce moderation fields | Restrict writes server-side; verify an author cannot directly approve/publish a submission or alter another author's post |
| First | Attempt writes can overwrite concurrent updates; failed attempts remain optimistic | Use atomic, retry-safe persistence and visible failure/reconciliation. Verify simultaneous attempts, repeated clicks, retries and refresh |
| First | `setUserCourses` deletes all selections then inserts in a separate request | Make replacement transactional; a failed save must retain the previous selection |
| Next | Question/theorem lists fetch full records without pagination; progress/bookmarks also load whole user collections | Introduce server filtering/search, stable pagination and narrower projections; load full solutions on detail/session demand. Verify complete results beyond the configured API row cap |
| Next | Stats, practice and recommendations depend on loaded collections | Move full-dataset aggregates and sampling to appropriate queries/RPCs as pagination arrives; never compute overall mastery or random practice from just the visible page |
| Next | Independent hooks repeat fetches and retain local mutation overlays | Introduce scoped caching/invalidation when measured useful; keys must include user, course scope, filters and page; clear private state on identity changes |
| Next | Routes import page modules eagerly; math/content rendering can grow expensive | Measure production bundle and render time, then split routes/heavy features and bound list rendering; test on mobile hardware |
| Operational | Repository tests do not establish deployed RLS, backups, or capacity | Add integration checks, restore rehearsal, error monitoring, query timing and a reproducible load scenario |

Before changing architecture, record a baseline: content rows per course, active/concurrent users, API payload bytes, request counts, p95 query/page latency, error rates, and representative mobile performance. Set targets with the owner; no capacity or uptime claim is established here. Add indexes based on query plans and actual filtering/order patterns, rather than duplicating existing indexes blindly.

A separate backend, queues, search service, multi-tenancy, and resumable practice are future options, not present dependencies or approved requirements. Record the specific limitation and migration plan before adding one.

## 8. Development, verification and deployment

The repository documents npm workflows and contains both npm and pnpm lockfiles. Use the established npm commands for now; select one lockfile policy explicitly before changing package-management conventions. Supabase CLI is pinned to `2.111.0` in `package.json`; preserve intentional pins unless investigated.

```bash
npm install
npm run dev          # port 3000
npm run typecheck
npm run lint
npm test             # Vitest run with coverage
npm run build        # dist/
npm run preview
```

`npm run format` and `format:check` currently target source TS/TSX/CSS, not Markdown. Coverage thresholds are 80% lines/functions/statements and 75% branches over the configured subset. DB/client files and most pages/context providers are outside that coverage calculation; a passing percentage is not full integration coverage.

Only public browser configuration belongs in `VITE_SUPABASE_URL` and `VITE_SUPABASE_ANON_KEY`. Despite their prefix this is Rsbuild, which maps these names explicitly to `process.env` in its config. Never place service-role credentials in the client or documentation. Missing configuration returns empty/null or no-op behavior in several DB helpers, so an empty screen alone does not establish an empty database.

Public-source documentation (2026-09-11): README now describes current study/exam features, contributor setup against a separate development Supabase project, deployment, and the distinction between repository content and hosted records. `.gitignore` excludes `.env` and `.env.*` while retaining `.env.example`; this does not remove previously committed files or history. The ordered SQL history contains schema and seeded educational content, which would be visible in a public repository. Keeping that material private requires a separate private repository and a reviewed public snapshot; no visibility change, history rewrite, migration removal, or database permission change was performed. There is no license file in the reviewed checkout, and no license was added implicitly.

Verification for that documentation change: README local links and package-script names resolved, environment ignore patterns behaved as intended, and `git diff --check` passed. A targeted pattern scan of 249 tracked files found no matching Supabase secret/service-role tokens, GitHub tokens, private-key blocks, or password-bearing Postgres URLs. Historical filename checks found only the environment template and TypeScript environment declarations among the searched environment/export/key names. This is not a full history scan, secret audit, live RLS test, or clearance to publish. No application tests were run for the documentation/ignore-only change.

Database workflow:

```bash
npm run db:new -- descriptive_change_name
npm run db:status
# Review and test the new SQL against the intended environment.
npm run db:push      # mutates the linked remote database
npm run db:reset     # destructive rebuild of LOCAL development DB only
```

Never edit an applied migration. Prefer admin tools for routine content editing and new migrations for schema changes or batch seed changes. Verify migration history before any migration repair; do not blindly mark baseline migrations as applied. Test clean replay plus upgrade from existing data for schema changes. Preserve content IDs or document their mapping when splitting/replacing questions so learning records are not silently discarded.

`vercel.json` builds with `npm run build`, serves `dist`, and rewrites non-static paths to `index.html`. Supabase OAuth redirect configuration must match the deployed origin and `/auth/callback`. Frontend release and SQL migration are separate operations: plan compatibility, order, and recovery. Verify deep-link refreshes, public blogs, sign-in, and service-worker updates after a release.

For relevant changes, check these journeys: anonymous blog reading; non-UP rejection and admin exception; onboarding/course changes; question reveal/keyboard/math; persisted bookmark/mastery after refresh; practice scoring and failed writes; theorem review; admin content editing; submission/moderation; mobile/dark theme. Test RLS/RPC behavior as anonymous, student A, student B, and admin against a disposable database, including direct requests. Unit mocks alone do not validate database access controls.

No application tests or production operations were run for this documentation-only baseline.

## 9. Keeping this memory useful

Before work:

1. Read this file and the code/SQL for the affected feature.
2. Identify the existing behavior, data owner, permissions and user-visible outcome.
3. Check unresolved risks here before building on an assumption.

Within each relevant change:

1. Update the affected route, domain, architecture, behavior, or operational section.
2. Record a meaningful decision with its reason and consequences; do not invent historical rationale.
3. Move resolved risks out of the active priority table and record verification evidence.
4. Keep README setup instructions aligned. Link detailed future documents here instead of expanding this into a transcript.
5. Report actual checks and limitations. Update the verification date only for sections rechecked; distinguish partial reviews from a full review.

Decision record template:

```markdown
### YYYY-MM-DD — Decision title
Status: proposed | accepted | superseded
Context: What concrete problem or constraint prompted this?
Decision: What changes, and what existing behavior must survive?
Reason: Why this choice? Which meaningful alternatives were considered?
Impact: Data, access, UX, compatibility, migration and recovery consequences.
Evidence: Source paths, migration/commit, tests or measured results.
Supersedes: Earlier decision, if applicable.
```

### 2026-09-10 — Establish maintained project memory

Status: accepted for this documentation task.

Context: The owner wants the app to retain its identity and technical context while scaling.

Decision: Keep this versioned guide as the project reference, with a short root contributor instruction pointing to it. Separate observed implementation, intended product behavior, and proposed improvements.

Impact: Future changes should update relevant context with the code. This file supports continuity when read and maintained; it does not automatically capture every future conversation or replace database backups.

Evidence: Repository inspection at `4df00c3`; no live deployment/database verification.

## 10. Open decisions and unknowns

- Expected audience size, peak concurrency, content-growth targets, and operating budget.
- Whether course selection should remain personalization or become an enforced entitlement.
- Whether additional schools or multiple organizations will be supported.
- Future admin/editor roles and a replacement for duplicated email allowlists.
- Whether users need resumable practice, attempt history, or spaced repetition.
- Production migration state, enabled auth-provider settings, row limits, backups, retention, recovery targets, and monitoring.
- Preferred package-manager/lockfile policy and automated release checks.

### 2026-09-11 — Full-paper quiz and exam review

Status: implemented locally; not deployed.

Decision: Add `/practice/exam` alongside ordinary guided practice, using the existing content bank and stable question IDs. Present all questions together, permit topic selection or a randomized balanced mix, and lock support until completion followed by explicit reveal. Keep self-ratings separate from mastery so an exam result does not silently rewrite the student's study history. Preserve the current paper in per-user tab storage without adding database tables or changing permissions.

Evidence: 194 tests passed in the full suite with configured coverage thresholds; after the final rendering optimization and added recovery cases, all 11 exam-specific tests passed. TypeScript and lint for affected files passed. Browser checks used synthetic questions at 375px and 1440px, including dark theme, refresh recovery, locked responses, and explicit answer reveal. Production content, authenticated deployment journeys, and cross-device persistence were not tested. The local npm command was unavailable; checks used the package scripts' underlying installed executables.

Resolve these when a feature depends on them; do not turn unknowns into implementation facts.

### 2026-09-11 — Exam-review usability and rendering fixes

Status: implemented locally; not deployed.

Decision: Preserve Supabase and content IDs while repairing study interactions. Question card action controls sit above the stretched navigation link. Next-question navigation stays strictly within the specified course/topic and disables when no other matching question is loaded; detail mastery uses the loaded detail record before the question list. Students can hide a hint or answer whenever a reset callback is available. Reveal shortcuts ignore dialogs, menus, composition and repeated key events.

Rendering: Inline Markdown titles unwrap links and block elements while preserving KaTeX/MathML. Long inline equations scroll within their available width; Markdown tables have a focusable horizontal scroll region. Theorem card actions wrap. The app uses bottom navigation below the large breakpoint, highlights nested mobile routes, provides a skip-to-content link, and respects reduced motion for scrolling.

Caching: `matematisko-static-v2` only caches the same-origin manifest and icon without query strings or Authorization headers. Navigation HTML and data requests are network-only. Activation removes older MatematIsko caches, including potentially cached private responses, without deleting other applications' caches. This deliberately does not promise offline study.

Evidence: Source review and regression tests cover Markdown/MathML, hide controls, keyboard suppression, empty question/theorem scope and worker cache boundaries. Public landing/sample inspected at 375px in light/dark themes. Signed-in production journeys, actual database limits, and deployed worker activation were not verified. See `APP_REVIEW.md` for remaining priorities and validation details.

### 2026-09-11 — Preserve dashboard random-problem mode

Dashboard "Give me a random problem" opens `/questions/:id?mode=random`. The detail page preserves this mode on subsequent picks, labels the action "Next random problem", and samples loaded questions in the student's selected-course scope except the current question. As of 2026-09-12, both actions randomly prioritize non-mastered questions (learning, unseen, or absent progress), falling back to mastered questions only when the eligible pool has no non-mastered questions. Both use current local mastery overlays; next-question selection still excludes the current question before choosing the priority pool. This inherits the existing loaded-bank/API row-cap limitation. Back returns to the dashboard. Explicit course/topic study and ordinary detail links retain their existing course-focused behavior. No schema or permission changes.

### 2026-09-11 — Article-style course-note reader

Course notes now use a single responsive article surface with blog-like typography and spacing, replacing nested collapsible cards and regex-based Markdown splitting. The full Markdown source goes through MathRenderer once, preserving heading levels, theorem numbers, code fences, math and tables. Contents links come from rendered headings with unique per-note/index IDs, including duplicate headings; navigation moves keyboard focus and clears the mobile contents panel. Mobile has a sticky collapsible contents menu; desktop has a sticky sidebar. Reading position is local viewport progress (not mastery), updated on scroll/resize/content resize; text size is per-mounted-note UI state. Previous/next links follow the already-loaded course-note order. No schema, ownership or permission changes.

Validated with synthetic notes at 375px and 1440px, in light/dark themes, including larger text and heading jumps. The preview used the real reader component without authentication or production data. Production note content and signed-in persistence were not modified.

### 2026-09-12 — Report correction workspace

Reports now expand an editor inside the report card, preserving the description while fetching the affected question/theorem directly by its stable ID. Saving retains the editor and displays confirmation; resolving remains an explicit separate operation through the existing report RPCs. Missing content and fetch failures have a retry state. No schema or permission changes.

Question and theorem forms share MathEditor: labeled, resizable source fields; responsive source/student preview panels; selection-aware inline/display/fraction/root/aligned-equation insertion; and KaTeX error messages derived from rendered math. Preview toggles now control all fields (the old question toggle did not). Diagnostics identify parsed invalid equations, not mathematical correctness or every missing delimiter. Content continues through the existing MathRenderer and updates preserve IDs.

Validation: targeted editor interaction tests, TypeScript, affected-file lint and production build run using installed package executables because npm is unavailable in the shell. Initial sandbox dependency access failed; checks were rerun with dependency access. No production records, deployment, or authenticated browser journey was modified or verified.

### 2026-09-12 — Deploy missing App users RPCs

The App users schema-cache error was caused by unapplied migration `20260911000003_admin_user_management.sql`. The linked remote history and a push dry run showed this was the only pending migration; it was applied successfully. Verified the app environment points to the linked project and both `admin_list_profiles` and `admin_update_profile` are now discoverable through the REST API and deny anonymous execution (42501). No user records were read or modified during verification; signed-in UI behavior was not exercised. The migration adds admin-checked, paginated profile search and bounded profile edits with stale-snapshot protection; student RLS and Auth identities remain unchanged. No frontend redeployment is needed for this database repair. The CLI emitted a local Docker catalog-cache warning after applying the migration; remote API verification succeeded.


### 2026-09-12 — Delegated administrator access

App users displays administrator/student status and offers Grant admin access for other registered users. A confirmation names the recipient and explains full content/report/profile administration and onward delegation. Success reloads the directory; failures preserve the confirmation for retry. Profile editing remains separate. Revocation was added by the subsequent super-admin migration described below.

Migration 20260912000001 adds admin_roles with RLS and no direct anon/authenticated grants, an admin-checked idempotent admin_grant_access RPC, role status in admin_list_profiles and delegated-role support in is_admin. Roles use Auth IDs rather than editable profile fields or user metadata; original grant attribution is preserved on duplicate requests. Existing bootstrap access remains intact. The shared auth provider scopes role results to the signed-in user and refreshes on focus; UI authorization fails closed. Course selection requests are invalidated when identity/role changes so old student results cannot overwrite unrestricted admin scope.

Validation: 215 full-suite tests passed with configured coverage thresholds; two added course-scope regression tests passed afterward. Typecheck, affected-file lint and production build were run with installed executables (npm unavailable). Isolated PGlite tests passed clean replay of 74 migrations and upgrade, anonymous/student/direct-table escalation denial, original grant attribution, duplicate grants, delegated directory access and onward delegation. Synthetic Auth helpers model claims; production user records were not inspected or granted roles for testing. Frontend deployment is separate from the database migration.

Deployment: the delegated-admin migration was applied successfully to the linked app database after verifying it was the only pending migration. The deployed grant RPC is discoverable and rejects anonymous calls (42501); no roles were granted during verification. The CLI's local Docker catalog-cache warning did not prevent migration application. The frontend changes remain local and require deployment before the new control appears on the hosted site. Final course-scope typecheck and lint passed.


### 2026-09-12 — Protected super admin and role removal

The owner account is identified by its current Auth email, jeremiah.regalario@gmail.com, through is_super_admin. The lookup uses auth.uid() against auth.users, not editable profiles, user metadata or a caller-supplied email. is_admin now uses that helper plus delegated membership. App users labels this account Super admin · protected. The directory returns a server-computed can_revoke_admin capability; only this account sees Remove admin access on other administrators. Confirmation names the recipient and explains that student records remain. Granting remains available to all admins; only the owner can revoke, and even the owner cannot revoke super-admin access through this RPC.

Migration 20260912000002 adds the super-admin-only admin_revoke_access RPC, checks protected target identity, and serializes grants/revocations with a role-table lock before authorization to prevent a queued grant from bypassing a preceding revocation. Removing a delegated role leaves profiles, bookmarks, progress and Auth identities intact. Existing signed-in clients refresh role UI on focus/reload; backend authorization reflects removal on subsequent calls. A different remaining administrator can still grant the removed user access again; revocation is not a permanent ban.

Validation: isolated PGlite upgrade and clean replay of 75 ordered migrations passed, including ordinary-admin/anonymous/direct-table revocation denial, protected-owner denial, spoofed caller-email denial, repeat revocation, loss of directory/grant permissions after removal, and preserved student profile. Tests use synthetic users; no live roles are changed by verification. Targeted UI tests cover owner controls, ordinary-admin exclusion, protected owner, confirmation and failure recovery.

Deployment and final verification: migration 20260912000002 was the only pending migration and was applied to the linked database. The deployed removal RPC is discoverable and denies anonymous requests (42501); no live roles were changed during verification. All 18 targeted tests, TypeScript, affected-file lint, production build and diff whitespace checks passed. The CLI reported only its local Docker catalog-cache warning after application. Frontend changes require deployment; signed-in hosted UI was not exercised.

### 2026-09-12 — Consistent contour-integral logo

The shared Logo uses a centered vector contour integral instead of font-dependent SVG text. All tile sizes use the same 40-unit geometry, eliminating the previous double-scaling of the glyph between navbar and landing/sign-in sizes. Each instance has a unique gradient ID; decorative marks avoid repeating the adjacent accessible wordmark. Favicon and installed-app icon match. A worker source revision triggers installation and refreshes the existing icon precache without changing cache scope. Local landing-page navbar and hero were visually checked in light/dark themes; logo lint, TypeScript and production build passed. No frontend deployment was performed.

### 2026-09-12 — Seed MATH 126 Unit I course notes

Migration `20260912000003` inserts the Math 126 Real Analysis Unit I note into `course_notes` for course `c0000000-0000-4000-8000-000000000004`, following the same Markdown + KaTeX format as the MATH 110.3 notes and the stored README/source content in `notes/math126-unit1-real-analysis.md`. It covers Lebesgue outer measure, measurable sets (including Vitali's construction, continuity of measure, and the Cantor set), measurable functions, and Littlewood's principles with Lusin's and Egoroff's theorems named as Theorem blocks. No schema, permission, or workflow changes; the note uses the existing `course_notes` table and its admin-only write policies.

Validation: PGlite clean replay of all 76 ordered migrations passed using the repo's check script with an installed PGlite module; without an applied `pgcrypto` extension declaration. The migration is local-only so far; it must be applied to the linked database (`npm run db:push`) before the note appears in the hosted app. Frontend notes rendering already handles the Markdown/KaTeX used here.

### 2026-09-12 — Seed MATH 126 Unit II course notes (L^p spaces)

Migration `20260912000005` inserts the Math 126 Real Analysis Unit II note into `course_notes` for course `c0000000-0000-4000-8000-000000000004` as `sort_order` 2, behind the Unit I seed. Source content lives in `notes/math126-unit2-lp-spaces.md`. It defines $L^p(\Omega)$ for $1 \le p \le \infty$, essential boundedness/essential supremum, norms (proving $L^1$ and $L^\infty$ are normed linear spaces), conjugates, and the name-carrying inequalities written as Theorem blocks: Young's inequality, Hölder's inequality (with the Cauchy–Schwarz special case), and Minkowski's inequality, plus the finite-measure nesting corollary $L^q(\Omega) \subseteq L^p(\Omega)$. No schema, permission, or workflow changes.

Validation: PGlite clean replay of all 78 ordered migrations passed using the repo's check script with an installed PGlite module. Both migration `20260912000003` and this one were applied to the linked database with `npm run db:push` on 2026-09-12; the notes seed is now visible in the hosted Math 126 course. The transient CLI-to-pooler connection timeouts observed that day were network-side and cleared on retry.

