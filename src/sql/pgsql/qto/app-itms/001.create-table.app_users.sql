-- file: src/sql/pgsql/qto/tables/34.create-table-app_users.sql
-- v0.8.3

SELECT 'create the "app_users" table'
; 
   CREATE TABLE app_users (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (100) NOT NULL DEFAULT 'name...'
    , email          varchar (200) UNIQUE NOT NULL DEFAULT 'email...'
    , password       varchar (200) NOT NULL DEFAULT 'password...'
    , status         smallint NOT NULL DEFAULT 1 -- 0-disabled,1-active...
    , description    varchar (200) NULL DEFAULT 'description...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_app_users_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_app_users_uniq_id on app_users (id);

-- the initial passwords are pio-pass, test.anonymous.user-pass etc...
INSERT INTO public.app_users (guid, id, name, email, password, status, description) VALUES 
   ('02d16010-20af-4b0d-be86-cdf116a7d8c7', 190709193352, 'test product instance owner', 'pio@gmail.com', '{CRYPT}$2a$08$v54Mn36v9BXPnhCFydH1TeQjxR340BLBMKqhSt1zmh1OioamCp/oq' , 1 , 'the product instance owner');

INSERT INTO public.app_users (guid, id, name, email, password, status, description) VALUES 
   ('2660a6e9-9e6b-4faa-8264-27a92872657b', 190707231513, 'test anonymous user', 'test.anonymous.user@gmail.com', '{CRYPT}$2a$08$UTxmWBQhkhfR.nh140oqu.BkJdL9GTINoiEzvXK5bdxjjQcwFMuE6', 1, 'the test user');

INSERT INTO public.app_users (guid, id, name, email, password, status, description) VALUES 
   ('2660a6e9-9e6b-4faa-8264-27a92872657c', 200107231510, 'the test reader user', 'test.reader.user@gmail.com', '{CRYPT}$2a$08$/Z3BoSd2cOO1Enb4xckj9Ocl/8dWGzUxlyaI0fDLveDSEPHQh6XiG', 1, 'the test user');

INSERT INTO public.app_users (guid, id, name, email, password, status, description) VALUES 
   ('2660a6e9-9e6b-4faa-8264-27a92872657d', 200107231511 , 'the test editor user', 'test.editor.user@gmail.com', '{CRYPT}$2a$08$3ZfAkbDUJTQdK6CZ.TEi6OBLIIERs/WVuk52dC7BeDxm0chKpsVY2', 1, 'the test user');
SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.app_users'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

   CREATE TRIGGER trg_set_update_time_on_app_users BEFORE UPDATE ON app_users 
      FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time()
   ;

   select tgname
   from pg_trigger
   where not tgisinternal
   and tgrelid = 'app_users'::regclass
   ;


