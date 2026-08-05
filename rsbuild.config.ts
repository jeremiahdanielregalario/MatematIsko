import { defineConfig } from '@rsbuild/core';
import { pluginReact } from '@rsbuild/plugin-react';

// Rsbuild exposes `PUBLIC_*` env vars to client code by default.
// We follow the Vite convention (`VITE_*`) instead, so map them explicitly.
// Values come from the process environment, which Rsbuild's loadEnv has
// already populated from `.env` files before this config is evaluated.
const env = (key: string) => JSON.stringify(process.env[key] ?? '');

export default defineConfig({
  plugins: [pluginReact()],
  source: {
    define: {
      'process.env.VITE_SUPABASE_URL': env('VITE_SUPABASE_URL'),
      'process.env.VITE_SUPABASE_ANON_KEY': env('VITE_SUPABASE_ANON_KEY'),
    },
  },
  resolve: {
    alias: {
      '@': './src',
    },
  },
  html: {
    title: 'MatematIsko',
    favicon: './public/favicon.svg',
    meta: {
      description:
        'MatematIsko is an interactive mathematics exam-review platform for UP students. Browse, practice, and master calculus, linear algebra, and more.',
      viewport: 'width=device-width, initial-scale=1.0, viewport-fit=cover',
    },
  },
  server: {
    port: 3000,
  },
  output: {
    assetPrefix: '/',
  },
});
