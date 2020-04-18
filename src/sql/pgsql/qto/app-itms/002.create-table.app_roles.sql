-- file: src/sql/pgsql/qto/app-itms/002.create-table.app_roles.sql
-- v0.8.3

-- DROP TABLE IF EXISTS app_roles ; 

SELECT 'create the "app_roles" table'
; 
   CREATE TABLE app_roles (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , level          smallint NOT NULL DEFAULT 1000 -- the anonymous role
    , description    varchar (200) NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_roles_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_app_roles_uniq_id on app_roles (id);


INSERT INTO app_roles 
   ( guid , id , name , level , description )
VALUES
   ( '71eea083-d818-4557-89fe-29eb950881aa' , '0' , 'PRODUCT_INSTANCE_OWNER', 0 , 'the product instance owner')
; 
INSERT INTO app_roles 
   ( guid , id , name , level , description )
VALUES
   ( '71eea083-d818-4557-89fe-29eb950881ab' , '1' , 'ANONYMOUS', 1000 , 'Any non-registered user having access to the instance')
; 
INSERT INTO app_roles 
   ( guid , id , name , level , description )
VALUES
   ( '71eea083-d818-4557-89fe-29eb950881ad' , '2' , 'READER', 7 , 'Has the right to read content')
; 
INSERT INTO app_roles 
   ( guid , id , name , level , description )
VALUES
   ( '71eea083-d818-4557-89fe-29eb950881ac' , '3' , 'EDITOR', 2 , 'Has generally the right to edit content')
; 




SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_roles'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_app_roles BEFORE UPDATE ON app_roles 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'app_roles'::regclass;

