# file: src/bash/qto/funcs/run-unit-tests.func.sh

# v0.7.8
# ---------------------------------------------------------
# call all the unit tests - fail if even one fails ...
# ---------------------------------------------------------
doRunUnitTests(){
  
   export QTO_NO_AUTH=1
   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_INSTANCE_DIR"
   source $PROJ_INSTANCE_DIR/.env ; env_type=$ENV_TYPE
   doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.db'
   doExportJsonSectionVars $PROJ_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.app'
   
   doLog "INFO START running the unit tests"
   while read -r f ; do 
      doLog "INFO START unit test for $f"
      perl $f
      test $? -ne 0 && doExit $? " the tests in the $f failed !!!"
      doLog "INFO STOP  unit test for $f"
      sleep 1
      clearTheScreen
   done < <(find src/perl/qto/t/lib/Qto/App -name '*.t' -type f |grep -v benchmarks |sort)

   export QTO_NO_AUTH=0
}

