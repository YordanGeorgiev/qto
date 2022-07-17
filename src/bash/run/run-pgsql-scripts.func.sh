doRunPgsqlScripts(){
   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   #
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json"

   pgsql_scripts_dir="$PRODUCT_DIR/src/sql/pgsql/qto"
   tmp_log_file="$tmp_dir/.$$.log"
   do_export_json_section_vars $PROJ_CONF_FILE '.env.db'
   do_log "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR"
   do_log "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"
   sleep 3 ; do_flush_screen ;
   echo -e "should run the following files: \n\n" ; find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n

   # run the sql scripts in alphabetical order - hence the file naming convention
   while read -r sql_script ; do

      relative_sql_script=$(echo $sql_script|perl -ne "s|$PROJ_INSTANCE_DIR\/||g;print")
      do_log "INFO START ::: running $relative_sql_script" ; echo -e '\n\n'
      perl -pi -e 's|-- DROP|DROP|g' $sql_script # drop and create the objects

      set -x
      PGPASSWORD="${postgres_sys_usr_admin_pw:-}" psql -v ON_ERROR_STOP=1 -q -t -X -w \
         -h $postgres_rdbms_host -p $postgres_rdbms_port -U "${postgres_sys_usr_admin:-}" \
         -v AdminEmail="${AdminEmail:-}" \
         -v postgres_app_db="$postgres_app_db" -f "$sql_script" "$postgres_app_db" > "$tmp_log_file" 2>&1
      ret=$?
      set +x

      perl -pi -e 's|DROP|-- DROP|g' $relative_sql_script
      cat "$tmp_log_file" ; cat "$tmp_log_file" >> $log_file  # show it and save it
      test $ret -ne 0 && sleep 3
      test $ret -ne 0 && do_exit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
      test $ret -ne 0 && break

      echo -e '\n\n'; do_flush_screen ;
      do_log "INFO STOP   ::: running $relative_sql_script"
   done < <(find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n)

   do_flush_screen ;
}
