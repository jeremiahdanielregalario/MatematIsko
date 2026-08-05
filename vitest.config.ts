import { fileURLToPath } from 'node:url';
import { defineConfig } from 'vitest/config';

export default defineConfig({
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  test: {
    environment: 'jsdom',
    globals: true,
    setupFiles: ['./src/test/setup.ts'],
    include: ['src/**/*.test.{ts,tsx}'],
    coverage: {
      provider: 'v8',
      reporter: ['text', 'json', 'html'],
      include: [
        'src/lib/**/*.{ts,tsx}',
        'src/hooks/useReveal.ts',
        'src/hooks/useDebounce.ts',
        'src/hooks/useAsync.ts',
        'src/hooks/useRevealKeyboard.ts',
      ],
      exclude: [
        'src/lib/**/__tests__/**',
        'src/lib/db.ts',
        'src/lib/supabase.ts',
        'src/lib/constants.ts',
      ],
      thresholds: {
        lines: 80,
        functions: 80,
        statements: 80,
        branches: 75,
      },
    },
  },
});
