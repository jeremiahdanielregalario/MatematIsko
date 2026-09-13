interface Node {
  type: string;
  value?: string;
  depth?: number;
  url?: string;
  children?: Node[];
  data?: Record<string, unknown>;
}

export interface NoteEnvironmentOptions {
  theorems?: { id: string; name: string }[];
}

const text = (node: Node): string => node.value ?? node.children?.map(text).join('') ?? '';
const normalize = (name: string) =>
  name
    .normalize('NFKD')
    .replace(/[\u0300-\u036f]/g, '')
    .toLowerCase()
    .replace(/['’]s\b/g, '')
    .replace(/\btheorem\b/g, '')
    .replace(/[^a-z0-9]/g, '');
const kind = (node: Node) =>
  node.type === 'heading'
    ? text(node)
        .match(/^(Theorem|Definition|Proof|Lemma|Corollary|Proposition)\b/i)?.[1]
        .toLowerCase()
    : node.type === 'paragraph' &&
        node.children?.[0]?.type === 'strong' &&
        /^Proof[.:]?$/i.test(text(node.children[0]))
      ? 'proof'
      : undefined;

/** Operate on parsed blocks so code, math, lists and Markdown links stay intact. */
export function remarkNoteEnvironments(options: NoteEnvironmentOptions = {}) {
  return (tree: Node) => {
    const visit = (parent: Node) => {
      if (!parent.children) return;
      const input = parent.children;
      const output: Node[] = [];
      for (let i = 0; i < input.length; i++) {
        const start = input[i];
        const environment = kind(start);
        if (!environment) {
          visit(start);
          output.push(start);
          continue;
        }
        const children = [start];
        while (
          i + 1 < input.length &&
          !(environment === 'proof' && /[∎□]\s*$/.test(text(children.at(-1)!)))
        ) {
          const next = input[i + 1];
          if (next.type === 'heading' || next.type === 'thematicBreak' || kind(next)) break;
          children.push(next);
          i++;
          // A printed end-of-proof marker provides a precise boundary.
          if (environment === 'proof' && /[∎□]\s*$/.test(text(next))) break;
        }
        children.slice(1).forEach(visit);
        if (environment !== 'proof' && environment !== 'definition') {
          const explicit = start.children?.find(
            (child) => child.type === 'link' && /^\/theorems\/[\w-]+$/.test(child.url ?? ''),
          );
          const name = text(start).replace(
            /^(Theorem|Lemma|Corollary|Proposition)\s*[:.]?\s*/i,
            '',
          );
          const matches = (options.theorems ?? []).filter((theorem) =>
            explicit
              ? theorem.id === explicit.url?.split('/').at(-1)
              : normalize(theorem.name) === normalize(name),
          );
          if (matches.length === 1)
            children.push({
              type: 'paragraph',
              data: { hProperties: { className: ['note-flashcard-link'] } },
              children: [
                {
                  type: 'link',
                  url: `/theorems/flashcards?theorem=${encodeURIComponent(matches[0].id)}`,
                  children: [{ type: 'text', value: 'Practice this theorem →' }],
                },
              ],
            });
        }
        output.push({
          type: 'noteEnvironment',
          data: {
            hName: 'section',
            hProperties: {
              className: ['note-environment', `note-environment-${environment}`],
              'aria-label': environment,
            },
          },
          children,
        });
      }
      parent.children = output;
    };
    visit(tree);
  };
}
