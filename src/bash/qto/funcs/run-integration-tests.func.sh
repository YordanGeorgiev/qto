# src/bash/qto/funcs/run-integration-tests.func.sh

# v0.5.6
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/run-integration-tests.func.txt
# ---------------------------------------------------------
doRunIntegrationTests(){

	doLog "DEBUG START doRunIntegrationTests @run-integration-tests.func.sh"
   cd $product_instance_dir 

	doLog "INFO re-start the qto app-layer just for sure"
   test -z "${qto_project:-}" && \
      doExit 10 "FATAL ERROR running $action without defined qto project environment vars
      !!! Run : source lib/bash/funcs/parse-cnf-env-vars.sh ; doParseCnfEnvVars
      cnf/qto.dev.host-name.cnf"

   bash src/bash/qto/qto.sh -a mojo-morbo-stop 
   test $? -ne 0 && return

   bash src/bash/qto/qto.sh -a mojo-morbo-start
   test $? -ne 0 && return

   doLog "INFO make a backup of the current db"
   bash src/bash/qto/qto.sh -a backup-postgres-db
	
   doLog "INFO re-create the $env_type db"
   bash src/bash/qto/qto.sh -a run-pgsql-scripts

   last_db_backup_file=$(find  -name $postgres_db_name*.sql | sort -n | tail -n 1)
   PGPASSWORD="${postgres_db_useradmin_pw:-}" psql -v ON_ERROR_STOP=1 -q -t -X -w \
      -h $postgres_db_host -p $postgres_db_port -U "${postgres_db_useradmin:-}" \
      -v postgres_db_name="$postgres_db_name" -f "$last_db_backup_file" -d "$postgres_db_name"
   ret=$?
   #test $ret -ne 0 && doExit 1 "the integration tests failed on db restore .."

   doLog "INFO generating md docs"
   bash src/bash/qto/qto.sh -a generate-md-docs

   test $? -ne 0 && return
   
   doLog "INFO START integration testing - do run all the implemented action tests" 
   perl src/perl/qto/t/TestQto.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 
   
	doLog "DEBUG STOP  doRunIntegrationTests"
}


# eof file: src/bash/qto/funcs/run-integration-tests.func.sh
