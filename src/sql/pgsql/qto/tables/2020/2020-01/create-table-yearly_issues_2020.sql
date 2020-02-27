DROP TABLE IF EXISTS yearly_issues_2020 ; 

SELECT 'create the "yearly_issues_2020" table'
; 
   CREATE TABLE yearly_issues_2020 (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , category_guid UUID NOT NULL DEFAULT '70724562-d83c-446e-94cf-58ced84f3a0e'
    , issues_status_guid UUID NOT NULL DEFAULT 'cb989a14-d0b8-46e4-b2cc-5e2a974b5d29'
    , prio           integer NOT NULL DEFAULT 0
    , name           varchar (100) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000)
    , owner          varchar (20) NOT NULL DEFAULT 'unknown'
    , type           varchar (30) NOT NULL DEFAULT 'task'
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_yearly_issues_2020_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_yearly_issues_2020_id on yearly_issues_2020 (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.yearly_issues_2020'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_yearly_issues_2020 BEFORE UPDATE ON yearly_issues_2020 FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'yearly_issues_2020'::regclass;

