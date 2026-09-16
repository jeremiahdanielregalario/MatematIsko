import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';

/** Visual deterrents only: browser UI cannot prevent or reliably detect screenshots. */
export function StudyPrivacy({ userId, watermark }: { userId: string; watermark: boolean }) {
  const [covered, setCovered] = useState(() => document.hidden || !document.hasFocus());
  const [timestamp, setTimestamp] = useState(() => new Date().toISOString().slice(0, 16));

  useEffect(() => {
    const sync = () => setCovered(document.hidden || !document.hasFocus());
    const blur = () => setCovered(true);
    window.addEventListener('blur', blur);
    window.addEventListener('focus', sync);
    document.addEventListener('visibilitychange', sync);
    const timer = window.setInterval(() => {
      setTimestamp(new Date().toISOString().slice(0, 16));
    }, 60_000);
    return () => {
      window.removeEventListener('blur', blur);
      window.removeEventListener('focus', sync);
      document.removeEventListener('visibilitychange', sync);
      window.clearInterval(timer);
    };
  }, []);

  // Auth UUID only; never put names, email addresses or access tokens in captures.
  const account = userId.replace(/[^a-zA-Z0-9-]/g, '').slice(0, 13);
  const label = `MatematIsko · ${account} · ${timestamp.replace('T', ' ')} UTC`;
  const tile = `<svg xmlns="http://www.w3.org/2000/svg" width="360" height="180"><text x="180" y="90" text-anchor="middle" transform="rotate(-20 180 90)" fill="#888888" fill-opacity="0.22" font-family="sans-serif" font-size="11">${label}</text></svg>`;

  return createPortal(
    <>
      {watermark && (
        <div
          aria-hidden="true"
          data-testid="study-watermark"
          className="study-watermark"
          style={{ backgroundImage: `url("data:image/svg+xml,${encodeURIComponent(tile)}")` }}
        />
      )}
      {covered && (
        <div className="study-privacy-cover" role="status">
          <div className="max-w-sm px-6 text-center">
            <p className="text-lg font-semibold">Study view hidden</p>
            <p className="mt-2 text-sm text-stone-600 dark:text-stone-400">
              Return to this window to continue. Your work stays in place; exam timers keep running.
            </p>
          </div>
        </div>
      )}
    </>,
    document.body,
  );
}
