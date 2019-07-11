-- START create table test_hcreate_table
DROP TABLE IF EXISTS test_hcreate_table ; 

SELECT 'create the "test_hcreate_table" table' as "---"
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
-- src: https://github.com/werc/TreeTraversal
   CREATE TABLE test_hcreate_table (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            integer NULL 
    , rgt            integer NULL 
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , src            varchar (4000)
    , CONSTRAINT pk_test_hcreate_table_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

-- STOP  create table test_hcreate_table
-- --------------------------------------------------------


SELECT 'show the columns of the just created table' as "---"
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_hcreate_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


