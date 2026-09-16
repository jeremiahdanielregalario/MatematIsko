import { useEffect, useState } from 'react';
import { createPortal } from 'react-dom';

/** Visual deterrents only: browser UI cannot prevent or reliably detect screenshots. */
export function StudyPrivacy() {
  const [covered, setCovered] = useState(() => document.hidden || !document.hasFocus());

  useEffect(() => {
    const sync = () => setCovered(document.hidden || !document.hasFocus());
    const blur = () => setCovered(true);
    window.addEventListener('blur', blur);
    window.addEventListener('focus', sync);
    document.addEventListener('visibilitychange', sync);
    return () => {
      window.removeEventListener('blur', blur);
      window.removeEventListener('focus', sync);
      document.removeEventListener('visibilitychange', sync);
    };
  }, []);

  return createPortal(
    <>
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
