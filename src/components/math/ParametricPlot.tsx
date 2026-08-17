import { useRef, useEffect, useCallback } from 'react';

export interface ParametricCurveConfig {
  xFn: string;
  yFn: string;
  color?: string;
  label?: string;
  tMin?: number;
  tMax?: number;
  samples?: number;
}

export interface ParametricPlotConfig {
  curves: ParametricCurveConfig[];
  title?: string;
  xMin?: number;
  xMax?: number;
  yMin?: number;
  yMax?: number;
  width?: number;
  height?: number;
}

const DEFAULT_COLORS = [
  '#dc2626',
  '#2563eb',
  '#16a34a',
  '#d97706',
  '#7c3aed',
  '#db2777',
];

function compileFn(expr: string): ((t: number) => number) | null {
  try {
    return new Function('t', `"use strict"; return (${expr});`) as (
      t: number,
    ) => number;
  } catch {
    return null;
  }
}

function drawGrid(
  ctx: CanvasRenderingContext2D,
  ox: number,
  oy: number,
  sx: number,
  sy: number,
  xMin: number,
  xMax: number,
  yMin: number,
  yMax: number,
  W: number,
  H: number,
  isDark: boolean,
) {
  const stroke = isDark ? 'rgba(255,255,255,0.08)' : 'rgba(0,0,0,0.06)';
  const axisColor = isDark ? 'rgba(255,255,255,0.3)' : 'rgba(0,0,0,0.25)';

  // Grid
  const xStep = niceStep(xMax - xMin, 6);
  const yStep = niceStep(yMax - yMin, 6);

  ctx.strokeStyle = stroke;
  ctx.lineWidth = 1;

  for (let x = Math.ceil(xMin / xStep) * xStep; x <= xMax; x += xStep) {
    const cx = ox + x * sx;
    ctx.beginPath();
    ctx.moveTo(cx, 0);
    ctx.lineTo(cx, H);
    ctx.stroke();
  }
  for (let y = Math.ceil(yMin / yStep) * yStep; y <= yMax; y += yStep) {
    const cy = oy - y * sy;
    ctx.beginPath();
    ctx.moveTo(0, cy);
    ctx.lineTo(W, cy);
    ctx.stroke();
  }

  // Axes
  ctx.strokeStyle = axisColor;
  ctx.lineWidth = 1.5;

  if (oy >= 0 && oy <= H) {
    ctx.beginPath();
    ctx.moveTo(0, oy);
    ctx.lineTo(W, oy);
    ctx.stroke();
  }
  if (ox >= 0 && ox <= W) {
    ctx.beginPath();
    ctx.moveTo(ox, 0);
    ctx.lineTo(ox, H);
    ctx.stroke();
  }

  // Tick labels
  ctx.fillStyle = isDark ? 'rgba(255,255,255,0.45)' : 'rgba(0,0,0,0.4)';
  ctx.font = '10px system-ui, sans-serif';
  ctx.textAlign = 'center';
  ctx.textBaseline = 'top';

  for (let x = Math.ceil(xMin / xStep) * xStep; x <= xMax; x += xStep) {
    if (Math.abs(x) < xStep * 0.01) continue;
    const cx = ox + x * sx;
    ctx.fillText(formatNum(x), cx, Math.min(Math.max(oy + 4, 4), H - 12));
  }

  ctx.textAlign = 'right';
  ctx.textBaseline = 'middle';
  for (let y = Math.ceil(yMin / yStep) * yStep; y <= yMax; y += yStep) {
    if (Math.abs(y) < yStep * 0.01) continue;
    const cy = oy - y * sy;
    ctx.fillText(formatNum(y), Math.max(Math.min(ox - 4, W - 4), 24), cy);
  }
}

function niceStep(range: number, maxTicks: number): number {
  const rough = range / maxTicks;
  const mag = Math.pow(10, Math.floor(Math.log10(rough)));
  const res = rough / mag;
  if (res <= 1.5) return mag;
  if (res <= 3) return 2 * mag;
  if (res <= 7) return 5 * mag;
  return 10 * mag;
}

function formatNum(n: number): string {
  const s = n.toFixed(2);
  return s.replace(/\.?0+$/, '') || '0';
}

