# src/bash/qto/funcs/run-pgsql-scripts.test.sh

doTestRunPgsqlScripts(){

	doLog "DEBUG START doTestRunPgsqlScripts"
	
	test -z "$sleep_interval" || sleep "$sleep_interval"

	doLog "test the running of the sql scripts under the product instance dir"
	doLog "Action !!! "
	doLog "bash src/bash/qto/qto.sh -a run-pgsql-scripts"

	bash src/bash/qto/qto.sh -a run-pgsql-scripts
   exit_code=$?
   test $exit_code -ne 0 && doExit $exit_code $exit_msg
   
	doLog "test the running of the sql scripts outside the product instance dir"
	doLog "with pre-set exported pgsql_scripts_dir var : aka export pgsql_scripts_dir=/tmp/qto"

   mkdir -p /tmp/qto
   cp -vr src/sql/pgsql/dev_pgsql_runner/* /tmp/qto/   
   export pgsql_scripts_dir=/tmp/qto

	doLog "Action !!! "
	doLog "bash src/bash/qto/qto.sh -a run-pgsql-scripts"
	bash src/bash/qto/qto.sh -a run-pgsql-scripts
   exit_code=$?
   doLog "DEBUG STOP  doTestRunPgsqlScripts"
}


# eof file: src/bash/qto/funcs/run-pgsql-scripts.test.sh
