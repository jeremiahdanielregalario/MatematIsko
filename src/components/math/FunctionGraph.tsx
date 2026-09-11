import { useId, useMemo, useState } from 'react';
import { compileExpression, parseGraph, sampleCurve, type GraphConfig } from '@/lib/graph';

const COLORS = [
  '#2563eb',
  '#d97706',
  '#9333ea',
  '#059669',
  '#dc2626',
  '#0891b2',
  '#db2777',
  '#64748b',
];
function ticks(min: number, max: number): number[] {
  const raw = (max - min) / 6;
  const power = 10 ** Math.floor(Math.log10(raw));
  const step = [1, 2, 5, 10].map((n) => n * power).find((n) => n >= raw)!;
  const start = Math.ceil(min / step) * step;
  return Array.from({ length: Math.min(12, Math.floor((max - start) / step) + 1) }, (_, i) =>
    Number((start + i * step).toPrecision(10)),
  );
}

export function FunctionGraph({ config }: { config: GraphConfig }) {
  const id = useId();
  const [showDescription, setShowDescription] = useState(false);
  const curves = useMemo(
    () => config.curves.map((curve) => ({ curve, segments: sampleCurve(curve, config) })),
    [config],
  );
  const sx = (x: number) => 48 + ((x - config.xMin) / (config.xMax - config.xMin)) * 540;
  const sy = (y: number) => 348 - ((y - config.yMin) / (config.yMax - config.yMin)) * 320;
  const xAxis = sy(Math.max(config.yMin, Math.min(config.yMax, 0)));
  const yAxis = sx(Math.max(config.xMin, Math.min(config.xMax, 0)));
  const markers = config.curves
    .flatMap((curve, index) => {
      const fn = compileExpression(curve.expression);
      return [
        { x: curve.min, type: curve.start },
        { x: curve.max, type: curve.end },
      ]
        .filter((point) => point.type && point.type !== 'none')
        .map((point) => ({
          x: point.x,
          y: fn(point.x),
          open: point.type === 'open',
          color: COLORS[index],
        }));
    })
    .concat(config.points.map((point) => ({ ...point, open: !!point.open, color: '#7b1113' })));
  return (
    <figure className="not-prose my-4 min-w-0 overflow-hidden rounded-xl border border-stone-200 bg-white dark:border-stone-700 dark:bg-stone-900">
      <figcaption className="border-b border-stone-200 px-4 py-3 font-sans text-sm font-semibold text-stone-900 dark:border-stone-700 dark:text-stone-100">
        {config.title}
      </figcaption>
      <svg
        viewBox="0 0 620 390"
        role="img"
        aria-labelledby={`${id}-title ${id}-description`}
        className="block h-auto w-full bg-white text-stone-600 dark:bg-stone-900 dark:text-stone-300"
      >
        <title id={`${id}-title`}>{config.title}</title>
        <desc id={`${id}-description`}>{config.description}</desc>
        <defs>
          <clipPath id={`${id}-clip`}>
            <rect x="48" y="28" width="540" height="320" />
          </clipPath>
        </defs>
        {ticks(config.xMin, config.xMax).map((x) => (
          <g key={`x${x}`}>
            <line x1={sx(x)} x2={sx(x)} y1="28" y2="348" stroke="currentColor" opacity="0.15" />
            <text x={sx(x)} y="370" textAnchor="middle" fill="currentColor" fontSize="15">
              {x}
            </text>
          </g>
        ))}
        {ticks(config.yMin, config.yMax).map((y) => (
          <g key={`y${y}`}>
            <line x1="48" x2="588" y1={sy(y)} y2={sy(y)} stroke="currentColor" opacity="0.15" />
            <text x="40" y={sy(y) + 5} textAnchor="end" fill="currentColor" fontSize="15">
              {y}
            </text>
          </g>
        ))}
        <line x1="48" x2="588" y1={xAxis} y2={xAxis} stroke="currentColor" />
        <line x1={yAxis} x2={yAxis} y1="28" y2="348" stroke="currentColor" />
        <text x="600" y={Math.max(40, Math.min(340, xAxis - 8))} fill="currentColor" fontSize="17">
          x
        </text>
        <text x={Math.max(52, Math.min(572, yAxis + 8))} y="20" fill="currentColor" fontSize="17">
          y
        </text>
        <g clipPath={`url(#${id}-clip)`}>
          {curves.map(({ segments }, index) =>
            segments.map((segment, part) => (
              <path
                key={`${index}-${part}`}
                d={segment
                  .map(([x, y], i) => `${i ? 'L' : 'M'}${sx(x).toFixed(2)},${sy(y).toFixed(2)}`)
                  .join(' ')}
                fill="none"
                stroke={COLORS[index]}
                strokeWidth="2.5"
                vectorEffect="non-scaling-stroke"
              />
            )),
          )}
        </g>
        {markers
          .filter(
            (point) =>
              Number.isFinite(point.y) &&
              point.x >= config.xMin &&
              point.x <= config.xMax &&
              point.y >= config.yMin &&
              point.y <= config.yMax,
          )
          .map((point, index) => (
            <circle
              key={index}
              cx={sx(point.x)}
              cy={sy(point.y)}
              r="5.5"
              fill={point.open ? undefined : point.color}
              className={point.open ? 'fill-white dark:fill-stone-900' : undefined}
              stroke={point.color}
              strokeWidth="2.5"
              vectorEffect="non-scaling-stroke"
            />
          ))}
      </svg>
      <div className="space-y-2 px-4 pb-4 font-sans text-xs text-stone-600 dark:text-stone-300">
        <p>Open circles exclude a point; filled circles include it.</p>
        <button
          type="button"
          aria-expanded={showDescription}
          aria-controls={`${id}-text`}
          onClick={() => setShowDescription(!showDescription)}
          className="min-h-10 rounded text-sm font-medium underline underline-offset-4"
        >
          {showDescription ? 'Hide graph description' : 'Read graph description'}
        </button>
        {showDescription && (
          <p id={`${id}-text`} className="text-sm leading-relaxed">
            {config.description}
          </p>
        )}
      </div>
    </figure>
  );
}

export function GraphBlock({ source, preview = false }: { source: string; preview?: boolean }) {
  const result = useMemo(() => {
    try {
      return { config: parseGraph(source), error: null };
    } catch (error) {
      return { config: null, error: error instanceof Error ? error.message : 'Invalid graph.' };
    }
  }, [source]);
  if (!result.config)
    return (
      <div
        role="status"
        className="not-prose my-3 rounded-lg border border-amber-300 p-3 text-sm text-amber-900 dark:text-amber-200"
      >
        Graph unavailable: {result.error}
      </div>
    );
  if (preview)
    return (
      <p className="not-prose text-sm text-stone-500">Graph included: {result.config.title}</p>
    );
  return <FunctionGraph key={source} config={result.config} />;
}
