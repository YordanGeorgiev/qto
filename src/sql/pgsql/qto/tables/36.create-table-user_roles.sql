-- DROP TABLE IF EXISTS user_roles ; 

SELECT 'create the "user_roles" table'
; 
   CREATE TABLE user_roles (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , users_guid     UUID NOT NULL DEFAULT gen_random_uuid()
    , roles_guid     UUID NOT NULL DEFAULT gen_random_uuid()
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , description    varchar (200) NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_user_roles_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_user_roles_uniq_id on user_roles (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.user_roles'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

CREATE TRIGGER trg_set_update_time_on_user_roles BEFORE UPDATE ON user_roles 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'user_roles'::regclass;

