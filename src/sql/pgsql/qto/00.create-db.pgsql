-- \echo 'DROP the DB if it already exists'
DROP DATABASE IF EXISTS :postgres_app_db ;

-- \echo 'CREATE the DB :postgres_app_db '
CREATE DATABASE :postgres_app_db
       CONNECTION LIMIT=-1;

-- \echo 'and check that the :postgres_app_db DB exists:'
SELECT datname, datcollate
	FROM pg_database
	WHERE datname=:'postgres_app_db' ;
	
COMMENT ON DATABASE :postgres_app_db
	IS 'Database for QTO' ;

-- \echo 'REVOKE all rights on the newly created DB'
REVOKE ALL
	ON DATABASE :postgres_app_db
	FROM public;

-- \echo 'SET the DEFAULT search language to English'
ALTER DATABASE :postgres_app_db
	SET default_text_search_config='pg_catalog.english' ;



