-- src: https://stackoverflow.com/a/49175321/65706
-- src: https://dba.stackexchange.com/a/213921/1245
		
ALTER ROLE :"postgres_app_usr" WITH PASSWORD :'postgres_app_usr_pw';

-- to enable this for newly created relations too, then set the default permissions:
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON TABLES TO :"postgres_app_usr";
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON SEQUENCES TO :"postgres_app_usr";

GRANT SELECT
	ON ALL TABLES
	IN SCHEMA PUBLIC
	TO :"postgres_app_usr";
	
GRANT SELECT
	ON ALL TABLES
	IN SCHEMA pg_catalog
	TO :"postgres_app_usr";

GRANT ALL PRIVILEGES
	ON DATABASE :"postgres_app_db"
	TO :"postgres_app_usr";
	
GRANT ALL PRIVILEGES
	ON ALL TABLES
	IN SCHEMA public
	TO :"postgres_app_usr";
	
GRANT ALL PRIVILEGES
	ON ALL SEQUENCES
	IN SCHEMA public
	TO :"postgres_app_usr";
	
GRANT SELECT, INSERT, UPDATE, DELETE, REFERENCES
	ON ALL TABLES
	IN SCHEMA public
	TO :"postgres_app_usr";

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit
	FROM pg_app_roles 
	WHERE 1=1
	ND rolname=:'postgres_app_usr';

