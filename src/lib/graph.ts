/** Small mathematical expression parser. Never executes JavaScript from content. */
type Fn = (x: number) => number;
const FUNCTIONS: Record<string, Fn> = {
  sin: Math.sin,
  cos: Math.cos,
  tan: Math.tan,
  sqrt: Math.sqrt,
  abs: Math.abs,
  ln: Math.log,
  log: Math.log,
  exp: Math.exp,
};
export function compileExpression(source: string): Fn {
  if (!source.trim() || source.length > 200)
    throw new Error('Use a formula between 1 and 200 characters.');
  const tokens = source.match(/(?:\d+(?:\.\d*)?|\.\d+)(?:[eE][+-]?\d+)?|[a-zA-Z]+|\S/g) ?? [];
  let index = 0;
  const peek = () => tokens[index];
  const take = () => tokens[index++];
  function atom(): Fn {
    const token = take();
    if (token === '(') {
      const result = sum();
      if (take() !== ')') throw new Error('Missing closing parenthesis.');
      return result;
    }
    if (token === 'x') return (x) => x;
    if (token === 'pi') return () => Math.PI;
    if (token === 'e') return () => Math.E;
    if (token && Object.hasOwn(FUNCTIONS, token)) {
      if (take() !== '(') throw new Error(`Use ${token}(...) with parentheses.`);
      const argument = sum();
      if (take() !== ')') throw new Error('Missing closing parenthesis.');
      return (x) => FUNCTIONS[token](argument(x));
    }
    if (token && /^(?:\d|\.)/.test(token) && Number.isFinite(Number(token)))
      return () => Number(token);
    throw new Error(
      `Unsupported formula near "${token ?? 'end'}". Use x, numbers, + - * / ^ and supported functions.`,
    );
  }
  function power(): Fn {
    const left = atom();
    if (peek() === '^') {
      take();
      const right = unary();
      return (x) => left(x) ** right(x);
    }
    return left;
  }
  function unary(): Fn {
    if (peek() === '-') {
      take();
      const value = unary();
      return (x) => -value(x);
    }
    if (peek() === '+') {
      take();
      return unary();
    }
    return power();
  }
  function product(): Fn {
    let result = unary();
    while (peek() === '*' || peek() === '/') {
      const operator = take();
      const left = result;
      const right = unary();
      result = operator === '*' ? (x) => left(x) * right(x) : (x) => left(x) / right(x);
    }
    return result;
  }
  function sum(): Fn {
    let result = product();
    while (peek() === '+' || peek() === '-') {
      const operator = take();
      const left = result;
      const right = product();
      result = operator === '+' ? (x) => left(x) + right(x) : (x) => left(x) - right(x);
    }
    return result;
  }
  const result = sum();
  if (index !== tokens.length)
    throw new Error('Unexpected formula text. Use explicit multiplication, for example 2*x.');
  return result;
}

export type Endpoint = 'none' | 'open' | 'closed';
export interface GraphCurve {
  expression: string;
  min: number;
  max: number;
  start?: Endpoint;
  end?: Endpoint;
}
export interface GraphPoint {
  x: number;
  y: number;
  open?: boolean;
}
export interface GraphConfig {
  version: 1;
  title: string;
  description: string;
  xMin: number;
  xMax: number;
  yMin: number;
  yMax: number;
  curves: GraphCurve[];
  points: GraphPoint[];
}
function object(value: unknown): Record<string, unknown> {
  if (!value || typeof value !== 'object' || Array.isArray(value))
    throw new Error('Graph configuration must be an object.');
  return value as Record<string, unknown>;
}
function number(value: unknown): number {
  if (typeof value !== 'number' || !Number.isFinite(value) || Math.abs(value) > 1e6)
    throw new Error('Coordinates must be finite numbers between -1000000 and 1000000.');
  return value;
}
function text(value: unknown, limit: number): string {
  if (typeof value !== 'string' || !value.trim() || value.length > limit)
    throw new Error(`Provide a nonempty title/description (at most ${limit} characters).`);
  return value;
}
function endpoint(value: unknown): Endpoint {
  if (value === undefined) return 'none';
  if (value !== 'none' && value !== 'open' && value !== 'closed')
    throw new Error('Endpoints must be none, open or closed.');
  return value;
}
export function parseGraph(raw: string): GraphConfig {
  if (raw.length > 16000) throw new Error('Graph configuration is too large.');
  const value = object(JSON.parse(raw));
  if (value.version !== 1) throw new Error('Use graph version 1.');
  const xMin = number(value.xMin),
    xMax = number(value.xMax),
    yMin = number(value.yMin),
    yMax = number(value.yMax);
  if (xMax - xMin < 0.001 || yMax - yMin < 0.001)
    throw new Error('Axis maximums must exceed minimums by at least 0.001.');
  if (!Array.isArray(value.curves) || value.curves.length > 8)
    throw new Error('Use up to 8 function pieces.');
  const curves = value.curves.map((item) => {
    const curve = object(item);
    const expression = text(curve.expression, 200);
    compileExpression(expression);
    const min = number(curve.min),
      max = number(curve.max);
    if (min >= max)
      throw new Error('Each function piece needs a minimum smaller than its maximum.');
    return { expression, min, max, start: endpoint(curve.start), end: endpoint(curve.end) };
  });
  const pointValues = value.points ?? [];
  if (!Array.isArray(pointValues) || pointValues.length > 32)
    throw new Error('Use up to 32 marked points.');
  const points = pointValues.map((item) => {
    const point = object(item);
    if (point.open !== undefined && typeof point.open !== 'boolean')
      throw new Error('Point open must be true or false.');
    return { x: number(point.x), y: number(point.y), open: point.open === true };
  });
  if (!curves.length && !points.length)
    throw new Error('Add at least one function piece or point.');
  return {
    version: 1,
    title: text(value.title, 160),
    description: text(value.description, 1200),
    xMin,
    xMax,
    yMin,
    yMax,
    curves,
    points,
  };
}

/** Fixed work per curve, with breaks at undefined values and large sampled jumps. */
export function sampleCurve(curve: GraphCurve, config: GraphConfig): [number, number][][] {
  const fn = compileExpression(curve.expression);
  const min = Math.max(curve.min, config.xMin),
    max = Math.min(curve.max, config.xMax);
  if (min >= max) return [];
  const segments: [number, number][][] = [];
  let segment: [number, number][] = [];
  const range = config.yMax - config.yMin;
  for (let i = 0; i <= 600; i++) {
    const x = min + ((max - min) * i) / 600;
    const y = fn(x);
    const previous = segment.at(-1);
    if (
      !Number.isFinite(y) ||
      y < config.yMin - range ||
      y > config.yMax + range ||
      (previous && Math.abs(y - previous[1]) > range)
    ) {
      if (segment.length) segments.push(segment);
      segment = [];
      continue;
    }
    segment.push([x, y]);
  }
  if (segment.length) segments.push(segment);
  return segments;
}
export function graphMarkdown(config: GraphConfig): string {
  return '\n\n```graph\n' + JSON.stringify(config, null, 2) + '\n```\n';
}
export const LIMIT_GRAPH: GraphConfig = {
  version: 1,
  title: 'Graph of f(x)',
  description:
    'Two line segments follow y = x + 2, with an open circle at (2, 4). A filled point at (2, 1) gives the function value there.',
  xMin: -2,
  xMax: 5,
  yMin: -1,
  yMax: 8,
  curves: [
    { expression: 'x+2', min: -2, max: 2, end: 'open' },
    { expression: 'x+2', min: 2, max: 5, start: 'open' },
  ],
  points: [{ x: 2, y: 1 }],
};
