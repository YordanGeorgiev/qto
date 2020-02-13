-- src: https://stackoverflow.com/a/49175321/65706
-- src: https://dba.stackexchange.com/a/213921/1245
		
ALTER ROLE :"postgres_db_user" WITH PASSWORD :'postgres_db_user_pw';

-- to enable this for newly created relations too, then set the default permissions:
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON TABLES TO :"postgres_db_user";
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON SEQUENCES TO :"postgres_db_user";

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO :"postgres_db_user";
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO :"postgres_db_user";
GRANT ALL PRIVILEGES ON DATABASE :"postgres_db_name" TO :"postgres_db_user";
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO :"postgres_db_user";
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO :"postgres_db_user";
GRANT SELECT, INSERT, UPDATE, DELETE , REFERENCES ON ALL TABLES IN SCHEMA public TO :"postgres_db_user";

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit FROM pg_roles 
WHERE 1=1
AND rolname=:'postgres_db_user'
;

