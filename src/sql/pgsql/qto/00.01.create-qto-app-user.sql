-- \c dev_qto
DO
$do$
BEGIN
   IF NOT EXISTS (
      SELECT                       -- SELECT list can stay empty for this
      FROM   pg_catalog.pg_roles
      WHERE  rolname = 'usrqtoapp') THEN

		CREATE ROLE usrqtoapp WITH PASSWORD 'usrqtoapp' LOGIN ;
   END IF;
END
$do$;
ALTER ROLE usrqtoapp WITH PASSWORD 'usrqtoapp' LOGIN ;

-- to enable this for newly created relations too, then set the default permissions:
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON TABLES TO usrqtoapp;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON SEQUENCES TO usrqtoapp;

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO usrqtoapp;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO usrqtoapp;
GRANT ALL PRIVILEGES ON DATABASE :postgres_db_name TO usrqtoapp ; 
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO usrqtoapp ;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO usrqtoapp ; 
GRANT SELECT, INSERT, UPDATE, DELETE , REFERENCES ON ALL TABLES IN SCHEMA public TO usrqtoapp ;

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit FROM pg_roles 
WHERE 1=1
AND rolname='usrqtoapp'
;

