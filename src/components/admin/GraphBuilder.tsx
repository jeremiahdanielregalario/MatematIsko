import { useState } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea } from '@/components/ui/textarea';
import { GraphBlock } from '@/components/math/FunctionGraph';
import {
  graphMarkdown,
  LIMIT_GRAPH,
  parseGraph,
  type Endpoint,
  type GraphConfig,
} from '@/lib/graph';

const JUMP: GraphConfig = {
  ...LIMIT_GRAPH,
  description:
    'The left line approaches the open point (0, 1). The right horizontal piece includes (0, 3).',
  xMin: -4,
  xMax: 4,
  yMin: -4,
  yMax: 5,
  curves: [
    { expression: 'x+1', min: -4, max: 0, end: 'open' },
    { expression: '3', min: 0, max: 4, start: 'closed' },
  ],
  points: [],
};
const ASYMPTOTE: GraphConfig = {
  ...LIMIT_GRAPH,
  description:
    'Two branches of y = 1/x on opposite sides of x = 0. The function is undefined at zero.',
  xMin: -5,
  xMax: 5,
  yMin: -5,
  yMax: 5,
  curves: [
    { expression: '1/x', min: -5, max: 0 },
    { expression: '1/x', min: 0, max: 5 },
  ],
  points: [],
};

function NumberField({
  label,
  value,
  onChange,
}: {
  label: string;
  value: number;
  onChange: (value: number) => void;
}) {
  return (
    <label className="block text-xs font-medium">
      {label}
      <Input
        type="number"
        step="any"
        value={Number.isNaN(value) ? '' : value}
        onChange={(event) => onChange(event.target.value === '' ? NaN : Number(event.target.value))}
      />
    </label>
  );
}

