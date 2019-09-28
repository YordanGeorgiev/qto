     -- DROP TABLE IF EXISTS confs ; 

SELECT 'create the "confs" table'
; 
   CREATE TABLE confs (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , seq            integer NULL
    , prio           integer NULL
    , category       varchar (30) NOT NULL DEFAULT 'category ...'
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , value          varchar (200)
    , description    varchar (400)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_confs_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.confs'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_confs BEFORE UPDATE ON confs FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'confs'::regclass;

