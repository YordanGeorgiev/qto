-- START create table test_htable
DROP TABLE IF EXISTS test_htable ; 

SELECT 'create the "test_htable" table' as "---"
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
-- src: https://github.com/werc/TreeTraversal
   CREATE TABLE test_htable (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            integer NULL 
    , rgt            integer NULL 
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , src            varchar (4000)
    , CONSTRAINT pk_test_htable_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

-- STOP  create table test_htable
-- --------------------------------------------------------



SELECT 'show the columns of the just created table' as "---"
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_htable'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


