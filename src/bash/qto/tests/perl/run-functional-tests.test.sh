# src/bash/qto/funcs/run-functional-tests.test.sh

# v1.2.9
# ---------------------------------------------------------
# cat doc/txt/qto/tests/perl/run-functional-tests.test.txt
# ---------------------------------------------------------
doTestRunFunctionalTests(){

	doLog "DEBUG START doTestRunFunctionalTests"
	
	sleep "$sleep_interval"
   # Action !!!	
	bash src/bash/qto/qto.sh -a run-functional-tests
	
	doLog "DEBUG STOP  doTestRunFunctionalTests"
}
# eof func doTestRunFunctionalTests


# eof file: src/bash/qto/funcs/run-functional-tests.test.sh
