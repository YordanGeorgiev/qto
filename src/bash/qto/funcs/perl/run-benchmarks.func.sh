# src/bash/qto/funcs/run-benchmarks.func.sh

# v0.6.8
# ---------------------------------------------------------
# implement the calls to all the functional tests
# ---------------------------------------------------------
doRunBenchmarks(){
  
   export QTO_NO_AUTH=1
   test -z ${qto_project:-} && \
      source "$PRODUCT_INSTANCE_DIR/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$PRODUCT_INSTANCE_DIR/cnf/$RUN_UNIT.$env_type.*.cnf"
   
   do_log "INFO START testing controllers"
   while read -r f ; do 
      do_log "INFO START functional test for $f"
      perl $f ;
      do_log "INFO STOP  functional test for $f"
      clearTheScreen
   done < <(find src/perl/qto/t/lib/Qto/App/benchmarks -type f -name '*.pl'|sort)

   export QTO_NO_AUTH=0
}


