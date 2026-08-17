import { useRef, useEffect, useCallback } from 'react';

export interface PolarCurveConfig {
  fn: string;
  color?: string;
  label?: string;
  thetaMin?: number;
  thetaMax?: number;
  samples?: number;
}

export interface PolarPlotConfig {
  curves: PolarCurveConfig[];
  title?: string;
  rMin?: number;
  rMax?: number;
  gridRings?: number;
  width?: number;
  height?: number;
}

const TWO_PI = 2 * Math.PI;

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

function toCanvasX(x: number, cx: number, scale: number) {
  return cx + x * scale;
}
function toCanvasY(y: number, cy: number, scale: number) {
  return cy - y * scale;
}

function drawGrid(
  ctx: CanvasRenderingContext2D,
  cx: number,
  cy: number,
  scale: number,
  rMax: number,
  gridRings: number,
  isDark: boolean,
) {
  const stroke = isDark ? 'rgba(255,255,255,0.1)' : 'rgba(0,0,0,0.08)';
  const axisColor = isDark ? 'rgba(255,255,255,0.3)' : 'rgba(0,0,0,0.25)';

  // Concentric rings
  for (let i = 1; i <= gridRings; i++) {
    const r = (i / gridRings) * rMax * scale;
    ctx.beginPath();
    ctx.arc(cx, cy, r, 0, TWO_PI);
    ctx.strokeStyle = stroke;
    ctx.lineWidth = 1;
    ctx.stroke();
  }

  // Radial lines every 30°
  for (let a = 0; a < 12; a++) {
    const angle = (a * Math.PI) / 6;
    ctx.beginPath();
    ctx.moveTo(cx, cy);
    ctx.lineTo(
      cx + Math.cos(angle) * rMax * scale,
      cy - Math.sin(angle) * rMax * scale,
    );
    ctx.strokeStyle = stroke;
    ctx.lineWidth = 1;
    ctx.stroke();
  }

  // Axes
  ctx.beginPath();
  ctx.moveTo(cx - rMax * scale - 10, cy);
  ctx.lineTo(cx + rMax * scale + 10, cy);
  ctx.moveTo(cx, cy - rMax * scale - 10);
  ctx.lineTo(cx, cy + rMax * scale + 10);
  ctx.strokeStyle = axisColor;
  ctx.lineWidth = 1;
  ctx.stroke();

  // Ring labels
  ctx.fillStyle = isDark ? 'rgba(255,255,255,0.5)' : 'rgba(0,0,0,0.45)';
  ctx.font = '10px system-ui, sans-serif';
  ctx.textAlign = 'left';
  ctx.textBaseline = 'bottom';
  for (let i = 1; i <= gridRings; i++) {
    const rVal = ((i / gridRings) * rMax).toFixed(0);
    ctx.fillText(rVal, cx + 2, cy - (i / gridRings) * rMax * scale - 2);
  }
}

export function PolarPlot({ config }: { config: PolarPlotConfig }) {
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

    // Background
    ctx.fillStyle = isDark ? '#1c1917' : '#fafaf9';
    ctx.fillRect(0, 0, W, H);

    const cx = W / 2;
    const cy = H / 2;
    const rMax = config.rMax ?? 5;
    const gridRings = config.gridRings ?? 5;
    const scale = (Math.min(W, H) / 2 - 30) / rMax;

    drawGrid(ctx, cx, cy, scale, rMax, gridRings, isDark);

    // Draw curves
    for (let ci = 0; ci < config.curves.length; ci++) {
      const curve = config.curves[ci];
      const fn = compileFn(curve.fn);
      if (!fn) continue;

      const tMin = curve.thetaMin ?? 0;
      const tMax = curve.thetaMax ?? TWO_PI;
      const samples = curve.samples ?? 500;
      const dt = (tMax - tMin) / samples;
      const color = curve.color ?? DEFAULT_COLORS[ci % DEFAULT_COLORS.length];

      ctx.beginPath();
      let started = false;
      for (let s = 0; s <= samples; s++) {
        const t = tMin + s * dt;
        const r = fn(t);
        if (!isFinite(r)) {
          started = false;
          continue;
        }
        const x = toCanvasX(r * Math.cos(t), cx, scale);
        const y = toCanvasY(r * Math.sin(t), cy, scale);
        if (!started) {
          ctx.moveTo(x, y);
          started = true;
        } else {
          ctx.lineTo(x, y);
        }
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
