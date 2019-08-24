# src/bash/qto/funcs/run-functional-tests.func.sh

# v0.6.9
# ---------------------------------------------------------
# implement the calls to all the functional tests
# ---------------------------------------------------------
doRunFunctionalTests(){
	
   doLog "DEBUG START : doRunFunctionalTests"
  
   export QTO_ONGOING_TEST=1
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.db'
   
   doLog "INFO START testing controllers"
   while read -r f ; do 
      doLog "INFO START functional test for $f"
      perl $f ;
      test $? -ne 0 && doExit $? " the tests in the $f failed !!!"
      doLog "INFO STOP  functional test for $f"
      sleep 1
      clearTheScreen
   done < <(find src/perl/qto/t/lib/Qto/Controller/ -type f |sort)

   export QTO_ONGOING_TEST=0
}


# eof file: src/bash/qto/funcs/run-functional-tests.func.sh
