DROP TABLE IF EXISTS sklad ; 

SELECT 'create the "sklad" table'
; 
   CREATE TABLE sklad (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , type           varchar (30) NOT NULL DEFAULT 'task'
    , count          integer NOT NULL DEFAULT 9
    , status         varchar (20) NOT NULL DEFAULT 'status ...'
    , prio           integer NOT NULL DEFAULT 0
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_sklad_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_sklad_id on sklad (id);

-- the rank search index
CREATE INDEX idx_rank_sklad ON sklad
USING gin(to_tsvector('English', name || ' ' || description || 'owner')); 


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.sklad'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_sklad BEFORE UPDATE ON sklad FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'sklad'::regclass;

