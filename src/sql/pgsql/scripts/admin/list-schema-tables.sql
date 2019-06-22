-- file: src/sql/pgsql/scripts/admin/list-schema-tables.sql
-- usage: 
/**
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-}"
psql -d dev_qto < src/sql/pgsql/scripts/admin/list-schema-tables.sql 
*/

SELECT * FROM information_schema.tables
WHERE 1=1
-- AND table_schema='pg_catalog'
;

-- eof file: src/sql/pgsql/scripts/admin/list-schema-tables.sql
