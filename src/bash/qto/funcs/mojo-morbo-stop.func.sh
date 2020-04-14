# file: src/bash/qto/funcs/mojo-morbo-stop.func.sh

# ---------------------------------------------------------
# stop any running morbo instances listenning on the wanted port
# cat doc/txt/qto/funcs/mojo-morbo-stop.func.txt
# ---------------------------------------------------------
doMojoMorboStop(){
   do_export_json_section_vars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.app'
   test -z "${mojo_morbo_port:-}" && export mojo_morbo_port=3001
   found=0

   while read -r listening_on_port_pid; do 
      while read -r pid; do 
         test $listening_on_port_pid -eq $pid && sudo kill -9 $pid
      done < <(sudo ps -ef| grep -i qto.$VERSION.$ENV_TYPE| grep -v grep|awk '{print $2}')
   done < <(lsof -i:${mojo_morbo_port:-} -t)
   
   echo start running ps -ef \| grep qto
   ps -ef | grep -i qto
   echo stop  running ps -ef \| grep qto
   echo -e "\n"
}
