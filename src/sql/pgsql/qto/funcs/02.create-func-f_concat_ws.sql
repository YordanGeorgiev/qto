CREATE OR REPLACE FUNCTION f_concat_ws(text, VARIADIC text[])
  RETURNS text LANGUAGE sql IMMUTABLE AS 'SELECT array_to_string($2, $1)'
  ;

select 'f_concat_ws exists is ' || exists(select * from pg_proc where proname = 'f_concat_ws')
