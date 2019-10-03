              -- DROP TABLE IF EXISTS naming_conventions ; 

SELECT 'create the "naming_conventions" table'
; 
   CREATE TABLE naming_conventions (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NULL
    , weight         integer NULL
    , category       varchar (20) NOT NULL DEFAULT 'category ...'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NULL
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , tags           varchar (50) NULL
    , CONSTRAINT pk_naming_conventions_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.naming_conventions'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_naming_conventions_upsrt_update_time 
   BEFORE UPDATE ON naming_conventions 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'naming_conventions'::regclass;
