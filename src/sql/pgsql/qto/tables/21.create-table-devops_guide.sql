                -- DROP TABLE IF EXISTS devops_guide CASCADE;

SELECT 'create the "devops_guide" table'
; 
   CREATE TABLE devops_guide (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , status         varchar (20) NULL 
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    text NULL
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_devops_guide_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_devops_guide_id on devops_guide (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.devops_guide'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger for the update_time update: 
   CREATE TRIGGER trg_devops_guide_set_update_time 
   BEFORE UPDATE ON devops_guide 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'devops_guide'::regclass;

