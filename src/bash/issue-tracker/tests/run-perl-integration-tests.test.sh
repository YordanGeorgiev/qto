# src/bash/issue-tracker/funcs/run-perl-integration-tests.test.sh

# v1.3.0
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/run-perl-integration-tests.test.txt
# ---------------------------------------------------------
doTestRunPerlIntegrationTests(){

	doLog "DEBUG START doTestRunPerlIntegrationTests"
	
	# Action !!!
   bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-unit-tests

	doLog "DEBUG STOP  doTestRunPerlIntegrationTests"
}
# eof func doTestRunPerlIntegrationTests


# eof file: src/bash/issue-tracker/funcs/run-perl-integration-tests.test.sh
