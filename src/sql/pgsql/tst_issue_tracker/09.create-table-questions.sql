-- DROP TABLE IF EXISTS questions ; 

SELECT 'create the "questions" table'
; 
   CREATE TABLE questions (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NOT NULL DEFAULT 1
    , weight         integer NOT NULL DEFAULT 9
    , status         varchar (200) NOT NULL DEFAULT '01-eval'
    , category       varchar (200) NOT NULL DEFAULT 'unknown'
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    varchar (4000) NOT NULL DEFAULT 'description ... '
    , owner          varchar (50) NULL 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_questions_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.questions'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


--The trigger:
CREATE TRIGGER trg_set_update_time_on_questions BEFORE UPDATE ON questions FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'questions'::regclass;
