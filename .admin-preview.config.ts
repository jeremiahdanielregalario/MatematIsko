import {defineConfig} from '@rsbuild/core';
import {pluginReact} from '@rsbuild/plugin-react';
export default defineConfig({plugins:[pluginReact()],source:{entry:{index:'./.admin-preview.tsx'},define:{'process.env.VITE_SUPABASE_URL':'""','process.env.VITE_SUPABASE_ANON_KEY':'""'}},resolve:{alias:{'@/hooks/useAuth':'./.admin-preview-auth.ts','@/lib/adminUsers':'./.admin-preview-api.ts','@':'./src'}},server:{port:3006}});
