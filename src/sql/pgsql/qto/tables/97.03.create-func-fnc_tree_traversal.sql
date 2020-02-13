CREATE OR REPLACE FUNCTION "fnc_tree_traversal" (INT,INT) RETURNS SETOF test_hi_create_table_doc AS '
DECLARE
	pid ALIAS FOR $1;
	pseq ALIAS FOR $2;
BEGIN
	INSERT INTO test_hi_create_table_doc (id,seq) values (pid,pseq);
   RETURN QUERY 
      SELECT * FROM test_hi_create_table_doc 
      WHERE 1=1 
      AND id=$1;
 END;
 ' LANGUAGE 'plpgsql';
