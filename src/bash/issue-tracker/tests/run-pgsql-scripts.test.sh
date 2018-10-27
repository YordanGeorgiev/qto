# src/bash/issue-tracker/funcs/run-pgsql-scripts.test.sh

# v1.1.0
# ---------------------------------------------------------
# docs cat doc/txt/issue-tracker/tests/run-pgsql-scripts.test.txt
# ---------------------------------------------------------
doTestRunPgsqlScripts(){

	doLog "DEBUG START doTestRunPgsqlScripts"
	
	test -z "$sleep_interval" || sleep "$sleep_interval"

	doLog "test the running of the sql scripts under the product instance dir"
	doLog "Action !!! "
	doLog "bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts"

	bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts
   exit_code=$?
   test $exit_code -ne 0 && doExit $exit_code $exit_msg
   
	doLog "test the running of the sql scripts outside the product instance dir"
	doLog "with pre-set exported pgsql_scripts_dir var : aka export pgsql_scripts_dir=/tmp/issue-tracker"

   mkdir -p /tmp/issue-tracker
   cp -vr src/sql/pgsql/dev_pgsql_runner/* /tmp/issue-tracker/   
   export pgsql_scripts_dir=/tmp/issue-tracker

	doLog "Action !!! "
	doLog "bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts"
	bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts
   exit_code=$?
   doLog "DEBUG STOP  doTestRunPgsqlScripts"
}
# eof func doTestRunPgsqlScripts


# eof file: src/bash/issue-tracker/funcs/run-pgsql-scripts.test.sh
