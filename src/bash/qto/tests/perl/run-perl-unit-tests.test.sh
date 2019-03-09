# src/bash/qto/funcs/run-perl-unit-tests.test.sh

# v1.2.9
# ---------------------------------------------------------
# cat doc/txt/qto/tests/perl/run-perl-unit-tests.test.txt
# ---------------------------------------------------------
doTestRunPerlTests(){

	doLog "DEBUG START doTestRunPerlTests"
	
	sleep "$sleep_interval"
   # Action !!!	
	bash src/bash/qto/qto.sh -a run-perl-unit-tests
	
	doLog "DEBUG STOP  doTestRunPerlTests"
}
# eof func doTestRunPerlTests


# eof file: src/bash/qto/funcs/run-perl-unit-tests.test.sh
