# src/bash/issue-tracker/funcs/run-perl-integration-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/run-perl-integration-tests.func.txt
# ---------------------------------------------------------
doRunPerlIntegrationTests(){

	doLog "DEBUG START doRunPerlIntegrationTests"

   # Action !!!
   doLog "INFO START Unit testing or the CtrlXlsToDb module" 
   perl src/perl/issue_tracker/t/TestCtrlXlsToDb.pl
	echo -e "\n\n\n" 

   doLog "INFO START integration testing - do run all the implemented action tests" 
   perl src/perl/issue_tracker/t/TestIssueTracker.pl
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunPerlIntegrationTests"
}
# eof func doRunPerlIntegrationTests


# eof file: src/bash/issue-tracker/funcs/run-perl-integration-tests.func.sh
