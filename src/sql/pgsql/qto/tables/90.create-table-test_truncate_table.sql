              -- DROP TABLE IF EXISTS test_truncate_table ; 

SELECT 'create the "test_truncate_table" table'
;

   CREATE TABLE test_truncate_table (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (200) default 'name ...'
    , description    varchar (4000) default 'desc ...'
    , CONSTRAINT pk_test_truncate_table_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_truncate_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


