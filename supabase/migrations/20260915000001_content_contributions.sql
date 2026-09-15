-- Private submission queue. Published study tables contain approved content only.
create table public.content_contributions (
  id uuid primary key,
  author_id uuid not null references public.profiles(id) on delete cascade,
  author_name text not null,
  kind text not null check (kind in ('question', 'note')),
  course_id uuid not null references public.courses(id) on delete cascade,
  title text not null check (length(btrim(title)) between 1 and 300),
  payload jsonb not null,
  status text not null default 'pending' check (status in ('pending', 'approved', 'rejected')),
  review_note text,
  reviewed_by uuid references public.profiles(id) on delete set null,
  reviewed_at timestamptz,
  published_id uuid,
  created_at timestamptz not null default now()
);
create index content_contributions_author_idx on public.content_contributions(author_id, created_at desc, id);
create index content_contributions_status_idx on public.content_contributions(status, created_at desc, id);
alter table public.content_contributions enable row level security;
revoke all on public.content_contributions from public, anon, authenticated;
grant select on public.content_contributions to authenticated;
create policy contributions_read on public.content_contributions for select to authenticated
  using (author_id = auth.uid() or public.is_admin());

create function public.submit_content_contribution(p_id uuid, p_kind text, p_course_id uuid, p_title text, p_payload jsonb)
returns public.content_contributions
language plpgsql security definer set search_path = public
as $function$
declare
  result public.content_contributions;
  author_label text;
  field text;
begin
  if auth.uid() is null then raise exception 'Sign in to contribute' using errcode = '42501'; end if;
  if p_id is null or p_kind is null or p_kind not in ('question', 'note')
     or p_course_id is null or length(btrim(coalesce(p_title, ''))) not between 1 and 300
     or p_payload is null or jsonb_typeof(p_payload) <> 'object' or octet_length(p_payload::text) > 300000 then
    raise exception 'Invalid contribution';
  end if;
  if not exists(select 1 from public.courses where id = p_course_id) then raise exception 'Course not found'; end if;
  foreach field in array case when p_kind = 'question' then array['question_text','answer','solution','exam_name'] else array['content'] end loop
    if jsonb_typeof(p_payload->field) is distinct from 'string' or btrim(p_payload->>field) = '' then
      raise exception 'Required field is missing: %', field;
    end if;
  end loop;
  if p_kind = 'question' then
    if (p_payload->>'difficulty') is null or (p_payload->>'difficulty') not in ('easy','medium','hard')
       or coalesce((p_payload->>'year')::integer, 0) not between 1900 and 2200
       or coalesce((p_payload->>'question_number')::integer, 0) not between 1 and 10000 then
      raise exception 'Invalid question metadata';
    end if;
    if not exists(select 1 from public.topics where id = (p_payload->>'topic_id')::uuid and course_id = p_course_id) then
      raise exception 'Topic does not belong to the selected course';
    end if;
    -- Strip caller-supplied IDs, status, ownership and unknown fields.
    p_payload := jsonb_build_object('topic_id',p_payload->>'topic_id','difficulty',p_payload->>'difficulty',
      'year',(p_payload->>'year')::integer,'question_number',(p_payload->>'question_number')::integer,
      'exam_name',p_payload->>'exam_name','question_text',p_payload->>'question_text',
      'answer',p_payload->>'answer','solution',p_payload->>'solution','hint',p_payload->>'hint');
  else
    p_payload := jsonb_build_object('content',p_payload->>'content');
  end if;
  select coalesce(nullif(btrim(full_name), ''), 'Student') into author_label from public.profiles where id = auth.uid();
  insert into public.content_contributions(id, author_id, author_name, kind, course_id, title, payload)
    values(p_id, auth.uid(), author_label, p_kind, p_course_id, btrim(p_title), p_payload)
    on conflict (id) do nothing returning * into result;
  if result.id is null then
    select * into result from public.content_contributions where id = p_id and author_id = auth.uid()
      and kind = p_kind and course_id = p_course_id and title = btrim(p_title) and payload = p_payload;
    if result.id is null then raise exception 'Submission reference is already in use. Start a new submission.'; end if;
  end if;
  return result;
end;
$function$;
revoke all on function public.submit_content_contribution(uuid,text,uuid,text,jsonb) from public, anon;
grant execute on function public.submit_content_contribution(uuid,text,uuid,text,jsonb) to authenticated;

create function public.admin_review_contribution(p_id uuid, p_decision text, p_review_note text default null)
returns public.content_contributions
language plpgsql security definer set search_path = public
as $function$
declare
  item public.content_contributions;
  content_id uuid;
  next_order integer;
begin
  if auth.uid() is null or not public.is_admin() then raise exception 'Only administrators can review contributions' using errcode = '42501'; end if;
  if p_decision is null or p_decision not in ('approved', 'rejected') then raise exception 'Invalid review decision'; end if;
  if length(coalesce(p_review_note, '')) > 2000 then raise exception 'Feedback must be at most 2000 characters'; end if;
  if p_decision = 'rejected' and btrim(coalesce(p_review_note, '')) = '' then raise exception 'Explain what needs to change before rejecting'; end if;
  select * into item from public.content_contributions where id = p_id for update;
  if item.id is null then raise exception 'Contribution not found'; end if;
  -- Retries and simultaneous approvals cannot publish duplicates or overwrite a decision.
  if item.status = p_decision then return item; end if;
  if item.status <> 'pending' then raise exception 'This contribution has already been reviewed'; end if;
  if p_decision = 'approved' then
    if item.kind = 'question' then
      if not exists(select 1 from public.topics where id = (item.payload->>'topic_id')::uuid and course_id = item.course_id) then
        raise exception 'The selected topic is no longer available for this course';
      end if;
      insert into public.questions(course_id,topic_id,title,question_text,difficulty,year,exam_name,question_number,answer,solution,hint)
        values(item.course_id,(item.payload->>'topic_id')::uuid,item.title,item.payload->>'question_text',
          item.payload->>'difficulty',(item.payload->>'year')::integer,item.payload->>'exam_name',
          (item.payload->>'question_number')::integer,item.payload->>'answer',item.payload->>'solution',item.payload->>'hint')
        returning id into content_id;
    else
      perform 1 from public.courses where id = item.course_id for update;
      select coalesce(max(sort_order), -1) + 1 into next_order from public.course_notes where course_id = item.course_id;
      insert into public.course_notes(course_id,title,content,sort_order)
        values(item.course_id,item.title,item.payload->>'content',next_order) returning id into content_id;
    end if;
  end if;
  update public.content_contributions set status = p_decision, review_note = nullif(btrim(p_review_note), ''),
    reviewed_by = auth.uid(), reviewed_at = now(), published_id = content_id
    where id = item.id returning * into item;
  return item;
end;
$function$;
revoke all on function public.admin_review_contribution(uuid,text,text) from public, anon;
grant execute on function public.admin_review_contribution(uuid,text,text) to authenticated;
