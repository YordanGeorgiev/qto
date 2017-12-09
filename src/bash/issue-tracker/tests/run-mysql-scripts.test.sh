# src/bash/issue-tracker/funcs/run-mysql-scripts.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/run-mysql-scripts.test.txt
# ---------------------------------------------------------
doTestRunMysqlScripts(){

	doLog "DEBUG START doTestRunMysqlScripts"
   
   # Action !!!
   msg="test-01 if the mysql_scripts_dir is empty the default one should be used"
   # to get the doParseIniEnvVars func
   source $product_instance_dir/src/bash/lib/.bash_funcs.host-name

   # pre-load a configurtion file
   doParseIniEnvVars /vagrant/var/csitea/cnf/projects/issue-tracker/ysg-issues.dev.host-name.cnf

   # set an undefined mysql_scripts_dir for the test case run
   export mysql_scripts_dir=""
   
   doLog "INFO $msg"
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts & export child_pid=$!
   sleep 4
   child_log_file=$product_instance_dir/dat/log/bash/issue-tracker.`date "+%Y%m"`.log
   str_to_grep='\['"$child_pid"'\]'" running all the files from the mysql_scripts_dir: $product_instance_dir/src/sql/mysql/dev_issue_tracker"
   test $(grep -c "$str_to_grep" $child_log_file) -eq 1 || export exit_code=1
   test $exit_code -eq 1 && doExit $exit_code "test run failed for test : $msg"

   #bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   
   #doLog "INFO test-02 test run if the mysql_scripts dir is not existing dir"
   #export mysql_scripts_dir=undefined

   #doLog "INFO test-02 test run if the mysql_scripts dir is not existing dir"
   #doParseIniEnvVars /vagrant/var/csitea/cnf/projects/issue-tracker/ysg-issues.dev.host-name.cnf

   #doLog "INFO test-02 test with existing mysql_scripts dir the creation of the mysql db"
   #bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts

	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doTestRunMysqlScripts"
}
# eof func doTestRunMysqlScripts


# eof file: src/bash/issue-tracker/funcs/run-mysql-scripts.test.sh
