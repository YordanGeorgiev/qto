-- START create table test_hierarchy_table
DROP TABLE IF EXISTS test_hierarchy_table ; 

SELECT 'create the "test_hierarchy_table" table' as "---"
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
   CREATE TABLE test_hierarchy_table (
      guid           UUID NOT NULL DEFAULT gen_rANDom_uuid()
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



SELECT 'show the columns of the just created table' as "---"
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_hierarchy_table'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


-- START trg_test_htable_set_lft_rgt
-- src: https://www.postgresql.org/docs/9.5/plpgsql-trigger.html
CREATE OR REPLACE FUNCTION fnc_test_htable_set_lft_rgt() RETURNS TRIGGER AS 
$$
   BEGIN 
      UPDATE test_hierarchy_table SET seq=col_serial FROM 
      (SELECT guid, row_number() OVER ( ORDER BY seq) AS col_serial 
         FROM test_hierarchy_table ORDER BY seq) AS tmp_test_hierarchy_table 
      WHERE test_hierarchy_table.guid=tmp_test_hierarchy_table.guid;

      -- set the root level node
      IF NEW.level = 0 THEN
         NEW.lft := 1; 
         NEW.rgt := 2; 
      END IF; 
      
      -- going down in the hierarchy 
      IF (NEW.level > (SELECT level from test_hierarchy_table WHERE seq = (NEW.seq-1))) THEN
         IF EXISTS (SELECT 1 FROM test_hierarchy_table WHERE level = NEW.level AND seq=(NEW.seq-1)) THEN
            -- with siblings
         ELSE  
            -- without siblings
            NEW.lft := (SELECT rgt from test_hierarchy_table WHERE seq = (NEW.seq-1));
            NEW.rgt := (NEW.lft+1);
            UPDATE test_hierarchy_table SET rgt = (rgt + 2) WHERE seq < NEW.seq AND level < NEW.level AND rgt >= (NEW.rgt-2) ;
         END IF; 
      END IF;
     
      -- staying flat 
      IF NEW.level = (SELECT level from test_hierarchy_table WHERE seq = (NEW.seq-1)) THEN
         IF EXISTS (SELECT 1 FROM test_hierarchy_table WHERE level = NEW.level AND seq=(NEW.seq-1)) THEN
            -- with siblings
            NEW.lft := ((SELECT rgt from test_hierarchy_table WHERE seq = (NEW.seq-1))+1) ; 
            NEW.rgt := (NEW.lft+1);
            UPDATE test_hierarchy_table SET rgt = rgt + 2 WHERE seq < NEW.seq AND level < NEW.level AND rgt >= NEW.lft;
         ELSE  
            -- without siblings
         END IF; 
      END IF; 
      
      -- going up in the hierarchy 
      IF (NEW.level < (SELECT level from test_hierarchy_table WHERE seq = (NEW.seq-1))) THEN
         -- with siblings
         IF EXISTS (SELECT 1 FROM test_hierarchy_table WHERE level = NEW.level AND rgt<(SELECT max(rgt) FROM test_hierarchy_table WHERE level = (NEW.level-1)) AND lft > (SELECT max(lft) FROM test_hierarchy_table WHERE level = (NEW.level-1))) THEN
            NEW.lft := (SELECT max(rgt) FROM test_hierarchy_table WHERE level = (NEW.level-1));
            NEW.rgt := (NEW.lft+1);
            UPDATE test_hierarchy_table SET rgt = rgt + 2 WHERE seq < NEW.seq AND level < NEW.level AND rgt >= NEW.lft ;
         ELSE  
            -- without siblings
         END IF; 
      END IF; 
   
   RAISE NOTICE 'NEW:%' , NEW ; 
   RETURN NEW;
   END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER trg_test_htable_set_lft_rgt
BEFORE INSERT 
ON test_hierarchy_table
FOR EACH ROW 
WHEN (pg_trigger_depth() < 1)
EXECUTE PROCEDURE fnc_test_htable_set_lft_rgt();
-- STOP trg_test_htable_set_lft_rgt

select tgname
from pg_trigger
where not tgisinternal
AND tgrelid = 'test_hierarchy_table'::regclass;


TRUNCATE TABLE test_hierarchy_table ; 
INSERT into test_hierarchy_table ( id,level,seq,name ) values (  1,0,1,'name-01 0.0.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  2,1,2,'name-02 1.0.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  3,2,3,'name-03 1.1.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  4,3,4,'name-04 1.1.1');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  5,3,5,'name-05 1.1.2');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  6,1,6,'name-06 2.0.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  7,2,7,'name-07 2.1.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  8,1,8,'name-08 3.0.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values (  9,2,9,'name-09 3.1.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values ( 10,2,10,'name-10 3.2.0');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values ( 11,3,11,'name-11 3.2.1');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

INSERT into test_hierarchy_table ( id,level,seq,name ) values ( 12,4,12,'name-12 3.2.1.1');
SELECT * FROM test_hierarchy_table ORDER BY seq ; 

SELECT 'retrieve the full branch from the parent id with sequence eq to 1' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_table AS node, test_hierarchy_table AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 1)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;
SELECT 'retrieve the full branch from the parent id with sequence eq to 2' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_table AS node, test_hierarchy_table AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 2)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;
SELECT 'retrieve the full branch from the parent id with sequence eq to 6' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_table AS node, test_hierarchy_table AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 6)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;
SELECT 'retrieve the full branch from the parent id with sequence eq to 8' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_table AS node, test_hierarchy_table AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 8)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;
-- SELECT * FROM test_hierarchy_table ORDER BY seq ; 




/*

  IF (TG_OP = 'DELETE') THEN
		INSERT INTO emp_audit SELECT 'D', now(), user, OLD.*;
		RETURN OLD;
  ELSIF (TG_OP = 'UPDATE') THEN
		INSERT INTO emp_audit SELECT 'U', now(), user, NEW.*;
		RETURN NEW;
  ELSIF (TG_OP = 'INSERT') THEN
		INSERT INTO emp_audit SELECT 'I', now(), user, NEW.*;
		RETURN NEW;
  END IF;

*/


