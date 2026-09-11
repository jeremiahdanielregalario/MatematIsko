import { createRoot } from 'react-dom/client';
import { useState } from 'react';
import { GraphBuilder } from './src/components/admin/GraphBuilder';
import { MathRenderer } from './src/components/math/MathRenderer';
import { graphMarkdown, LIMIT_GRAPH } from './src/lib/graph';
import './src/index.css';
function Preview() {
 const [content,setContent]=useState('Use the graph to determine $\\lim_{x\\to 2} f(x)$ and compare it with $f(2)$.'+graphMarkdown(LIMIT_GRAPH));
 return <main className="mx-auto max-w-3xl space-y-5 p-4"><button onClick={()=>document.documentElement.classList.toggle('dark')}>Toggle theme</button><h1 className="font-serif text-2xl">Graph authoring preview</h1><GraphBuilder onInsert={(text)=>setContent(text)} /><MathRenderer>{content}</MathRenderer></main>;
}
createRoot(document.getElementById('root')!).render(<Preview/>);
