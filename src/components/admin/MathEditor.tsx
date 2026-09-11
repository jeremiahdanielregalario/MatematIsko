import katex from 'katex';
import { useEffect, useId, useRef, useState } from 'react';
import { MathRenderer } from '@/components/math/MathRenderer';
import { Button } from '@/components/ui/button';
import { Label } from '@/components/ui/label';
import { Textarea } from '@/components/ui/textarea';

interface Props {
  label: string;
  value: string;
  onChange: (value: string) => void;
  showPreview?: boolean;
}
const snippets = [
  ['Inline math', '$', '$', 'x^2'],
  ['Display math', '\n$$\n', '\n$$\n', 'x^2'],
  ['Fraction', '\\frac{', '}{b}', 'a'],
  ['Square root', '\\sqrt{', '}', 'x'],
  [
    'Aligned equations',
    '\n$$\n\\begin{aligned}\n',
    '\n\\end{aligned}\n$$\n',
    'a &= b \\\\\nc &= d',
  ],
];

export function MathEditor({ label, value, onChange, showPreview = true }: Props) {
  const id = useId();
  const input = useRef<HTMLTextAreaElement>(null);
  const preview = useRef<HTMLDivElement>(null);
  const [errors, setErrors] = useState<string[]>([]);
  useEffect(() => {
    const issues = Array.from(preview.current?.querySelectorAll('.katex-error') ?? []).map(
      (el) => el.getAttribute('title') ?? 'Invalid equation',
    );
    for (const annotation of preview.current?.querySelectorAll(
      'annotation[encoding="application/x-tex"]',
    ) ?? []) {
      try {
        katex.renderToString(annotation.textContent ?? '', { throwOnError: true });
      } catch (error) {
        issues.push(error instanceof Error ? error.message : String(error));
      }
    }
    setErrors([...new Set(issues)]);
  }, [value, showPreview]);
  const insert = (prefix: string, suffix: string, fallback: string) => {
    const start = input.current?.selectionStart ?? value.length;
    const end = input.current?.selectionEnd ?? start;
    const selected = value.slice(start, end) || fallback;
    onChange(value.slice(0, start) + prefix + selected + suffix + value.slice(end));
    requestAnimationFrame(() => {
      input.current?.focus();
      input.current?.setSelectionRange(
        start + prefix.length,
        start + prefix.length + selected.length,
      );
    });
  };
  return (
    <section className="min-w-0 space-y-2 rounded-xl border border-stone-200 p-3 dark:border-stone-700">
      <Label htmlFor={id}>{label}</Label>
      <div className="flex flex-wrap gap-1" role="group" aria-label={`${label} equation tools`}>
        {snippets.map(([name, prefix, suffix, fallback]) => (
          <Button
            key={name}
            type="button"
            variant="outline"
            size="sm"
            onClick={() => insert(prefix, suffix, fallback)}
          >
            {name}
          </Button>
        ))}
      </div>
      <div className={showPreview ? 'grid min-w-0 gap-3 xl:grid-cols-2' : ''}>
        <div className="min-w-0 space-y-2">
          <p className="text-xs text-stone-500">Markdown source</p>
          <Textarea
            ref={input}
            id={id}
            value={value}
            onChange={(e) => onChange(e.target.value)}
            spellCheck={false}
            className="min-h-44 resize-y font-mono text-sm leading-relaxed"
            aria-describedby={`${id}-help`}
          />
        </div>
        {showPreview && (
          <div className="min-w-0 space-y-2">
            <p className="text-xs text-stone-500">Live student preview</p>
            <div
              ref={preview}
              className="min-h-44 min-w-0 overflow-x-auto rounded-lg bg-stone-50 p-3 dark:bg-stone-950"
            >
              {value.trim() ? (
                <MathRenderer>{value}</MathRenderer>
              ) : (
                <p className="text-sm text-stone-500">Start typing to preview.</p>
              )}
            </div>
          </div>
        )}
      </div>
      <p id={`${id}-help`} className="text-xs text-stone-500">
        Use $…$ inline or $$…$$ on separate lines for display math. Insert fractions and roots
        inside math delimiters. Select source text to wrap it.
      </p>
      {errors.length > 0 && (
        <div
          role="status"
          className="rounded-lg bg-amber-50 p-3 text-sm text-amber-900 dark:bg-amber-950 dark:text-amber-200"
        >
          <p className="font-semibold">
            Check {errors.length} equation{errors.length === 1 ? '' : 's'}
          </p>
          {errors.map((error, index) => (
            <p key={index} className="mt-1 break-words font-mono text-xs">
              {error}
            </p>
          ))}
        </div>
      )}
    </section>
  );
}
