import { useMemo } from 'react';
import ReactMarkdown from 'react-markdown';
import rehypeKatex from 'rehype-katex';
import remarkGfm from 'remark-gfm';
import remarkMath from 'remark-math';
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
}: MathRendererProps) {
  const source = useMemo(() => decodeUnicodeEscapes(children), [children]);

  const Wrapper = inline ? 'span' : 'div';

  return (
    <Wrapper
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
        remarkPlugins={[remarkMath, remarkGfm]}
        rehypePlugins={[[rehypeKatex, { throwOnError: false }]]}
        components={inline ? { p: 'span' } : undefined}
      >
        {source}
      </ReactMarkdown>
    </Wrapper>
  );
}
