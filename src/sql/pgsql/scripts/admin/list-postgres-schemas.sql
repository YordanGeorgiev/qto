-- file: src/sql/pgsql/list-postgres-schemas.sql
-- usage: 
/**
alias psql="PGPASSWORD=${postgres_app_usr_pw:-} psql -v -q -t -X -w -U ${postgres_app_usr:-}"
alias psql="PGPASSWORD=${postgres_sys_usr_admin_pw:-} psql -v -q -t -X -w -U ${postgres_sys_usr_admin:-}"
psql -d dev_qto < src/sql/pgsql/list-postgres-schemas.sql | less
*/

select schema_name
from information_schema.schemata;

-- eof file: src/sql/pgsql/list-postgres-schemas.sql
