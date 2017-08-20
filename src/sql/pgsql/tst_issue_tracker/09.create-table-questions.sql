-- DROP TABLE IF EXISTS questions ; 

SELECT 'create the "questions" table'
; 
   CREATE TABLE questions (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NULL
    , status         varchar (200) NOT NULL
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000) NOT NULL
    , owner          varchar (50) NULL
    , update_time    timestamp DEFAULT NOW()
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
