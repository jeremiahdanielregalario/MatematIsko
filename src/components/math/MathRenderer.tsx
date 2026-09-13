import { useEffect, useMemo, useRef } from 'react';
import { GraphBlock } from './FunctionGraph';
import ReactMarkdown from 'react-markdown';
import rehypeKatex from 'rehype-katex';
import remarkGfm from 'remark-gfm';
import remarkMath from 'remark-math';
import { remarkDisplayMath } from './remarkDisplayMath';
import { remarkNoteEnvironments, type NoteEnvironmentOptions } from './remarkNoteEnvironments';
import { cn } from '@/lib/cn';
import { decodeUnicodeEscapes } from '@/lib/unicode';

interface MathRendererProps {
  /**
   * Markdown + LaTeX source. Inline math uses `$...$`,
   * display math uses `$$...$$`. Rendered safely via
   * react-markdown (no raw HTML is emitted) + KaTeX.
   */
  children: string;
  className?: string;
  /** Compact size used for card previews. */
  preview?: boolean;
  noteEnvironments?: NoteEnvironmentOptions;
  /**
   * Render as inline content inside a heading/link.
   * Uses a `<span>` wrapper without block prose classes.
   */
  inline?: boolean;
}

export function MathRenderer({
  children,
  className,
  preview = false,
  inline = false,
  noteEnvironments,
}: MathRendererProps) {
  const source = useMemo(() => decodeUnicodeEscapes(children), [children]);
  const rootRef = useRef<HTMLDivElement & HTMLSpanElement>(null);

  useEffect(() => {
    const root = rootRef.current;
    if (!root) return;

    const equations = Array.from(root.querySelectorAll<HTMLElement>('.katex'));
    const updateOverflow = () => {
      for (const equation of equations) {
        const content = equation.querySelector<HTMLElement>('.katex-html');
        const container = equation.parentElement?.classList.contains('katex-display')
          ? equation.parentElement
          : equation;
        if (content && container) {
          container.classList.toggle(
            'math-overflow',
            content.getBoundingClientRect().width > container.getBoundingClientRect().width + 1,
          );
        }
      }
    };

    updateOverflow();
    if (typeof ResizeObserver === 'undefined') return;
    let frame = 0;
    const observer = new ResizeObserver(() => {
      cancelAnimationFrame(frame);
      frame = requestAnimationFrame(updateOverflow);
    });
    observer.observe(root);
    for (const equation of equations) {
      observer.observe(equation);
      const content = equation.querySelector('.katex-html');
      if (content) observer.observe(content);
    }
    return () => {
      observer.disconnect();
      cancelAnimationFrame(frame);
    };
  }, [source, inline]);

  const Wrapper = inline ? 'span' : 'div';

  return (
    <Wrapper
      ref={rootRef}
      className={cn(
        'math-prose',
        !inline &&
          'prose prose-stone max-w-none prose-headings:font-semibold prose-p:my-2 prose-ul:my-2 prose-ol:my-2 prose-li:my-1',
        !inline && 'dark:prose-invert',
        preview && 'text-sm prose-sm',
        className,
      )}
    >
      <ReactMarkdown
        remarkPlugins={[
          remarkMath,
          remarkGfm,
          remarkDisplayMath,
          ...(noteEnvironments
            ? [
                [remarkNoteEnvironments, noteEnvironments] as [
                  typeof remarkNoteEnvironments,
                  NoteEnvironmentOptions,
                ],
              ]
            : []),
        ]}
        rehypePlugins={[[rehypeKatex, { throwOnError: false }]]}
        disallowedElements={
          inline
            ? [
                'p',
                'a',
                'h1',
                'h2',
                'h3',
                'h4',
                'h5',
                'h6',
                'div',
                'pre',
                'blockquote',
                'ul',
                'ol',
                'li',
                'table',
                'thead',
                'tbody',
                'tr',
                'th',
                'td',
                'hr',
                'img',
                'input',
              ]
            : undefined
        }
        unwrapDisallowed={inline}
        components={
          inline
            ? { p: 'span' }
            : {
                pre: ({ node, children, ...props }) => {
                  const code = node?.children[0];
                  if (
                    code?.type === 'element' &&
                    code.tagName === 'code' &&
                    Array.isArray(code.properties.className) &&
                    code.properties.className.includes('language-graph')
                  ) {
                    const source = code.children
                      .filter((child) => child.type === 'text')
                      .map((child) => child.value)
                      .join('');
                    return <GraphBlock source={source} preview={preview} />;
                  }
                  return <pre {...props}>{children}</pre>;
                },
                table: ({ children }) => (
                  <div
                    className="overflow-x-auto"
                    role="region"
                    aria-label="Scrollable table"
                    tabIndex={0}
                  >
                    <table>{children}</table>
                  </div>
                ),
              }
        }
      >
        {source}
      </ReactMarkdown>
    </Wrapper>
  );
}
