# src/bash/qto/funcs/mojo-daemon-stop.func.sh

# ---------------------------------------------------------
# stop any running daemon instances listenning on the wanted port
# cat doc/txt/qto/funcs/mojo-daemon-stop.func.txt
# ---------------------------------------------------------
doMojoDaemonStop(){
   should_exit=${1:-}
   test -z "${should_exit:-}" && should_exit=1
   test -z "${mojo_daemon_port:-}" && export mojo_daemon_port=3001
   found=0

	doLog "DEBUG START doMojoDaemonStop"
   echo -e "\n"

      while read -r listening_on_port_pid; do 
         while read -r pid_to_kill; do 
            echo killing the following pid_to_kill  $pid_to_kill; 
            test $listening_on_port_pid -eq $pid_to_kill && sudo kill -9 $pid_to_kill
            found=1
         done < <(ps -ef|grep 'qto.'|grep $env_type.$product_owner|grep -v 'docker-entry-point'|grep -v grep|awk '{print $2}'); 
      done < <(lsof -i:${mojo_daemon_port:-} -t)
   
   not_found_msg="daemon is NOT running for the mojo_daemon_port: "${mojo_daemon_port:-}" of this product instance"
   if [ "${should_exit:-}" -eq 1 ]; then
      test $found -eq 0 && doExit 1 $not_found_msg
   else 
      test $found -eq 0 && doLog INFO $not_found_msg
   fi
   
   echo -e "\n"
   doLog "DEBUG STOP  doMojoDaemonStop"
}

# eof file: src/bash/qto/funcs/mojo-daemon-stop.func.sh
