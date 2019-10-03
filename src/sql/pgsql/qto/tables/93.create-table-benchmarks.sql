             -- DROP TABLE IF EXISTS benchmarks ; 

SELECT 'create the "benchmarks" table'
; 
   CREATE TABLE benchmarks (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , git_hash                char (8) NULL DEFAULT ''
    , name                    varchar (200) NOT NULL DEFAULT 'name ...'
    , url                     varchar (4000) NOT NULL DEFAULT 'url ...'
    , start_time              timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , stop_time               timestamp NOT NULL DEFAULT DATE_TRUNC('second', NOW())
    , avg_ua_load_time        numeric( 6,6 ) NOT NULL  default '0.0' 
    , diff_time               varchar (20) NOT NULL DEFAULT 'HH:MI:SS'
    , diff_min                numeric ( 10,2 ) NOT NULL  default '0.0' 
    , diff_sec                numeric ( 14,2 ) NOT NULL  default '0.0' 
    , diff_hours              numeric ( 10,2 ) NOT NULL  default '0.0' 
    , description             varchar (4000) NOT NULL DEFAULT 'desc...'
    , update_time             timestamp DEFAULT DATE_TRUNC('second', NOW())
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

-- START trigger trg_benchmarks_upsrt_update_time
CREATE TRIGGER trg_benchmarks_upsrt_update_time 
   BEFORE UPDATE ON benchmarks 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

-- STOP trigger trg_benchmarks_upsrt_update_time

-- START trigger trg_benchmarks_upsrt_diff_time
-- hrt = human readable time
CREATE OR REPLACE FUNCTION fnc_benchmarks_upsrt_diff_time()

    RETURNS TRIGGER
    AS $$
       BEGIN 
          -- NEW.diff_time = age(NEW.stop_time::timestamp-NEW.start_time::timestamp);
          NEW.diff_time = to_char(NEW.stop_time::timestamp-NEW.start_time::timestamp, 'DDD HH24:MI:SS');
          RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;


 CREATE TRIGGER trg_benchmarks_upsrt_diff_time
  BEFORE INSERT OR UPDATE ON benchmarks
  FOR EACH ROW EXECUTE PROCEDURE fnc_benchmarks_upsrt_diff_time();
-- 
-- STOP trigger trg_benchmarks_upsrt_diff_time

-- START trg_benchmarks_upsrt_diff_sec
CREATE OR REPLACE FUNCTION fnc_benchmarks_calc_diff_sec()

    RETURNS TRIGGER
    AS $$
       BEGIN 
          NEW.diff_sec = EXTRACT(EPOCH FROM (NEW.stop_time::timestamp - NEW.start_time::timestamp));
          RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;

 CREATE TRIGGER trg_benchmarks_upsrt_diff_sec
  BEFORE INSERT OR UPDATE ON benchmarks
  FOR EACH ROW EXECUTE PROCEDURE fnc_benchmarks_calc_diff_sec();
-- STOP trg_benchmarks_upsrt_diff_sec

-- START trg_benchmarks_upsrt_diff_hours
CREATE OR REPLACE FUNCTION fnc_benchmarks_calc_diff_hours()

    RETURNS TRIGGER
    AS $$
       BEGIN 
          NEW.diff_hours = 
(DATE_PART('day', NEW.stop_time::timestamp - NEW.start_time::timestamp) * 24 + 
DATE_PART('hour', NEW.stop_time::timestamp - NEW.start_time::timestamp))  +
DATE_PART('minute', NEW.stop_time::timestamp - NEW.start_time::timestamp)/60;
          RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;

 CREATE TRIGGER trg_benchmarks_upsrt_diff_hours
  BEFORE INSERT OR UPDATE ON benchmarks
  FOR EACH ROW EXECUTE PROCEDURE fnc_benchmarks_calc_diff_hours();
-- STOP trg_benchmarks_upsrt_diff_hours

-- START trg_benchmarks_upsrt_diff_min
CREATE OR REPLACE FUNCTION fnc_benchmarks_calc_diff_min()

    RETURNS TRIGGER
    AS $$
       BEGIN 
          NEW.diff_min = 
(DATE_PART('day', NEW.stop_time::timestamp - NEW.start_time::timestamp) * 24 * 60 + 
DATE_PART('hour', NEW.stop_time::timestamp - NEW.start_time::timestamp)) * 60 +
DATE_PART('minute', NEW.stop_time::timestamp - NEW.start_time::timestamp);
          RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;

 CREATE TRIGGER trg_benchmarks_upsrt_diff_min
  BEFORE INSERT OR UPDATE ON benchmarks
  FOR EACH ROW EXECUTE PROCEDURE fnc_benchmarks_calc_diff_min();
-- STOP trg_benchmarks_upsrt_diff_min

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'benchmarks'::regclass;

