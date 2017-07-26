# file: src/bash/issue-tracker/funcs/run-pgsql-scripts.func.sh

# v1.0.2
# ---------------------------------------------------------
# the docs	
# cat doc/txt/issue-tracker/funcs/run-pgsql-scripts.func.txt
# ---------------------------------------------------------
doRunPgsqlScripts(){

	doLog "DEBUG START doRunPgsqlScripts"
	
   export tmp_log_file="$tmp_dir/.$$.log"
	doLog "INFO START :: running sql scripts "	
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen

   # if the calling shell did not have exported sql_dir var	
	test -z "$sql_dir" && \
	   sql_dir="$product_instance_dir/src/sql/pgsql/$db_name"

   # if a relative path is passed add to the product version dir
	[[ $sql_dir == /* ]] || export sql_dir="$product_instance_dir"/"$sql_dir"
   sql_script="$sql_dir/""00.create-db.pgsql"
   
   # run the sql save the result into a tmp log file
   psql -v ON_ERROR_STOP=1 -q -t -X -U "${pgsql_user:-}" \
       -v db_name="$db_name" -f "$sql_script" postgres > "$tmp_log_file" 2>&1
   ret=$?
   
   # show the user what is happenning 
   cat "$tmp_log_file"

   test $ret -ne 0 && doExit $ret "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"
 
	# show the developer what happened
	cat "$tmp_log_file" 

	# and save the tmp log file into the log file
	cat "$tmp_log_file" >> $log_file
   sleep 2

	test -z "${is_sql_biz_as_usual_run:-}" && sleep 1 ; 
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen
	
	doLog "INFO should run the following sql files: "
   echo -e "\n\n"
	find "$sql_dir" -type f -name "*.sql"|sort -n
	sleep 1

	# run the sql scripts in alphabetical order
   while read -r sql_script ; do (

		relative_sql_script=$(echo $sql_script|perl -ne "s#$product_instance_dir##g;print")

		# give the poor dev a time to see what is happening
		test -z "${is_sql_biz_as_usual_run:-}" && sleep 1 ; 

		# and clear the screen
		printf "\033[2J";printf "\033[0;0H"

		doLog "INFO START ::: running $relative_sql_script"
		echo -e '\n\n'
		# run the sql save the result into a tmp log file
		psql -v ON_ERROR_STOP=1 -q -t -X -U "${pgsql_user:-}" \
         -v db_name="$db_name" -f "$sql_script" "$db_name" > "$tmp_log_file" 2>&1
       
		# show the user what is happenning 
		cat "$tmp_log_file"

      test $ret -ne 0 && doExit $ret "pid: $$ psql ret $ret - failed to run sql_script: $sql_script !!!"


		# and save the tmp log file into the script log file
		cat "$tmp_log_file" >> $log_file
		echo -e '\n\n'

		doLog "INFO STOP  ::: running $relative_sql_script"
	);
	done < <(find "$sql_dir" -type f -name "*.sql"|sort -n)
	
	doLog "INFO STOP  :: running sql scripts "	
	test -z "${is_sql_biz_as_usual_run:-}" && sleep 1 ; 
	
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen
	doLog "DEBUG STOP  doRunPgsqlScripts"
}
# eof func doRunPgsqlScripts


# eof file: src/bash/issue-tracker/funcs/run-pgsql-scripts.func.sh
