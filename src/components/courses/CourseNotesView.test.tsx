import { render, screen, fireEvent } from '@testing-library/react';
import { expect, it, vi } from 'vitest';
import { CourseNotesView } from './CourseNotesView';
import type { CourseNote } from '@/types';

const note: CourseNote = {
  id: 'sample',
  course_id: 'math',
  title: 'Limits and continuity',
  content:
    '# Overview\n\n## Theorem 1.3\n\nFor $x>0$, consider $f(x)$.\n\n## Repeated\n\nFirst.\n\n## Repeated\n\nSecond.\n\n```text\n# Not a section\n```',
  sort_order: 1,
  created_at: '',
  updated_at: '',
};

it('preserves heading levels, theorem numbers and unique contents targets', () => {
  const { container } = render(<CourseNotesView notes={[note]} />);
  expect(screen.getByRole('heading', { name: 'Overview', level: 1 })).toBeInTheDocument();
  expect(screen.getByRole('heading', { name: 'Theorem 1.3', level: 2 })).toBeInTheDocument();
  const repeated = screen.getAllByRole('heading', { name: 'Repeated' });
  expect(repeated[0].id).not.toBe(repeated[1].id);
  expect(container.querySelectorAll('.note-reading [id]')).toHaveLength(4);
  expect(screen.queryByRole('heading', { name: 'Not a section' })).not.toBeInTheDocument();
  expect(container.querySelector('.katex')).toBeInTheDocument();
});

it('changes text size and navigates to a focused heading', () => {
  const scroll = vi.fn();
  const { container } = render(<CourseNotesView notes={[note]} />);
  fireEvent.click(screen.getByRole('button', { name: 'Larger text' }));
  expect(container.querySelector('.note-reading')).toHaveClass('note-reading-large');
  const heading = screen.getByRole('heading', { name: 'Theorem 1.3' });
  heading.scrollIntoView = scroll;
  fireEvent.click(screen.getAllByRole('button', { name: 'Theorem 1.3' })[0]);
  expect(heading).toHaveFocus();
  expect(scroll).toHaveBeenCalled();
  const progress = screen.getByRole('progressbar');
  expect(Number(progress.getAttribute('aria-valuenow'))).toBeGreaterThanOrEqual(0);
});
