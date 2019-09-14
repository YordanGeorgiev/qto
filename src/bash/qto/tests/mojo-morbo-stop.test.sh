# src/bash/qto/funcs/mojo-morbo-stop.test.sh

# v0.6.7
# ---------------------------------------------------------
# test the stoping of the mojo morbo server
# ---------------------------------------------------------
doTestMojoMorboStop(){

	sleep "$sleep_interval"
	
   # Action !!!
   bash src/bash/qto/qto.sh -a mojo-morbo-stop
	doLog "check with netstat "
   # sudo visudoers 
   # usrqtoadmin ALL=(ALL) NOPASSWD: /bin/netstat -tulpn
   sudo netstat -tulpn | grep qto

}


# eof file: src/bash/qto/funcs/mojo-morbo-stop.test.sh
