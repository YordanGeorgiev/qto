# ---------------------------------------------------------
# cat doc/txt/qto/funcs/run-pgsql-scripts.func.txt
# ---------------------------------------------------------
doRunPgsqlScripts(){

   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   test -z ${PROJ_CONF_FILE:-} && export PROJ_CONF_FILE="$PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json"
   doExportJsonSectionVars $PROJ_CONF_FILE '.env.db'
   export tmp_log_file="$tmp_dir/.$$.log"

   # create the db
	pgsql_scripts_dir="$PRODUCT_INSTANCE_DIR/src/sql/pgsql/qto"
   sql_script="$pgsql_scripts_dir/""00.create-db.pgsql"
   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -v -q -t -X -w -U "${postgres_db_useradmin:-}" \
      -h $postgres_db_host -p $postgres_db_port \
		-v ON_ERROR_STOP=1 \
		-v postgres_db_name="${postgres_db_name:-}" \
      -f "$sql_script" postgres > "$tmp_log_file" 2>&1
   ret=$?
   cat "$tmp_log_file" # show it 
   test $ret -ne 0 && sleep 3
   test $ret -ne 0 && doExit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
   test $ret -ne 0 && break
	cat "$tmp_log_file" >> $log_file # save it
  
   # create the app user
   sql_script="$pgsql_scripts_dir/01.create-qto-app-user.pgsql"
   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -q -t -X -w -U "${postgres_db_useradmin:-}" \
      -h $postgres_db_host -p $postgres_db_port \
		-v ON_ERROR_STOP=1 \
      -v postgres_db_user_pw="${postgres_db_user_pw:-}" \
      -v postgres_db_name="${postgres_db_name:-}" \
      -f "$sql_script" "${postgres_db_name:-}" > "$tmp_log_file" 2>&1
   ret=$?
   cat "$tmp_log_file" # show it 
   test $ret -ne 0 && sleep 3
   test $ret -ne 0 && doExit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
   test $ret -ne 0 && break
	cat "$tmp_log_file" >> $log_file # save it

	test -z "${is_sql_biz_as_usual_run:-}" || sleep 1 ; 
   clearTheScreen	
   
   echo -e "should run the following files: \n\n" ; 
	find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n

	# run the sql scripts in alphabetical order
   while read -r sql_script ; do 

		relative_sql_script=$(echo $sql_script|perl -ne "s#$PRODUCT_INSTANCE_DIR##g;print")

		# give the poor dev a time to see what is happening
		test -z "${is_sql_biz_as_usual_run:-}" || sleep $sleep_interval ; clearTheScreen ; 

		doLog "INFO START ::: running $relative_sql_script"
		echo -e '\n\n'
      PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -v ON_ERROR_STOP=1 -q -t -X -w \
         -h $postgres_db_host -p $postgres_db_port -U "${postgres_db_useradmin:-}" \
         -v postgres_db_name="$postgres_db_name" -f "$sql_script" "$postgres_db_name" > "$tmp_log_file" 2>&1
      ret=$?

		cat "$tmp_log_file"
      test $ret -ne 0 && sleep 3
      test $ret -ne 0 && doExit 1 "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
      test $ret -ne 0 && break

		# and save the tmp log file into the script log file
		cat "$tmp_log_file" >> $log_file
		echo -e '\n\n'

		doLog "INFO STOP  ::: running $relative_sql_script"
	done < <(find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n)
	
	clearTheScreen ; 
}


# eof file: src/bash/qto/funcs/run-pgsql-scripts.func.sh
