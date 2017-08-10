-- DROP TABLE IF EXISTS principles ; 

SELECT 'create the "principles" table'
; 
   CREATE TABLE principles (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , level          integer NULL
    , seq            integer NULL
    , prio           integer NULL
    , weight         integer NULL
    , tags           varchar (4000) NOT NULL
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000) NOT NULL
    , update_time    timestamp DEFAULT NOW()
    , CONSTRAINT pk_principles_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.principles'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
