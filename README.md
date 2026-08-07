# MatematIsko

Interactive mathematics exam-review platform for University of the Philippines students.

Browse questions, attempt them yourself, then reveal hints, answers, and full solutions — all rendered with real math notation via KaTeX.

**Tagline:** *Review smarter. Solve better.*

---

## Features

- **Question Bank** — filter by course, topic, difficulty, year, and status; search by text
- **Progressive Reveal** — work the problem first, then unlock hint → answer → full solution
- **Keyboard Shortcuts** — `H` hint, `A` answer, `S` solution (never fires while typing)
- **Bookmarks & Mastery** — save tricky questions; mark as learning or mastered
- **Practice Mode** — random questions scored in-session, review mistakes afterward
- **Dashboard & Progress** — per-topic mastery bars, overall stats, continue-studying prompts
- **Light & Dark Mode** — full contrast accessibility with KaTeX readable in both themes
- **Responsive Design** — works well on desktop, tablet, and phone; long equations scroll horizontally
- **Supabase Auth** — Google OAuth restricted to `@up.edu.ph` accounts; domain enforced at both the database trigger and the frontend

---

## Tech Stack

| Layer | Tool |
|---|---|
| Build | Rsbuild |
| UI | React 19, TypeScript 6, Tailwind CSS 4, Radix primitives (shadcn-style) |
| Math | KaTeX via react-markdown + remark-math + rehype-katex |
| Routing | React Router 7 |
| Auth/DB | Supabase Auth (Google OAuth) + Postgres |
| Quality | ESLint 9, Prettier, Vitest + Testing Library, v8 coverage |

---

## Architecture

```
src/
  components/
    ui/          Radix-based accessible primitives (button, card, badge, select, …)
    layout/      AppShell, Header, MobileNav, UserMenu, ThemeToggle
    math/        MathRenderer (react-markdown + KaTeX)
    questions/   QuestionCard, RevealSection, BookmarkButton, FilterPanel, …
    common/      LoadingState, ErrorState, EmptyState, ProgressCard
  hooks/         useAuth, useQuestions, useReveal, useDebounce, useAsync, …
  lib/           supabase client, DB queries, questionFilter, stats, format
  features/      auth (RequireAuth, GoogleSignInButton), practice (Setup, Session, Results)
  pages/         Landing, Dashboard, QuestionBank, QuestionDetail, Practice, Bookmarks, Progress, Course, Profile
  types/         TypeScript interfaces shared across the application
```

---

## Local Development

```bash
# 1. Install dependencies
npm install

# 2. Copy the env template and fill in your Supabase credentials
cp .env.example .env
#    VITE_SUPABASE_URL=https://<project>.supabase.co
#    VITE_SUPABASE_ANON_KEY=<anon-key>

# 3. Start the dev server (http://localhost:3000)
npm run dev

# 4. Run checks
npm run typecheck   # TypeScript strict check
npm run lint        # ESLint (0 errors)
npm test            # Vitest + coverage
npm run build       # Production build in dist/
```

---

## Environment Variables

| Variable | Description | Where to find it |
|---|---|---|
| `VITE_SUPABASE_URL` | Supabase project REST endpoint | Dashboard → Settings → API |
| `VITE_SUPABASE_ANON_KEY` | Public anon key (safe to expose in the browser) | Dashboard → Settings → API |

Never commit `.env`. Never expose `service_role` in client code.

---

## Supabase Setup

