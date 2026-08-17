import { useRef, useEffect, useCallback } from 'react';

export interface Surface3DConfig {
  /** Explicit mesh arrays (rows × cols grid of [x,y,z] triples). */
  mesh?: number[][][];
  /**
   * Parametric surface: provide JS expressions for x(u,v), y(u,v), z(u,v).
   * `u` and `v` are in [0, 1]; they are mapped to [uMin,uMax] × [vMin,vMax].
   */
  parametric?: {
    x: string;
    y: string;
    z: string;
    uMin?: number;
    uMax?: number;
    vMin?: number;
    vMax?: number;
    uSamples?: number;
    vSamples?: number;
  };
  title?: string;
  width?: number;
  height?: number;
  /** Camera rotation in degrees. */
  rotateX?: number;
  rotateZ?: number;
  /** View bounds for clipping. */
  xRange?: [number, number];
  yRange?: [number, number];
  zRange?: [number, number];
}

function compileFn(
  expr: string,
): ((u: number, v: number) => number) | null {
  try {
    return new Function(
      'u',
      'v',
      `"use strict"; return (${expr});`,
    ) as (u: number, v: number) => number;
  } catch {
    return null;
  }
}

function buildParametricMesh(param: Surface3DConfig['parametric']) {
  if (!param) return null;
  const xFn = compileFn(param.x);
  const yFn = compileFn(param.y);
  const zFn = compileFn(param.z);
  if (!xFn || !yFn || !zFn) return null;

  const uMin = param.uMin ?? 0;
  const uMax = param.uMax ?? 1;
  const vMin = param.vMin ?? 0;
  const vMax = param.vMax ?? 1;
  const uN = param.uSamples ?? 40;
  const vN = param.vSamples ?? 40;
  const du = (uMax - uMin) / uN;
  const dv = (vMax - vMin) / vN;

  const mesh: number[][][] = [];
  for (let i = 0; i <= uN; i++) {
    const row: number[][] = [];
    const u = uMin + i * du;
    for (let j = 0; j <= vN; j++) {
      const v = vMin + j * dv;
      row.push([xFn(u, v), yFn(u, v), zFn(u, v)]);
    }
    mesh.push(row);
  }
  return mesh;
}

/** Simple 3D → 2D isometric-like projection with rotation. */
function project(
  x: number,
  y: number,
  z: number,
  rx: number,
  rz: number,
  scale: number,
  cx: number,
  cy: number,
): [number, number] {
  // Rotate around Z axis
  const cosZ = Math.cos(rz);
  const sinZ = Math.sin(rz);
  const x1 = x * cosZ - y * sinZ;
  const y1 = x * sinZ + y * cosZ;

  // Rotate around X axis (tilt)
  const cosX = Math.cos(rx);
  const sinX = Math.sin(rx);
  const y2 = y1 * cosX - z * sinX;
  const z2 = y1 * sinX + z * cosX;

  // Simple perspective-free projection
  return [cx + x1 * scale, cy - y2 * scale + z2 * scale * 0.3];
}

function shadeColor(
  _nx: number,
  _ny: number,
  nz: number,
  baseColor: string,
): string {
  // Simple diffuse shading based on normal z-component
  const light = Math.max(0, Math.min(1, 0.5 + 0.5 * nz));
  // Parse hex color
  const hex = baseColor.replace('#', '');
  const r = parseInt(hex.substring(0, 2), 16);
  const g = parseInt(hex.substring(2, 4), 16);
  const b = parseInt(hex.substring(4, 6), 16);
  return `rgb(${Math.round(r * light + 255 * (1 - light) * 0.3)},${Math.round(g * light + 255 * (1 - light) * 0.3)},${Math.round(b * light + 255 * (1 - light) * 0.3)})`;
}

function computeNormal(
  mesh: number[][][],
  i: number,
  j: number,
): [number, number, number] {
  const rows = mesh.length;
  const cols = mesh[0].length;

  const get = (r: number, c: number): number[] => {
    const ri = Math.max(0, Math.min(rows - 1, r));
    const ci = Math.max(0, Math.min(cols - 1, c));
    return mesh[ri][ci];
  };

  const dx = get(i + 1 < rows ? i + 1 : i, j);
  const dy = get(i, j + 1 < cols ? j + 1 : j);
  const bx = get(i - 1 >= 0 ? i - 1 : i, j);
  const by = get(i, j - 1 >= 0 ? j - 1 : j);

  // Cross product of partial derivatives
  const ux = (dx[0] - bx[0]) / 2;
  const uy = (dx[1] - bx[1]) / 2;
  const uz = (dx[2] - bx[2]) / 2;
  const vx = (dy[0] - by[0]) / 2;
  const vy = (dy[1] - by[1]) / 2;
  const vz = (dy[2] - by[2]) / 2;

  const nx = uy * vz - uz * vy;
  const ny = uz * vx - ux * vz;
  const nz = ux * vy - uy * vx;
  const len = Math.sqrt(nx * nx + ny * ny + nz * nz) || 1;
  return [nx / len, ny / len, nz / len];
}

