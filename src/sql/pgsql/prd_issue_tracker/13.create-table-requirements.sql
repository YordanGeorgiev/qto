-- DROP TABLE IF EXISTS requirements ; 

SELECT 'create the "requirements" table'
; 
   CREATE TABLE requirements (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , weight         integer NOT NULL DEFAULT 9
    , status         varchar (50) NOT NULL DEFAULT 'type the status ...'
    , category       varchar (200) NOT NULL DEFAULT 'type the category ...'
    , name           varchar (200) NOT NULL DEFAULT 'type the name ...'
    , description    varchar (4000)
    , owner          varchar (50) NOT NULL DEFAULT 'unknown'
    , tags           varchar (200)
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
CREATE TRIGGER trg_set_update_time_on_requirements BEFORE UPDATE ON requirements FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'requirements'::regclass;

