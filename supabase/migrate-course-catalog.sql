-- ============================================================================
-- Course Catalog Migration
-- Updates existing courses to the official UP Math catalog names and
-- inserts all courses from the provided catalog. Safe to re-run.
-- ============================================================================

-- ---------------------------------------------------------------------------
-- 1. Merge old "MATH 121 Modern Algebra" questions/topics into MATH 110.1
-- ---------------------------------------------------------------------------
-- Move topics that belonged to the placeholder Modern Algebra course.
insert into public.topics (id, course_id, name, description)
select
  t.id,
  'cd574181-02fb-4093-9e23-f268fea6baff',
  t.name,
  t.description
from public.topics t
where t.course_id = 'c0000000-0000-4000-8000-000000000005'
on conflict (course_id, name) do nothing;

-- Move questions referencing the old Modern Algebra course.
update public.questions
set course_id = 'cd574181-02fb-4093-9e23-f268fea6baff'
where course_id = 'c0000000-0000-4000-8000-000000000005';

-- Remove the placeholder course row (its content now lives under MATH 110.1).
delete from public.courses
where id = 'c0000000-0000-4000-8000-000000000005';

-- ---------------------------------------------------------------------------
-- 2. Rename existing courses to their official catalog codes/names
-- ---------------------------------------------------------------------------
update public.courses
set code = 'MATH 40', name = 'Linear Algebra'
where id = 'c0000000-0000-4000-8000-000000000003';

update public.courses
set code = 'MATH 126', name = 'Real Analysis'
where id = 'c0000000-0000-4000-8000-000000000004';

update public.courses
set code = 'MATH 122', name = 'Differential Equations and Applications'
where id = 'c0000000-0000-4000-8000-000000000006';

update public.courses
set code = 'MATH 142', name = 'Elementary Topology'
where id = 'c0000000-0000-4000-8000-000000000009';

update public.courses
set name = 'Abstract Algebra I'
where id = 'cd574181-02fb-4093-9e23-f268fea6baff';

-- ---------------------------------------------------------------------------
-- 3. Insert the full catalog (renamed courses update in place, new ones added)
-- ---------------------------------------------------------------------------
insert into public.courses (id, code, name, description) values
  ('c0000000-0000-4000-8000-000000000001', 'MATH 21', 'Elementary Analysis I', 'Limits, continuity, and differentiation of single-variable functions.'),
  ('c0000000-0000-4000-8000-000000000002', 'MATH 22', 'Elementary Analysis II', 'Definite integrals, integration techniques, sequences and series.'),
  ('c0000000-0000-4000-8000-000000000003', 'MATH 40', 'Linear Algebra', 'Systems of linear equations, vector spaces, linear transformations, and eigenvalues.'),
  ('c0000000-0000-4000-8000-000000000004', 'MATH 126', 'Real Analysis', 'Sequences, limits, continuity, and differentiability on the real line.'),
  ('c0000000-0000-4000-8000-000000000006', 'MATH 122', 'Differential Equations and Applications', 'First-order and linear second-order ordinary differential equations.'),
  ('c0000000-0000-4000-8000-000000000009', 'MATH 142', 'Elementary Topology', 'Metric and topological spaces, open sets, compactness, and connectedness.'),
  ('cd574181-02fb-4093-9e23-f268fea6baff', 'MATH 110.1', 'Abstract Algebra I', 'Groups, rings, fields, ideals, homomorphisms, and fields of quotients.'),
  ('789feaf3-7a97-4b89-b15a-8df1c829f3d5', 'MATH 20', 'Precalculus: Functions and their Graphs', null),
  ('d3485837-0c50-4398-8b0a-ffb7c9fb124c', 'MATH 23', 'Elementary Analysis III', null),
  ('7576a751-3f12-4cda-9322-9de2933e5fc4', 'MATH 108', 'Foundations of Abstract Mathematics', null),
  ('7e4a2549-1495-4df2-a58c-b2fe4f4ae68c', 'MATH 110.2', 'Abstract Algebra II', null),
  ('9f9a5e39-6e48-4ae6-a455-37c3a5cfb4ab', 'MATH 110.3', 'Abstract Algebra III', null),
  ('896694f7-bb16-4889-9d30-e420a4519e48', 'MATH 117', 'Elementary Theory of Numbers', null),
  ('816a9f4b-634d-4849-8b19-00544f1d8a6e', 'MATH 123.1', 'Advanced Calculus I', null),
  ('18324841-e967-45c4-8ec9-c5267defe480', 'MATH 123.2', 'Advanced Calculus II', null),
  ('f2320f48-d0dc-4d1b-8bb0-2ca4997ec072', 'MATH 128', 'Complex Analysis', null),
  ('2604a996-9cfe-4924-906a-36ef04720b74', 'MATH 131', 'Elementary Set Theory', null),
  ('56de71e9-a366-4101-9aa8-33c2f4039fc7', 'MATH 133', 'Introduction to Mathematical Modeling', null),
  ('49c4929b-cf0d-4541-9819-d9c364d3b8df', 'MATH 140', 'Introduction to Modern Geometries', null),
  ('609dc463-1524-494d-bf0f-91859a2e4cf4', 'MATH 146', 'Introduction to Differential Geometry', null),
  ('91959100-9356-482c-a89e-0e350542be7b', 'MATH 147', 'Introduction to Algebraic Geometry', null),
  ('c97251be-a5b0-4deb-b6ba-79a06142e497', 'MATH 148', 'Introduction to Projective Geometry', null),
  ('08caf103-b0d9-4125-812f-04ac5a684955', 'MATH 150.1', 'Mathematical Statistics I', null),
  ('382dbd9f-43d0-4bc6-a0cc-2e204b83b9cc', 'MATH 150.2', 'Mathematical Statistics II', null),
  ('b2e10744-de71-405d-a6f9-e7f23a1bcab7', 'MATH 158', 'Introduction to Discrete Mathematics', null),
  ('b7e0974a-2bea-4e63-9969-8d7793c712bb', 'MATH 160', 'Mathematics of Life Insurance', null),
  ('ac0ec5eb-1c92-4af7-bba6-176adc6eb80f', 'MATH 162', 'Theory of Interest', null),
  ('6f3af6ab-2635-4ca8-8f94-6b181aa4d39a', 'MATH 164', 'Mathematics of Life Contingencies', null),
  ('15565f87-430f-482d-854c-2f0a31819964', 'MATH 166', 'Mathematics of Finance', null),
  ('5a90feae-6af2-4639-9813-7c56004a654a', 'MATH 171', 'Introduction to Numerical Analysis', null),
  ('4b3b64fe-6c14-4e7e-8648-24dd74aa0bae', 'MATH 180.1', 'Operations Research I', null)
on conflict (code) do update
  set name = excluded.name, description = excluded.description;
