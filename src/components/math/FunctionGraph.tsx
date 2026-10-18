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
  const [inspecting, setInspecting] = useState(false);
  const [traceX, setTraceX] = useState<number | null>(null);
  const [zoom, setZoom] = useState(1);

  const viewConfig = useMemo<GraphConfig>(() => {
    if (zoom === 1) return config;
    const xCenter = (config.xMin + config.xMax) / 2;
    const yCenter = (config.yMin + config.yMax) / 2;
    const halfX = (config.xMax - config.xMin) / (2 * zoom);
    const halfY = (config.yMax - config.yMin) / (2 * zoom);
    return {
      ...config,
      xMin: Number((xCenter - halfX).toPrecision(8)),
      xMax: Number((xCenter + halfX).toPrecision(8)),
      yMin: Number((yCenter - halfY).toPrecision(8)),
      yMax: Number((yCenter + halfY).toPrecision(8)),
    };
  }, [config, zoom]);

  const curves = useMemo(
    () => viewConfig.curves.map((curve) => ({ curve, segments: sampleCurve(curve, viewConfig) })),
    [viewConfig],
  );
  const sx = (x: number) =>
    48 + ((x - viewConfig.xMin) / (viewConfig.xMax - viewConfig.xMin)) * 540;
  const sy = (y: number) =>
    348 - ((y - viewConfig.yMin) / (viewConfig.yMax - viewConfig.yMin)) * 320;
  const xAxis = sy(Math.max(viewConfig.yMin, Math.min(viewConfig.yMax, 0)));
  const yAxis = sx(Math.max(viewConfig.xMin, Math.min(viewConfig.xMax, 0)));
  const markers = viewConfig.curves
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
    .concat(viewConfig.points.map((point) => ({ ...point, open: !!point.open, color: '#7b1113' })));

  const tracedValues = useMemo(() => {
    if (traceX === null) return [];
    return viewConfig.curves
      .map((curve, index) => {
        if (traceX < curve.min || traceX > curve.max) return null;
        const fn = compileExpression(curve.expression);
        const y = fn(traceX);
        if (!Number.isFinite(y)) return null;
        return {
          index,
          expression: curve.expression,
          x: traceX,
          y,
          color: COLORS[index],
          inBounds: y >= viewConfig.yMin && y <= viewConfig.yMax,
        };
      })
      .filter((item): item is NonNullable<typeof item> => item !== null);
  }, [viewConfig, traceX]);

  const toggleInspect = () => {
    if (inspecting) {
      setInspecting(false);
      setTraceX(null);
    } else {
      setInspecting(true);
      setTraceX(Number(((viewConfig.xMin + viewConfig.xMax) / 2).toFixed(2)));
    }
  };

  return (
    <figure className="not-prose my-4 min-w-0 overflow-hidden rounded-xl border border-stone-200 bg-white dark:border-stone-700 dark:bg-stone-900">
      <figcaption className="flex flex-wrap items-center justify-between gap-2 border-b border-stone-200 px-4 py-3 font-sans text-sm font-semibold text-stone-900 dark:border-stone-700 dark:text-stone-100">
        <span>{config.title}</span>
        <div className="flex flex-wrap items-center gap-1.5 text-xs font-normal">
          <button
            type="button"
            onClick={() => setZoom((z) => Math.min(4, Number((z * 1.5).toFixed(2))))}
            aria-label="Zoom in graph"
            className="rounded border border-stone-200 px-2 py-1 hover:bg-stone-100 dark:border-stone-700 dark:hover:bg-stone-800"
          >
            Zoom +
          </button>
          <button
            type="button"
            onClick={() => setZoom((z) => Math.max(0.5, Number((z / 1.5).toFixed(2))))}
            aria-label="Zoom out graph"
            className="rounded border border-stone-200 px-2 py-1 hover:bg-stone-100 dark:border-stone-700 dark:hover:bg-stone-800"
          >
            Zoom −
          </button>
          {zoom !== 1 && (
            <button
              type="button"
              onClick={() => setZoom(1)}
              className="rounded border border-stone-200 px-2 py-1 hover:bg-stone-100 dark:border-stone-700 dark:hover:bg-stone-800"
            >
              Reset zoom
            </button>
          )}
        </div>
      </figcaption>
      <svg
        viewBox="0 0 620 390"
        role="img"
        aria-labelledby={`${id}-title ${id}-description`}
        onPointerMove={(e) => {
          if (!inspecting) return;
          const rect = e.currentTarget.getBoundingClientRect();
          if (rect.width <= 0) return;
          const svgX = ((e.clientX - rect.left) / rect.width) * 620;
          const clampedSvgX = Math.max(48, Math.min(588, svgX));
          const xVal =
            viewConfig.xMin +
            ((clampedSvgX - 48) / 540) * (viewConfig.xMax - viewConfig.xMin);
          setTraceX(Number(xVal.toFixed(2)));
        }}
        className="block h-auto w-full bg-white text-stone-600 dark:bg-stone-900 dark:text-stone-300"
      >
        <title id={`${id}-title`}>{config.title}</title>
        <desc id={`${id}-description`}>{config.description}</desc>
        <defs>
          <clipPath id={`${id}-clip`}>
            <rect x="48" y="28" width="540" height="320" />
          </clipPath>
        </defs>
        {ticks(viewConfig.xMin, viewConfig.xMax).map((x) => (
          <g key={`x${x}`}>
            <line x1={sx(x)} x2={sx(x)} y1="28" y2="348" stroke="currentColor" opacity="0.15" />
            <text x={sx(x)} y="370" textAnchor="middle" fill="currentColor" fontSize="15">
              {x}
            </text>
          </g>
        ))}
        {ticks(viewConfig.yMin, viewConfig.yMax).map((y) => (
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
          {inspecting &&
            traceX !== null &&
            traceX >= viewConfig.xMin &&
            traceX <= viewConfig.xMax && (
              <line
                x1={sx(traceX)}
                x2={sx(traceX)}
                y1="28"
                y2="348"
                stroke="#7b1113"
                strokeDasharray="4 4"
                strokeWidth="1.5"
              />
            )}
        </g>
        {markers
          .filter(
            (point) =>
              Number.isFinite(point.y) &&
              point.x >= viewConfig.xMin &&
              point.x <= viewConfig.xMax &&
              point.y >= viewConfig.yMin &&
              point.y <= viewConfig.yMax,
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
        {inspecting &&
          tracedValues
            .filter((pt) => pt.inBounds)
            .map((pt) => (
              <rect
                key={`trace-${pt.index}`}
                x={sx(pt.x) - 4.5}
                y={sy(pt.y) - 4.5}
                width="9"
                height="9"
                rx="2"
                fill={pt.color}
                stroke="#ffffff"
                strokeWidth="2"
              />
            ))}
      </svg>
      <div className="space-y-2 px-4 pb-4 font-sans text-xs text-stone-600 dark:text-stone-300">
        <p>Open circles exclude a point; filled circles include it.</p>
        <div className="flex flex-wrap items-center gap-4">
          <button
            type="button"
            aria-expanded={showDescription}
            aria-controls={`${id}-text`}
            onClick={() => setShowDescription(!showDescription)}
            className="min-h-10 rounded text-sm font-medium underline underline-offset-4"
          >
            {showDescription ? 'Hide graph description' : 'Read graph description'}
          </button>
          <button
            type="button"
            aria-pressed={inspecting}
            onClick={toggleInspect}
            className="min-h-10 rounded text-sm font-medium text-brand-800 underline underline-offset-4 dark:text-brand-300"
          >
            {inspecting ? 'Hide coordinate inspector' : 'Inspect coordinates'}
          </button>
        </div>
        {inspecting && traceX !== null && (
          <div
            role="region"
            aria-label="Coordinate inspector"
            className="space-y-2 rounded-lg border border-stone-200 bg-stone-50 p-3 dark:border-stone-700 dark:bg-stone-800/60"
          >
            <label className="flex items-center gap-3 text-xs font-medium text-stone-700 dark:text-stone-200">
              <span className="shrink-0 font-mono">x = {traceX}</span>
              <input
                type="range"
                aria-label="Trace x coordinate"
                min={viewConfig.xMin}
                max={viewConfig.xMax}
                step={(viewConfig.xMax - viewConfig.xMin) / 200}
                value={traceX}
                onChange={(e) => setTraceX(Number(Number(e.target.value).toFixed(2)))}
                className="w-full accent-brand-800"
              />
            </label>
            <div className="flex flex-wrap gap-3 text-xs font-mono">
              {tracedValues.length > 0 ? (
                tracedValues.map((pt) => (
                  <span
                    key={pt.index}
                    className="inline-flex items-center gap-1.5 rounded bg-white px-2 py-1 shadow-xs dark:bg-stone-900"
                  >
                    <span
                      className="size-2.5 rounded-xs"
                      style={{ backgroundColor: pt.color }}
                      aria-hidden="true"
                    />
                    y = {pt.expression}: ({pt.x}, {Number(pt.y.toFixed(4))})
                  </span>
                ))
              ) : (
                <span className="text-stone-500">Undefined at x = {traceX}</span>
              )}
            </div>
          </div>
        )}
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
