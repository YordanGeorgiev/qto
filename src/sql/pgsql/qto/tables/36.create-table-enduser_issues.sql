DROP TABLE IF EXISTS enduser_issues ; 

SELECT 'create the "enduser_issues" table'
; 
   CREATE TABLE enduser_issues (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , type           varchar (30) NOT NULL DEFAULT 'bug/wish/..'
    , weight         integer NOT NULL DEFAULT 9
    , category       varchar (30) NOT NULL DEFAULT 'category...'
    , status         varchar (20) NOT NULL DEFAULT 'status...'
    , prio           integer NOT NULL DEFAULT 0
    , name           varchar (100) NOT NULL DEFAULT 'short-title...'
    , description    varchar (4000) DEFAULT 'what was expected...what happened actually ?'
    , owner          varchar (20) NOT NULL DEFAULT 'unknown'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_enduser_issues_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_enduser_issues_id on enduser_issues (id);

-- the rank search index
CREATE INDEX idx_rank_enduser_issues ON enduser_issues
USING gin(to_tsvector('English', name || ' ' || description || 'owner')); 


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.enduser_issues'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_enduser_issues BEFORE UPDATE ON enduser_issues FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'enduser_issues'::regclass;

