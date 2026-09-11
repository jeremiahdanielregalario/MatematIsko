import { describe, expect, it } from 'vitest';
import { compileExpression, graphMarkdown, LIMIT_GRAPH, parseGraph, sampleCurve } from './graph';

describe('safe graph formulas', () => {
  it.each([
    ['x^2+2*x-1', 3, 14],
    ['-x^2', 3, -9],
    ['2^3^2', 0, 512],
    ['2^-2', 0, 0.25],
    ['(x+1)/(x-1)', 3, 2],
    ['sin(pi/2)+cos(0)', 0, 2],
    ['sqrt(abs(-4))+ln(e)', 0, 3],
    ['exp(0)+log(e)+tan(0)', 0, 2],
    ['+x-0.5', 2, 1.5],
    ['1e2*x', 2, 200],
  ])('evaluates %s', (source, x, expected) => {
    expect(compileExpression(source)(x)).toBeCloseTo(expected);
  });
  it.each([
    'window.alert(1)',
    'x;fetch(1)',
    'constructor(x)',
    'Math.sin(x)',
    '2x',
    '(x',
    'sin x',
    'sin(x',
    '',
    'x'.repeat(201),
    'x +',
    'Infinity',
    'x[0]',
  ])('rejects executable or invalid input: %s', (source) => {
    expect(() => compileExpression(source)).toThrow();
  });
});

describe('graph validation and sampling', () => {
  it('round trips configurations inside a graph code fence', () => {
    const markdown = graphMarkdown(LIMIT_GRAPH);
    expect(parseGraph(markdown.split('```graph\n')[1].split('\n```')[0])).toMatchObject(
      LIMIT_GRAPH,
    );
  });
  it.each([
    null,
    [],
    { ...LIMIT_GRAPH, version: 2 },
    { ...LIMIT_GRAPH, title: '' },
    { ...LIMIT_GRAPH, xMax: LIMIT_GRAPH.xMin },
    { ...LIMIT_GRAPH, yMin: 1e7 },
    { ...LIMIT_GRAPH, curves: Array(9).fill(LIMIT_GRAPH.curves[0]) },
    { ...LIMIT_GRAPH, points: Array(33).fill({ x: 0, y: 0 }) },
    { ...LIMIT_GRAPH, curves: [], points: [] },
    { ...LIMIT_GRAPH, curves: [{ expression: 'x', min: 2, max: 1 }] },
    { ...LIMIT_GRAPH, curves: [{ expression: 'x', min: 0, max: 1, start: 'bad' }] },
    { ...LIMIT_GRAPH, points: [{ x: 0, y: 0, open: 'yes' }] },
  ])('rejects invalid configuration %#', (value) => {
    expect(() => parseGraph(JSON.stringify(value))).toThrow();
  });
  it('rejects oversized or malformed JSON', () => {
    expect(() => parseGraph(' '.repeat(16001))).toThrow();
    expect(() => parseGraph('{')).toThrow();
  });
  it('does not connect branches across a vertical asymptote', () => {
    const config = { ...LIMIT_GRAPH, xMin: -5, xMax: 5, yMin: -5, yMax: 5 };
    const segments = sampleCurve({ expression: '1/x', min: -5, max: 5 }, config);
    expect(segments.length).toBeGreaterThanOrEqual(2);
    for (const segment of segments)
      expect(segment.some(([x]) => x < 0) && segment.some(([x]) => x > 0)).toBe(false);
  });
  it('handles undefined domains and offscreen pieces', () => {
    expect(sampleCurve({ expression: 'x', min: 10, max: 20 }, LIMIT_GRAPH)).toEqual([]);
    const segments = sampleCurve({ expression: 'sqrt(x)', min: -2, max: 5 }, LIMIT_GRAPH);
    expect(segments.flat().every(([x, y]) => x >= 0 && Number.isFinite(y))).toBe(true);
  });
  it('keeps each explicitly authored piece separate', () => {
    const [left, right] = LIMIT_GRAPH.curves.map((curve) => sampleCurve(curve, LIMIT_GRAPH));
    expect(left.flat().at(-1)).toEqual([2, 4]);
    expect(right.flat()[0]).toEqual([2, 4]);
  });
});
