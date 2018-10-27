# src/bash/issue-tracker/funcs/mojo-hypnotoad-stop.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/mojo-hypnotoad-stop.func.txt
# ---------------------------------------------------------
doMojoHypnotoadStop(){

   should_exit=${1:-}
   test -z "${should_exit:-}" && should_exit=1
   test -z "${mojo_hypnotoad_port:-}" && export mojo_hypnotoad_port=8080
   found=0

	doLog "INFO mojo_hypnotoad_port: $mojo_hypnotoad_port"
	doLog "DEBUG START doMojoHypnotoadStop"
	
   while read -r child_of_1_pid; do 
      while read -r listening_on_port_pid; do 
         while read -r pid_to_kill; do 
            echo killing the following pid_to_kill  $pid_to_kill; 
            kill -9 $pid_to_kill
            found=1
         done < <(ps -ef | grep $child_of_1_pid|grep issue_tracker|grep -v grep|awk '{print $2}'); 
      echo listening_on_port_pid: $listening_on_port_pid
      done < <(lsof -i:${mojo_hypnotoad_port:-} -t|grep $child_of_1_pid)
   echo child_of_1_pid : $child_of_1_pid
   done < <(pgrep -P 1); 

	doLog "DEBUG STOP  doMojoHypnotoadStop"
}
# eof func doMojoHypnotoadStop


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-stop.func.sh
