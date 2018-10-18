# src/bash/issue-tracker/funcs/run-integration-tests.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/run-integration-tests.func.txt
# ---------------------------------------------------------
doRunIntegrationTests(){

	doLog "DEBUG START doRunIntegrationTests @run-integration-tests.func.sh"
   cd $product_instance_dir 

	doLog "INFO re-start the issue-tracker app-layer just for sure"
   test -z "${issue_tracker_project:-}" && \
      doExit 10 "FATAL ERROR running $action without defined issue-tracker project environment vars
      !!! Run : source lib/bash/funcs/parse-cnf-env-vars.sh ; doParseCnfEnvVars
      cnf/issue-tracker.dev.host-name.cnf"

   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-stop 
   test $? -ne 0 && return
   bash src/bash/issue-tracker/issue-tracker.sh -a mojo-morbo-start
   test $? -ne 0 && return
   daily_data_dir=$mix_data_dir/$(date "+%Y")/$(date "+%Y-%m")/$(date "+%Y-%m-%d")
   doLog "INFO make a backup of the current db"
   bash src/bash/issue-tracker/issue-tracker.sh -a backup-postgres-db

   # re-create the mysql documentation db
   bash src/bash/issue-tracker/issue-tracker.sh -a run-mysql-scripts

	doLog "INFO load the documentation db run xls-to-db to mysql"
   export
   tables=ItemController,ItemModel,ItemView,ExportFile,Installation,UserStory,Requirement,DevOps,Feature,ReadMe,Image,SystemGuide,Concepts;
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
   export tables=`curl -s -k http://$web_host:$mojo_morbo_port/$postgres_db_name/select-tables \
      |jq -r '.|.dat| .[] | .table_name'|perl -nle 's/ /,/g;print'`
   export do_truncate_tables=1 
   export rdbms_type=postgres ; export load_model=upsert ; 
   perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables $tables
   test $? -ne 0 && return
	
   doLog "INFO re-create the $env_type db once again for the db dump restore"
   bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts
   last_db_backup_file=$(find  -name $postgres_db_name*.sql | sort -n | tail -n 1)
   psql -d $postgres_db_name < "$last_db_backup_file"
   test $? -ne 0 && return

   doLog "INFO START test the Select Controller "
   doLog " $postgres_db_name/select-tables"
   doLog " $postgres_db_name/select/<<table-name>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelect.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 
  
   doLog "INFO START test the Select Controller filtering with the like operator: "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectPick.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 

   doLog "INFO START test the Select Controller with the o=<<order-by>> url param"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectOrder.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 

   doLog "INFO START test the Select Controller filtering with the like operator: "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectLike.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 

   doLog "INFO START test the Select Controller filtering: "
   doLog "INFO S: $postgres_db_name/Select/<<table-name>>?fltr-by=<<attribute>>&fltr-val=<<value>>"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectFilter.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 
   
   doLog "INFO START test the List as Cloud "
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestListCloud.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 
   
   doLog "INFO START test the List Controller with the hide url param"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestListHide.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 
   
   doLog "INFO START integration testing - do run all the implemented action tests" 
   perl src/perl/issue_tracker/t/TestIssueTracker.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 

   doLog "INFO TODO: implement proper client side testing"

   doLog "INFO START select with operator testing"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestSelectWith.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 

   doLog "INFO START testing the list as <<output-type>> page"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestListAsOutputType.pl
<<<<<<< HEAD
   test $? -ne 0 && return
	echo -e "\n\n\n" 
   
   doLog "INFO test the create action on the web-action"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestCreate.pl
=======
>>>>>>> f72769e2... it-181018080737 kill procs occupying wanted app instance ports with mojo-morbo-start and doMojoMorboStop
   test $? -ne 0 && return
	echo -e "\n\n\n" 
  
   doLog "INFO test the update action on the web-action"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestUpdate.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 
   
   doLog "INFO test the delete action on the web-action"
   perl src/perl/issue_tracker/t/lib/IssueTracker/Controller/TestDelete.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunIntegrationTests"
}


# eof file: src/bash/issue-tracker/funcs/run-integration-tests.func.sh
