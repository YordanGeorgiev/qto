-- DROP TABLE IF EXISTS ideas ; 

SELECT 'create the "ideas" table'
; 
   CREATE TABLE ideas (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             integer UNIQUE NOT NULL 
    , seq            integer NULL
    , prio           integer NULL
    , status         varchar (50) NOT NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , owner          varchar (50) NULL
    , update_time    timestamp DEFAULT NOW()
    , CONSTRAINT pk_ideas_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

create unique index idx_ideas_uniq_id on ideas (id);


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.ideas'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
