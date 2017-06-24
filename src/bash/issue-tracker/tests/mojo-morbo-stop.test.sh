# src/bash/issue-tracker/funcs/mojo-morbo-stop.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestMojoMorboStop comments ...
# ---------------------------------------------------------
doTestMojoMorboStop(){

	doLog "DEBUG START doTestMojoMorboStop"
	
	cat doc/txt/issue-tracker/tests/mojo-morbo-stop.test.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop

	doLog "DEBUG STOP  doTestMojoMorboStop"
}
# eof func doTestMojoMorboStop


# eof file: src/bash/issue-tracker/funcs/mojo-morbo-stop.test.sh
