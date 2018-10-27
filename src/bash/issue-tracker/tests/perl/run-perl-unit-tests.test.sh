# src/bash/issue-tracker/funcs/run-perl-unit-tests.test.sh

# v1.2.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/perl/run-perl-unit-tests.test.txt
# ---------------------------------------------------------
doTestRunPerlTests(){

	doLog "DEBUG START doTestRunPerlTests"
	
	sleep "$sleep_interval"
   # Action !!!	
	bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-unit-tests
	
	doLog "DEBUG STOP  doTestRunPerlTests"
}
# eof func doTestRunPerlTests


# eof file: src/bash/issue-tracker/funcs/run-perl-unit-tests.test.sh
