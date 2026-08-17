import { PolarPlot, type PolarPlotConfig } from './PolarPlot';
import { ParametricPlot, type ParametricPlotConfig } from './ParametricPlot';
import { Surface3D, type Surface3DConfig } from './Surface3D';

type VizConfig = PolarPlotConfig | ParametricPlotConfig | Surface3DConfig;

function parseConfig(raw: string): VizConfig | null {
  try {
    return JSON.parse(raw) as VizConfig;
  } catch {
    return null;
  }
}

interface MathVizProps {
  'data-math-viz': string;
  'data-config': string;
}

/**
 * Router component that receives a `data-math-viz` type tag and
 * `data-config` JSON string (set by the remarkMathViz plugin) and
 * renders the appropriate Canvas-based math visualization.
 */
export function MathViz({ 'data-math-viz': type, 'data-config': raw }: MathVizProps) {
  const config = parseConfig(raw);
  if (!config) {
    return <div className="math-viz-error">Invalid visualization configuration.</div>;
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
