# src/bash/qto/funcs/run-benchmarks.func.sh

# v0.6.8
# ---------------------------------------------------------
# implement the calls to all the functional tests
# ---------------------------------------------------------
doRunBenchmarks(){
  
   export QTO_ONGOING_TEST=1
   test -z ${qto_project:-} && \
      source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$product_instance_dir/cnf/$run_unit.$env_type.*.cnf"
   
   doLog "INFO START testing controllers"
   while read -r f ; do 
      doLog "INFO START functional test for $f"
      perl $f ;
      doLog "INFO STOP  functional test for $f"
      clearTheScreen
   done < <(find src/perl/qto/t/lib/Qto/App/benchmarks -type f -name '*.pl'|sort)

   export QTO_ONGOING_TEST=0
}


# eof file: src/bash/qto/funcs/run-benchmarks.func.sh
