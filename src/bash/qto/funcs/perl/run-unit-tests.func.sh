# file: src/bash/qto/funcs/run-unit-tests.func.sh

# v0.7.8
# ---------------------------------------------------------
# call all the unit tests - fail if even one fails ...
# ---------------------------------------------------------
do_run_unit_tests(){

   export QTO_NO_AUTH=1
     export PATH=$PATH:~/perl5/bin/
  export PERL5LIB=${PERL5LIB:-}:~/perl5/lib/perl5/:$PRODUCT_DIR/src/perl/qto/t/lib:$PRODUCT_DIR/src/perl/qto/public/lib:$PRODUCT_DIR/src/perl/qto/lib

   test -z "${PROJ_INSTANCE_DIR-}" && PROJ_INSTANCE_DIR="$PRODUCT_DIR"
   #
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.db'
   do_export_json_section_vars $PROJ_INSTANCE_DIR/cnf/env/$ENV.env.json '.env.app'

   do_log "INFO START running the unit tests"
   while read -r f ; do
      do_log "INFO START unit test for $f"

      perl -MCarp::Always \
        -I $PRODUCT_DIR/src/perl/qto/t/lib/Qto/App -I $PRODUCT_DIR/src/perl/qto/t/lib/Qto/App/lib $f
      test $? -ne 0 && do_exit $? " the tests in the $f failed !!!"
      do_log "INFO STOP  unit test for $f"
      sleep 1
      do_flush_screen
   done < <(find src/perl/qto/t/lib/Qto/App -name '*.t' -type f |grep -v benchmarks |sort)

   export QTO_NO_AUTH=0
}

