doRunPgsqlScripts(){
   test -z "${PROJ_INSTANCE_DIR-}" && export PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"
   pgsql_scripts_dir="$PROJ_INSTANCE_DIR/src/sql/pgsql/qto"
   tmp_log_file="$tmp_dir/.$$.log"
   doExportJsonSectionVars $PROJ_CONF_FILE '.env.db'
   doLog "INFO using PROJ_INSTANCE_DIR: $PROJ_INSTANCE_DIR"
   doLog "INFO using PROJ_CONF_FILE: $PROJ_CONF_FILE"
   sleep 3 ; clearTheScreen	
   echo -e "should run the following files: \n\n" ; find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n

	# run the sql scripts in alphabetical order - hence the file namging convention
   while read -r sql_script ; do 

		relative_sql_script=$(echo $sql_script|perl -ne "s|$PROJ_INSTANCE_DIR\/||g;print")
		doLog "INFO START ::: running $relative_sql_script" ; echo -e '\n\n'
      perl -pi -e 's|-- DROP|DROP|g' $sql_script # drop and create the objects

      PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -v ON_ERROR_STOP=1 -q -t -X -w \
         -h $postgres_db_host -p $postgres_db_port -U "${postgres_db_useradmin:-}" \
         -v postgres_db_name="$postgres_db_name" -f "$sql_script" "$postgres_db_name" > "$tmp_log_file" 2>&1
      ret=$?

      perl -pi -e 's|DROP|-- DROP|g' $relative_sql_script
      cat "$tmp_log_file" ; cat "$tmp_log_file" >> $log_file # show it and save it 
      test $ret -ne 0 && sleep 3
      test $ret -ne 0 && doExit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
      test $ret -ne 0 && break

		echo -e '\n\n'; clearTheScreen	
		doLog "INFO STOP   ::: running $relative_sql_script"
	done < <(find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n)
	
	clearTheScreen ; 
}
