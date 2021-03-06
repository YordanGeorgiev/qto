               -- DROP TABLE IF EXISTS test_delete_table ; 

SELECT 'create the "test_delete_table" table'
;

   CREATE TABLE test_delete_table (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , name           varchar (200) default 'name ...'
    , description    varchar (4000) default 'desc ...'
    , CONSTRAINT pk_test_delete_table_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   insert into test_delete_table ( id,name,description) values (1,'name-1','the name should be deleted to deleted-name-1'); 
   insert into test_delete_table ( id,name,description) values (2,'name-2','the name attr should NOT be deleted'); 
   insert into test_delete_table ( id,name,description) values (3,'name-3','the name attr should be deleted to deleted-name-3'); 

SELECT 'Display the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_delete_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


