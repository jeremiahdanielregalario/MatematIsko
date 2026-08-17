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
      'theme-color': '#7b1113',
      'apple-mobile-web-app-capable': 'yes',
      'apple-mobile-web-app-status-bar-style': 'black-translucent',
      'apple-mobile-web-app-title': 'MatematIsko',
    },
    tags: [
      {
        tag: 'link',
        attrs: {
          rel: 'manifest',
          href: '/manifest.json',
        },
      },
      {
        tag: 'link',
        attrs: {
          rel: 'apple-touch-icon',
          href: '/icons/icon.svg',
        },
      },
    ],
  },
  server: {
    port: 3000,
  },
  output: {
    assetPrefix: '/',
  },
});
