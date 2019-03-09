# src/bash/qto/funcs/mojo-hypnotoad-start.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestMojoHypnotoadStart comments ...
# ---------------------------------------------------------
doTestMojoHypnotoadStart(){

	doLog "DEBUG START doTestMojoHypnotoadStart"
	
	# cat doc/txt/qto/tests/mojo-hypnotoad-start.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/qto/qto.sh -a mojo-hypnotoad-start
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestMojoHypnotoadStart"
}
# eof func doTestMojoHypnotoadStart


# eof file: src/bash/qto/funcs/mojo-hypnotoad-start.test.sh
