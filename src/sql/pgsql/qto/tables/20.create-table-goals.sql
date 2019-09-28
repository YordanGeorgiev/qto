      -- DROP TABLE IF EXISTS goals ; 

SELECT 'create the "goals" table'
; 
   CREATE TABLE goals (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , status         varchar (20) NOT NULL DEFAULT 'status ...'
    , category       varchar (20) NOT NULL DEFAULT 'category ...'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NOT NULL DEFAULT 'desc ...'
    , seq            integer NULL
    , weight         integer NOT NULL DEFAULT 9
    , update_time    timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_goals_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.goals'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


--The trigger:
CREATE TRIGGER trg_set_update_time_on_goals BEFORE UPDATE ON goals FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'goals'::regclass;
