# src/bash/qto/funcs/run-pgsql-scripts.test.sh

doTestRunPgsqlScripts(){

	do_log "DEBUG START doTestRunPgsqlScripts"
	
	test -z "$sleep_interval" || sleep "$sleep_interval"

	do_log "test the running of the sql scripts under the product instance dir"
	do_log "Action !!! "
	do_log "bash src/bash/qto/qto.sh -a run-pgsql-scripts"

	bash src/bash/qto/qto.sh -a run-pgsql-scripts
   exit_code=$?
   test $exit_code -ne 0 && do_exit $exit_code $exit_msg
   
	do_log "test the running of the sql scripts outside the product instance dir"
	do_log "with pre-set exported pgsql_scripts_dir var : aka export pgsql_scripts_dir=/tmp/qto"

   mkdir -p /tmp/qto
   cp -vr src/sql/pgsql/dev_pgsql_runner/* /tmp/qto/   
   export pgsql_scripts_dir=/tmp/qto

	do_log "Action !!! "
	do_log "bash src/bash/qto/qto.sh -a run-pgsql-scripts"
	bash src/bash/qto/qto.sh -a run-pgsql-scripts
   exit_code=$?
   do_log "DEBUG STOP  doTestRunPgsqlScripts"
}


# eof file: src/bash/qto/funcs/run-pgsql-scripts.test.sh
