-- run as the postgres user
-- \c postgres
CREATE USER usrqtoadmin WITH SUPERUSER CREATEROLE CREATEDB REPLICATION BYPASSRLS PASSWORD 'usrqtoadmin';
-- alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -q -t -X -w -U ${postgres_db_useradmin:-}"
-- psql -d dev_qto < src/sql/pgsql/list-table-priviledges.sql | less
-- \c dev_qto
CREATE ROLE usrqtoapp WITH PASSWORD 'usrqtoapp' LOGIN ;

GRANT SELECT ON ALL TABLES IN SCHEMA PUBLIC TO usrqtoapp;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO usrqtoapp;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO usrqtoapp;

SELECT rolname, rolsuper, rolinherit, rolcreaterole, rolcreatedb, rolcanlogin, rolreplication, rolconnlimit, rolvaliduntil 
FROM pg_roles 
WHERE 1=1
AND rolname='usrqtoapp'
;

/*
GRANT ALL PRIVILEGES ON DATABASE dev_qto TO usrqtoapp ;
GRANT SELECT, INSERT, UPDATE, DELETE , TRIGGER ON ALL TABLES IN SCHEMA public TO usrqtoapp ;
GRANT SELECT ON ALL TABLES IN SCHEMA pg_catalog TO usrqtoapp;
GRANT SELECT ON TABLE pg_attribute TO usrqtoapp ;
GRANT SELECT ON TABLE pg_class TO usrqtoapp;
GRANT SELECT ON TABLE pg_index TO usrqtoapp;
GRANT SELECT ON TABLE pg_description TO usrqtoapp ;
GRANT SELECT ON TABLE pg_attrdef TO usrqtoapp ;

*/
