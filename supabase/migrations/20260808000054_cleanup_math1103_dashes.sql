-- ============================================================================
-- Replace --- separators with em dashes in MATH 110.3 notes
-- ============================================================================

update public.course_notes
set content = regexp_replace(content, ' --- ', ' — ', 'g'),
    updated_at = now()
where id = 'e5f6a7b8-c9d0-4e1f-a2b3-c4d5e6f7a8b9';
