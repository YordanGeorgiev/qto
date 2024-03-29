-- \echo 'src: https://stackoverflow.com/a/49175321/65706'
-- \echo 'src: https://dba.stackexchange.com/a/213921/1245'
-- \echo 'src: https://stackoverflow.com/a/22684537/65706'

SET myvars.postgres_app_usr TO :'postgres_app_usr';
SET myvars.postgres_app_usr_pw TO :'postgres_app_usr_pw';
SET myvars.postgres_app_db TO :'postgres_app_db';

DO
$do$
BEGIN
	EXECUTE format( 'CREATE ROLE %I WITH PASSWORD %L LOGIN' 
			, current_setting('myvars.postgres_app_usr', true)::text 
			, current_setting('myvars.postgres_app_usr_pw', true)::text
	);
	RAISE NOTICE 'Created user "%"', current_setting('myvars.postgres_app_usr', true)::text;
EXCEPTION WHEN OTHERS THEN
	RAISE NOTICE 'User "%" already exists, re-creating it', current_setting('myvars.postgres_app_usr', true)::text;
	EXECUTE format( '
            GRANT SELECT, INSERT, UPDATE, DELETE
				ON ALL TABLES
				IN SCHEMA public
				TO %I ;'
			, current_setting('myvars.postgres_app_usr', true)::text 
	);
	EXECUTE format( '
			ALTER DEFAULT PRIVILEGES			
				IN SCHEMA public
				GRANT SELECT, INSERT, UPDATE, DELETE
			 		ON TABLES
					TO %I ;'
			, current_setting('myvars.postgres_app_usr', true)::text 
	);
	EXECUTE format( '
            GRANT CONNECT
				ON DATABASE %I
				TO %I ;'
			, current_setting('myvars.postgres_app_db', true)::text 
			, current_setting('myvars.postgres_app_usr', true)::text 
	);
	EXECUTE format( '
            GRANT SELECT, UPDATE
				ON ALL SEQUENCES
				IN SCHEMA public
				TO %I ;'
			, current_setting('myvars.postgres_app_usr', true)::text 
	);
	EXECUTE format( '
			ALTER DEFAULT PRIVILEGES			
				IN SCHEMA public
				GRANT SELECT, UPDATE
			 		ON SEQUENCES
					TO %I ;'
			, current_setting('myvars.postgres_app_usr', true)::text 
	);	
   	EXECUTE format( '
			GRANT EXECUTE
				ON ALL FUNCTIONS
				IN SCHEMA public
				TO %I ;'
           , current_setting('myvars.postgres_app_usr', true)::text 
	);
	EXECUTE format( '
			ALTER DEFAULT PRIVILEGES			
				IN SCHEMA public
				GRANT EXECUTE
			 		ON FUNCTIONS
					TO %I ;'
			, current_setting('myvars.postgres_app_usr', true)::text 
	);

END
$do$;


-- \echo 'Uncomment to enable this for newly created relations, then set the default permissions:'
-- \echo 'ALTER DEFAULT PRIVILEGES IN SCHEMA public '
-- \echo '   GRANT ALL PRIVILEGES ON TABLES TO :postgres_app_usr;'
-- \echo 'ALTER DEFAULT PRIVILEGES IN SCHEMA public '
-- \echo '   GRANT ALL PRIVILEGES ON SEQUENCES TO :postgres_app_usr;'

-- \echo 'GRANT SELECT ON ALL TABLES IN SCHEMA public TO :postgres_app_usr;'
-- \echo 'GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO :postgres_app_usr;'
-- \echo 'GRANT ALL PRIVILEGES ON DATABASE :postgres_app_db TO :postgres_app_usr;'
-- \echo 'GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO :postgres_app_usr;''
-- \echo 'GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO :postgres_app_usr;'
-- \echo 'GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES ON ALL TABLES IN SCHEMA public TO :postgres_app_usr;'

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit 
	FROM pg_roles 
	WHERE 1=1
	AND rolname=:'postgres_app_usr';
