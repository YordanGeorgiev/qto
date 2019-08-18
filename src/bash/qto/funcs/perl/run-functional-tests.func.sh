# src/bash/qto/funcs/run-functional-tests.func.sh

# v0.6.9
# ---------------------------------------------------------
# implement the calls to all the functional tests
# ---------------------------------------------------------
doRunFunctionalTests(){
	
   doLog "DEBUG START : doRunFunctionalTests"
  
   export QTO_ONGOING_TEST=1
   test -z ${qto_project:-} && \
      source "$PRODUCT_INSTANCE_DIR/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$PRODUCT_INSTANCE_DIR/cnf/$run_unit.$env_type.*.cnf"
   
   doLog "INFO START testing controllers"
   while read -r f ; do 
      doLog "INFO START functional test for $f"
      perl $f ;
      doLog "INFO STOP  functional test for $f"
      sleep 1
      clearTheScreen
   done < <(find src/perl/qto/t/lib/Qto/Controller/ -type f |sort)

   export QTO_ONGOING_TEST=0
}


# eof file: src/bash/qto/funcs/run-functional-tests.func.sh
