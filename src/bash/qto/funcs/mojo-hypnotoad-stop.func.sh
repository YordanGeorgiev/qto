# 
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/mojo-hypnotoad-stop.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStop(){

   doExportJsonSectionVars $PRODUCT_INSTANCE_DIR/cnf/env/$env_type.env.json '.env.db'
   test -z "${mojo_hypnotoad_port:-}" && export mojo_hypnotoad_port=8080

   while read -r child_of_1_pid; do 
      echo from the child_of_1_pid : $child_of_1_pid
      
      while read -r listening_on_port_pid; do 
         echo and the listening_on_port_pid: $listening_on_port_pid
         
         while read -r pid_to_kill; do 
            echo killing the following pid_to_kill  $pid_to_kill; 
            sudo kill -9 $pid_to_kill

         done < <(ps -ef | grep $child_of_1_pid|grep $RUN_UNIT |grep -v grep|awk '{print $2}'); 
      done < <(lsof -i:${mojo_hypnotoad_port:-} -t|grep $child_of_1_pid)
   done < <(pgrep -P 1)

}

