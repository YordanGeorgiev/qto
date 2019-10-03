             -- DROP TABLE IF EXISTS system_guide_doc CASCADE;

SELECT 'create the "system_guide_doc" table'
; 
   CREATE TABLE system_guide_doc (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            bigint  NULL
    , rgt            bigint  NULL
    , prio           integer NOT NULL DEFAULT 1
    , status         varchar (20) NOT NULL DEFAULT 'status...'
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (4000)
    , src            varchar (4000)
    , formats  text NULL
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , runtime        varchar (20) NULL DEFAULT 'runtime...'
    , CONSTRAINT pk_system_guide_doc_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_system_guide_doc_id on system_guide_doc (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.system_guide_doc'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
   CREATE TRIGGER trg_set_update_time_on_system_guide_doc 
   BEFORE UPDATE ON system_guide_doc 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'system_guide_doc'::regclass;

