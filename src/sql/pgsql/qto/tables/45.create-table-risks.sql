-- DROP TABLE IF EXISTS risks ; 

SELECT 'create the "risks" table'
; 
   CREATE TABLE risks (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NULL default 0
    , status         varchar (50) NOT NULL DEFAULT 'unknown' 
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NOT NULL DEFAULT 'description ...'
    , owner          varchar (50) NOT NULL DEFAULT 'unknown' 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_risks_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_risks_uniq_id on risks (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.risks'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_risks BEFORE UPDATE ON risks FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'risks'::regclass;
