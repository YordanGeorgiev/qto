# src/bash/qto/funcs/mojo-hypnotoad-start.func.sh

# v0.6.5
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/mojo-hypnotoad-start.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStart(){
   
   doLog "DEBUG START doMojoHypnotoadStart"
   doMojoHypnotoadStop

   test -z ${qto_project:-} && \
      source "$product_instance_dir/lib/bash/funcs/parse-cnf-env-vars.sh" && \
      doParseCnfEnvVars "$product_instance_dir/cnf/$run_unit.$env_type.$host_name.cnf"

   export MOJO_LOG_LEVEL='error'
   export MOJO_MODE='production'

   cd src/perl/qto/script
   hypnotoad  qto  &
   cd $product_instance_dir
   doLog "DEBUG STOP  doMojoHypnotoadStart"
}

# eof file: src/bash/qto/funcs/mojo-hypnotoad-start.func.sh