1. Create a new Supabase project.
2. **Install the Supabase CLI** (pinned to `2.111.0` as a devDependency — v2.112.0 has a known
   regression in `supabase link`; see [supabase/cli#6115](https://github.com/supabase/cli/issues/6115)):
   ```bash
   npm install
   npx supabase login                      # one-time auth
   ```
3. **Link this repo to your remote project** (needs the project ref from Dashboard → Settings → General):
   ```bash
   npx supabase link --project-ref <your-project-ref>
   ```
4. **Apply the schema + question bank** (this runs every file in `supabase/migrations/` in order):
   ```bash
   npm run db:push
   ```
   > Migrating an *existing* database? Run `npm run db:status`, then mark the three baseline
   > migrations as already-applied so they don't run again:
   > `npx supabase migration repair --status applied 20260808000001 20260808000002 20260808000003`
   > (only needed the very first time, and only if tables already exist).
5. In **Authentication → Providers**, enable **Google** and enter your Google Cloud OAuth client ID + secret.
6. In **Authentication → URL Configuration**, add:
   - **Site URL:** `http://localhost:3000` (development)
   - **Redirect URLs:** `http://localhost:3000/auth/callback` (and your Vercel domain for production)
7. (Recommended) In **Authentication → Providers → Email**, add `up.edu.ph` to the allowed email domains list as an additional safety layer.

## Making Database Changes (Migrations)

**Stop using the SQL Editor.** Every schema change or new batch of questions becomes a versioned
migration file that is applied with one command:

```bash
npm run db:new -- add-stat-201-questions   # creates supabase/migrations/<timestamp>_add-stat-201-questions.sql
#   ...write your SQL in the new file...
npm run db:push                            # applies pending migrations to the linked (remote) database
npm run db:status                          # shows which migrations are applied vs. pending
npm run db:reset                           # (local dev only) rebuild local DB from migrations
```

Rules to keep it painless:

- **Adding questions? Use the Admin page** (`/admin`, only visible to the admin account). Create/edit
  questions with a live Markdown + LaTeX preview — no SQL required. Schema changes (new tables,
  columns, constraints) still go through migrations.
- **Never edit an already-applied migration.** Add a *new* migration file instead — they run exactly
  once, in order, so edits won't re-run.
- **Migrations run in order.** Keep them read-only after they're pushed so the repo always matches
  the remote database (`npm run db:status` should show no drift).
- **Local dev** (optional, needs Docker): `npx supabase start` spins up a full local Supabase stack
  and applies the same migrations, so you can test schema changes before pushing.

---

## Google OAuth Setup

1. Go to [Google Cloud Console → Credentials](https://console.cloud.google.com/apis/credentials).
2. Create an **OAuth 2.0 Client ID** of type **Web application**.
3. Add **Authorized redirect URIs:**
   - `https://<your-project-ref>.supabase.co/auth/v1/callback`
   - `http://localhost:3000/auth/callback` (for local development)
4. Copy the Client ID and Client Secret into your Supabase Google provider settings.

---

## Database Schema

| Table | Purpose |
|---|---|
| `profiles` | One row per student; created automatically on first sign-up by a database trigger |
| `courses` | Math/stat courses (MATH 21, MATH 111, STAT 101, …) |
| `topics` | Sub-topics belonging to a course |
| `questions` | Exam questions with Markdown + LaTeX source for text, hint, answer, and solution |
| `bookmarks` | Which questions a student has saved |
| `progress` | Per-question mastery status, attempts, and timestamps |

Row-Level Security policies ensure students can only read/write their own bookmarks and progress. There are **no insert/update/delete policies** on `courses`, `topics`, or `questions`, so the question bank cannot be modified by students.

A `handle_new_user` trigger on `auth.users` rejects sign-ups from non-`@up.edu.ph` emails at the database level before the profile row is created.

---

## Seed Data

The question bank lives in the migration history (`supabase/migrations/`):

- **Baseline migration** `..._seed_questions.sql`: 9 courses, 26 topics, 25+ questions with real math
  content in LaTeX (limits, derivatives, integrals, eigenvalues, group theory, ODEs, Bayes' theorem,
  p-values, compactness, …) plus the course-catalog migration for the full UP Math catalog.
- **New questions:** use the Admin page (`/admin`) for everyday content, or add a migration file via
  `npm run db:new -- <name>` for batch/scripted inserts. Do not edit applied migrations.

---

## Deployment (Vercel)

1. Push this repository to GitHub.
2. In [vercel.com](https://vercel.com), import the repository.
3. Framework preset: **Rsbuild** (Vercel will auto-detect).
4. Add the two environment variables (`VITE_SUPABASE_URL`, `VITE_SUPABASE_ANON_KEY`) in the Vercel project settings.
5. Deploy. Vercel serves the static SPA from `dist/`.
6. Update your Supabase **Redirect URLs** to include `https://<your-vercel-domain>.com/auth/callback`.

The `vercel.json` in the project root rewrites all paths to `index.html` so React Router handles client-side routes.

---

## Keyboard Shortcuts

| Key | Action |
|---|---|
| `H` | Reveal hint |
| `A` | Reveal answer |
| `S` | Reveal solution |

Shortcuts are suppressed while typing in any input or textarea, and only apply on question detail and practice pages.

---

## Security Notes

- **Client keys only:** The `.env` file contains only the public `anon` key. The `service_role` key is never used or referenced in frontend code.
- **Domain enforcement (backend):** The `handle_new_user` Postgres trigger rejects any `auth.users` insert where the email domain is not `up.edu.ph`. This cannot be bypassed from the client.
- **Domain enforcement (frontend):** The `AuthProvider` immediately signs out users with non-UP emails and shows a clear message.
- **Row-Level Security:** Students can only read/write their own `bookmarks` and `progress` rows. The question bank is read-only.
- **Admin tooling:** The `/admin` page lets the admin create/edit/delete questions and topics from the
  browser. Writes go through `security definer` database functions (`admin_upsert_question`,
  `admin_delete_question`, `admin_upsert_topic`, …) that check the admin email server-side, so there
  is no RLS write policy for students to exploit.

---

## License

This project is built for educational use by University of the Philippines students and instructors.
