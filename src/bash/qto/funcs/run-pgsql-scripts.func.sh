doRunPgsqlScripts(){
   test -z "${proj_instance_dir-}" && export proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   test -z ${proj_conf_file:-} && export proj_conf_file="$proj_instance_dir/cnf/env/$env_type.env.json"

   pgsql_scripts_dir="$product_instance_dir/src/sql/pgsql/qto"
   tmp_log_file="$tmp_dir/.$$.log"
   do_export_json_section_vars $proj_conf_file '.env.db'
   do_log "INFO using proj_instance_dir: $proj_instance_dir"
   do_log "INFO using proj_conf_file: $proj_conf_file"
   sleep 3 ; do_flush_screen ;
   echo -e "should run the following files: \n\n" ; find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n

   # run the sql scripts in alphabetical order - hence the file naming convention
   while read -r sql_script ; do 

      relative_sql_script=$(echo $sql_script|perl -ne "s|$proj_instance_dir\/||g;print")
      do_log "INFO START ::: running $relative_sql_script" ; echo -e '\n\n'
      perl -pi -e 's|-- DROP|DROP|g' $sql_script # drop and create the objects
      
      set -x
      PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -v ON_ERROR_STOP=1 -q -t -X -w \
         -h $postgres_db_host -p $postgres_db_port -U "${postgres_db_useradmin:-}" \
         -v AdminEmail="${AdminEmail:-}" \
         -v postgres_db_name="$postgres_db_name" -f "$sql_script" "$postgres_db_name" > "$tmp_log_file" 2>&1
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
