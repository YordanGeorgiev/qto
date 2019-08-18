# src/bash/qto/funcs/mojo-hypnotoad-start.func.sh

# v0.6.9
# ---------------------------------------------------------
# start the hypnotoad server with preloaded vars
# ---------------------------------------------------------
doMojoHypnotoadStart(){
   
   doLog "DEBUG START doMojoHypnotoadStart"
   doMojoHypnotoadStop

   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.db'

   export MOJO_LOG_LEVEL='error'
   export MOJO_MODE='production'

   cd src/perl/qto/script
   hypnotoad  qto  &
   cd $PRODUCT_INSTANCE_DIR
   doLog "DEBUG STOP  doMojoHypnotoadStart"
}

# eof file: src/bash/qto/funcs/mojo-hypnotoad-start.func.sh
