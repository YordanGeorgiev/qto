# src/bash/qto/funcs/run-integration-tests.test.sh

# v1.3.0
doTestRunIntegrationTests(){

	doLog "DEBUG START doTestRunIntegrationTests"
	
	# Action !!!
   bash src/bash/qto/qto.sh -a run-perl-unit-tests

	doLog "DEBUG STOP  doTestRunIntegrationTests"
}
# eof func doTestRunIntegrationTests


# eof file: src/bash/qto/funcs/run-integration-tests.test.sh
