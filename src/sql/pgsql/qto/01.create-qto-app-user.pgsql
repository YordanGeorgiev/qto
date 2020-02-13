-- src: https://stackoverflow.com/a/49175321/65706
-- src: https://dba.stackexchange.com/a/213921/1245

SET myvars.postgres_db_user TO :'postgres_db_user';
SET myvars.postgres_db_user_pw TO :'postgres_db_user_pw';
SET myvars.postgres_db_name TO :'postgres_db_name';

DO
$do$
BEGIN
	EXECUTE format( 'CREATE ROLE %I WITH PASSWORD %L LOGIN' 
			, current_setting('myvars.postgres_db_user', true)::text 
			, current_setting('myvars.postgres_db_user_pw', true)::text
	);
	RAISE NOTICE 'Created user "%"', current_setting('myvars.postgres_db_user', true)::text;
EXCEPTION WHEN OTHERS THEN
	RAISE NOTICE 'User "%" already exists, re-creating it', current_setting('myvars.postgres_db_user', true)::text;
	EXECUTE format( '
         ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO %I;'
			, current_setting('myvars.postgres_db_user', true)::text 
	);
	EXECUTE format( '
            ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT ALL PRIVILEGES ON TABLES TO %I
            '
			, current_setting('myvars.postgres_db_user', true)::text 
	);
	EXECUTE format( '
            GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO %I
         '
			, current_setting('myvars.postgres_db_user', true)::text 
	);
	EXECUTE format( '
      GRANT SELECT, INSERT, UPDATE, DELETE , REFERENCES ON ALL TABLES IN SCHEMA public TO %I
         '
			, current_setting('myvars.postgres_db_user', true)::text 
	);
END
$do$;


-- to enable this for newly created relations too, then set the default permissions:
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON TABLES TO :postgres_db_user;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON SEQUENCES TO :postgres_db_user;

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO :postgres_db_user;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO :postgres_db_user;
GRANT ALL PRIVILEGES ON DATABASE :postgres_db_name TO :postgres_db_user;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO :postgres_db_user;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO :postgres_db_user;
GRANT SELECT, INSERT, UPDATE, DELETE , REFERENCES ON ALL TABLES IN SCHEMA public TO :postgres_db_user;

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit 
FROM pg_roles 
WHERE 1=1
AND rolname=:'postgres_db_user'
;

