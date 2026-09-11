import { defineConfig } from '@rsbuild/core';
import { pluginReact } from '@rsbuild/plugin-react';
export default defineConfig({ plugins: [pluginReact()], source: { entry: { index: './.graph-preview.tsx' } }, resolve: { alias: { '@': './src' } }, server: { port: 3003 } });
