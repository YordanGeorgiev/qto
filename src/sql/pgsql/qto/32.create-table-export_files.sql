DROP TABLE IF EXISTS export_files ; 

SELECT 'create the "export_files" table'
; 
   CREATE TABLE export_files (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , url            varchar (200) NOT NULL DEFAULT 'url...'
    , path           varchar (50) NULL DEFAULT 'rel-path-from-doc-root' 
    , name           varchar (100) NOT NULL DEFAULT 'the-export-file-name'
    , extension      varchar (50) NOT NULL DEFAULT 'the-file-extension' 
    , description    varchar (200) NOT NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_export_files_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_export_files_uniq_id on export_files (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.export_files'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_export_files BEFORE UPDATE ON export_files FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'export_files'::regclass;
