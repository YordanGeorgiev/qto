# file: src/bash/qto/funcs/mojo-hypnotoad-stop.func.sh
#
# ---------------------------------------------------------
# cat doc/txt/qto/funcs/mojo-hypnotoad-stop.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStop(){

   do_export_json_section_vars $product_instance_dir/cnf/env/$env_type.env.json '.env.app'
   test -z "${mojo_hypnotoad_port:-}" && export mojo_hypnotoad_port=8080

   # try nicely first to stop the hypnotoad worker processes
   while read -r child_of_1_pid; do 
      echo the child_of_1_pid : $child_of_1_pid
      while read -r listening_on_port_pid; do 
         echo and the listening_on_port_pid: $listening_on_port_pid
         while read -r pid_to_stop; do 
            echo trying first to stop gracefully the following pid_to_sop  $pid_to_stop; 
            sudo kill -3 $pid_to_stop # try nicely first 
         done < <(ps -ef | grep $child_of_1_pid|grep $RUN_UNIT |grep -v grep|awk '{print $2}'); 
       done < <(lsof -i:${mojo_hypnotoad_port:-} -t|grep $child_of_1_pid)
   done < <(pgrep -P 1)
   
  # no more nice guy .. - kill those which did not stop ...
   while read -r child_of_1_pid; do 
      while read -r listening_on_port_pid; do 
         while read -r pid_to_kill; do 
            echo trying then to kill the following pid_to_kill $pid_to_kill; 
            sudo kill -9 $pid_to_kill # try forcefully then ...
         done < <(ps -ef | grep $child_of_1_pid|grep $RUN_UNIT |grep -v grep|awk '{print $2}'); 
       done < <(lsof -i:${mojo_hypnotoad_port:-} -t|grep $child_of_1_pid)
   done < <(pgrep -P 1)

   sudo service nginx stop
}

