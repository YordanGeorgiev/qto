# src/bash/issue-tracker/funcs/run-perl-integration-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/run-perl-integration-tests.func.txt
# ---------------------------------------------------------
doRunPerlIntegrationTests(){

	doLog "DEBUG START doRunPerlIntegrationTests"

	doLog "INFO re-start the issue-tracker app-layer just for sure"
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop 
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start

	doLog "INFO re-create the documentation db"
   bash src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts


	doLog "INFO load the documentation db run xls-to-db to mysql"
   export tables=Tests,ItemController,ItemModel,ItemView,ExportFile,UserStory,Requirement,DevOps,Feature,ReadMe,Image,SystemGuide;
   export do_truncate_tables=1 ; export rdbms_type=mysql ; export load_model=nested-set
   perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables

   doc_pub_instances_running=$(ps -ef | grep -i doc_pub | wc -l)
   if [ $doc_pub_instances_running -gt 0 ]; then
      doLog "INFO generate the pdf and the mysql documentation"
      bash src/bash/issue-tracker/issue-tracker.sh -a generate-docs
   fi

   doLog "INFO laod the postgres data"
   export tables=daily_issues,weekly_issues,monthly_issues,yearly_issues;export do_truncate_tables=1 
   export rdbms_type=postgres ; export load_model=upsert ; 
   perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables

   doLog "INFO START test the Select Controller "
   doLog " <<app-db>>/Select-tables"
   doLog " <<app-db>>/Select/<<table-name>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelect.pl
	echo -e "\n\n\n" 
  
   doLog "INFO START test the Select Controller filtering with the like operator: "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectPick.pl
	echo -e "\n\n\n" 

   doLog "INFO START test the Select Controller with the o=<<order-by>> url param"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectOrder.pl
	echo -e "\n\n\n" 

   doLog "INFO START test the Select Controller filtering with the like operator: "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectLike.pl
	echo -e "\n\n\n" 


   doLog "INFO S: <<app-db>>/Select/<<table-name>>?fltr-by=<<attribute>>&fltr-val=<<value>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectFilter.pl
	echo -e "\n\n\n" 

   doLog "INFO START test the Select Controller filtering: "
   
   
   doLog "INFO START test the List Controller "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestList.pl
	echo -e "\n\n\n" 
   
   doLog "INFO START test the List Controller with the hide url param"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestListHide.pl
	echo -e "\n\n\n" 
   
   # Action !!!
   doLog "INFO START Unit testing or the CtrlXlsToDb module" 
   perl src/perl/issue_tracker/t/TestCtrlXlsToDb.pl
	echo -e "\n\n\n" 

   doLog "INFO START integration testing - do run all the implemented action tests" 
   perl src/perl/issue_tracker/t/TestIssueTracker.pl
	echo -e "\n\n\n" 

   doLog "INFO START client side testing"
   perl -I src/perl/issue_tracker/lib/ \
   src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestListOnClient.pl
	echo -e "\n\n\n" 

   doLog "INFO START select with operator testing"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectWith.pl
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunPerlIntegrationTests"
}
# eof func doRunPerlIntegrationTests


# eof file: src/bash/issue-tracker/funcs/run-perl-integration-tests.func.sh
