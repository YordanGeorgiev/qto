# src/bash/qto/funcs/run-data-load-tests.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestRunDataLoadTests comments ...
# ---------------------------------------------------------
doTestRunDataLoadTests(){
	do_log "DEBUG START doTestRunDataLoadTests"
	
	
	sleep "$sleep_interval"
	# Action !!!
   clear ; bash src/bash/qto/qto.sh -a run-data-load-tests

	do_log "DEBUG STOP  doTestRunDataLoadTests"
}
# eof func doTestRunDataLoadTests


# eof file: src/bash/qto/funcs/run-data-load-tests.test.sh
