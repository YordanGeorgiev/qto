-- file: src/sql/pgsql/qto/app-itms/002.create-table.app_roles.sql
-- v0.8.4

-- \echo 'If necessary, perform -- DROP TABLE IF EXISTS app_roles;'

-- \echo '1. Creating the app_roles table'

CREATE TABLE app_roles (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NOT NULL DEFAULT 'Role name'
    , level          smallint NOT NULL DEFAULT 1000
    , description    varchar (200) NULL DEFAULT ''
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_roles_guid PRIMARY KEY (guid)
    );

CREATE unique index idx_app_roles_uniq_id
	ON app_roles (id);


INSERT INTO app_roles 
   ( guid, id, name, level, description )
VALUES
   ('71eea083-d818-4557-89fe-29eb950881aa', 1, 'PRODUCT_INSTANCE_OWNER', 0, 'Product instance owner'),
   ('71eea083-d818-4557-89fe-29eb950881ac', 2, 'EDITOR', 2, 'Has the right to edit content'),
   ('71eea083-d818-4557-89fe-29eb950881ad', 3, 'READER', 7, 'Has the right to read content'),
   ('71eea083-d818-4557-89fe-29eb950881ab', 4, 'ANONYMOUS', 1000, 'Non-registered user having access to instance');


-- \echo 'List columns of the created table app_roles'
SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid='public.app_roles'::regclass
   AND    attnum>0
   AND    NOT attisdropped
   ORDER  BY attnum ; 

-- \echo 'Update time on every EXECUTE trigger:'
CREATE TRIGGER trg_set_update_time_on_app_roles
	BEFORE UPDATE ON app_roles 
	FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
	FROM pg_trigger
	WHERE NOT tgisinternal
	AND tgrelid='app_roles'::regclass;