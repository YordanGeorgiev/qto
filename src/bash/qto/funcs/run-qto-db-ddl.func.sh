doRunQtoDbDdl(){

   test -z "${proj_instance_dir-}" && export proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   test -z ${proj_conf_file:-} && export proj_conf_file="$proj_instance_dir/cnf/env/$env_type.env.json"
   do_export_json_section_vars $proj_conf_file '.env.db'
   do_log "INFO using proj_instance_dir: $proj_instance_dir" ; do_log "INFO using proj_conf_file: $proj_conf_file"
   sleep 3;

   # 00 create the db
   tmp_log_file="$tmp_dir/.$$.log"
	pgsql_scripts_dir="$product_instance_dir/src/sql/pgsql/qto"
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
	  GRANT CONNECT ON DATABASE $postgres_db_name TO $postgres_db_user;
	  GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO $postgres_db_user;
      GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_db_user;"

}
