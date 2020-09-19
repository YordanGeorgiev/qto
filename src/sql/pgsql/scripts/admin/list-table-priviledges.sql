-- file: src/sql/pgsql/list-table-priviledges.sql
-- usage: 
-- alias psql="PGPASSWORD=${postgres_sys_usr_admin_pw:-} psql -v -q -t -X -w -U ${postgres_sys_usr_admin:-}"
-- psql -d dev_qto < src/sql/pgsql/list-table-priviledges.sql | less
SELECT grantee, table_name , privilege_type
FROM information_schema.role_table_grants 
WHERE 1=1 
AND grantee = 'usrqtoapp'
AND table_name='readme_doc'
; 

-- purpose: 
-- list the priveledges per user or for user in a database
-- eof file: src/sql/pgsql/list-table-priviledges.sql
