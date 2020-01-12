---- DROP TABLE IF EXISTS release_issues ; 

SELECT 'create the "release_issues" table'
; 
   CREATE TABLE release_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , type           varchar (30) NOT NULL DEFAULT 'task'
    , category       varchar (30) NOT NULL DEFAULT 'category ...'
    , status         varchar (20) NOT NULL DEFAULT 'status ...'
    , prio           integer NOT NULL DEFAULT 0
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , owner          varchar (20) NOT NULL DEFAULT 'unknown'
    , version        varchar (20) NOT NULL DEFAULT 'current'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_release_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_release_issues_id on release_issues (id);

-- the rank search index
CREATE INDEX idx_rank_release_issues ON release_issues
USING gin(to_tsvector('English', name || ' ' || description || 'owner')); 


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.release_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_release_issues BEFORE UPDATE ON release_issues FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'release_issues'::regclass;

