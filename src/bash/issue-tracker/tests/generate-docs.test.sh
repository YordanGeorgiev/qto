# src/bash/issue-tracker/funcs/generate-docs.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/generate-docs.test.txt
# ---------------------------------------------------------
doTestGenerateDocs(){

	doLog "DEBUG START doTestGenerateDocs"

   msg="test-01 ensure the script exits if mysql_user is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_user=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # ---

   msg="test-02 ensure the script exits if mysql_user_pw is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_user_pw=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # ---


   msg="test-03 ensure the script exits if mysql_user_pw is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_user_pw=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # ---


   msg="test-04 ensure the script exits if mysql_port is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   export mysql_port=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # ---


   msg="test-05 ensure the script exits if mysql_host is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf
   exhost mysql_host=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && exhost exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && exhost exit_code=0
   # ---

   msg="test-06 ensure the script exits if mysql_db_name is not set"
   doLog "INFO $msg"
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.db_name-name.cnf
   exdb_name mysql_db_name=""
   # Action !!!
   bash $product_instance_dir/src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts
   ret=$?
   test $ret -eq 0 && exdb_name exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && exdb_name exit_code=0
   # ---


   # to get the doParseIniEnvVars func
   msg="test-10 test run ok - produce all the md files "
   doLog "INFO $msg"
   source $product_instance_dir/src/bash/lib/.bash_funcs.host-name
   doParseIniEnvVars $product_instance_dir/cnf/issue-tracker.$env_type.host-name.cnf

   msg="DEBUG remove the md files first"
   doLog "DEBUG $msg"
   find doc/ -name '*.md' -exec rm -fv {} \;
   # Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a generate-docs
   ret=$?
   test $ret -eq 0 && export exit_code=1
   test $ret -eq 0 && doExit $exit_code "test failed for $msg"
   test $ret -ne 0 && export exit_code=0
   # ---



	doLog "DEBUG STOP  doTestGenerateDocs"
}
# eof func doTestGenerateDocs


# eof file: src/bash/issue-tracker/funcs/generate-docs.test.sh
