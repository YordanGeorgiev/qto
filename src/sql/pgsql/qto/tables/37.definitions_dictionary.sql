  ---- DROP TABLE IF EXISTS definitions_dictionary CASCADE;

SELECT 'create the "definitions_dictionary" table'
; 
   CREATE TABLE definitions_dictionary (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (4000) DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , runtime        varchar (20) NULL DEFAULT 'runtime...'
    , CONSTRAINT pk_definitions_dictionary_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_definitions_dictionary_id on definitions_dictionary (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.definitions_dictionary'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
   CREATE TRIGGER trg_set_update_time_on_definitions_dictionary 
   BEFORE UPDATE ON definitions_dictionary 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'definitions_dictionary'::regclass;

