// @vitest-environment node
import { readFileSync } from 'node:fs';
import { runInNewContext } from 'node:vm';
import { describe, expect, it, vi } from 'vitest';

function worker() {
  const handlers: Record<string, (event: unknown) => void> = {};
  const cache = { addAll: vi.fn(), put: vi.fn(), match: vi.fn() };
  const caches = {
    open: vi.fn(async () => cache),
    keys: vi.fn(async () => ['matematisko-v1', 'other-app']),
    delete: vi.fn(),
  };
  const claim = vi.fn();
  const fetch = vi.fn(async () => ({ ok: true, type: 'basic', clone: () => ({}) }));
  runInNewContext(readFileSync('public/sw.js', 'utf8'), {
    self: {
      location: { origin: 'https://study.test' },
      addEventListener: (name: string, handler: (event: unknown) => void) => {
        handlers[name] = handler;
      },
      skipWaiting: vi.fn(),
      clients: { claim },
    },
    caches,
    fetch,
    URL,
    Response,
  });
  return { handlers, caches, cache, claim, fetch };
}

describe('service worker data boundaries', () => {
  it.each([
    ['https://database.test/rest/v1/progress', 'GET', {}],
    ['https://study.test/questions/123', 'GET', {}],
    ['https://study.test/manifest.json?user=123', 'GET', {}],
    ['https://study.test/manifest.json', 'GET', { authorization: 'Bearer test' }],
    ['https://study.test/manifest.json', 'POST', {}],
  ])('does not intercept private or non-static requests: %s %s', (url, method, headers) => {
    const { handlers, fetch } = worker();
    const respondWith = vi.fn();
    handlers.fetch({ request: new Request(url, { method, headers }), respondWith });
    expect(respondWith).not.toHaveBeenCalled();
    expect(fetch).not.toHaveBeenCalled();
  });

  it('removes legacy app caches without deleting another app cache', async () => {
    const { handlers, caches, claim } = worker();
    let completion: Promise<unknown> | undefined;
    handlers.activate({
      waitUntil: (value: Promise<unknown>) => {
        completion = value;
      },
    });
    await completion;
    expect(caches.delete).toHaveBeenCalledExactlyOnceWith('matematisko-v1');
    expect(claim).toHaveBeenCalledOnce();
  });

  it('falls back to the cached public icon when offline', async () => {
    const { handlers, fetch, cache } = worker();
    fetch.mockRejectedValueOnce(new Error('offline'));
    const cached = new Response('icon');
    cache.match.mockResolvedValue(cached);
    let response: Promise<Response> | undefined;
    handlers.fetch({
      request: new Request('https://study.test/icons/icon.svg'),
      respondWith: (value: Promise<Response>) => {
        response = value;
      },
    });
    expect(await response).toBe(cached);
  });
});
