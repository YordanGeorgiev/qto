-- credit & src: https://stackoverflow.com/a/42108936/65706
-- docs & usage @end
/*
SELECT grantee, privilege_type 
FROM information_schema.role_table_grants 
WHERE table_name='foobar'
;
*/
select a.tablename , b.usename
   , HAS_TABLE_PRIVILEGE(usename,tablename, 'select') as select
   , HAS_TABLE_PRIVILEGE(usename,tablename, 'insert') as insert
   , HAS_TABLE_PRIVILEGE(usename,tablename, 'update') as update
   , HAS_TABLE_PRIVILEGE(usename,tablename, 'delete') as delete
   , HAS_TABLE_PRIVILEGE(usename,tablename, 'references') as references  
from pg_tables a , pg_user b 
where a.tablename='monthly_issues'
;

/* 
usage: 
psql -d $postgres_db_name < src/sql/pgsql/scripts/check-postgres-tables-permissions.sql

*/

