-- file: src/sql/pgsql/list-postgres-schemas.sql
-- usage: 
/**
alias psql="PGPASSWORD=${postgres_db_user_pw:-} psql -v -q -t -X -w -U ${postgres_db_user:-}"
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -q -t -X -w -U ${postgres_db_useradmin:-}"
psql -d dev_qto < src/sql/pgsql/list-postgres-schemas.sql | less
*/

select schema_name
from information_schema.schemata;

-- eof file: src/sql/pgsql/list-postgres-schemas.sql
