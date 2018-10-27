# src/bash/issue-tracker/funcs/mojo-morbo-stop.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/mojo-morbo-stop.test.txt
# ---------------------------------------------------------
doTestMojoMorboStop(){

	doLog "DEBUG START doTestMojoMorboStop"
	
	
	sleep "$sleep_interval"
	
   # Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop
	doLog "check with netstat "
   # sudo visudoers 
   # ysg ALL=(ALL) NOPASSWD: /bin/netstat -tulpn
   netstat -tulpn | grep issue_tracker

	doLog "DEBUG STOP  doTestMojoMorboStop"
}
# eof func doTestMojoMorboStop


# eof file: src/bash/issue-tracker/funcs/mojo-morbo-stop.test.sh
