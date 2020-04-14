# src/bash/qto/funcs/run-unit-tests.test.sh

# v0.6.9
doTestRunUnitTests(){

	do_log "DEBUG START doTestRununitTests"
	
	sleep "$sleep_interval"
   # Action !!!	
	bash src/bash/qto/qto.sh -a run-unit-tests
	
	do_log "DEBUG STOP  doTestRununitTests"
}


# eof file: src/bash/qto/funcs/run-unit-tests.test.sh
