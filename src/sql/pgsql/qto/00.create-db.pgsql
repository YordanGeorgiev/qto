-- \echo 'DROP the DB if it already exists'
DROP DATABASE IF EXISTS :postgres_db_name ;

-- \echo 'CREATE the DB :postgres_db_name '
CREATE DATABASE :postgres_db_name
       LC_COLLATE='C'
       LC_CTYPE='C'
       CONNECTION LIMIT=-1;

-- \echo 'and check that the :postgres_db_name DB exists:'
SELECT datname, datcollate
	FROM pg_database
	WHERE datname=:'postgres_db_name' ;
	
COMMENT ON DATABASE :postgres_db_name
	IS 'Database for QTO' ;

-- \echo 'REVOKE all rights on the newly created DB'
REVOKE ALL
	ON DATABASE :postgres_db_name
	FROM public;

-- \echo 'SET the DEFAULT search language to English'
ALTER DATABASE :postgres_db_name
	SET default_text_search_config='pg_catalog.english' ;



