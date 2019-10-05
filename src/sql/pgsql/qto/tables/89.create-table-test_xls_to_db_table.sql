               -- DROP TABLE IF EXISTS test_xls_to_db_table CASCADE;

SELECT 'create the "test_xls_to_db_table" table'
; 
   CREATE TABLE test_xls_to_db_table (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            bigint  NULL
    , rgt            bigint  NULL
    , prio           integer NOT NULL DEFAULT 1
    , status         varchar (20) NULL 
    , type           varchar (25) NULL 
    , name           varchar (200) NOT NULL DEFAULT 'name ...'
    , description    text NULL
    , src            text NULL
    , formats        text NULL
    , runtime        varchar (20) NULL 
    , update_time    timestamp DEFAULT DATE_TRUNC('second', NOW())
    , CONSTRAINT pk_test_xls_to_db_table_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

   create unique index idx_uniq_test_xls_to_db_table_id on test_xls_to_db_table (id);



SELECT 'show the columns of the just created table'
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_xls_to_db_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 

--The trigger for the update_time update: 
   CREATE TRIGGER trg_test_xls_to_db_table_set_update_time 
   BEFORE UPDATE ON test_xls_to_db_table 
   FOR EACH ROW EXECUTE PROCEDURE fnc_set_update_time();

-- START trg_test_xls_to_db_table_set_all_seq
CREATE OR REPLACE FUNCTION fnc_test_xls_to_db_table_set_all_seq()
    RETURNS TRIGGER
    AS $$
       BEGIN 
         -- src: https://stackoverflow.com/a/29747683/65706
         UPDATE test_xls_to_db_table SET seq=col_serial FROM 
         (SELECT guid, row_number() OVER ( ORDER BY seq) AS col_serial FROM test_xls_to_db_table ORDER BY seq) AS tmp_test_xls_to_db_table 
         WHERE test_xls_to_db_table.guid=tmp_test_xls_to_db_table.guid;

         RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;

 CREATE TRIGGER trg_test_xls_to_db_table_set_all_seq
  AFTER UPDATE OR DELETE ON test_xls_to_db_table
  FOR EACH ROW 
  WHEN (pg_trigger_depth() < 1)
  EXECUTE PROCEDURE fnc_test_xls_to_db_table_set_all_seq();
-- STOP trg_test_xls_to_db_table_set_all_seq

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'test_xls_to_db_table'::regclass;

