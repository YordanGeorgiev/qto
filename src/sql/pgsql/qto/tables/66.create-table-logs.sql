-- DROP TABLE IF EXISTS logs ; 

SELECT 'create the "logs" table'
; 
   CREATE TABLE logs (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             numeric (25) UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISSMSUS') as numeric(25)) 
    , prio           integer NOT NULL DEFAULT 5
    , env            varchar (50) NOT NULL DEFAULT 'dev'
    , app            varchar (50) NOT NULL DEFAULT 'qto'
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    varchar (400)
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_logs_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.logs'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger:
CREATE TRIGGER trg_set_update_time_on_logs BEFORE UPDATE ON logs FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

SELECT tgname
FROM pg_trigger
WHERE NOT tgisinternal
AND tgrelid = 'logs'::regclass;

