# file: src/bash/issue-tracker/funcs/run-pgsql-scripts.func.sh

# v1.0.3
# ---------------------------------------------------------
# the docs	:
# cat doc/txt/issue-tracker/funcs/run-pgsql-scripts.func.txt
# ---------------------------------------------------------
doRunPgsqlScripts(){

	doLog "DEBUG START doRunPgsqlScripts"
	
   export tmp_log_file="$tmp_dir/.$$.log"
	doLog "INFO START :: running pg sql scripts "	
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen

   # if the calling shell did not have exported pgsql_scripts_dir var	
	test -z "${pgsql_scripts_dir:-}" && \
	   pgsql_scripts_dir="$product_instance_dir/src/sql/pgsql/${postgres_db_name:-}"

   echo postgres_db_name : $postgres_db_name 
   sleep 10 ; 

   # if a relative path is passed add to the product version dir
	[[ ${pgsql_scripts_dir:-} == /* ]] || export pgsql_scripts_dir="$product_instance_dir"/"$pgsql_scripts_dir"
   sql_script="$pgsql_scripts_dir/""00.create-db.pgsql"
   
   # run the sql save the result into a tmp log file
   psql -v ON_ERROR_STOP=1 -q -t -X -U "${pgsql_user:-}" \
       -v postgres_db_name="${postgres_db_name:-}" -f "$sql_script" postgres > "$tmp_log_file" 2>&1
   ret=$?
   doLog "INFO ret: $ret" 
   
   # show the user what is happenning 
   cat "$tmp_log_file"

   test $ret -ne 0 && sleep 3
   test $ret -ne 0 && export exit_code=1
   test $ret -ne 0 && exit 1
   test $ret -ne 0 && doExit "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
   test $ret -ne 0 && break
 
	# show the developer what happened
	cat "$tmp_log_file" 

	# and save the tmp log file into the log file
	cat "$tmp_log_file" >> $log_file
   sleep $sleep_interval

	test -z "${is_sql_biz_as_usual_run:-}" || sleep 1 ; 
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen
	
	doLog "INFO should run the following sql files: "
   echo -e "\n\n"
	find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n
   sleep $sleep_interval

	# run the sql scripts in alphabetical order
   while read -r sql_script ; do 

		relative_sql_script=$(echo $sql_script|perl -ne "s#$product_instance_dir##g;print")

		# give the poor dev a time to see what is happening
		test -z "${is_sql_biz_as_usual_run:-}" || sleep $sleep_interval ; 

		# and clear the screen
		printf "\033[2J";printf "\033[0;0H"

		doLog "INFO START ::: running $relative_sql_script"
		echo -e '\n\n'
		# run the sql save the result into a tmp log file
		psql -v ON_ERROR_STOP=1 -q -t -X -U "${pgsql_user:-}" \
         -v postgres_db_name="$postgres_db_name" -f "$sql_script" "$postgres_db_name" > "$tmp_log_file" 2>&1
      ret=$?

		# show the user what is happenning 
		cat "$tmp_log_file"
      test $ret -ne 0 && sleep 3
      test $ret -ne 0 && export exit_code=1
      test $ret -ne 0 && doExit "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
      test $ret -ne 0 && break

		# and save the tmp log file into the script log file
		cat "$tmp_log_file" >> $log_file
		echo -e '\n\n'

		doLog "INFO STOP  ::: running $relative_sql_script"
	done < <(find "$pgsql_scripts_dir" -type f -name "*.sql"|sort -n)
	
	doLog "INFO STOP  :: running sql scripts "	
	test -z "${is_sql_biz_as_usual_run:-}" || sleep $sleep_interval ; 
	
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen
	doLog "DEBUG STOP  doRunPgsqlScripts"
}
# eof func doRunPgsqlScripts


# eof file: src/bash/issue-tracker/funcs/run-pgsql-scripts.func.sh
