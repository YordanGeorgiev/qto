-- file: src/sql/pgsql/qto/app-itms/003.create-table.app_items_roles_permissions.sql
-- v0.8.4

-- \echo 'If necessary, perform -- DROP TABLE IF EXISTS app_items_roles_permissions;' 

-- \echo '4. Creating the app_items_roles_permissions table'

CREATE TABLE app_items_roles_permissions (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             BIGSERIAL UNIQUE NOT NULL 
    , app_roles_guid     UUID NOT NULL DEFAULT gen_random_uuid()
    , allowed        bool default true
    , app_routes_guid UUID NOT NULL DEFAULT gen_random_uuid()
    , app_items_guid UUID NOT NULL DEFAULT gen_random_uuid()
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (200) NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_items_roles_permissions_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_app_items_roles_permissions_uniq_id on app_items_roles_permissions (id);


SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_items_roles_permissions'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

CREATE TRIGGER trg_set_update_time_on_app_items_roles_permissions BEFORE UPDATE ON app_items_roles_permissions 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'app_items_roles_permissions'::regclass;

