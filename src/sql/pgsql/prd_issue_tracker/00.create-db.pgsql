SELECT 'OBS !!! drop the db if it already exists' ; 
DROP DATABASE IF EXISTS :pgsql_db ;


SELECT ' CREATE THE DB :pgsql_db ' ; 
CREATE DATABASE :pgsql_db ;


SELECT 'and check that the :pgsql_db db exists:' ; 
SELECT datname , datcollate FROM pg_database WHERE datname=:'pgsql_db' ; 
