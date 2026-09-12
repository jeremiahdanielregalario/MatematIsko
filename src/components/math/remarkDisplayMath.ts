// remark-math treats same-line double-dollar math as inlineMath. Preserve the
// author's display intent without rewriting Markdown/code or stored content.
interface MathNode {
  type: string;
  children?: MathNode[];
  position?: { start: { offset?: number }; end: { offset?: number } };
  data?: { hProperties?: Record<string, unknown>; [key: string]: unknown };
}

export function remarkDisplayMath() {
  return (tree: MathNode, file: { value: unknown }) => {
    const source = String(file.value);
    const visit = (node: MathNode) => {
      if (node.type === 'inlineMath') {
        const start = node.position?.start.offset;
        const end = node.position?.end.offset;
        const raw = start === undefined || end === undefined ? '' : source.slice(start, end);
        if (raw.startsWith('$$') && !raw.startsWith('$$$') && raw.endsWith('$$')) {
          node.data = {
            ...node.data,
            hProperties: {
              ...node.data?.hProperties,
              className: ['language-math', 'math-display'],
            },
          };
        }
      }
      node.children?.forEach(visit);
    };
    visit(tree);
  };
}
