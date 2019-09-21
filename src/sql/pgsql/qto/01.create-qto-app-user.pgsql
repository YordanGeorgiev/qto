-- \c dev_qto
-- SELECT ''||:postgres_db_user_pw||'';

-- set pw :'postgres_db_user_pw'
-- echo :postgres_db_user_pw postgres_db_user_pw;
-- echo :pw pw;

-- ALTER ROLE usrqtoapp WITH PASSWORD ':postgres_db_user_pw' LOGIN ;
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT 
      FROM   pg_catalog.pg_roles
      WHERE  rolname = 'usrqtoapp') THEN
		   CREATE ROLE usrqtoapp WITH PASSWORD ':postgres_db_user_pw' LOGIN ;
   END IF;
END
$do$;
ALTER ROLE usrqtoapp WITH PASSWORD  :'postgres_db_user_pw' LOGIN ;

-- how-to perform this one in a one-liner from sudo os usr ?!
-- sudo su - postgres -c "psql -d prd_ysg -c "ALTER ROLE usrqtoadmin WITH PASSWORD 'usrqtoadmin' LOGIN;"

-- to enable this for newly created relations too, then set the default permissions:
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON TABLES TO usrqtoapp;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON SEQUENCES TO usrqtoapp;

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO usrqtoapp;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO usrqtoapp;
GRANT ALL PRIVILEGES ON DATABASE :"postgres_db_name" TO usrqtoapp ; 
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO usrqtoapp ;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO usrqtoapp ; 
GRANT SELECT, INSERT, UPDATE, DELETE , REFERENCES ON ALL TABLES IN SCHEMA public TO usrqtoapp ;

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit FROM pg_roles 
WHERE 1=1
AND rolname='usrqtoapp'
;

