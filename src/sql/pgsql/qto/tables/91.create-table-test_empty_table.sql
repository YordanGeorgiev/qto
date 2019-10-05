                -- DROP TABLE IF EXISTS test_empty_table ; 

SELECT 'create the "test_empty_table" table'
;

   CREATE TABLE test_empty_table (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (200) NOT NULL DEFAULT 'name...'
    , description    varchar (4000)
    , CONSTRAINT pk_test_empty_table_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_empty_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
