import React from 'react';
import {createRoot} from 'react-dom/client';
import {UsersAdminSection} from './src/components/admin/UsersAdminSection';
import './src/index.css';
createRoot(document.getElementById('root')!).render(<main style={{maxWidth:1100,margin:'auto',padding:20}}><button onClick={()=>document.documentElement.classList.toggle('dark')}>Toggle theme</button><UsersAdminSection/></main>);
