-- file: src/sql/pgsql/scripts/admin/list-schema-tables.sql
-- usage: 
/**
alias psql="PGPASSWORD=${postgres_db_useradmin_pw:-} psql -v -t -X -w -U ${postgres_db_useradmin:-}"
psql -d dev_qto < src/sql/pgsql/scripts/admin/list-schema-tables.sql 
*/

      INSERT INTO app_items ( id,name,is_menu)
      SELECT  
           ROW_NUMBER () OVER (ORDER BY table_name) as id
         , table_name as name
         , '1'
      FROM information_schema.tables  
      WHERE 1=1 
      AND table_type = 'BASE TABLE' 
      AND table_schema = 'public' 
      ORDER BY table_name
;

/*
      SELECT  
           ROW_NUMBER () OVER (ORDER BY table_name) as row_id
         , table_name as name
      FROM information_schema.tables  
      WHERE 1=1 
      AND table_type = 'BASE TABLE' 
      AND table_schema = 'public' 
      ORDER BY table_name
;
*/
-- eof file: src/sql/pgsql/scripts/admin/list-schema-tables.sql
