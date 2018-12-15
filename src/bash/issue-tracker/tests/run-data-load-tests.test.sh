# src/bash/issue-tracker/funcs/run-data-load-tests.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestRunDataLoadTests comments ...
# ---------------------------------------------------------
doTestRunDataLoadTests(){
	doLog "DEBUG START doTestRunDataLoadTests"
	
	
	sleep "$sleep_interval"
	# Action !!!
   clear ; bash src/bash/issue-tracker/issue-tracker.sh -a run-data-load-tests

	doLog "DEBUG STOP  doTestRunDataLoadTests"
}
# eof func doTestRunDataLoadTests


# eof file: src/bash/issue-tracker/funcs/run-data-load-tests.test.sh
