# src/bash/qto/funcs/mojo-hypnotoad-start.func.sh

doMojoHypnotoadStart(){
   
   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.app'
   doMojoHypnotoadStop

   export MOJO_LOG_LEVEL='error'
   export MOJO_LOG_LEVEL='debug'
   export MOJO_MODE='production'

   cd src/perl/qto/script
   hypnotoad qto &
   cd $PRODUCT_INSTANCE_DIR
}

