# src/bash/qto/funcs/mojo-hypnotoad-start.func.sh

doMojoHypnotoadStart(){
   
   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.app'
   doMojoHypnotoadStop

   export MOJO_LOG_LEVEL='error'
   export MOJO_LOG_LEVEL='debug'
   export MOJO_MODE='production'

   while read -r p ; do 
      p=$(echo $p|sed 's/^ *//g')
      test $p -ne $$ && kill -9 $p ; 
   done < <(sudo ps -ef | grep -v grep | grep 'mojo-hypnotoad-start'|awk '{print $2}')

   cd src/perl/qto/script
   hypnotoad qto &
   cd $PRODUCT_INSTANCE_DIR
   set -x
   sudo service nginx restart
   test $? -ne 0 && exit 1
   set +x
}

