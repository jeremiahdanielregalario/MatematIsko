import { describe, expect, it } from 'vitest';
import { decodeUnicodeEscapes } from './unicode';

describe('decodeUnicodeEscapes', () => {
  it('decodes angle brackets', () => {
    expect(decodeUnicodeEscapes('\\u27E8 3 \\u27E9')).toBe('\u27E8 3 \u27E9');
  });

  it('decodes blackboard bold Z', () => {
    expect(decodeUnicodeEscapes('\\u2124')).toBe('\u2124');
  });

  it('decodes multiplication sign', () => {
    expect(decodeUnicodeEscapes('\\u00D7')).toBe('\u00D7');
  });

  it('decodes element-of symbol', () => {
    expect(decodeUnicodeEscapes('\\u2208')).toBe('\u2208');
  });

  it('passes through normal text unchanged', () => {
    const text = 'Is the Interval (0,1) Compact?';
    expect(decodeUnicodeEscapes(text)).toBe(text);
  });

  it('passes through LaTeX commands unchanged', () => {
    const text = '$\\langle 6 \\rangle$ is an ideal of $\\mathbb{Z}_{12}$';
    expect(decodeUnicodeEscapes(text)).toBe(text);
  });

  it('decodes multiple escapes in one string', () => {
    expect(
      decodeUnicodeEscapes(
        'S = \\u2124 \\u00D7 \\u2124',
      ),
    ).toBe('S = \u2124 \u00D7 \u2124');
  });
});
