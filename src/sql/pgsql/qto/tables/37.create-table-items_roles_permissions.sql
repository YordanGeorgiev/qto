-- DROP TABLE IF EXISTS items_roles_permissions ; 

SELECT 'create the "items_roles_permissions" table'
; 
   CREATE TABLE items_roles_permissions (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             BIGSERIAL UNIQUE NOT NULL 
    , roles_guid     UUID NOT NULL DEFAULT gen_random_uuid()
    , allowed        bool default true
    , meta_routes_guid UUID NOT NULL DEFAULT gen_random_uuid()
    , app_items_guid UUID NOT NULL DEFAULT gen_random_uuid()
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (200) NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_items_roles_permissions_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_items_roles_permissions_uniq_id on items_roles_permissions (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.items_roles_permissions'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

CREATE TRIGGER trg_set_update_time_on_items_roles_permissions BEFORE UPDATE ON items_roles_permissions 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'items_roles_permissions'::regclass;

