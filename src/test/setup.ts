import '@testing-library/jest-dom/vitest';
import { cleanup } from '@testing-library/react';
import { afterEach } from 'vitest';

class TestStorage {
  #store = new Map<string, string>();

  get length(): number {
    return this.#store.size;
  }

  clear(): void {
    this.#store.clear();
  }

  getItem(key: string): string | null {
    return this.#store.get(String(key)) ?? null;
  }

  key(index: number): string | null {
    return [...this.#store.keys()][index] ?? null;
  }

  removeItem(key: string): void {
    this.#store.delete(String(key));
  }

  setItem(key: string, value: string): void {
    this.#store.set(String(key), String(value));
  }
}

if (typeof window !== 'undefined') {
  const local = new TestStorage();
  const session = new TestStorage();
  for (const target of [window, globalThis]) {
    Object.defineProperty(target, 'Storage', {
      value: TestStorage,
      configurable: true,
      writable: true,
    });
    Object.defineProperty(target, 'localStorage', {
      value: local,
      configurable: true,
      writable: true,
    });
    Object.defineProperty(target, 'sessionStorage', {
      value: session,
      configurable: true,
      writable: true,
    });
  }
  if (typeof HTMLCanvasElement !== 'undefined') {
    HTMLCanvasElement.prototype.getContext = (() => null) as typeof HTMLCanvasElement.prototype.getContext;
  }
}

afterEach(() => {
  cleanup();
});
