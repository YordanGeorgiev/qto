doMojoHypnotoadStart(){
   
   do_export_json_section_vars $PRODUCT_DIR/cnf/env/$ENV.env.json '.env.app'
   doMojoHypnotoadStop

   export MOJO_LOG_LEVEL='error'; #could be warn, debug, info
   export MOJO_MODE='production'; #could be development as well ...

   while read -r p ; do 
      p=$(echo $p|sed 's/^ *//g')
      test $p -ne $$ && kill -9 $p ; 
   done < <(sudo ps -ef | grep -v grep | grep 'mojo-hypnotoad-start'|awk '{print $2}')

   cd $PRODUCT_DIR/src/perl/qto/script

   hypnotoad qto &
   cd $PRODUCT_DIR
   sudo service nginx restart
   test $? -ne 0 && exit 1
   sudo ps -ef | grep -v grep | grep qto
}

