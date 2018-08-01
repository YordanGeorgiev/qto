-- DROP TABLE IF EXISTS test_update_table ; 

SELECT 'create the "test_update_table" table'
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
   CREATE TABLE test_update_table (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , seq            integer NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , CONSTRAINT pk_test_update_table_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

insert into test_update_table ( id,seq,name,description) values (1,1,'name-1','the name should be updated to updated-name-1'); 
insert into test_update_table ( id,seq,name,description) values (2,2,'name-2','the name attr should NOT be updated'); 
insert into test_update_table ( id,seq,name,description) values (3,3,'name-3','the name attr should be updated to updated-name-3'); 

SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_update_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 
