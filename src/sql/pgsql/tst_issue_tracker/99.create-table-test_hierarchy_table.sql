-- DROP TABLE IF EXISTS test_hierarchy_table ; 

SELECT 'create the "test_hierarchy_table" table'
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
   CREATE TABLE test_hierarchy_table (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            integer NULL
    , rgt            integer NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , CONSTRAINT pk_test_hierarchy_table_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );


SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_hierarchy_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
