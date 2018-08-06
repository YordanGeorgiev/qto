-- DROP TABLE IF EXISTS check_lists ; 

SELECT 'create the "check_lists" table'
; 
   CREATE TABLE check_lists (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , seq            integer NULL
    , prio           integer NOT NULL DEFAULT 1
    , status         varchar (50) NOT NULL DEFAULT 'type the status ...'
    , category       varchar (200) NOT NULL DEFAULT 'type the category ...'
    , name           varchar (200) NOT NULL DEFAULT 'type the name ...'
    , description    varchar (4000)
    , CONSTRAINT pk_check_lists_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_check_lists_id on check_lists (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.check_lists'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_check_lists BEFORE UPDATE ON check_lists FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'check_lists'::regclass;
