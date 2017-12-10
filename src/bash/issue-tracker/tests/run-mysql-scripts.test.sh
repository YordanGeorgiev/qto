# src/bash/issue-tracker/funcs/run-mysql-scripts.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/run-mysql-scripts.test.txt
# ---------------------------------------------------------
doTestRunMysqlScripts(){

	doLog "DEBUG START doTestRunMysqlScripts"
   # to get the doParseIniEnvVars func
   source $product_instance_dir/src/bash/lib/.bash_funcs.host-name
   
   msg="test-01 if the mysql_scripts_dir is empty the default one should be used"
   doLog "INFO $msg"
   # pre-load a configurtion file
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf

   # set an undefined mysql_scripts_dir for the test case run
   export mysql_scripts_dir=""
   # Action !!! 
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts & export child_pid=$!
   sleep 4 # give some time for the child the finish
   child_log_file=$product_instance_dir/dat/log/bash/issue-tracker.`date "+%Y%m"`.log
   str_to_grep='\['"$child_pid"'\]'" running all the files from the mysql_scripts_dir: "
   str_to_grep="$str_to_grep""$product_instance_dir/src/sql/mysql/dev_issue_tracker"
   test $(grep -c "$str_to_grep" $child_log_file) -eq 1 || export exit_code=1
   test $exit_code -eq 1 && doExit $exit_code "test run failed for test : $msg"

   
   msg="test-02 test run if the mysql_scripts dir is not existing dir"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_scripts_dir=undefined
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # --


   msg="test-03 test run if the mysql_scripts dir is defined in the configuration file"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   str_to_grep='\['"$child_pid"'\]'" running all the files from the mysql_scripts_dir: "
   str_to_grep="$str_to_grep""$mysql_scripts_dir"
   test $(grep -c "$str_to_grep" $child_log_file) -eq 1 || export exit_code=1
   test $exit_code -eq 1 && doExit $exit_code "test run failed for test : $msg"
   # --


   msg="test-04 if a relative path is set add to the product instance dir"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   mysql_scripts_dir_chk=$mysql_scripts_dir
   export mysql_scripts_dir='src/sql/mysql/dev_issue_tracker'
   str_to_grep='\['"$child_pid"'\]'" running all the files from the mysql_scripts_dir: "
   str_to_grep="$str_to_grep""$mysql_scripts_dir_chk"
   test $(grep -c "$str_to_grep" $child_log_file) -eq 1 || export exit_code=1
   test $exit_code -eq 1 && doExit $exit_code "test run failed for test : $msg"
   # ---
   
   msg="test-05 test run if the mysql_user is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_user=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # --
   
   
   msg="test-06 test run if the mysql_user_pw is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_user_pw=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # --


   msg="test-07 fail if the db creation fails"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_scripts_dir="$product_instance_dir/src/sql/mysql/dev_issue_tracker"
   export mysql_create_db_script="$mysql_scripts_dir/00.create-db.mysql"
   # break the syntax of the sql on purpose
   perl -pi -e 's/CREATE DATABASE/UNCREATE DATABASE/g' $mysql_create_db_script
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # restore the syntax
   perl -pi -e 's/UNCREATE DATABASE/CREATE DATABASE/g' $mysql_create_db_script
   # --


   msg="test-08 the full run is ok if all the ok conditions are met"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=0
   test $ret -ne 0 && export exit_code=1
   test $ret -ne 0 && doExit $exit_code "test failed for $msg"
   # --

	doLog "DEBUG STOP  doTestRunMysqlScripts"
}
# eof func doTestRunMysqlScripts


# eof file: src/bash/issue-tracker/funcs/run-mysql-scripts.test.sh
