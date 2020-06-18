doMojoHypnotoadStart(){
   
   do_export_json_section_vars $product_instance_dir/cnf/env/$ENV_TYPE.env.json '.env.app'
   doMojoHypnotoadStop

   export MOJO_LOG_LEVEL='error'; #could be warn, debug, info
   export MOJO_MODE='production'; #could be development as well ...

   while read -r p ; do 
      p=$(echo $p|sed 's/^ *//g')
      test $p -ne $$ && kill -9 $p ; 
   done < <(sudo ps -ef | grep -v grep | grep 'mojo-hypnotoad-start'|awk '{print $2}')

   cd $product_instance_dir/src/perl/qto/script

   hypnotoad qto &
   cd $product_instance_dir
   sudo service nginx restart
   test $? -ne 0 && exit 1
   sudo ps -ef | grep -v grep | grep qto
}

