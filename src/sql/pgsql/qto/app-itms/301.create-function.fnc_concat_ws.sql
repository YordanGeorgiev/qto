CREATE OR REPLACE FUNCTION fnc_concat_ws(text, VARIADIC text[])
	RETURNS text LANGUAGE sql IMMUTABLE AS 'SELECT array_to_string($2, $1)';

SELECT 'fnc_concat_ws exists is ' || exists(SELECT * FROM pg_proc WHERE proname = 'fnc_concat_ws')