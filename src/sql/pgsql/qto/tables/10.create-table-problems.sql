-- DROP TABLE IF EXISTS problems ; 

SELECT 'create the "problems" table'
; 
   CREATE TABLE problems (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , problems_status_guid uuid DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'::uuid NOT NULL
    , category       varchar (20) NOT NULL DEFAULT 'category ...'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NOT NULL DEFAULT 'desc ...'
    , solution_proposal varchar (4000) NULL
    , owner          varchar (50) NOT NULL DEFAULT 'none'
    , update_time    timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_problems_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.problems'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


--The trigger:
CREATE TRIGGER trg_set_update_time_on_problems BEFORE UPDATE ON problems FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'problems'::regclass;
