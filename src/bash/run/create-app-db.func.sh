do_create_app_db(){

	# set up confs
   source $PRODUCT_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PRODUCT_DIR/cnf/env/$env_type.env.json"
   source $PRODUCT_DIR/lib/bash/funcs/export-json-section-vars.sh
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'
   
   # create the app db
   tmp_log_file="/tmp/.$$.log"
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
  
	# verify the sql for the provisioning of the postgres_sys_usr_admin
  sudo -Hiu postgres PGPASSWORD=$postgres_rdbms_usr_pw psql --port $postgres_rdbms_port \
         --host $postgres_rdbms_host -d postgres -c '\l'
  sleep 1
}
