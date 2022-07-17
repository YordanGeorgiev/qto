doRunQtoDbDdl(){

   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   #
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json"
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'
   do_log "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR" ; do_log "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"
   sleep 3;

   # 00 create the db
   tmp_log_file="$tmp_dir/.$$.log"
	pgsql_scripts_dir="$PRODUCT_DIR/src/sql/pgsql/qto"
   sql_script="$pgsql_scripts_dir/00.create-db.pgsql"

   PGPASSWORD="${postgres_sys_usr_admin_pw:-}" psql -v -q -t -X -w -U "${postgres_sys_usr_admin:-}" \
      -h $postgres_rdbms_host -p $postgres_rdbms_port -v ON_ERROR_STOP=1 \
		-v postgres_app_db="${postgres_app_db:-}" \
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
   PGPASSWORD="${postgres_sys_usr_admin_pw:-}" psql -q -t -X -w -U "${postgres_sys_usr_admin:-}" \
      -h $postgres_rdbms_host -p $postgres_rdbms_port -v ON_ERROR_STOP=1 \
      -v postgres_app_usr="${postgres_app_usr:-}" \
      -v postgres_app_usr_pw="${postgres_app_usr_pw:-}" \
      -v postgres_app_db="${postgres_app_db:-}" \
      -f "$sql_script" "${postgres_app_db:-}" > "$tmp_log_file" 2>&1
   ret=$?

   cat "$tmp_log_file" ; cat "$tmp_log_file" >> $log_file # show it and save it
   test $ret -ne 0 && {
      sleep 3 ; do_exit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!";
   }
   PGPASSWORD="${postgres_sys_usr_admin_pw:-}" psql -q -t -X -w -U "${postgres_sys_usr_admin:-}" \
      -h $postgres_rdbms_host -p $postgres_rdbms_port -d postgres -v ON_ERROR_STOP=1 -c \
      "GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO $postgres_app_usr;
	  GRANT CONNECT ON DATABASE $postgres_app_db TO $postgres_app_usr;
	  GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO $postgres_app_usr;
      GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO $postgres_app_usr;"

}
