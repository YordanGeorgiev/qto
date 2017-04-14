SELECT 'OBS !!! drop the db if it already exists' ; 
DROP DATABASE IF EXISTS :db_name ;


SELECT ' CREATE THE DB :db_name ' ; 
CREATE DATABASE :db_name ;


SELECT 'and check that the :db_name db exists:' ; 
SELECT datname , datcollate FROM pg_database WHERE datname=:'db_name' ; 
