import { render } from '@testing-library/react';
import { describe, expect, it } from 'vitest';
import { MathRenderer } from './MathRenderer';

describe('MathRenderer', () => {
  it('renders a block div by default', () => {
    const { container } = render(<MathRenderer>Factor the numerator.</MathRenderer>);
    expect(container.firstElementChild?.tagName).toBe('DIV');
  });

  it('renders a span when inline', () => {
    const { container } = render(<MathRenderer inline>Factor the numerator.</MathRenderer>);
    expect(container.firstElementChild?.tagName).toBe('SPAN');
  });

  it('decodes Unicode escape sequences before rendering', () => {
    const { container } = render(
      <MathRenderer inline>
        {'Is \\u27E8 3 \\u27E9 a Maximal or Prime Ideal of \\u2124_12?'}
      </MathRenderer>,
    );
    const text = container.textContent ?? '';
    expect(text).toContain('\u27E8');
    expect(text).toContain('\u27E9');
    expect(text).toContain('\u2124');
    expect(text).not.toContain('\\u27E8');
    expect(text).not.toContain('\\u2124');
  });

  it('decodes multiplication and element-of signs', () => {
    const { container } = render(
      <MathRenderer inline>{'S = \\u2124 \\u00D7 \\u2124 contains a \\u2208'}</MathRenderer>,
    );
    const text = container.textContent ?? '';
    expect(text).toContain('\u00D7');
    expect(text).toContain('\u2208');
    expect(text).not.toContain('\\u00D7');
  });

  it('renders KaTeX math in display mode', () => {
    render(<MathRenderer>$$x^2$$</MathRenderer>);
    expect(document.querySelector('.katex')).toBeInTheDocument();
  });

  it('renders a multi-line aligned display math block', () => {
    const src =
      "$$\n\\begin{aligned}\nf'(2) &= \\lim_{h \\to 0} \\frac{f(2 + h) - f(2)}{h} \\\\\n     &= \\lim_{h \\to 0} \\frac{(2 + h)^3 - 8}{h}.\n\\end{aligned}\n$$";
    const { container } = render(<MathRenderer>{src}</MathRenderer>);
    expect(container.querySelector('.katex-display')).toBeInTheDocument();
  });
});

it('keeps Markdown titles valid inside links while preserving accessible math', () => {
  const { container } = render(
    <a href="/questions/example">
      <MathRenderer inline>
        {'# Find [the limit](https://example.com) $\\frac{x^2}{2}$'}
      </MathRenderer>
    </a>,
  );
  expect(container.querySelectorAll('a')).toHaveLength(1);
  expect(container.querySelector('h1, p, div, pre')).toBeNull();
  expect(container.querySelector('.katex math')).not.toBeNull();
  expect(container.textContent).toContain('the limit');
});

it('puts wide tables in a keyboard-accessible scroll region', () => {
  const { getByRole } = render(<MathRenderer>{'| x | f(x) |\n|---|---|\n| 1 | 2 |'}</MathRenderer>);
  const region = getByRole('region', { name: 'Scrollable table' });
  expect(region).toHaveAttribute('tabindex', '0');
  expect(region.querySelector('table')).toBeInTheDocument();
});
