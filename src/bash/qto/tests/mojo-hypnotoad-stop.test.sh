# src/bash/qto/funcs/mojo-hypnotoad-stop.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestMojoHypnotoadStop comments ...
# ---------------------------------------------------------
doTestMojoHypnotoadStop(){

	doLog "DEBUG START doTestMojoHypnotoadStop"
	
	# cat doc/txt/qto/tests/mojo-hypnotoad-stop.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/qto/qto.sh -a mojo-hypnotoad-stop
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestMojoHypnotoadStop"
}
# eof func doTestMojoHypnotoadStop


# eof file: src/bash/qto/funcs/mojo-hypnotoad-stop.test.sh
