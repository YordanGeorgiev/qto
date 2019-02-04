-- START create table test_hierarchy_table
DROP TABLE IF EXISTS test_hierarchy_table ; 

SELECT 'create the "test_hierarchy_table" table' as "---"
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

-- STOP  create table test_hierarchy_table
-- --------------------------------------------------------


DROP TABLE IF EXISTS test_hierarchy_table_expected ; 

SELECT 'create the "test_hierarchy_table_expected" table' as "---"
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
   CREATE TABLE test_hierarchy_table_expected (
      guid           UUID NOT NULL DEFAULT gen_random_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            integer NULL
    , rgt            integer NULL
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , CONSTRAINT pk_test_hierarchy_table_expected_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

-- STOP  create table test_hierarchy_table_expected
-- --------------------------------------------------------

SELECT 'show the columns of the just created table' as "---"
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_hierarchy_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


-- START trg_test_hierarchy_table_set_all_seq
CREATE OR REPLACE FUNCTION fnc_test_hierarchy_table_set_all_seq()
    RETURNS TRIGGER
    AS $$
       BEGIN 
         -- src: https://stackoverflow.com/a/29747683/65706
         -- UPDATE test_hierarchy_table SET seq=seq+1 WHERE 1=1 AND seq > NEW.seq ;
         -- UPDATE test_hierarchy_table SET seq=seq-1 WHERE 1=1 AND seq <= NEW.seq;
         UPDATE test_hierarchy_table SET seq=col_serial FROM 
         (SELECT guid, row_number() OVER ( ORDER BY seq) AS col_serial 
            FROM test_hierarchy_table ORDER BY seq) AS tmp_test_hierarchy_table 
         WHERE test_hierarchy_table.guid=tmp_test_hierarchy_table.guid;
         RETURN NEW;
       END;
    $$ LANGUAGE plpgsql;

 CREATE TRIGGER trg_test_hierarchy_table_set_all_seq
  AFTER INSERT OR UPDATE OR DELETE ON test_hierarchy_table
  FOR EACH ROW 
  WHEN (pg_trigger_depth() < 1)
  EXECUTE PROCEDURE fnc_test_hierarchy_table_set_all_seq();
-- STOP trg_test_hierarchy_table_set_all_seq

select tgname
from pg_trigger
where not tgisinternal
and tgrelid = 'test_hierarchy_table'::regclass;


INSERT into test_hierarchy_table ( id,name ) values ( 1,'name-01');
INSERT into test_hierarchy_table ( id,name ) values ( 2,'name-02');
INSERT into test_hierarchy_table ( id,name ) values ( 3,'name-03');
INSERT into test_hierarchy_table ( id,name ) values ( 4,'name-04');
INSERT into test_hierarchy_table ( id,name ) values ( 5,'name-05');
INSERT into test_hierarchy_table ( id,name ) values ( 6,'name-06');
INSERT into test_hierarchy_table ( id,name ) values ( 7,'name-07');

SELECT * FROM test_hierarchy_table ORDER BY seq ; 
SELECT 'should get 1,2,3,4,5,6,7' AS "---" ; 

INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 1,1,'name-01');
INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 3,2,'name-03');
INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 2,3,'name-02');
INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 4,4,'name-04');
INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 5,5,'name-05');
INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 6,6,'name-06');
INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 7,7,'name-07');

-- OBS when moving up the seq should be the "desired" seq exactly
UPDATE test_hierarchy_table SET seq=2 WHERE 1=1 AND name = 'name-03' ; 
SELECT * FROM test_hierarchy_table ORDER BY seq ; 
SELECT 'should get 2,3,4,5,6,7,8' AS "---" ; 



SELECT case when count (1) = 0
then 'test-01: passed - moving from down to up works !!!'
else 'test_failed - moving from down to up does not work !!!'
end as "TEST_RESULT"
FROM test_hierarchy_table
FULL OUTER JOIN test_hierarchy_table_expected
USING (id,seq,name)
WHERE test_hierarchy_table.id IS NULL
OR test_hierarchy_table_expected.id IS NULL ;

-- OBS when moving down the seq should be the "desired" seq + 1
UPDATE test_hierarchy_table SET seq=4 WHERE 1=1 AND name = 'name-03' ; 
UPDATE test_hierarchy_table_expected SET seq=2 WHERE 1=1 AND name = 'name-02' ; 
UPDATE test_hierarchy_table_expected SET seq=3 WHERE 1=1 AND name = 'name-03' ; 
UPDATE test_hierarchy_table_expected SET seq=1 WHERE 1=1 AND name = 'name-01' ; 

SELECT * FROM test_hierarchy_table ORDER BY seq ; 

SELECT case when count (1) = 0
then 'test-02: passed - moving from up to down works !!!'
else 'test_failed - moving from up to down does not work !!!'
end as "TEST_RESULT"
FROM test_hierarchy_table
FULL OUTER JOIN test_hierarchy_table_expected
USING (id,seq,name)
WHERE test_hierarchy_table.id IS NULL
OR test_hierarchy_table_expected.id IS NULL ;


DELETE FROM test_hierarchy_table WHERE 1=1 AND name = 'name-03' ; 
DELETE FROM test_hierarchy_table_expected WHERE 1=1 AND name = 'name-03' ; 
UPDATE test_hierarchy_table_expected SET seq=seq-1 WHERE seq>3 ; 
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

SELECT case when count (1) = 0
then 'test-03: passed -  DELETE works !!!'
else 'test_failed - DELETE does not work !!!'
end as "TEST_RESULT"
FROM test_hierarchy_table
FULL OUTER JOIN test_hierarchy_table_expected
USING (id,seq,name)
WHERE test_hierarchy_table.id IS NULL
;

INSERT into test_hierarchy_table ( id,seq,name ) values ( 3,3,'name-03') ;
UPDATE test_hierarchy_table_expected SET seq=seq+1 WHERE seq >= 3 ; 
INSERT into test_hierarchy_table_expected ( id,seq,name ) values ( 3,3,'name-03');

SELECT * FROM test_hierarchy_table ORDER BY seq ; 
SELECT * FROM test_hierarchy_table_expected ORDER BY seq ; 

SELECT case when count (1) = 0
then 'test-04: passed -  INSERT into the middle  works !!!'
else 'test_failed - INSERT into the middle does not work !!!'
end as "TEST_RESULT"
FROM test_hierarchy_table
FULL OUTER JOIN test_hierarchy_table_expected
USING (id,seq,name)
WHERE test_hierarchy_table.id IS NULL
;
































