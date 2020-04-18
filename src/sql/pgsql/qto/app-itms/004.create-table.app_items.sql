-- DROP TABLE IF EXISTS app_items ; 

SELECT 'create the "app_items" table'
; 
   CREATE TABLE app_items (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigserial UNIQUE 
    , prio           integer NOT NULL DEFAULT 1
    , name           varchar (200) NOT NULL DEFAULT 'name...'
    , ver            varchar (10) NOT NULL DEFAULT 'version...'
    , description    varchar (4000) DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_items_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_app_items_id on app_items (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_items'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_app_items BEFORE UPDATE ON app_items FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'app_items'::regclass;

