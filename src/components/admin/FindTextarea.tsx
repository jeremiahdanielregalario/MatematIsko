import { useEffect, useMemo, useRef, useState } from 'react';
import type { Ref } from 'react';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Textarea, type TextareaProps } from '@/components/ui/textarea';

// Measure wrapped source with the textarea's typography so distant matches are visible.
function revealMatch(input: HTMLTextAreaElement, start: number, end: number) {
  input.setSelectionRange(start, end);
  const mirror = document.createElement('div');
  const style = getComputedStyle(input);
  for (const property of [
    'font',
    'letter-spacing',
    'line-height',
    'padding',
    'tab-size',
    'word-break',
  ]) {
    mirror.style.setProperty(property, style.getPropertyValue(property));
  }
  Object.assign(mirror.style, {
    position: 'absolute',
    visibility: 'hidden',
    boxSizing: 'border-box',
    width: `${input.clientWidth}px`,
    whiteSpace: 'pre-wrap',
    overflowWrap: 'break-word',
  });
  mirror.textContent = input.value.slice(0, start);
  const marker = document.createElement('span');
  marker.textContent = input.value.slice(start, end) || ' ';
  mirror.append(marker);
  document.body.append(mirror);
  input.scrollTop = Math.max(0, marker.offsetTop - input.clientHeight / 2);
  mirror.remove();
}

export function FindTextarea({
  value,
  ref,
  onKeyDown,
  ...props
}: TextareaProps & {
  value: string;
  ref?: Ref<HTMLTextAreaElement>;
}) {
  const source = useRef<HTMLTextAreaElement>(null);
  const search = useRef<HTMLInputElement>(null);
  const [open, setOpen] = useState(false);
  const [query, setQuery] = useState('');
  const [position, setPosition] = useState(0);
  const matches = useMemo(() => {
    if (!query) return [];
    const escaped = query.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    return Array.from(value.matchAll(new RegExp(escaped, 'gi')), (match) => ({
      start: match.index,
      end: match.index + match[0].length,
    }));
  }, [value, query]);
  const current = Math.min(position, Math.max(0, matches.length - 1));
  useEffect(() => {
    if (open && matches[current] && source.current && document.activeElement !== source.current) {
      revealMatch(source.current, matches[current].start, matches[current].end);
    }
  }, [open, matches, current]);
  const showFind = () => {
    const input = source.current;
    const selected = input?.value.slice(input.selectionStart, input.selectionEnd);
    if (selected) setQuery(selected);
    setPosition(0);
    setOpen(true);
    requestAnimationFrame(() => {
      search.current?.focus();
      search.current?.select();
    });
  };
  const close = () => {
    setOpen(false);
    source.current?.focus();
  };
  const navigate = (direction: number) => {
    if (!matches.length) return;
    const next = (current + direction + matches.length) % matches.length;
    setPosition(next);
    if (source.current) {
      if (document.activeElement !== search.current) source.current.focus({ preventScroll: true });
      revealMatch(source.current, matches[next].start, matches[next].end);
    }
  };
  return (
    <div
      className="min-w-0 space-y-2"
      onKeyDown={(event) => {
        if ((event.ctrlKey || event.metaKey) && event.key.toLowerCase() === 'f') {
          event.preventDefault();
          showFind();
        } else if (open && event.key === 'Escape') {
          event.preventDefault();
          event.stopPropagation();
          close();
        }
      }}
    >
      <Button type="button" variant="outline" size="sm" onClick={showFind} aria-expanded={open}>
        Find
      </Button>
      {open && (
        <div
          className="flex flex-wrap items-center gap-2"
          role="group"
          aria-label="Find in Markdown"
        >
          <Input
            ref={search}
            aria-label="Find in Markdown"
            placeholder="Find in Markdown…"
            className="min-w-0 flex-1 basis-40"
            value={query}
            onChange={(event) => {
              setQuery(event.target.value);
              setPosition(0);
            }}
            onKeyDown={(event) => {
              if (event.key === 'Enter') {
                event.preventDefault();
                navigate(event.shiftKey ? -1 : 1);
              }
            }}
          />
          <span role="status" className="text-xs text-stone-500">
            {!query
              ? 'Enter text to find'
              : matches.length
                ? `${current + 1} of ${matches.length}`
                : 'No matches'}
          </span>
          <Button
            type="button"
            variant="outline"
            size="sm"
            disabled={!matches.length}
            onClick={() => navigate(-1)}
          >
            Previous
          </Button>
          <Button
            type="button"
            variant="outline"
            size="sm"
            disabled={!matches.length}
            onClick={() => navigate(1)}
          >
            Next
          </Button>
          <Button type="button" variant="ghost" size="sm" onClick={close}>
            Close find
          </Button>
          <p className="w-full text-xs text-stone-500">
            Case-insensitive · Enter / Shift+Enter to navigate · Esc to close
          </p>
        </div>
      )}
      <Textarea
        {...props}
        value={value}
        ref={(element) => {
          source.current = element;
          if (typeof ref === 'function') return ref(element);
          if (ref) ref.current = element;
        }}
        onKeyDown={(event) => {
          onKeyDown?.(event);
          if (open && query && event.key === 'Enter' && (event.ctrlKey || event.metaKey)) {
            event.preventDefault();
            navigate(event.shiftKey ? -1 : 1);
          }
        }}
      />
    </div>
  );
}
