-- DROP TABLE IF EXISTS confs ; 

SELECT 'create the "confs" table'
; 
   CREATE TABLE confs (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , seq            integer NULL
    , prio           integer NULL
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , value          varchar (4000)
    , description    varchar (4000)
    , owner          varchar (50) NULL
    , update_time    timestamp DEFAULT NOW()
    , CONSTRAINT pk_confs_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.confs'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
