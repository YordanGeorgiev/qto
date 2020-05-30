SELECT 'create the "bugs" table'
; 

CREATE TABLE public.bugs (
    guid uuid DEFAULT public.gen_random_uuid() NOT NULL,
    id bigint DEFAULT (to_char(CURRENT_TIMESTAMP, 'YYMMDDHH12MISS'::text))::bigint NOT NULL,
    prio integer DEFAULT 1 NOT NULL,
    issues_status_guid uuid DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'::uuid NOT NULL,
    name character varying(100) DEFAULT 'name ...'::character varying NOT NULL,
    description character varying(4000) DEFAULT 'desc ...'::character varying NOT NULL,
    solution_proposal character varying(4000),
    location character varying(100),
    app_users_guid uuid DEFAULT '2660a6e9-9e6b-4faa-8264-27a92872657b'::uuid NOT NULL,
    category_guid uuid DEFAULT '70724562-d83c-446e-94cf-58ced84f3a0e'::uuid NOT NULL,
    update_time timestamp without time zone DEFAULT date_trunc('second'::text, now()) NOT NULL
    , CONSTRAINT pk_bugs_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.bugs'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


--The trigger:
CREATE TRIGGER trg_set_update_time_on_bugs BEFORE UPDATE ON bugs FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'bugs'::regclass;
