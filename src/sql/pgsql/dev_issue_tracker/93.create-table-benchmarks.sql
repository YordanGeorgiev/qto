-- DROP TABLE IF EXISTS benchmarks ; 

SELECT 'create the "benchmarks" table'
; 
   CREATE TABLE benchmarks (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , url            varchar (4000) NOT NULL DEFAULT 'url ...'
    , start_time     timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , stop_time      timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , avg_ua_load_time numeric( 6,6 ) NOT NULL  default '0.0' 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_benchmarks_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_uniq_benchmarks_id on benchmarks (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.benchmarks'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_benchmarks BEFORE UPDATE ON benchmarks FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'benchmarks'::regclass;

