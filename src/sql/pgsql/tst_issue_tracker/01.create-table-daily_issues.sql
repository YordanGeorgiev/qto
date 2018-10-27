-- DROP TABLE IF EXISTS daily_issues ; 

SELECT 'create the "daily_issues" table'
; 
   CREATE TABLE daily_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NOT NULL DEFAULT 1
    , weight         integer NOT NULL DEFAULT 9
    , status         varchar (50) NOT NULL DEFAULT 'status ...'
    , category       varchar (200) NOT NULL DEFAULT 'category ...'
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , type           varchar (50) NOT NULL DEFAULT 'task'
    , owner          varchar (50) NOT NULL DEFAULT 'unknown'
    , start_time     timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , stop_time      timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , planned_hours  decimal (6,2) NULL
    , actual_hours   decimal (6,2) NULL
    , tags           varchar (200)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_daily_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_daily_issues_id on daily_issues (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.daily_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


--The trigger:
CREATE TRIGGER trg_set_update_time_on_daily_issues BEFORE UPDATE ON daily_issues FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'daily_issues'::regclass;

