# src/bash/qto/funcs/run-unit-tests.func.sh

# v0.6.9
# ---------------------------------------------------------
# implement the calls to all the unit tests
# ---------------------------------------------------------
doRunUnitTests(){
  
   export QTO_ONGOING_TEST=1
   test -z ${qto_project:-} && \
      source "$PRODUCT_INSTANCE_DIR/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.*.cnf"
   
   doLog "INFO START unit tests"
   while read -r f ; do 
      doLog "INFO START unit test for $f"
      perl $f ;
      doLog "INFO STOP  unit test for $f"
      sleep 1
      clearTheScreen
   done < <(find src/perl/qto/t/lib/Qto/App -name '*.t' -type f |grep -v benchmarks |sort)

   export QTO_ONGOING_TEST=0
}


# eof file: src/bash/qto/funcs/run-unit-tests.func.sh
