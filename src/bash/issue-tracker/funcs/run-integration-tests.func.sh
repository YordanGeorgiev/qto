# src/bash/issue-tracker/funcs/run-integration-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/run-integration-tests.func.txt
# ---------------------------------------------------------
doRunIntegrationTests(){

	doLog "DEBUG START doRunIntegrationTests @run-integration-tests.func.sh"

	doLog "INFO re-start the issue-tracker app-layer just for sure"
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop 
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start
   daily_data_dir=$mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")
   doLog "INFO make a backup of the current db"
   pg_dump  --column-inserts --data-only $postgres_db_name  > \
   $daily_data_dir/sql/$postgres_db_name/$postgres_db_name.`date "+%Y%m%d_%H%M%S"`.insrt.dump.sql
   ls -1 $daily_data_dir/sql/$postgres_db_name/* | sort -nr
   last_db_backup_file=$(ls -1 $daily_data_dir/sql/$postgres_db_name/* | sort -nr|head -n 1)
	doLog "INFO created the following postgres db backup : $last_db_backup_file" 
	doLog "INFO re-create the documentation db"
   bash src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts

	doLog "INFO load the documentation db run xls-to-db to mysql"
   export tables=ItemController,ItemModel,ItemView,ExportFile,Installation,UserStory,Requirement,DevOps,Feature,ReadMe,Image,SystemGuide;
   export do_truncate_tables=1 ; export rdbms_type=mysql ; export load_model=nested-set
   perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables

   doc_pub_instances_running=$(ps -ef | grep -i doc_pub | wc -l)
   if [ $doc_pub_instances_running -gt 0 ]; then
      doLog "INFO generate the pdf and the mysql documentation"
      bash src/bash/issue-tracker/issue-tracker.sh -a generate-docs
   fi

	doLog "INFO re-create the $env_type db"
   bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts

   doLog "INFO laod the postgres data"
   export tables=`curl -s -k http://$web_host:3000/$postgres_db_name/select-tables \
      |jq -r '.|.dat| .[] | .table_name'|perl -nle 's/ /,/g;print'`
   export do_truncate_tables=1 
   export rdbms_type=postgres ; export load_model=upsert ; 
   perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables
	
   doLog "INFO re-create the $env_type db once again for the db dump restore"
   bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts
   psql -d $postgres_db_name < "$last_db_backup_file"

   doLog "INFO START test the Select Controller "
   doLog " $postgres_db_name/Select-tables"
   doLog " $postgres_db_name/Select/<<table-name>>"
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


   doLog "INFO S: $postgres_db_name/Select/<<table-name>>?fltr-by=<<attribute>>&fltr-val=<<value>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectFilter.pl
	echo -e "\n\n\n" 

   doLog "INFO START test the Select Controller filtering: "
   
   
   doLog "INFO START test the List Controller "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestList.pl
	echo -e "\n\n\n" 
   
   doLog "INFO START test the List Controller with the hide url param"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestListHide.pl
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

   doLog "INFO START testing the list as table page"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestListTable.pl
	echo -e "\n\n\n" 
  
   doLog "INFO test the update action on the web-action"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestUpdate.pl
	echo -e "\n\n\n" 
   
   doLog "INFO test the create action on the web-action"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestCreate.pl
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunIntegrationTests"
}


# eof file: src/bash/issue-tracker/funcs/run-integration-tests.func.sh
