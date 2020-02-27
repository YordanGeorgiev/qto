-- DROP TABLE IF EXISTS ideas ; 

SELECT 'create the "ideas" table'
; 
   CREATE TABLE ideas (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NULL default 0
    , ideas_status_guid UUID NOT NULL DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NOT NULL DEFAULT 'description ...'
    , owner          varchar (50) NOT NULL DEFAULT 'unknown' 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_ideas_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_ideas_uniq_id on ideas (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.ideas'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_ideas BEFORE UPDATE ON ideas FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'ideas'::regclass;
