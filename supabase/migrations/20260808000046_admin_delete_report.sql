-- ============================================================================
-- Admin delete reports
-- Allows admins to permanently remove reports from the database.
-- ============================================================================

create or replace function public.admin_delete_report(
  p_table text,
  p_id uuid
)
returns void
language plpgsql
security definer
set search_path = public
as $$
begin
  if not public.is_admin() then
    raise exception 'Only administrators can delete reports';
  end if;
  if p_table = 'question_reports' then
    delete from public.question_reports where id = p_id;
  elsif p_table = 'theorem_reports' then
    delete from public.theorem_reports where id = p_id;
  else
    raise exception 'Invalid table name';
  end if;
end;
$$;

revoke execute on function public.admin_delete_report(text, uuid) from public, anon;
grant execute on function public.admin_delete_report(text, uuid) to authenticated;
