-- DROP TABLE IF EXISTS skills ; 

SELECT 'create the "skills" table'
; 
   CREATE TABLE skills (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , seq            integer NULL
    , prio           integer NULL
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NOT NULL DEFAULT 'description ...'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_skills_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_skills_uniq_id on skills (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.skills'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_skills BEFORE UPDATE ON skills FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'skills'::regclass;
