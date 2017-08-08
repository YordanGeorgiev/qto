-- DROP TABLE IF EXISTS procurement_items ; 

SELECT 'create the "procurement_items" table'
; 
   CREATE TABLE procurement_items (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , seq            integer NULL
    , prio           integer NULL
    , category       varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , start_time     text NULL
    , stop_time      text NULL
    , update_time    timestamp DEFAULT NOW()
    , owner          varchar (50) NULL
    , CONSTRAINT pk_procurement_items_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.procurement_items'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
