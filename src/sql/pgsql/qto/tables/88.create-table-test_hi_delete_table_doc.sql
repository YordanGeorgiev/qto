-- DROP TABLE IF EXISTS test_hi_delete_table_doc CASCADE;

SELECT 'delete the "test_hi_delete_table_doc" table' as "---"
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
-- src: https://github.com/werc/TreeTraversal
   CREATE TABLE test_hi_delete_table_doc (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISSMS') as bigint) 
    , level          integer NOT NULL DEFAULT 1
    , seq            integer NOT NULL DEFAULT 1
    , lft            integer NOT NULL DEFAULT 1
    , rgt            integer NOT NULL DEFAULT 2
    , name           varchar (200) NOT NULL DEFAULT 'name...'
    , description    varchar (4000) NULL
    , formats        varchar (200) NULL 
    , src            varchar (4000) NULL
    , CONSTRAINT pk_test_hi_delete_table_doc_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

-- STOP  delete table test_hi_delete_table_doc
-- --------------------------------------------------------

-- INSERT INTO test_hi_delete_table_doc ( id,level,seq,lft,rgt,name) 
  --                      values ( 0,0,1,1,2,'test_hi_delete_table_doc');


SELECT 'Display the columns of the just deleted table' as "---"
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_hi_delete_table_doc'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


