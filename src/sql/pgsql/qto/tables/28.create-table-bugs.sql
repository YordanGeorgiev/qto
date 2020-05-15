-- DROP TABLE IF EXISTS bugs ; 

SELECT 'create the "bugs" table'
; 
-- DROP TABLE bugs ; 

CREATE TABLE bugs (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , prio           integer NOT NULL DEFAULT 1
    , issues_status_guid uuid DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'::uuid NOT NULL
    , category_guid uuid DEFAULT '70724562-d83c-446e-94cf-58ced84f3a0e'::uuid NOT NULL
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NOT NULL DEFAULT 'desc ...'
    , solution_proposal varchar (4000) NULL
    , owner          varchar (50) NOT NULL DEFAULT 'none'
    , update_time    timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_bugs_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.bugs'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


--The trigger:
CREATE TRIGGER trg_set_update_time_on_bugs BEFORE UPDATE ON bugs FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'bugs'::regclass;
