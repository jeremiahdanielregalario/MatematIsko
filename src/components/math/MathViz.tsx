import { PolarPlot, type PolarPlotConfig } from './PolarPlot';
import { ParametricPlot, type ParametricPlotConfig } from './ParametricPlot';
import { Surface3D, type Surface3DConfig } from './Surface3D';

type VizConfig = PolarPlotConfig | ParametricPlotConfig | Surface3DConfig;

function parseConfig(raw: string): VizConfig | null {
  try {
    const parsed = JSON.parse(raw);
    if (!parsed || typeof parsed !== 'object' || Array.isArray(parsed)) return null;
    return parsed as VizConfig;
  } catch {
    return null;
  }
}

interface MathVizProps {
  'data-math-viz': string;
  'data-config': string;
  preview?: boolean;
}

/**
 * Router component that receives a `data-math-viz` type tag and
 * `data-config` JSON string and renders the appropriate Canvas-based math
 * visualization.
 */
export function MathViz({ 'data-math-viz': type, 'data-config': raw, preview = false }: MathVizProps) {
  const config = parseConfig(raw);
  if (!config) {
    return (
      <div
        role="status"
        className="not-prose my-3 rounded-lg border border-amber-300 p-3 text-sm text-amber-900 dark:text-amber-200"
      >
        Invalid visualization configuration.
      </div>
    );
  }

  if (preview) {
    return (
      <p className="not-prose text-sm text-stone-500">
        Visualization included: {config.title ?? type}
      </p>
    );
  }

  switch (type) {
    case 'polar':
      return <PolarPlot config={config as PolarPlotConfig} />;
    case 'parametric':
      return <ParametricPlot config={config as ParametricPlotConfig} />;
    case 'surface3d':
      return <Surface3D config={config as Surface3DConfig} />;
    default:
      return (
        <div className="math-viz-unknown">
          Unknown visualization type: {type}
        </div>
      );
  }
}
