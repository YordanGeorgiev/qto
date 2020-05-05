doRunQtoDbDdl(){

   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'
   do_log "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ; do_log "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"
   sleep 3;

   # 00 create the db
   tmp_log_file="$tmp_dir/.$$.log"
	pgsql_scripts_dir="$PRODUCT_INSTANCE_DIR/src/sql/pgsql/qto"
   sql_script="$pgsql_scripts_dir/00.create-db.pgsql"

   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -v -q -t -X -w -U "${postgres_db_useradmin:-}" \
      -h $postgres_db_host -p $postgres_db_port -v ON_ERROR_STOP=1 \
		-v postgres_db_name="${postgres_db_name:-}" \
      -f "$sql_script" postgres > "$tmp_log_file" 2>&1
   ret=$?
   cat "$tmp_log_file" ; cat "$tmp_log_file" >> $log_file # show it and save it 
   test $ret -ne 0 && { 
      sleep 3 ; do_exit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!" ; break ;
   }
  
   doRunPgsqlScripts
   # 01 create / modify the app user
   sql_script="$pgsql_scripts_dir/01.create-qto-app-user.pgsql"
   #sql_script="$pgsql_scripts_dir/02.alter-qto-app-user.pgsql"
   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -q -t -X -w -U "${postgres_db_useradmin:-}" \
      -h $postgres_db_host -p $postgres_db_port -v ON_ERROR_STOP=1 \
      -v postgres_db_user="${postgres_db_user:-}" \
      -v postgres_db_user_pw="${postgres_db_user_pw:-}" \
      -v postgres_db_name="${postgres_db_name:-}" \
      -f "$sql_script" "${postgres_db_name:-}" > "$tmp_log_file" 2>&1
   ret=$?

   cat "$tmp_log_file" ; cat "$tmp_log_file" >> $log_file # show it and save it 
   test $ret -ne 0 && {
      sleep 3 ; do_exit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"; 
   } 
   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -q -t -X -w -U "${postgres_db_useradmin:-}" \
      -h $postgres_db_host -p $postgres_db_port -d postgres -v ON_ERROR_STOP=1 -c \
      "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO $postgres_db_user;
	  GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO $postgres_db_user;
      GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user;"

}
