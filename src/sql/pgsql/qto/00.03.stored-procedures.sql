-- DROP FUNCTION fnc_tree_traversal ;
CREATE OR REPLACE FUNCTION "fnc_tree_traversal" (INT,INT) RETURNS SETOF test_hcreate_table AS '
DECLARE
	pid ALIAS FOR $1;
	pseq ALIAS FOR $2;
BEGIN
	INSERT INTO test_hcreate_table (id,seq) values (pid,pseq);
   RETURN QUERY 
      SELECT * FROM test_hcreate_table 
      WHERE 1=1 
      AND id=$1;
 END;
 ' LANGUAGE 'plpgsql';
