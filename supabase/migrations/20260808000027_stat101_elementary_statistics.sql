-- ============================================================================
-- Consolidate STAT courses into STAT 101 — Elementary Statistics
-- The UP Diliman BS Math catalog has a single statistics course:
-- STAT 101 "Elementary Statistics". The placeholder STAT 102
-- (Statistical Methods II) is merged into STAT 101 and removed.
-- ============================================================================

-- Move STAT 102 topics under STAT 101 (Estimation, Hypothesis Testing).
update public.topics
set course_id = 'c0000000-0000-4000-8000-000000000007'
where course_id = 'c0000000-0000-4000-8000-000000000008';

-- Move STAT 102 questions under STAT 101.
update public.questions
set course_id = 'c0000000-0000-4000-8000-000000000007'
where course_id = 'c0000000-0000-4000-8000-000000000008';

-- Rename the consolidated course to the official catalog entry.
update public.courses
set code = 'STAT 101',
    name = 'Elementary Statistics',
    description = 'Elementary probability, descriptive statistics, estimation, and hypothesis testing.'
where id = 'c0000000-0000-4000-8000-000000000007';

-- Remove the placeholder STAT 102 course row (its content now lives under STAT 101).
delete from public.courses
where id = 'c0000000-0000-4000-8000-000000000008';
