-- DROP TABLE IF EXISTS procurement_items ; 

SELECT 'create the "purchases" table'
; 
   CREATE TABLE purchases (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             integer UNIQUE NOT NULL 
    , seq            integer NULL
    , prio           integer NULL
    , category       varchar (200) NOT NULL
    , status         varchar (200) NOT NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000) NULL
    , owner          varchar (50) NULL
    , start_price    decimal (6,2) NULL
    , stop_price     decimal (6,2) NULL
    , CONSTRAINT pk_purchases PRIMARY KEY (guid)
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
