-- DROP TABLE IF EXISTS monthly_issues_202006 ; 

SELECT 'create the "monthly_issues_202006" table'
; 

CREATE TABLE public.monthly_issues_202006 (
    guid uuid DEFAULT public.gen_random_uuid() NOT NULL,
    id bigint DEFAULT (to_char(CURRENT_TIMESTAMP, 'YYMMDDHH12MISS'::text))::bigint NOT NULL,
    deadline timestamp without time zone DEFAULT date_trunc('second'::text, now()),
    category_guid uuid DEFAULT '70724562-d83c-446e-94cf-58ced84f3a0e'::uuid NOT NULL,
    status_guid uuid DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'::uuid NOT NULL,
    prio integer DEFAULT 0 NOT NULL,
    name character varying(100) DEFAULT 'name...'::character varying NOT NULL,
    description character varying(4000),
    app_users_guid uuid DEFAULT public.gen_random_uuid(),
    update_time timestamp without time zone DEFAULT date_trunc('second'::text, now())
);

create unique index idx_uniq_monthly_issues_202006_id on monthly_issues_202006 (id);

-- the rank search index
CREATE INDEX idx_rank_monthly_issues_202006 ON monthly_issues_202006
USING gin(to_tsvector('English', name || ' ' || description || 'owner')); 


SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.monthly_issues_202006'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_monthly_issues_202006 BEFORE UPDATE ON monthly_issues_202006 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'monthly_issues_202006'::regclass;

