create function touch_updated_at() returns trigger language plpgsql as $$ begin new.updated_at=now(); return new; end; $$;
create table campaigns (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),name text not null unique check(trim(name)<>''), owner text not null check(trim(owner)<>''), objective text not null, closes_on date not null, currency text not null default 'NZD' check(currency ~ '^[A-Z]{3}$'), budget numeric(14,2) not null default 0 check(budget>=0), status text not null default 'open' check(status in ('open','closed')));
create trigger touch_campaigns before update on campaigns for each row execute function touch_updated_at();
alter table campaigns enable row level security;
revoke all on campaigns from public;
create table ideas (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),campaign_id uuid not null references campaigns(id), name text not null check(trim(name)<>''), description text not null default '', submitter text not null default '', owner text not null default '', department text not null default '', stage text not null default 'submitted' check(stage in ('submitted','review','pilot','implemented','rejected')), review_due date, last_activity date not null default current_date, purpose text not null default '', retention_review date, confidential boolean not null default true, external_id text, source_stage text not null default '', source_data jsonb not null default '{}'::jsonb, unique(campaign_id,external_id));
create trigger touch_ideas before update on ideas for each row execute function touch_updated_at();
alter table ideas enable row level security;
revoke all on ideas from public;
create table criteria (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),campaign_id uuid not null references campaigns(id), name text not null check(trim(name)<>''), weight numeric(8,2) not null check(weight>0), unique(campaign_id,name));
create trigger touch_criteria before update on criteria for each row execute function touch_updated_at();
alter table criteria enable row level security;
revoke all on criteria from public;
create table reviews (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),idea_id uuid not null references ideas(id), criterion_id uuid not null references criteria(id), reviewer text not null check(trim(reviewer)<>''), score integer not null check(score between 1 and 5), rationale text not null check(trim(rationale)<>''), unique(idea_id,criterion_id,reviewer));
create trigger touch_reviews before update on reviews for each row execute function touch_updated_at();
alter table reviews enable row level security;
revoke all on reviews from public;
create table pilots (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),idea_id uuid not null unique references ideas(id), name text not null check(trim(name)<>''), owner text not null check(trim(owner)<>''), hypothesis text not null check(trim(hypothesis)<>''), metric text not null check(trim(metric)<>''), baseline numeric not null, target numeric not null, actual numeric, cost numeric(14,2) not null check(cost>=0), due_date date not null, status text not null default 'running' check(status in ('running','passed','failed')), evidence text not null default '', direction text not null check(direction in ('increase','decrease')), approved_by text not null);
create trigger touch_pilots before update on pilots for each row execute function touch_updated_at();
alter table pilots enable row level security;
revoke all on pilots from public;
create table outcomes (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),idea_id uuid not null references ideas(id), name text not null check(trim(name)<>''), amount numeric(14,2) not null check(amount>=0), period_start date not null, period_end date not null, evidence text not null check(trim(evidence)<>''), recorded_by text not null, verified_by text, verified_at timestamptz, check(period_end>=period_start), unique(idea_id,period_start,period_end), check((verified_by is null)=(verified_at is null)));
create trigger touch_outcomes before update on outcomes for each row execute function touch_updated_at();
alter table outcomes enable row level security;
revoke all on outcomes from public;
create table decisions (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),idea_id uuid not null references ideas(id), action text not null, actor text not null, reason text not null, from_stage text not null, to_stage text not null);
create trigger touch_decisions before update on decisions for each row execute function touch_updated_at();
alter table decisions enable row level security;
revoke all on decisions from public;
create table notes (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),idea_id uuid not null references ideas(id), actor text not null, body text not null check(trim(body)<>''));
create trigger touch_notes before update on notes for each row execute function touch_updated_at();
alter table notes enable row level security;
revoke all on notes from public;
create table audit_log (id uuid primary key default gen_random_uuid(), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),actor text not null, action text not null, entity text not null, record_id uuid, before_data jsonb, after_data jsonb);
create trigger touch_audit_log before update on audit_log for each row execute function touch_updated_at();
alter table audit_log enable row level security;
revoke all on audit_log from public;

