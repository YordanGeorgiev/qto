                -- DROP TABLE IF EXISTS principles ; 

SELECT 'create the "principles" table'
; 
   CREATE TABLE principles (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NULL DEFAULT 0
    , weight         integer NULL
    , category       varchar (20) NOT NULL DEFAULT 'category ...'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NULL
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , tags           varchar (50) NULL
    , CONSTRAINT pk_principles_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.principles'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_principles BEFORE UPDATE ON principles FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'principles'::regclass;
