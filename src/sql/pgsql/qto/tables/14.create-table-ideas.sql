-- DROP TABLE IF EXISTS ideas ; 

SELECT 'create the "ideas" table'
; 
   CREATE TABLE ideas (
    guid uuid DEFAULT public.gen_random_uuid() NOT NULL,
    id bigint DEFAULT (to_char(CURRENT_TIMESTAMP, 'YYMMDDHH12MISS'::text))::bigint NOT NULL,
    app_users_guid uuid DEFAULT '2660a6e9-9e6b-4faa-8264-27a92872657b'::uuid NOT NULL,
    prio integer DEFAULT 0,
    ideas_status_guid uuid DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'::uuid NOT NULL,
    name character varying(100) DEFAULT 'name ...'::character varying NOT NULL,
    description character varying(4000) DEFAULT 'description ...'::character varying NOT NULL,
    owner character varying(50) DEFAULT 'unknown'::character varying NOT NULL,
    update_time timestamp without time zone DEFAULT date_trunc('second'::text, now())
    , CONSTRAINT pk_ideas_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_ideas_uniq_id on ideas (id);


SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.ideas'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_ideas BEFORE UPDATE ON ideas FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'ideas'::regclass;
