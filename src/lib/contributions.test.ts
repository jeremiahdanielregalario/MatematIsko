import { beforeEach, describe, expect, it, vi } from 'vitest';
const mocks = vi.hoisted(() => ({
  rpc: vi.fn(),
  from: vi.fn(),
  query: { select: vi.fn(), order: vi.fn(), eq: vi.fn(), range: vi.fn() },
}));
vi.mock('./supabase', () => ({ supabase: { rpc: mocks.rpc, from: mocks.from } }));
import {
  listContributions,
  reviewContribution,
  submitContribution,
  validateContribution,
  type ContributionDraft,
} from './contributions';
const draft: ContributionDraft = {
  kind: 'note',
  course_id: 'course',
  title: 'Notes',
  payload: { content: 'A definition.' },
};
beforeEach(() => {
  vi.clearAllMocks();
  mocks.from.mockReturnValue(mocks.query);
  mocks.query.select.mockReturnValue(mocks.query);
  mocks.query.order.mockReturnValue(mocks.query);
  mocks.query.eq.mockReturnValue(mocks.query);
  mocks.query.range.mockResolvedValue({ data: [], error: null });
  mocks.rpc.mockResolvedValue({ data: { id: 'submission' }, error: null });
});
describe('contribution validation', () => {
  it('accepts correctly delimited notes and aligned equations', () => {
    expect(
      validateContribution({
        ...draft,
        payload: {
          content: 'Let $x=1$.\n\n$$\n\\begin{aligned}\ny &= x \\\\\n &= 1\n\\end{aligned}\n$$\n',
        },
      }),
    ).toBeNull();
  });
  it.each(['$$x$$', '$$\nx', '\\[x\\]', '$$\\nx\\n$$'])(
    'rejects malformed display math: %s',
    (content) => {
      expect(validateContribution({ ...draft, payload: { content } })).not.toBeNull();
    },
  );
  it('requires title, course, note content and an inline-only title', () => {
    expect(validateContribution({ ...draft, title: '' })).toBeTruthy();
    expect(validateContribution({ ...draft, course_id: '' })).toBeTruthy();
    expect(validateContribution({ ...draft, title: 'x'.repeat(301) })).toBeTruthy();
    expect(validateContribution({ ...draft, title: '$$x$$' })).toBeTruthy();
    expect(validateContribution({ ...draft, payload: { content: '' } })).toBeTruthy();
  });
  it('requires complete question metadata and answers', () => {
    const question: ContributionDraft = {
      kind: 'question',
      course_id: 'course',
      title: 'Question',
      payload: {
        topic_id: 'topic',
        question_text: 'Compute.',
        answer: '1',
        solution: 'Explanation.',
        hint: null,
        difficulty: 'easy',
        year: 2026,
        question_number: 1,
        exam_name: 'Original',
      },
    };
    expect(validateContribution(question)).toBeNull();
    expect(
      validateContribution({ ...question, payload: { ...question.payload, solution: '' } }),
    ).toBeTruthy();
    expect(
      validateContribution({ ...question, payload: { ...question.payload, year: 0 } }),
    ).toBeTruthy();
    expect(
      validateContribution({ ...question, payload: { ...question.payload, question_number: 1.5 } }),
    ).toBeTruthy();
  });
});
describe('contribution data access', () => {
  it('submits through the RPC without accepting caller approval fields', async () => {
    await expect(submitContribution('submission', draft)).resolves.toEqual({ id: 'submission' });
    expect(mocks.rpc).toHaveBeenCalledWith('submit_content_contribution', {
      p_id: 'submission',
      p_kind: 'note',
      p_course_id: 'course',
      p_title: 'Notes',
      p_payload: draft.payload,
    });
    await expect(submitContribution('submission', { ...draft, title: '' })).rejects.toThrow();
    expect(mocks.rpc).toHaveBeenCalledTimes(1);
  });
  it('bounds list reads and filters personal submissions by author', async () => {
    await listContributions({ authorId: 'writer', status: 'pending', page: 2 });
    expect(mocks.query.eq).toHaveBeenCalledWith('author_id', 'writer');
    expect(mocks.query.eq).toHaveBeenCalledWith('status', 'pending');
    expect(mocks.query.range).toHaveBeenCalledWith(40, 60);
    await listContributions({});
    expect(mocks.query.range).toHaveBeenLastCalledWith(0, 20);
  });
  it('submits admin decisions through the protected review RPC', async () => {
    await reviewContribution('submission', 'rejected', 'Add a proof.');
    expect(mocks.rpc).toHaveBeenCalledWith('admin_review_contribution', {
      p_id: 'submission',
      p_decision: 'rejected',
      p_review_note: 'Add a proof.',
    });
  });
  it('surfaces database failures for submit, list, and review', async () => {
    mocks.rpc.mockResolvedValue({ error: { message: 'Denied' } });
    mocks.query.range.mockResolvedValue({ error: { message: 'Denied' } });
    await expect(submitContribution('id', draft)).rejects.toThrow('Denied');
    await expect(reviewContribution('id', 'approved', '')).rejects.toThrow('Denied');
    await expect(listContributions({})).rejects.toThrow('Denied');
  });
});
