-- file: src/sql/pgsql/qto/tables/39.create-table-security_checklist_doc.sql
-- v0.7.8
-- DROP TABLE IF EXISTS security_checklist_doc CASCADE;

SELECT 'create the "security_checklist_doc" table'
; 
   CREATE TABLE security_checklist_doc (
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
    , CONSTRAINT pk_security_checklist_doc_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_security_checklist_doc_id on security_checklist_doc (id);



SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.security_checklist_doc'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
   CREATE TRIGGER trg_set_update_time_on_security_checklist_doc 
   BEFORE UPDATE ON security_checklist_doc 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'security_checklist_doc'::regclass;