export function GraphBuilder({ onInsert }: { onInsert: (markdown: string) => void }) {
  const [config, setConfig] = useState<GraphConfig>(LIMIT_GRAPH);
  const [inserted, setInserted] = useState(false);
  const change = (next: GraphConfig) => {
    setConfig(next);
    setInserted(false);
  };
  const raw = JSON.stringify(config);
  let error = '';
  try {
    parseGraph(raw);
  } catch (problem) {
    error = problem instanceof Error ? problem.message : 'Invalid graph.';
  }
  return (
    <details className="rounded-xl border border-stone-200 p-4 dark:border-stone-700">
      <summary className="cursor-pointer text-sm font-semibold">
        Add a graph to this problem
      </summary>
      <div className="mt-4 space-y-4">
        <p className="text-sm text-stone-500">
          Build a graph, then insert it into the question text. You can edit the inserted graph
          block later, or move it to a hint or solution.
        </p>
        <div className="flex flex-wrap gap-2">
          <Button type="button" variant="outline" size="sm" onClick={() => change(LIMIT_GRAPH)}>
            Removable discontinuity
          </Button>
          <Button type="button" variant="outline" size="sm" onClick={() => change(JUMP)}>
            Jump discontinuity
          </Button>
          <Button type="button" variant="outline" size="sm" onClick={() => change(ASYMPTOTE)}>
            Vertical asymptote
          </Button>
        </div>
        <label className="block text-sm">
          Graph title
          <Input
            value={config.title}
            onChange={(event) => change({ ...config, title: event.target.value })}
          />
        </label>
        <label className="block text-sm">
          Graph description
          <Textarea
            value={config.description}
            onChange={(event) => change({ ...config, description: event.target.value })}
          />
          <span className="text-xs text-stone-500">
            Describe the visible graph for students using screen readers. Do not put the answer
            here.
          </span>
        </label>
        <div className="grid grid-cols-2 gap-3 sm:grid-cols-4">
          {(['xMin', 'xMax', 'yMin', 'yMax'] as const).map((key) => (
            <NumberField
              key={key}
              label={key}
              value={config[key]}
              onChange={(value) => change({ ...config, [key]: value })}
            />
          ))}
        </div>
        <p className="text-xs text-stone-500">
          Formulas use x, + − * / ^, parentheses, pi, e, sin, cos, tan, sqrt, abs, ln, log (natural
          logarithm), exp. Write 2*x, not 2x. Trigonometric inputs use radians.
        </p>
        {config.curves.map((curve, index) => (
          <fieldset
            key={index}
            className="space-y-3 rounded-lg border border-stone-200 p-3 dark:border-stone-700"
          >
            <legend className="px-1 text-sm font-medium">Function piece {index + 1}</legend>
            <label className="block text-xs">
              y =
              <Input
                aria-label={`Formula ${index + 1}`}
                value={curve.expression}
                onChange={(event) =>
                  change({
                    ...config,
                    curves: config.curves.map((item, i) =>
                      i === index ? { ...item, expression: event.target.value } : item,
                    ),
                  })
                }
              />
            </label>
            <div className="grid grid-cols-2 gap-3">
              {(['min', 'max'] as const).map((key) => (
                <NumberField
                  key={key}
                  label={key === 'min' ? 'From x' : 'To x'}
                  value={curve[key]}
                  onChange={(value) =>
                    change({
                      ...config,
                      curves: config.curves.map((item, i) =>
                        i === index ? { ...item, [key]: value } : item,
                      ),
                    })
                  }
                />
              ))}
              {(['start', 'end'] as const).map((key) => (
                <label key={key} className="text-xs">
                  {key === 'start' ? 'Left endpoint' : 'Right endpoint'}
                  <select
                    className="mt-1 block h-10 w-full rounded border border-stone-300 bg-white px-2 dark:border-stone-700 dark:bg-stone-950"
                    value={curve[key] ?? 'none'}
                    onChange={(event) =>
                      change({
                        ...config,
                        curves: config.curves.map((item, i) =>
                          i === index ? { ...item, [key]: event.target.value as Endpoint } : item,
                        ),
                      })
                    }
                  >
                    <option value="none">No marker</option>
                    <option value="open">Open circle</option>
                    <option value="closed">Filled circle</option>
                  </select>
                </label>
              ))}
            </div>
            <Button
              type="button"
              variant="ghost"
              size="sm"
              onClick={() =>
                change({ ...config, curves: config.curves.filter((_, i) => i !== index) })
              }
            >
              Remove piece {index + 1}
            </Button>
          </fieldset>
        ))}
        <Button
          type="button"
          variant="outline"
          size="sm"
          disabled={config.curves.length >= 8}
          onClick={() =>
            change({
              ...config,
              curves: [...config.curves, { expression: 'x', min: config.xMin, max: config.xMax }],
            })
          }
        >
          Add function piece
        </Button>
        {config.points.map((point, index) => (
          <fieldset
            key={index}
            className="rounded-lg border border-stone-200 p-3 dark:border-stone-700"
          >
            <legend className="px-1 text-sm">Point {index + 1}</legend>
            <div className="grid grid-cols-2 gap-3">
              {(['x', 'y'] as const).map((key) => (
                <NumberField
                  key={key}
                  label={key}
                  value={point[key]}
                  onChange={(value) =>
                    change({
                      ...config,
                      points: config.points.map((item, i) =>
                        i === index ? { ...item, [key]: value } : item,
                      ),
                    })
                  }
                />
              ))}
              <label className="flex items-center gap-2 text-sm">
                <input
                  type="checkbox"
                  checked={!!point.open}
                  onChange={(event) =>
                    change({
                      ...config,
                      points: config.points.map((item, i) =>
                        i === index ? { ...item, open: event.target.checked } : item,
                      ),
                    })
                  }
                />
                Open circle
              </label>
              <Button
                type="button"
                variant="ghost"
                size="sm"
                onClick={() =>
                  change({ ...config, points: config.points.filter((_, i) => i !== index) })
                }
              >
                Remove point
              </Button>
            </div>
          </fieldset>
        ))}
        <Button
          type="button"
          variant="outline"
          size="sm"
          disabled={config.points.length >= 32}
          onClick={() => change({ ...config, points: [...config.points, { x: 0, y: 0 }] })}
        >
          Add marked point
        </Button>
        <GraphBlock source={raw} />
        {error && (
          <p role="alert" className="text-sm text-red-600 dark:text-red-400">
            {error}
          </p>
        )}
        <Button
          type="button"
          disabled={!!error}
          onClick={() => {
            onInsert(graphMarkdown(parseGraph(raw)));
            setInserted(true);
          }}
        >
          Insert graph into question
        </Button>
        {inserted && (
          <p role="status" className="text-sm text-emerald-700 dark:text-emerald-300">
            Graph inserted. Review the question preview, then save the question.
          </p>
        )}
      </div>
    </details>
  );
}
