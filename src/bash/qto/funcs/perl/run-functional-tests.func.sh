# src/bash/qto/funcs/run-functional-tests.func.sh

# ---------------------------------------------------------
# implement the calls to all the functional tests
# ---------------------------------------------------------
doRunFunctionalTests(){

   export QTO_NO_AUTH=1
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   #
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.db'

   do_log "INFO START testing controllers"
   while read -r f ; do
      do_log "INFO START functional test for $f"
      perl $f ;
      test $? -ne 0 && do_exit $? " the tests in the $f failed !!!"
      do_log "INFO STOP  functional test for $f"
      sleep 1
      do_flush_screen
   done < <(find src/perl/qto/t/lib/Qto/Controller -type f -name '*.t' |sort)

   export QTO_NO_AUTH=0
}
