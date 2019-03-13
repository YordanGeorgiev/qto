DROP TABLE IF EXISTS app_user ; 

SELECT 'create the "app_user" table'
; 
   CREATE TABLE app_user (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NULL DEFAULT 'name...'
    , email          varchar (200) NOT NULL DEFAULT 'email...'
    , password       varchar (200) NOT NULL DEFAULT 'password...'
    , description    varchar (200) NOT NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_user_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_app_user_uniq_id on app_user (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_user'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_app_user BEFORE UPDATE ON app_user 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'app_user'::regclass;