create unique index reviews_case_reviewer on reviews(idea_id,criterion_id,lower(trim(reviewer)));
create index ideas_campaign on ideas(campaign_id);
create index reviews_idea on reviews(idea_id);
create index outcomes_idea on outcomes(idea_id);
create function guard_review() returns trigger language plpgsql as $$
begin
 if not exists(select 1 from ideas i join criteria c on c.campaign_id=i.campaign_id where i.id=new.idea_id and c.id=new.criterion_id) then raise exception 'Criterion belongs to another campaign'; end if;
 if exists(select 1 from ideas where id=new.idea_id and lower(trim(submitter))=lower(trim(new.reviewer))) then raise exception 'Submitters cannot score their own ideas'; end if;
 return new;
end; $$;
create trigger review_guard before insert or update on reviews for each row execute function guard_review();
create view idea_scores as
with per_criterion as (
 select i.id idea_id,c.id criterion_id,c.weight,avg(r.score) mean_score,count(r.id) reviews
 from ideas i join criteria c on c.campaign_id=i.campaign_id
 left join reviews r on r.idea_id=i.id and r.criterion_id=c.id group by i.id,c.id,c.weight
)
select i.id,i.name,c.name campaign,i.owner,i.stage,
 (select count(*) from criteria where campaign_id=i.campaign_id)::int criteria,
 (select count(*) from per_criterion p where p.idea_id=i.id and p.reviews>0)::int covered,
 (select count(distinct lower(trim(reviewer))) from reviews where idea_id=i.id)::int reviewers,
 (select round(sum(p.mean_score*p.weight)/nullif(sum(p.weight),0),2) from per_criterion p where p.idea_id=i.id and p.mean_score is not null) weighted_score,
 (select count(*) from (select lower(trim(r.reviewer)) from reviews r where r.idea_id=i.id group by lower(trim(r.reviewer)) having count(distinct r.criterion_id)=(select count(*) from criteria where campaign_id=i.campaign_id)) x)::int complete_reviewers
from ideas i join campaigns c on c.id=i.campaign_id;
create view campaign_summary as
select c.id,c.name,c.owner,c.currency,c.budget,
 (select count(*) from ideas i where i.campaign_id=c.id)::int ideas,
 coalesce((select sum(p.cost) from pilots p join ideas i on i.id=p.idea_id where i.campaign_id=c.id),0) committed,
 coalesce((select sum(o.amount) from outcomes o join ideas i on i.id=o.idea_id where i.campaign_id=c.id and o.verified_by is not null),0) verified_outcomes
from campaigns c;
create view attention_items as
select 'Unowned idea' kind,c.name campaign,i.name item,i.owner,i.review_due due_date from ideas i join campaigns c on c.id=i.campaign_id where i.owner='' and i.stage not in ('implemented','rejected')
union all select 'Review overdue',c.name,i.name,i.owner,i.review_due from ideas i join campaigns c on c.id=i.campaign_id where i.stage in ('submitted','review') and i.review_due<current_date
union all select 'Quiet idea',c.name,i.name,i.owner,i.last_activity from ideas i join campaigns c on c.id=i.campaign_id where i.stage not in ('implemented','rejected') and i.last_activity<current_date-14
union all select 'Pilot overdue',c.name,p.name,p.owner,p.due_date from pilots p join ideas i on i.id=p.idea_id join campaigns c on c.id=i.campaign_id where p.status='running' and p.due_date<current_date
union all select 'Outcome unverified',c.name,o.name,i.owner,o.period_end from outcomes o join ideas i on i.id=o.idea_id join campaigns c on c.id=i.campaign_id where o.verified_by is null;
create view compliance_findings as
select 'NZ-IPP9 / AU-APP11' rule,name item,'Review lawful purpose and retention date; do not delete automatically' finding from ideas where purpose='' or retention_review is null or retention_review<current_date
union all select 'LOCAL-OWNER',name,'Open idea has no accountable owner' from ideas where owner='' and stage not in ('implemented','rejected')
union all select 'LOCAL-EVIDENCE',name,'Finished pilot needs result evidence' from pilots where status<>'running' and evidence=''
union all select 'LOCAL-INDEPENDENCE',name,'Outcome verifier matches recorder' from outcomes where lower(trim(recorded_by))=lower(trim(verified_by));
