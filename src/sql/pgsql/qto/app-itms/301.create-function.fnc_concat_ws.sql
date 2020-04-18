CREATE OR REPLACE FUNCTION fnc_concat_ws(text, VARIADIC text[])
  RETURNS text LANGUAGE sql IMMUTABLE AS 'SELECT array_to_string($2, $1)'
  ;

select 'fnc_concat_ws exists is ' || exists(select * from pg_proc where proname = 'fnc_concat_ws')
