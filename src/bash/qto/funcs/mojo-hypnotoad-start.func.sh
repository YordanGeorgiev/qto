doMojoHypnotoadStart(){
   
   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$ENV_TYPE.env.json '.env.app'
   doMojoHypnotoadStop


   export MOJO_LOG_LEVEL='error'; #could be warn, debug, info
   export MOJO_MODE='production'; #could be development as well ...
   export QTO_JWT_AUTH='0'; 

   while read -r p ; do 
      p=$(echo $p|sed 's/^ *//g')
      test $p -ne $$ && kill -9 $p ; 
   done < <(sudo ps -ef | grep -v grep | grep 'mojo-hypnotoad-start'|awk '{print $2}')

   cd src/perl/qto/script

   echo QTO_JWT_AUTH: $QTO_JWT_AUTH #temporary for v0.8.2
   sleep 1
   hypnotoad qto &
   cd $PRODUCT_INSTANCE_DIR
   sudo service nginx restart
   test $? -ne 0 && exit 1
   sudo ps -ef | grep -v grep | grep qto
}

