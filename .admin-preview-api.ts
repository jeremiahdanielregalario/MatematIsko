import type {Profile} from './src/types';
export {profileDraft,PROFILE_YEAR_LEVELS,ADMIN_USERS_PAGE_SIZE} from './src/lib/adminUsers';
let profiles = Array.from({length:28},(_,i)=>({id:String(i),email:`sample${i+1}@example.test`,full_name:`Sample Student ${i+1}`,degree_program:i%2?'BS Mathematics':'BS Applied Physics',year_level:'2nd Year',upmmc_member:i%2===0,avatar_url:null,created_at:'2026-09-01T00:00:00Z'})) as Profile[];
export async function adminListProfiles(search:string,page:number) { const found=profiles.filter(p=>`${p.full_name} ${p.email}`.toLowerCase().includes(search.toLowerCase()));return {users:found.slice(page*25,(page+1)*25),total:found.length}; }
export async function adminUpdateProfile(profile:Profile,draft:Partial<Profile>) {const next={...profile,...draft};profiles=profiles.map(p=>p.id===profile.id?next:p);return next;}
