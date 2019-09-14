# src/bash/qto/funcs/run-unit-tests.test.sh

# v0.6.9
doTestRunUnitTests(){

	doLog "DEBUG START doTestRununitTests"
	
	sleep "$sleep_interval"
   # Action !!!	
	bash src/bash/qto/qto.sh -a run-unit-tests
	
	doLog "DEBUG STOP  doTestRununitTests"
}


# eof file: src/bash/qto/funcs/run-unit-tests.test.sh
