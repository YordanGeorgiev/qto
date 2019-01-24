DROP TABLE IF EXISTS requirements CASCADE;

SELECT 'create the "requirements" table'
; 
   CREATE TABLE requirements (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            bigint  NULL
    , rgt            bigint  NULL
    , weight         integer NOT NULL DEFAULT 1
    , prio           integer NOT NULL DEFAULT 1
    , status         varchar (20) NOT NULL DEFAULT 'status ...'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , src            varchar (4000)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_requirements_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_requirements_id on requirements (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.requirements'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
   CREATE TRIGGER trg_set_update_time_on_requirements 
   BEFORE UPDATE ON requirements 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'requirements'::regclass;

