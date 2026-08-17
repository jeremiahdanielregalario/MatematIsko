import type { Plugin } from 'unified';
import type { Root, Code, Html } from 'mdast';

const VIZ_LANGUAGES = new Set(['polar', 'parametric', 'surface3d']);

/**
 * Remark plugin that transforms fenced code blocks with math-visualization
 * language tags (`polar`, `parametric`, `surface3d`) into custom MDX-like
 * elements that react-markdown can render via its `components` prop.
 *
 * The code block body must be valid JSON describing the plot configuration.
 *
 * Transform:
 *   ```polar
 *   { "curves": [...] }
 *   ```
 * ↓
 *   <div data-math-viz="polar" data-config='{ "curves": [...] }' />
 */
export const remarkMathViz: Plugin<[], Root> = () => {
  return (tree: Root) => {
    for (let i = tree.children.length - 1; i >= 0; i--) {
      const node = tree.children[i];
      if (node.type !== 'code') continue;
      const code = node as Code;
      if (!code.lang || !VIZ_LANGUAGES.has(code.lang)) continue;

      tree.children[i] = {
        type: 'html',
        value: `<div data-math-viz="${code.lang}" data-config="${escapeAttr(code.value ?? '')}"></div>`,
      } as Html;
    }
  };
};

function escapeAttr(s: string): string {
  return s
    .replace(/&/g, '&amp;')
    .replace(/"/g, '&quot;')
    .replace(/</g, '&lt;')
    .replace(/>/g, '&gt;');
}
