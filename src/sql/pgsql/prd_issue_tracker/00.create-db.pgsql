SELECT 'OBS !!! drop the db if it already exists' ; 
DROP DATABASE IF EXISTS :postgres_db_name ;


SELECT ' CREATE THE DB :postgres_db_name ' ; 
CREATE DATABASE :postgres_db_name ;


SELECT 'and check that the :postgres_db_name db exists:' ; 
SELECT datname , datcollate FROM pg_database WHERE datname=:'postgres_db_name' ; 
