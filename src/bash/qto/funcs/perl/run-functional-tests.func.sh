# src/bash/qto/funcs/run-functional-tests.func.sh

# ---------------------------------------------------------
# implement the calls to all the functional tests
# ---------------------------------------------------------
doRunFunctionalTests(){
	
   export QTO_NO_AUTH=1
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.db'
   
   do_log "INFO START testing controllers"
   while read -r f ; do 
      do_log "INFO START functional test for $f"
      perl $f ;
      test $? -ne 0 && do_exit $? " the tests in the $f failed !!!"
      do_log "INFO STOP  functional test for $f"
      sleep 1
      clearTheScreen
   done < <(find src/perl/qto/t/lib/Qto/Controller -type f -name '*.t' |sort)

   export QTO_NO_AUTH=0
}
