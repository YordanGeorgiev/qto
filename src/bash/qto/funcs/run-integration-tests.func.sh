#!/bin/bash
# src/bash/qto/funcs/run-integration-tests.func.sh

doRunIntegrationTests(){
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   #
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.db'
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.app'

   bash src/bash/qto/qto.sh -a mojo-morbo-stop
   bash src/bash/qto/qto.sh -a mojo-morbo-start
   #test $? -ne 0 && return

   do_log "INFO make a backup of the current db - inserts only "
   bash src/bash/qto/qto.sh -a backup-postgres-db-inserts

   do_log "INFO re-create the $ENV db"
   bash src/bash/qto/qto.sh -a run-pgsql-scripts

   last_db_backup_file=$(find $PROJ_INSTANCE_DIR/dat/mix -name $postgres_app_db*insrts.dmp.sql | sort -n | tail -n 1)
   PGPASSWORD="${postgres_sys_usr_admin_pw:-}" psql -v ON_ERROR_STOP=1 -q -t -X -w \
      -h $postgres_rdbms_host -p $postgres_rdbms_port -U "${postgres_sys_usr_admin:-}" \
      -v postgres_app_db="$postgres_app_db" -f "$last_db_backup_file" -d "$postgres_app_db"
   ret=$? ; test $ret -ne 0 && do_exit 1 "the integration tests failed on db restore .."

   do_log "INFO generating md docs"
   bash src/bash/qto/qto.sh -a generate-md-docs
   test $? -ne 0 && return

   do_log "INFO START integration testing - do run all the implemented action tests"
   perl src/perl/qto/t/TestQto.pl
   test $? -ne 0 && return
	echo -e "\n\n\n"

}

# eof file: src/bash/qto/funcs/run-integration-tests.func.sh
