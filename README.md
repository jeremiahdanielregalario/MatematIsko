# MatematIsko

**Review smarter. Solve better.**

MatematIsko is a mathematics exam-review platform built for University of the Philippines students. It brings course questions, worked solutions, theorems, notes, and timed review into one study space.

The study flow is simple: attempt a problem, use support when you need it, reflect on your understanding, and return to the topics that need more work.

[Features](#features) · [Getting started](#getting-started) · [Development](#development) · [Data and security](#data-and-security) · [Contributing](#contributing)

## Features

| Study tool | What you can do |
| --- | --- |
| Course question bank | Browse and filter problems by course, topic, difficulty, exam year, and study status. |
| Guided review | Reveal hints, answers, and worked solutions progressively after attempting a question. |
| Quiz & exam | Build a full paper from selected topics or a random mix, choose 1–30 questions, and set a 5–90-minute timer. |
| Post-exam review | Finish the paper before revealing answers, self-check your work, and retry missed or uncertain questions. |
| Bookmarks and mastery | Save problems and record which ones you are learning or have mastered. |
| Theorem study | Read theorem statements and formal notation, or review with flashcards. |
| Course notes | Read mathematical articles with a contents menu, adjustable text size, and previous/next navigation. |
| Study dashboard | See your study progress and find a starting point for your next review session. |
| Community writing | Read published articles and submit writing for moderation. |

Mathematics is rendered with KaTeX. The interface supports mobile and desktop layouts, light and dark themes, and keyboard navigation. Long equations scroll when they exceed the available width.

### Two ways to practice

**Guided practice** works through questions individually, with hints and solutions available along the way. The `H`, `A`, and `S` shortcuts reveal support on compatible study screens and are suppressed while typing or using dialogs.

**Quiz & exam** presents the entire paper so you can work in any order, write optional notes, and flag questions to revisit. Responses lock when the timer expires or you confirm that you are done. Answers remain hidden until you explicitly reveal them. The current paper survives refreshes in the same browser tab; it is not synced across devices.

Questions are selected from the existing question bank. Results are self-assessed, not automatically graded. Exam self-checks do not change mastery records. Exam answer locking is a study aid, not a proctoring or anti-cheating system.

## Technology

| Area | Tools |
| --- | --- |
| Interface | React 19, TypeScript 6, Tailwind CSS 4, Radix UI, Lucide |
| Build and routing | Rsbuild, React Router |
| Mathematical content | React Markdown, remark-math, remark-gfm, rehype-katex |
| Authentication and data | Supabase Auth and PostgreSQL |
| Testing and quality | Vitest, Testing Library, ESLint, Prettier |
| Deployment | Static SPA with Vercel configuration |

The browser communicates directly with Supabase. Database policies and privileged functions enforce access; there is no separate application server in this repository.

## Getting started

You can read the source without a Supabase account. To run the complete application, use **your own development Supabase project**, separate from the production service.

### 1. Install dependencies

Install a current Node.js LTS release and npm. From a local copy of the repository:

```bash
npm install
```

### 2. Configure the application

Copy `.env.example` to `.env` and supply your development project's public configuration:

```dotenv
VITE_SUPABASE_URL=https://your-project.supabase.co
VITE_SUPABASE_ANON_KEY=your-public-anon-or-publishable-key
```

These variable names are retained for compatibility. Rsbuild explicitly maps them into the browser build in [rsbuild.config.ts](rsbuild.config.ts).

Use only a public anon/publishable key. Never put a Supabase secret key, `service_role` key, database password, or OAuth client secret in either variable. See [Supabase's API-key guide](https://supabase.com/docs/guides/getting-started/api-keys).

### 3. Prepare your development database

The Supabase CLI is included as a pinned development dependency. For a new, disposable development project:

```bash
npx supabase login
npx supabase link --project-ref YOUR_DEVELOPMENT_PROJECT_REF
npm run db:status
npm run db:push
```

`db:push` changes the linked remote database. Review the ordered files in [supabase/migrations](supabase/migrations) before applying them: they contain schema, access policies, functions, and seeded study content. Do not point a contributor setup at production.

For an existing database, inspect its migration history before proceeding. Do not mark migrations as applied merely because tables already exist. An optional local Supabase stack is configured in [supabase/config.toml](supabase/config.toml) and requires Docker.

### 4. Configure sign-in

The application supports Google OAuth and email/password sign-in. Its current access rules target `up.edu.ph` accounts, with an explicit administrator exception. A separate deployment must review both the application access rules and database authentication/admin functions before adopting different account rules.

For Google sign-in:

1. Enable Google in your development project's Supabase authentication settings.
2. Configure the Google OAuth client with the **Supabase Auth callback URL** shown by Supabase, typically `https://YOUR_PROJECT_REF.supabase.co/auth/v1/callback`.
3. Keep the Google client secret in the Supabase provider settings.
4. Set the Supabase development Site URL to `http://localhost:3000` and allow `http://localhost:3000/auth/callback` as an application redirect.

The Google-to-Supabase callback and Supabase-to-application redirect are different URLs. Follow the [Supabase Google sign-in guide](https://supabase.com/docs/guides/auth/social-login/auth-google) for provider configuration.

### 5. Start the application

```bash
npm run dev
```

Open [localhost:3000](http://localhost:3000). Without Supabase configuration, authenticated study features are unavailable; the repository does not include a complete standalone demo database.

## Development

| Command | Purpose |
| --- | --- |
| `npm run dev` | Start the development server. |
| `npm run typecheck` | Check TypeScript types. |
| `npm run lint` | Run ESLint. |
| `npm test` | Run the test suite with coverage. |
| `npm run format:check` | Check source formatting. |
| `npm run format` | Format source files. |
| `npm run build` | Build the application into `dist/`. |
| `npm run preview` | Preview the production build. |
| `npm run db:new -- descriptive_name` | Create a new SQL migration. |
| `npm run db:status` | Inspect migration status. |
| `npm run db:push` | Apply pending migrations to the linked remote database. |
| `npm run db:reset` | Destructively rebuild the local development database. |

Use the admin interface for routine content editing. Use new migrations for schema changes and scripted content batches. **Never edit an already-applied migration.** Preserve question and theorem IDs so content updates do not disconnect students' study records.

### Project structure

```text
src/
  components/    Shared UI, math rendering, and study components
  features/      Authentication, guided practice, and quiz/exam workflows
  hooks/         Data loading, authentication, course scope, and study state
  lib/           Database access and domain helpers
  pages/         Route-level screens
  types/         Shared domain types
supabase/
  migrations/    Ordered schema, policy, function, and content history
public/          Static assets and service worker
```

For deeper implementation context, read [PROJECT_MEMORY.md](PROJECT_MEMORY.md). [APP_REVIEW.md](APP_REVIEW.md) records review findings and verification limits. These documents distinguish implemented behavior from future work.

## Data and security

**Public source code does not grant access to the hosted Supabase dashboard or unrestricted access to live student records.** Database access depends on authentication, grants, Row Level Security (RLS), and database functions. The project's URL and public client key are visible in a running browser application; hiding them is not a substitute for access controls. See [Supabase's data-security guide](https://supabase.com/docs/guides/database/secure-data).

There are two different kinds of data to consider:

- **Repository content:** SQL migrations include database structure and seeded questions, answers, solutions, and other study material. Anything committed to a public repository, including its accessible Git history, can be read and copied. A public repository cannot contain a private folder.
- **Hosted records:** Account profiles, bookmarks, progress, reports, and other live records remain in Supabase. Do not add database exports, credentials, or student records to source control, issues, screenshots, or test fixtures.

If database definitions or seeded material must remain private, keep them in a separate private repository and prepare a reviewed public source snapshot with synthetic examples. Adding existing files to `.gitignore` does not remove them from earlier commits. Review history before changing visibility; rotate any exposed privileged credentials. GitHub documents [removing sensitive repository data](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository).

Migration files describe intended access controls, not proof of the deployed database's state. Known permission gaps remain recorded in the project memory. Test policies and functions with anonymous, student, and administrator accounts in a disposable environment before relying on them for a public deployment. Never include exploit details or private data in a public issue; use GitHub's private vulnerability reporting if the repository has enabled it.

## Deployment

[vercel.json](vercel.json) configures `npm run build`, the `dist/` output directory, and SPA routing. Configure the two public Supabase environment variables in the deployment project, and add the deployed application's `/auth/callback` URL to Supabase's allowed redirects.

Frontend deployment and database migrations are separate operations. Verify the intended database and migration status before applying SQL. The service worker caches a small set of public assets; full offline study is not supported.

## Contributing

Bug reports, usability feedback, and focused improvements are welcome. Include the affected page, reproduction steps, expected behavior, and device/browser details. Use synthetic examples rather than student data.

Before changing code, read [AGENTS.md](AGENTS.md) and [PROJECT_MEMORY.md](PROJECT_MEMORY.md). Keep mathematics readable, preserve stable content IDs and user-data boundaries, and update the project memory when behavior or architecture changes. Run the checks relevant to your change and state what you verified.

## License and educational content

This repository does not currently include a license file. Public visibility is not an open-source license; no additional reuse license is granted by this README. See [GitHub's explanation of repository licensing](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/licensing-a-repository).

Review the source and permissions of educational materials separately before redistributing them. Repository visibility alone does not establish ownership or permission to reuse course or exam content.
