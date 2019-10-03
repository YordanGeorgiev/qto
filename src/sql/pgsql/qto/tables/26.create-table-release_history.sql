              -- DROP TABLE IF EXISTS release_history ; 

SELECT 'create the "release_history" table'
; 
   CREATE TABLE release_history (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , category       varchar (30) NOT NULL DEFAULT 'category...'
    , status         varchar (20) NOT NULL DEFAULT 'status...'
    , name           varchar (100) NOT NULL DEFAULT 'name...' 
    , description    varchar (4000)
    , owner          varchar (20) NOT NULL DEFAULT 'who?!..'
    , version        varchar (20) NOT NULL DEFAULT 'v0.0.0'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_release_history_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_release_history_id on release_history (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.release_history'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_release_history 
   BEFORE UPDATE ON release_history FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'release_history'::regclass;

