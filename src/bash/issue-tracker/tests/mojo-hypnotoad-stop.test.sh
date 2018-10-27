# src/bash/issue-tracker/funcs/mojo-hypnotoad-stop.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestMojoHypnotoadStop comments ...
# ---------------------------------------------------------
doTestMojoHypnotoadStop(){

	doLog "DEBUG START doTestMojoHypnotoadStop"
	
	# cat doc/txt/issue-tracker/tests/mojo-hypnotoad-stop.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-hypnotoad-stop
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestMojoHypnotoadStop"
}
# eof func doTestMojoHypnotoadStop


# eof file: src/bash/issue-tracker/funcs/mojo-hypnotoad-stop.test.sh
