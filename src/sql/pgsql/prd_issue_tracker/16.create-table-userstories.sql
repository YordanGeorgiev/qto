-- DROP TABLE IF EXISTS userstories ; 

SELECT 'create the "userstories" table'
; 
   CREATE TABLE userstories (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , weight         integer NOT NULL DEFAULT 9
    , status         varchar (50) NOT NULL DEFAULT 'status ...'
    , category       varchar (200) NOT NULL DEFAULT 'category ...'
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , owner          varchar (50) NOT NULL DEFAULT 'unknown'
    , tags           varchar (200)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_userstories_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_userstories_id on userstories (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.userstories'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_userstories BEFORE UPDATE ON userstories FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'userstories'::regclass;