export function Surface3D({ config }: { config: Surface3DConfig }) {
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

    let mesh = config.mesh;
    if (!mesh && config.parametric) {
      mesh = buildParametricMesh(config.parametric) ?? undefined;
    }
    if (!mesh || mesh.length === 0) return;

    const rx = ((config.rotateX ?? -30) * Math.PI) / 180;
    const rz = ((config.rotateZ ?? 45) * Math.PI) / 180;

    // Compute scale from bounds
    let allX: number[] = [];
    let allY: number[] = [];
    let allZ: number[] = [];
    for (const row of mesh) {
      for (const pt of row) {
        allX.push(pt[0]);
        allY.push(pt[1]);
        allZ.push(pt[2]);
      }
    }

    // Filter ranges
    if (config.xRange) {
      allX = allX.filter(
        (v) => v >= config.xRange![0] && v <= config.xRange![1],
      );
    }
    if (config.yRange) {
      allY = allY.filter(
        (v) => v >= config.yRange![0] && v <= config.yRange![1],
      );
    }
    if (config.zRange) {
      allZ = allZ.filter(
        (v) => v >= config.zRange![0] && v <= config.zRange![1],
      );
    }

    if (allX.length === 0) return;

    const xC = (Math.min(...allX) + Math.max(...allX)) / 2;
    const yC = (Math.min(...allY) + Math.max(...allY)) / 2;
    const zC = (Math.min(...allZ) + Math.max(...allZ)) / 2;
    const maxSpan = Math.max(
      Math.max(...allX) - Math.min(...allX),
      Math.max(...allY) - Math.min(...allY),
      Math.max(...allZ) - Math.min(...allZ),
    );
    const scale = (Math.min(W, H) * 0.35) / (maxSpan || 1);
    const cx = W / 2;
    const cy = H / 2;

    // Build quads with painter's sort (back-to-front)
    const quads: Array<{
      pts: [number, number][];
      depth: number;
      nz: number;
      color: string;
    }> = [];
    const rows = mesh.length;
    const cols = mesh[0].length;

    const baseR = 100;
    const baseG = 130;
    const baseB = 220;
    const baseColor = `rgb(${baseR},${baseG},${baseB})`;

    for (let i = 0; i < rows - 1; i++) {
      for (let j = 0; j < cols - 1; j++) {
        const p0 = mesh[i][j];
        const p1 = mesh[i][j + 1];
        const p2 = mesh[i + 1][j + 1];
        const p3 = mesh[i + 1][j];

        // Skip out-of-range
        if (config.xRange) {
          if (
            p0[0] < config.xRange[0] ||
            p0[0] > config.xRange[1]
          )
            continue;
        }

        const proj0 = project(
          p0[0] - xC,
          p0[1] - yC,
          p0[2] - zC,
          rx,
          rz,
          scale,
          cx,
          cy,
        );
        const proj1 = project(
          p1[0] - xC,
          p1[1] - yC,
          p1[2] - zC,
          rx,
          rz,
          scale,
          cx,
          cy,
        );
        const proj2 = project(
          p2[0] - xC,
          p2[1] - yC,
          p2[2] - zC,
          rx,
          rz,
          scale,
          cx,
          cy,
        );
        const proj3 = project(
          p3[0] - xC,
          p3[1] - yC,
          p3[2] - zC,
          rx,
          rz,
          scale,
          cx,
          cy,
        );

        const avgZ = (p0[2] + p1[2] + p2[2] + p3[2]) / 4;
        const [, , nz] = computeNormal(mesh, i, j);

        quads.push({
          pts: [proj0, proj1, proj2, proj3],
          depth: avgZ,
          nz,
          color: shadeColor(0, 0, nz, baseColor),
        });
      }
    }

    // Sort back-to-front by depth
    quads.sort((a, b) => a.depth - b.depth);

    for (const q of quads) {
      ctx.beginPath();
      ctx.moveTo(q.pts[0][0], q.pts[0][1]);
      ctx.lineTo(q.pts[1][0], q.pts[1][1]);
      ctx.lineTo(q.pts[2][0], q.pts[2][1]);
      ctx.lineTo(q.pts[3][0], q.pts[3][1]);
      ctx.closePath();
      ctx.fillStyle = q.color;
      ctx.fill();
      ctx.strokeStyle = isDark
        ? 'rgba(255,255,255,0.06)'
        : 'rgba(0,0,0,0.08)';
      ctx.lineWidth = 0.5;
      ctx.stroke();
    }

    // Title
    if (config.title) {
      ctx.fillStyle = isDark ? '#e7e5e4' : '#1c1917';
      ctx.font = '12px system-ui, sans-serif';
      ctx.textAlign = 'center';
      ctx.textBaseline = 'top';
      ctx.fillText(config.title, W / 2, 8);
    }
  }, [config]);

  useEffect(() => {
    draw();
  }, [draw]);

  return (
    <div className="my-4 flex flex-col items-center gap-1">
      <canvas
        ref={canvasRef}
        className="rounded-lg border border-stone-200 dark:border-stone-700"
      />
    </div>
  );
}
