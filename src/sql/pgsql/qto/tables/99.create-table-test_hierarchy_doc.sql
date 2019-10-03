-- START create table test_hierarchy_doc
         -- DROP TABLE IF EXISTS test_hierarchy_doc ; 

SELECT 'create the "test_hierarchy_doc" table' as "---"
;

-- src: http://mikehillyer.com/articles/managing-hierarchical-data-in-mysql/
   CREATE TABLE test_hierarchy_doc (
      guid           UUID NOT NULL DEFAULT gen_rANDom_uuid()
    , id             bigint UNIQUE NOT NULL DEFAULT cast (to_char(current_timestamp, 'YYMMDDHH12MISS') as bigint) 
    , level          integer NULL
    , seq            integer NULL
    , lft            integer NULL 
    , rgt            integer NULL 
    , name           varchar (200) NOT NULL
    , description    varchar (4000)
    , src            varchar (4000)
    , formats        text NULL
    , CONSTRAINT pk_test_hierarchy_doc_guid PRIMARY KEY (guid)
    ) WITH (
      OIDS=FALSE
    );

-- STOP  create table test_hierarchy_doc
-- --------------------------------------------------------



SELECT 'show the columns of the just created table' as "---"
; 

   SELECT attrelid::regclass, attnum, attname
   FROM   pg_attribute
   WHERE  attrelid = 'public.test_hierarchy_doc'::regclass
   AND    attnum > 0
   AND    NOT attisdropped
   ORDER  BY attnum
   ; 


-- 
-- TRUNCATE TABLE test_hierarchy_doc ; 
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 0 ,0,1 ,1,23,'name-01 0.0.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 1 ,1,2 ,2,9,'name-02 1.0.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 2 ,2,3 ,3,8,'name-03 1.1.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 3 ,3,4 ,4,5,'name-04 1.1.1');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 4 ,3,5 ,6,7,'name-05 1.1.2');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 5 ,1,6 ,10,13,'name-06 2.0.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 6 ,2,7 ,11,12,'name-07 2.1.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 7 ,1,8 ,14,23,'name-08 3.0.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 8 ,2,9 ,15,16,'name-09 3.1.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 9 ,2,10,17,22,'name-10 3.2.0');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 10,3,11,18,21,'name-11 3.2.1');
-- INSERT into test_hierarchy_doc ( id,level,seq,lft,rgt,name ) values ( 11,4,12,19,20,'name-12 3.2.1.1');
-- SELECT * FROM test_hierarchy_doc ORDER BY seq ; 

SELECT 'retrieve the full branch from the parent id with sequence eq to 1' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_doc AS node, test_hierarchy_doc AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 1)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;
SELECT 'retrieve the full branch from the parent id with sequence eq to 2' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_doc AS node, test_hierarchy_doc AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 2)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;
SELECT 'retrieve the full branch from the parent id with sequence eq to 6' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_doc AS node, test_hierarchy_doc AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 6)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;
SELECT 'retrieve the full branch from the parent id with sequence eq to 8' as "---" ;
SELECT * FROM (
	SELECT node.* FROM test_hierarchy_doc AS node, test_hierarchy_doc AS parent
	WHERE 1=1 AND node.lft
	BETWEEN parent.lft AND parent.rgt
	AND parent.seq = 8)  AS dyn_sql
WHERE 1=1
ORDER BY seq
;


