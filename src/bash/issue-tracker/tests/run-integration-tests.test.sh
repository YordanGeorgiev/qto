# src/bash/issue-tracker/funcs/run-integration-tests.test.sh

# v1.3.0
doTestRunIntegrationTests(){

	doLog "DEBUG START doTestRunIntegrationTests"
	
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-unit-tests

	doLog "DEBUG STOP  doTestRunIntegrationTests"
}
# eof func doTestRunIntegrationTests


# eof file: src/bash/issue-tracker/funcs/run-integration-tests.test.sh
