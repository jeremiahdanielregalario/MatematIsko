-- Preserve existing reports, including legacy duplicates, while reserving each
-- open question/category atomically across RPC and direct table writes.
lock table public.question_reports in share row exclusive mode;

create table public.open_question_report_reasons (
  question_id uuid not null,
  category text not null,
  report_count integer not null check (report_count >= 0),
  primary key (question_id, category)
);
alter table public.open_question_report_reasons enable row level security;
revoke all on public.open_question_report_reasons from public, anon, authenticated;

insert into public.open_question_report_reasons
select question_id, category, count(*)::integer
from public.question_reports where status = 'open'
group by question_id, category;

create function public.guard_question_report_reason()
returns trigger language plpgsql security definer set search_path = '' as $guard$
begin
  if TG_OP = 'UPDATE' then
    if old.status = new.status and old.question_id = new.question_id and old.category = new.category then
      return null;
    end if;
  end if;

  if TG_OP in ('UPDATE', 'DELETE') then
    if old.status = 'open' then
      update public.open_question_report_reasons
      set report_count = report_count - 1
      where question_id = old.question_id and category = old.category;
      delete from public.open_question_report_reasons
      where question_id = old.question_id and category = old.category and report_count = 0;
    end if;
  end if;

  if TG_OP in ('INSERT', 'UPDATE') then
    if new.status = 'open' then
      begin
        insert into public.open_question_report_reasons values (new.question_id, new.category, 1);
      exception when unique_violation then
        raise exception using errcode = 'P0001',
          message = 'A report has already been sent for this question with the same reason. Please wait for it to be addressed.';
      end;
    end if;
  end if;
  return null;
end;
$guard$;
revoke all on function public.guard_question_report_reason() from public, anon, authenticated;

create trigger question_report_reason_guard
after insert or update or delete on public.question_reports
for each row execute function public.guard_question_report_reason();
