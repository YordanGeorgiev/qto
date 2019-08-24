# src/bash/qto/funcs/mojo-morbo-stop.func.sh

# ---------------------------------------------------------
# stop any running morbo instances listenning on the wanted port
# cat doc/txt/qto/funcs/mojo-morbo-stop.func.txt
# ---------------------------------------------------------
doMojoMorboStop(){
   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.db'
   should_exit=${1:-}
   test -z "${should_exit:-}" && should_exit=1
   test -z "${mojo_morbo_port:-}" && export mojo_morbo_port=3001
   found=0

	doLog "DEBUG START doMojoMorboStop"
   echo -e "\n"

      while read -r listening_on_port_pid; do 
         while read -r pid_to_kill; do 
            echo killing the following pid_to_kill  $pid_to_kill; 
            test $listening_on_port_pid -eq $pid_to_kill && sudo kill -9 $pid_to_kill
            found=1
         done < <(ps -ef|grep 'qto.'|grep $env_type.$product_owner|grep -v 'docker-entry-point'|grep -v grep|awk '{print $2}'); 
      done < <(lsof -i:${mojo_morbo_port:-} -t)
   
   not_found_msg="morbo is NOT running for the mojo_morbo_port: "${mojo_morbo_port:-}" of this product instance"
   if [ "${should_exit:-}" -eq 1 ]; then
      test $found -eq 0 && doExit 1 $not_found_msg
   else 
      test $found -eq 0 && doLog INFO $not_found_msg
   fi
   
   echo -e "\n"
   doLog "DEBUG STOP  doMojoMorboStop"
}
# eof func doMojoMorboStop

# eof file: src/bash/qto/funcs/mojo-morbo-stop.func.sh
