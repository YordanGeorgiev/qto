# src/bash/qto/funcs/run-data-load-tests.help.sh

# v1.0.9
# ---------------------------------------------------------
# show the help for this shell action
# ---------------------------------------------------------
doHelpRunDataLoadTests(){

	do_log "DEBUG START doHelpRunDataLoadTests"
	
	cat doc/txt/qto/funcs/run-data-load-tests.func.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

	do_log "DEBUG STOP  doHelpRunDataLoadTests"
}
# eof func doHelpRunDataLoadTests


# eof file: src/bash/qto/funcs/run-data-load-tests.help.sh
