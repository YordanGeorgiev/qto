-- DROP TABLE IF EXISTS monthly_issues_202005 ; 

SELECT 'create the "monthly_issues_202005" table'
; 

CREATE TABLE public.monthly_issues_202005 (
    guid uuid DEFAULT public.gen_random_uuid() NOT NULL,
    id bigint DEFAULT (to_char(CURRENT_TIMESTAMP, 'YYMMDDHH12MISS'::text))::bigint NOT NULL,
    category_guid uuid DEFAULT '70724562-d83c-446e-94cf-58ced84f3a0e'::uuid NOT NULL,
    issues_status_guid uuid DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'::uuid NOT NULL,
    prio integer DEFAULT 0 NOT NULL,
    name character varying(100) DEFAULT 'name...'::character varying NOT NULL,
    description character varying(4000),
    app_users_guid uuid DEFAULT public.gen_random_uuid(),
    type character varying(30) DEFAULT 'task'::character varying NOT NULL,
    update_time timestamp without time zone DEFAULT date_trunc('second'::text, now())
);

create unique index idx_uniq_monthly_issues_202005_id on monthly_issues_202005 (id);

-- the rank search index
CREATE INDEX idx_rank_monthly_issues_202005 ON monthly_issues_202005
USING gin(to_tsvector('English', name || ' ' || description || 'owner')); 


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.monthly_issues_202005'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_monthly_issues_202005 BEFORE UPDATE ON monthly_issues_202005 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'monthly_issues_202005'::regclass;

