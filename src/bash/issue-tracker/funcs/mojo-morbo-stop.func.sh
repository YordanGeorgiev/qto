# src/bash/issue-tracker/funcs/mojo-morbo-stop.func.sh

# v1.0.0
# ---------------------------------------------------------
# stop any running morbo
# ---------------------------------------------------------
doMojoMorboStop(){

	doLog "DEBUG START doMojoMorboStop"
	
	#cat doc/txt/issue-tracker/funcs/mojo-morbo-stop.func.txt
	
	sleep "$sleep_interval"

	# Action !!!
	while read -r l; do
      # grap the process
      p=$(echo $l| cut -d" " -f2); 
      doLog "INFO sending SIGTERM to pid: $p in:"
      doLog "INFO $l:"
      kill -15 $p ; 
   done < <(ps -ef| grep -i 'issue_tracker' | grep -v 'grep')

   doLog "DEBUG STOP  doMojoMorboStop"
}
# eof func doMojoMorboStop


# eof file: src/bash/issue-tracker/funcs/mojo-morbo-stop.func.sh