export function ParametricPlot({ config }: { config: ParametricPlotConfig }) {
  const canvasRef = useRef<HTMLCanvasElement>(null);

  const draw = useCallback(() => {
    const canvas = canvasRef.current;
    if (!canvas) return;
    const ctx = canvas.getContext('2d');
    if (!ctx) return;

    const dpr = window.devicePixelRatio || 1;
    const W = config.width ?? 420;
    const H = config.height ?? 420;
    canvas.width = W * dpr;
    canvas.height = H * dpr;
    canvas.style.width = `${W}px`;
    canvas.style.height = `${H}px`;
    ctx.scale(dpr, dpr);

    const isDark =
      typeof document !== 'undefined' &&
      document.documentElement.classList.contains('dark');

    ctx.fillStyle = isDark ? '#1c1917' : '#fafaf9';
    ctx.fillRect(0, 0, W, H);

    // Compute bounds
    let xMin = config.xMin ?? Infinity;
    let xMax = config.xMax ?? -Infinity;
    let yMin = config.yMin ?? Infinity;
    let yMax = config.yMax ?? -Infinity;

    const evaluated: Array<{ xs: number[]; ys: number[] }> = [];

    for (const curve of config.curves) {
      const xFn = compileFn(curve.xFn);
      const yFn = compileFn(curve.yFn);
      if (!xFn || !yFn) {
        evaluated.push({ xs: [], ys: [] });
        continue;
      }
      const tMin = curve.tMin ?? 0;
      const tMax = curve.tMax ?? 2 * Math.PI;
      const samples = curve.samples ?? 500;
      const dt = (tMax - tMin) / samples;
      const xs: number[] = [];
      const ys: number[] = [];

      for (let s = 0; s <= samples; s++) {
        const t = tMin + s * dt;
        const x = xFn(t);
        const y = yFn(t);
        if (!isFinite(x) || !isFinite(y)) continue;
        xs.push(x);
        ys.push(y);
        if (config.xMin === undefined) {
          xMin = Math.min(xMin, x);
          xMax = Math.max(xMax, x);
        }
        if (config.yMin === undefined) {
          yMin = Math.min(yMin, y);
          yMax = Math.max(yMax, y);
        }
      }
      evaluated.push({ xs, ys });
    }

    if (xMin === Infinity) {
      xMin = -5;
      xMax = 5;
      yMin = -5;
      yMax = 5;
    }

    // Pad bounds
    const padX = (xMax - xMin) * 0.1 || 1;
    const padY = (yMax - yMin) * 0.1 || 1;
    xMin -= padX;
    xMax += padX;
    yMin -= padY;
    yMax += padY;

    const sx = W / (xMax - xMin);
    const sy = H / (yMax - yMin);
    const ox = -xMin * sx;
    const oy = yMax * sy;

    drawGrid(ctx, ox, oy, sx, sy, xMin, xMax, yMin, yMax, W, H, isDark);

    // Draw curves
    for (let ci = 0; ci < evaluated.length; ci++) {
      const { xs, ys } = evaluated[ci];
      if (xs.length === 0) continue;
      const curve = config.curves[ci];
      const color = curve.color ?? DEFAULT_COLORS[ci % DEFAULT_COLORS.length];

      ctx.beginPath();
      ctx.moveTo(ox + xs[0] * sx, oy - ys[0] * sy);
      for (let j = 1; j < xs.length; j++) {
        ctx.lineTo(ox + xs[j] * sx, oy - ys[j] * sy);
      }
      ctx.strokeStyle = color;
      ctx.lineWidth = 2;
      ctx.stroke();
    }

    // Legend
    const labeled = config.curves.filter((c) => c.label);
    if (labeled.length > 0) {
      const lx = 12;
      let ly = 20;
      ctx.font = '12px system-ui, sans-serif';
      ctx.textAlign = 'left';
      ctx.textBaseline = 'middle';
      for (let ci = 0; ci < config.curves.length; ci++) {
        const curve = config.curves[ci];
        if (!curve.label) continue;
        const color = curve.color ?? DEFAULT_COLORS[ci % DEFAULT_COLORS.length];
        ctx.fillStyle = color;
        ctx.fillRect(lx, ly - 5, 14, 3);
        ctx.fillStyle = isDark ? '#e7e5e4' : '#1c1917';
        ctx.fillText(curve.label, lx + 20, ly);
        ly += 18;
      }
    }
  }, [config]);

  useEffect(() => {
    draw();
  }, [draw]);

  return (
    <div className="my-4 flex flex-col items-center gap-1">
      {config.title && (
        <span className="text-sm font-medium text-stone-600 dark:text-stone-400">
          {config.title}
        </span>
      )}
      <canvas
        ref={canvasRef}
        className="rounded-lg border border-stone-200 dark:border-stone-700"
      />
    </div>
  );
}
