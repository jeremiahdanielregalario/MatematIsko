import { fireEvent, render, screen } from '@testing-library/react';
import { useState } from 'react';
import { describe, expect, it } from 'vitest';
import { MathEditor } from './MathEditor';
function Editor({ initial = '' }: { initial?: string }) {
  const [value, setValue] = useState(initial);
  return <MathEditor label="Solution" value={value} onChange={setValue} />;
}
describe('MathEditor', () => {
  it('wraps selected source without replacing surrounding content', () => {
    render(<Editor initial="Find x now" />);
    const input = screen.getByRole('textbox') as HTMLTextAreaElement;
    input.setSelectionRange(5, 6);
    fireEvent.click(screen.getByRole('button', { name: 'Inline math' }));
    expect(input.value).toBe('Find $x$ now');
  });
  it('reports rendering errors and clears them after correction', () => {
    render(<Editor initial={'$\\notacommand{x}$'} />);
    expect(screen.getByRole('status')).toHaveTextContent('Check 1 equation');
    fireEvent.change(screen.getByRole('textbox'), { target: { value: '$x^2$' } });
    expect(screen.queryByRole('status')).not.toBeInTheDocument();
    expect(document.querySelector('.katex')).toBeInTheDocument();
  });
  it('actually hides the preview when requested', () => {
    render(<MathEditor label="Answer" value="$x$" onChange={() => {}} showPreview={false} />);
    expect(screen.queryByText('Live student preview')).not.toBeInTheDocument();
    expect(screen.getByRole('textbox')).toHaveValue('$x$');
  });
});
