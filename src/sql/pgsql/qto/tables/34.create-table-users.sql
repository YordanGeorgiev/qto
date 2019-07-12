DROP TABLE IF EXISTS users ; 

SELECT 'create the "users" table'
; 
   CREATE TABLE users (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , email          varchar (200) UNIQUE NOT NULL DEFAULT 'email...'
    , password       varchar (200) NOT NULL DEFAULT 'password...'
    , description    varchar (200) NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_users_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_users_uniq_id on users (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.users'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_users BEFORE UPDATE ON users 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'users'::regclass;

INSERT INTO public.users (guid, id, name, email, password, description, update_time) VALUES ('2660a6e9-9e6b-4faa-8264-27a92872657b', 190707231513, 'test user', 'test.user@gmail.com', '{CRYPT}$2a$08$/Z3BoSd2cOO1Enb4xckj9Ocl/8dWGzUxlyaI0fDLveDSEPHQh6XiG', NULL, '2019-07-07 23:20:20');
INSERT INTO public.users (guid, id, name, email, password, description, update_time) VALUES ('02d16010-20af-4b0d-be86-cdf116a7d8c7', 190709193352, 'ysg', 'yordan.georgiev@gmail.com', '{CRYPT}$2a$08$XaP0t.LxDtUZUFzAMbolMu1OoxLiErhlstQGQzaEnF15AyUFQVuKm', 'the product instance owner', '2019-07-09 19:34:29');
