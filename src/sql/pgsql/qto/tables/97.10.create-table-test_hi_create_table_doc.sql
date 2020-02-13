-- DROP TABLE IF EXISTS test_hi_create_table_doc CASCADE ; 

SELECT 'create the "test_hi_create_table_doc" table' as "---"
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
   CREATE TABLE test_hi_create_table_doc (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             SERIAL UNIQUE
    , level          integer NOT NULL DEFAULT 0
    , seq            integer NOT NULL DEFAULT 1
    , lft            integer NOT NULL DEFAULT 1
    , rgt            integer NOT NULL DEFAULT 2
    , name           varchar (200) NOT NULL DEFAULT 'name...'
    , description    varchar (4000) NULL
    , src            varchar (4000) NULL
    , formats        text NULL
    , CONSTRAINT pk_test_hi_create_table_doc_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );



SELECT 'show the columns of the just created table' as "---"
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_hi_create_table_doc'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


