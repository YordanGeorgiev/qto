# src/bash/issue-tracker/funcs/run-mysql-scripts.func.sh

# v1.0.9
# ---------------------------------------------------------
# run all the mysql scripts under the src/sql/mysql/db_
# ---------------------------------------------------------
doRunMySqlScripts(){

	doLog "DEBUG START doRunMySqlScripts"
	
   export tmp_log_file="$tmp_dir/.$$.log"
   test -d $tmp_dir || mkdir -p $tmp_dir

	doLog "INFO START :: running mysql sql scripts "	
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen

   # if the calling shell did not have exported mysql_scripts_dir var	
	test -z "${mysql_scripts_dir:-}" && \
	   mysql_scripts_dir="$product_instance_dir/src/sql/mysql/${env_type:-}_issue_tracker"
  
   test -d $mysql_scripts_dir || doExit "the mysql_scripts_dir: $mysql_scripts_dir
   does NOT EXIST. Nothing to do !!!"

   doLog "INFO running all the files from the mysql_scripts_dir: $mysql_scripts_dir"
   # echo mysql_db_name : $mysql_db_name 
   # sleep 10 ; 

   # if a relative path is passed add to the product version dir
	[[ ${mysql_scripts_dir:-} == /* ]] || export mysql_scripts_dir="$product_instance_dir"/"$mysql_scripts_dir"
   sql_script="$mysql_scripts_dir/""00.create-db.mysql"
  
   exit 0

   test -z "$mysql_scripts_dir" && mysql -u"$mysql_db_user" -p"$mysql_user_pw" \
   -e "set @mysql_db_name='$mysql_db_name';source $sql_script ;" > "$tmp_log_file" 2>&1
   ret=$?
   doLog "INFO ret: $ret" 
   
   # show the user what is happenning 
   cat "$tmp_log_file"
   exit 1

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
	find "$mysql_scripts_dir" -type f -name "*.sql"|sort -n
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
		# psql -v ON_ERROR_STOP=1 -q -t -X -U "${MySql_user:-}" \
      #  -v mysql_db_name="$mysql_db_name" -f "$sql_script" "$mysql_db_name" > "$tmp_log_file" 2>&1
      #ret=$?
      ret=0


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
	done < <(find "$mysql_scripts_dir" -type f -name "*.sql"|sort -n)
	
	doLog "INFO STOP  :: running mysql sql scripts "	
	test -z "${is_sql_biz_as_usual_run:-}" || sleep $sleep_interval ; 
	
	printf "\033[2J";printf "\033[0;0H"  ;    #and flush the screen
	doLog "DEBUG STOP  doRunMySqlScripts"
}
# eof func doRunMySqlScripts


# eof file: src/bash/issue-tracker/funcs/run-mysql-scripts.func.sh
