import { useContext, type ReactNode } from 'react';
import { WatermarkEmailContext } from './watermarkContext';

export function QuestionWatermark({ children }: { children: ReactNode }) {
  const email = useContext(WatermarkEmailContext);
  if (!email) return <>{children}</>;

  // Escape XML before embedding the authenticated email in an SVG text node.
  const escaped = email.replace(
    /[<>&"']/g,
    (character) =>
      ({ '<': '&lt;', '>': '&gt;', '&': '&amp;', '"': '&quot;', "'": '&apos;' })[character]!,
  );
  // Enhanced SVG: Two overlapping layers with slightly different positions and opacity to increase complexity.
  const tile = `<svg xmlns="http://www.w3.org/2000/svg" width="320" height="160">
    <text x="160" y="80" text-anchor="middle" transform="rotate(-15 160 80)" fill="#888888" fill-opacity="0.1" font-family="sans-serif" font-size="11" textLength="280" lengthAdjust="spacingAndGlyphs">${escaped}</text>
    <text x="162" y="82" text-anchor="middle" transform="rotate(-15 160 80)" fill="#888888" fill-opacity="0.08" font-family="sans-serif" font-size="11" textLength="280" lengthAdjust="spacingAndGlyphs">${escaped}</text>
  </svg>`;

  return (
    <div className="question-watermark-content">
      {children}
      <div
        aria-hidden="true"
        data-testid="question-watermark"
        className="question-watermark"
        style={{ backgroundImage: `url("data:image/svg+xml,${encodeURIComponent(tile)}")` }}
      />
      <p className="mt-2 break-all text-right text-[10px] leading-normal text-stone-400 dark:text-stone-500">
        Personal study copy · {email}
      </p>
    </div>
  );
}
