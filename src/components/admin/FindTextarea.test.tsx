import { fireEvent, render, screen, within } from '@testing-library/react';
import { useState } from 'react';
import { describe, expect, it } from 'vitest';
import { FindTextarea } from './FindTextarea';

function Editor({ initial = 'Alpha beta ALPHA' }: { initial?: string }) {
  const [value, setValue] = useState(initial);
  return (
    <FindTextarea aria-label="Source" value={value} onChange={(e) => setValue(e.target.value)} />
  );
}
function find(query: string) {
  fireEvent.click(screen.getByRole('button', { name: 'Find' }));
  fireEvent.change(screen.getByRole('textbox', { name: 'Find in Markdown' }), {
    target: { value: query },
  });
}
describe('FindTextarea', () => {
  it('finds literal text ignoring case, selects matches and wraps both directions without edits', () => {
    render(<Editor />);
    find('alpha');
    const source = screen.getByRole('textbox', { name: 'Source' }) as HTMLTextAreaElement;
    expect(screen.getByRole('status')).toHaveTextContent('1 of 2');
    expect([source.selectionStart, source.selectionEnd]).toEqual([0, 5]);
    fireEvent.click(screen.getByRole('button', { name: 'Previous' }));
    expect([source.selectionStart, source.selectionEnd]).toEqual([11, 16]);
    fireEvent.click(screen.getByRole('button', { name: 'Next' }));
    expect(screen.getByRole('status')).toHaveTextContent('1 of 2');
    expect(source).toHaveValue('Alpha beta ALPHA');
  });
  it('treats LaTeX and regex characters literally and updates after source edits', () => {
    render(<Editor initial={'Text \\frac{x}{y} and [a].*'} />);
    find('\\frac{x}{y}');
    expect(screen.getByRole('status')).toHaveTextContent('1 of 1');
    fireEvent.change(screen.getByRole('textbox', { name: 'Source' }), {
      target: { value: 'Removed' },
    });
    expect(screen.getByRole('status')).toHaveTextContent('No matches');
    expect(screen.getByRole('button', { name: 'Next' })).toBeDisabled();
    fireEvent.change(screen.getByRole('textbox', { name: 'Find in Markdown' }), {
      target: { value: '' },
    });
    expect(screen.getByRole('status')).toHaveTextContent('Enter text to find');
  });
  it('supports local shortcuts, selected text, Enter navigation and Escape', () => {
    render(<Editor />);
    const source = screen.getByRole('textbox', { name: 'Source' }) as HTMLTextAreaElement;
    source.setSelectionRange(0, 5);
    fireEvent.keyDown(source, { key: 'f', metaKey: true });
    const search = screen.getByRole('textbox', { name: 'Find in Markdown' });
    expect(search).toHaveValue('Alpha');
    search.focus();
    fireEvent.keyDown(search, { key: 'Enter' });
    expect(screen.getByRole('status')).toHaveTextContent('2 of 2');
    expect(search).toHaveFocus();
    fireEvent.keyDown(search, { key: 'Enter', shiftKey: true });
    expect(screen.getByRole('status')).toHaveTextContent('1 of 2');
    fireEvent.keyDown(search, { key: 'Escape' });
    expect(screen.queryByRole('status')).not.toBeInTheDocument();
    expect(source).toHaveFocus();
  });
  it('keeps searches independent across editors', () => {
    render(
      <>
        <div data-testid="first">
          <Editor />
        </div>
        <div data-testid="second">
          <Editor />
        </div>
      </>,
    );
    const first = within(screen.getByTestId('first'));
    fireEvent.click(first.getByRole('button', { name: 'Find' }));
    fireEvent.change(first.getByRole('textbox', { name: 'Find in Markdown' }), {
      target: { value: 'beta' },
    });
    expect(first.getByRole('status')).toHaveTextContent('1 of 1');
    expect(within(screen.getByTestId('second')).queryByRole('status')).not.toBeInTheDocument();
  });
});
