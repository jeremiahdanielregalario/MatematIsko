-- ============================================================================
-- Insert MATH 146 Course
-- ============================================================================

INSERT INTO public.courses (id, code, name, description)
VALUES (
  '609dc463-1524-494d-bf0f-91859a2e4cf4', -- Using the ID from the existing catalog migration
  'MATH 146',
  'Introduction to Differential Geometry',
  'Elementary topology; calculus of several variables; curves and surfaces; theorems of Stokes and Gauss; differential forms.'
)
ON CONFLICT (code) DO UPDATE SET
  name = EXCLUDED.name,
  description = EXCLUDED.description;
