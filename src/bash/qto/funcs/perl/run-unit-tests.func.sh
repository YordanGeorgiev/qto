# file: src/bash/qto/funcs/run-unit-tests.func.sh

# v0.7.8
# ---------------------------------------------------------
# call all the unit tests - fail if even one fails ...
# ---------------------------------------------------------
doRunUnitTests(){
  
   export QTO_NO_AUTH=1
   test -z "${proj_instance_dir-}" && proj_instance_dir="$product_instance_dir"
   source $proj_instance_dir/.env ; env_type=$ENV_TYPE
   do_export_json_section_vars $proj_instance_dir/cnf/env/$env_type.env.json '.env.db'
   do_export_json_section_vars $proj_instance_dir/cnf/env/$env_type.env.json '.env.app'
   
   do_log "INFO START running the unit tests"
   while read -r f ; do 
      do_log "INFO START unit test for $f"
      perl $f
      test $? -ne 0 && do_exit $? " the tests in the $f failed !!!"
      do_log "INFO STOP  unit test for $f"
      sleep 1
      do_flush_screen
   done < <(find src/perl/qto/t/lib/Qto/App -name '*.t' -type f |grep -v benchmarks |sort)

   export QTO_NO_AUTH=0
}

