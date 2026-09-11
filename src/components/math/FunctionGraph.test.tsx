import { render, screen, fireEvent } from '@testing-library/react';
import { expect, it, vi } from 'vitest';
import { MathRenderer } from './MathRenderer';
import { GraphBuilder } from '@/components/admin/GraphBuilder';
import { graphMarkdown, LIMIT_GRAPH, parseGraph } from '@/lib/graph';

it('renders graph Markdown as an accessible figure, alongside ordinary math', () => {
  const { container } = render(<MathRenderer>{'$x^2$' + graphMarkdown(LIMIT_GRAPH)}</MathRenderer>);
  expect(screen.getByRole('img', { name: /Graph of f/ })).toBeInTheDocument();
  expect(container.querySelector('.katex')).toBeInTheDocument();
  expect(container.querySelectorAll('circle')).toHaveLength(3);
  expect(container.querySelector('pre')).toBeNull();
  fireEvent.click(screen.getByRole('button', { name: 'Read graph description' }));
  expect(screen.getByText(LIMIT_GRAPH.description, { selector: 'p' })).toBeInTheDocument();
});

it('keeps card previews compact and malformed graphs recoverable', () => {
  const { rerender } = render(<MathRenderer preview>{graphMarkdown(LIMIT_GRAPH)}</MathRenderer>);
  expect(screen.queryByRole('img')).toBeNull();
  expect(screen.getByText(/Graph included/)).toBeInTheDocument();
  rerender(<MathRenderer>{'Before\n\n```graph\n{}\n```\n\nAfter'}</MathRenderer>);
  expect(screen.getByRole('status')).toHaveTextContent('Graph unavailable');
  expect(screen.getByText('After')).toBeInTheDocument();
});

it('inserts a valid graph and blocks invalid formulas', () => {
  const onInsert = vi.fn();
  render(<GraphBuilder onInsert={onInsert} />);
  fireEvent.click(screen.getByText('Add a graph to this problem'));
  fireEvent.click(screen.getByRole('button', { name: 'Insert graph into question' }));
  expect(
    parseGraph(onInsert.mock.calls[0][0].split('```graph\n')[1].split('\n```')[0]),
  ).toMatchObject(LIMIT_GRAPH);
  fireEvent.change(screen.getByLabelText('Formula 1'), { target: { value: 'window.alert(1)' } });
  expect(screen.getByRole('button', { name: 'Insert graph into question' })).toBeDisabled();
  fireEvent.click(screen.getByRole('button', { name: 'Vertical asymptote' }));
  expect(screen.getByRole('button', { name: 'Insert graph into question' })).toBeEnabled();
});
