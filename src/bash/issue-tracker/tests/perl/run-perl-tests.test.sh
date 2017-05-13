# src/bash/issue-tracker/funcs/run-perl-tests.test.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doTestRunPerlTests comments ...
# ---------------------------------------------------------
doTestRunPerlTests(){

	doLog "DEBUG START doTestRunPerlTests"
	
	cat doc/txt/issue-tracker/tests/perl/run-perl-tests.test.txt
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	
	bash src/bash/issue-tracker/issue-tracker.sh -a run-perl-tests
	
	doLog "DEBUG STOP  doTestRunPerlTests"
}
# eof func doTestRunPerlTests


# eof file: src/bash/issue-tracker/funcs/run-perl-tests.test.sh
