# src/bash/issue-tracker/funcs/run-perl-integration-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/run-perl-integration-tests.func.txt
# ---------------------------------------------------------
doRunPerlIntegrationTests(){

	doLog "DEBUG START doRunPerlIntegrationTests"
   
   doLog "INFO START test the Select Controller "
   doLog " <<app-db>>/Select-tables"
   doLog " <<app-db>>/Select/<<table-name>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelect.pl
	echo -e "\n\n\n" 
   
   doLog "INFO START test the Select Controller filtering: "
   doLog "INFO S: <<app-db>>/Select/<<table-name>>?fltr-by=<<attribute>>&fltr-val=<<value>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectFilter.pl
	echo -e "\n\n\n" 
   
   doLog "INFO START test the Select Controller filtering with the like operator: "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectLike.pl
	echo -e "\n\n\n" 
   
   doLog "INFO START test the Select Controller filtering with the like operator: "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectPick.pl
	echo -e "\n\n\n" 
   
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
