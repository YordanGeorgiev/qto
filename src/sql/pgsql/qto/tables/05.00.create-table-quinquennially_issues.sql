-- DROP TABLE IF EXISTS quinquennially_issues ; 

SELECT 'create the "quinquennially_issues" table'
; 
   CREATE TABLE quinquennially_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , category       varchar (30) NOT NULL DEFAULT 'category...'
    , type           varchar (30) NOT NULL DEFAULT 'task...'
    , status         varchar (20) NOT NULL DEFAULT 'status...'
    , prio           integer NOT NULL DEFAULT 1
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (1000)
    , start_time     text NOT NULL DEFAULT to_char(date_trunc('minute', now()::time),'HH24:MI')
    , stop_time      text NOT NULL DEFAULT to_char(date_trunc('minute', now()::time),'HH24:MI')
    , owner          varchar (100) NOT NULL DEFAULT 'none'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_quinquennially_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_quinquennially_issues_id on quinquennially_issues (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.quinquennially_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_quinquennially_issues BEFORE UPDATE ON quinquennially_issues FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'quinquennially_issues'::regclass;

