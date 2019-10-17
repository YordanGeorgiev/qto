 ---- DROP TABLE IF EXISTS check_lists ; 

SELECT 'create the "check_lists" table'
; 
   CREATE TABLE check_lists (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 0
    , status         varchar (20) NOT NULL DEFAULT 'status?!...'
    , owner          varchar (30) NOT NULL DEFAULT 'kuka?!...'
    , name           varchar (200) NOT NULL DEFAULT 'mikä?..'
    , description    varchar (4000)
    , type           varchar (30) DEFAULT 'laji/tyyppi?...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
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


select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'check_lists'::regclass;
