CREATE OR REPLACE FUNCTION "fnc_set_update_time" () RETURNS trigger AS '
    BEGIN
        NEW.update_time = DATE_TRUNC(''second'', NOW());
        RETURN NEW;
    END;'
LANGUAGE "plpgsql";

select 'fnc_set_update_time exists is ' || exists(select * from pg_proc where proname = 'fnc_set_update_time')
;

CREATE OR REPLACE FUNCTION f_concat_ws(text, VARIADIC text[])
  RETURNS text LANGUAGE sql IMMUTABLE AS 'SELECT array_to_string($2, $1)'
  ;

select 'f_concat_ws exists is ' || exists(select * from pg_proc where proname = 'f_concat_ws')
