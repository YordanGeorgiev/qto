# src/bash/qto/funcs/run-integration-tests.test.sh

# v1.3.0
doTestRunIntegrationTests(){

	do_log "DEBUG START doTestRunIntegrationTests"
	
	# Action !!!
   bash src/bash/qto/qto.sh -a run-integration-tests

	do_log "DEBUG STOP  doTestRunIntegrationTests"
}
# eof func doTestRunIntegrationTests


# eof file: src/bash/qto/funcs/run-integration-tests.test.sh
