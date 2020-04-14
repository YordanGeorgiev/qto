# src/bash/qto/funcs/mojo-morbo-start.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestMojoMorboStart comments ...
# cat doc/txt/qto/tests/mojo-morbo-start.test.txt
# ---------------------------------------------------------
doTestMojoMorboStart(){

	do_log "INFO START doTestMojoMorboStart"
	
	sleep "$sleep_interval"
	
   # Action !!!
   bash src/bash/qto/qto.sh -a mojo-morbo-start

   # sudo visudoers 
   # ysg ALL=(ALL) NOPASSWD: /bin/netstat -tulpn
   netstat -tulpn | grep qto
	do_log "INFO STOP  doTestMojoMorboStart"
}
# eof func doTestMojoMorboStart


# eof file: src/bash/qto/funcs/mojo-morbo-start.test.sh
