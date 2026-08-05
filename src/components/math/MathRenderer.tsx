import ReactMarkdown from 'react-markdown';
import rehypeKatex from 'rehype-katex';
import remarkGfm from 'remark-gfm';
import remarkMath from 'remark-math';
import { cn } from '@/lib/cn';

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
}

export function MathRenderer({ children, className, preview = false }: MathRendererProps) {
  return (
    <div
      className={cn(
        'math-prose prose prose-stone max-w-none',
        'prose-headings:font-semibold prose-p:my-2 prose-ul:my-2 prose-ol:my-2 prose-li:my-1',
        preview && 'text-sm prose-sm',
        'dark:prose-invert',
        className,
      )}
    >
      <ReactMarkdown
        remarkPlugins={[remarkMath, remarkGfm]}
        rehypePlugins={[[rehypeKatex, { throwOnError: false }]]}
      >
        {children}
      </ReactMarkdown>
    </div>
  );
}
