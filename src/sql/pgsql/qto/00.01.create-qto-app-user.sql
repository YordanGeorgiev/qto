CREATE ROLE usrqtoapp WITH PASSWORD 'usrqtoapp' LOGIN ;
-- \c dev_qto
GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO usrqtoapp;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO usrqtoapp;

GRANT SELECT, INSERT, UPDATE, DELETE , REFERENCES ON ALL TABLES IN SCHEMA public TO usrqtoapp ;

GRANT ALL PRIVILEGES ON DATABASE dev_qto TO USRQTOAPP;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO usrqtoapp ;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO usrqtoapp ; 

-- to enable this for newly created relations too, then set the default permissions:
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON TABLES TO usrqtoapp;
ALTER DEFAULT PRIVILEGES IN SCHEMA public 
   GRANT ALL PRIVILEGES ON SEQUENCES TO usrqtoapp;

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit, rolvaliduntil 
FROM pg_roles  WHERE 1=1 AND rolname='usrqtoapp' ;
