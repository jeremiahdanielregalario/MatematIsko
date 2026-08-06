/**
 * Decode JSON-style Unicode escape sequences (`\uXXXX`) into their
 * actual characters. Non-escape text passes through unchanged.
 *
 * Safe against LaTeX commands: only matches `\u` followed by exactly
 * 4 hex digits (e.g. `\u27E8` → `⟨`), which never occurs in valid
 * LaTeX (`\underline`, `\upsilon`, etc. have alphabetic continuations).
 */
export function decodeUnicodeEscapes(value: string): string {
  return value.replace(/\\u([0-9a-fA-F]{4})/g, (_, hex: string) =>
    String.fromCharCode(parseInt(hex, 16)),
  );
}
