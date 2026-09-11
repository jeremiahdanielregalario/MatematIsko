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
| Above + admin | `/admin` | Courses, questions/topics, theorems, notes, blogs, reports |
| Fallback | `*` | Not-found page |

Do not resurrect README-only page names as if routes exist. The current router has no standalone `/question-bank` or `/progress` page.

## 5. Domain and persistence contracts

| Entity | Relationship and meaning |
|---|---|
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

Google OAuth and email/password sign-in exist. Approved access means an exact `up.edu.ph` domain or the explicit admin exception in `src/lib/auth.ts`. The initial SQL user trigger also contains an admin exception. Admin authorization has a database `is_admin()` function; keep backend and frontend identity rules aligned.

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

Dashboard "Give me a random problem" opens `/questions/:id?mode=random`. The detail page preserves this mode on subsequent picks, labels the action "Next random problem", and samples all loaded questions in the student's selected-course scope except the current question. Back returns to the dashboard. Explicit course/topic study and ordinary detail links retain their existing course-focused behavior. No schema or permission changes.

### 2026-09-11 — Article-style course-note reader

Course notes now use a single responsive article surface with blog-like typography and spacing, replacing nested collapsible cards and regex-based Markdown splitting. The full Markdown source goes through MathRenderer once, preserving heading levels, theorem numbers, code fences, math and tables. Contents links come from rendered headings with unique per-note/index IDs, including duplicate headings; navigation moves keyboard focus and clears the mobile contents panel. Mobile has a sticky collapsible contents menu; desktop has a sticky sidebar. Reading position is local viewport progress (not mastery), updated on scroll/resize/content resize; text size is per-mounted-note UI state. Previous/next links follow the already-loaded course-note order. No schema, ownership or permission changes.

Validated with synthetic notes at 375px and 1440px, in light/dark themes, including larger text and heading jumps. The preview used the real reader component without authentication or production data. Production note content and signed-in persistence were not modified.
