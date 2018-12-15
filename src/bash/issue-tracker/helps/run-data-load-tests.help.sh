# src/bash/issue-tracker/funcs/run-data-load-tests.help.sh

# v1.0.9
# ---------------------------------------------------------
# show the help for this shell action
# ---------------------------------------------------------
doHelpRunDataLoadTests(){

	doLog "DEBUG START doHelpRunDataLoadTests"
	
	cat doc/txt/issue-tracker/funcs/run-data-load-tests.func.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	doLog "DEBUG STOP  doHelpRunDataLoadTests"
}
# eof func doHelpRunDataLoadTests


# eof file: src/bash/issue-tracker/funcs/run-data-load-tests.help.sh
