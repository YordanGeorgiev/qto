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
   export tables=ItemController,ItemModel,ItemView,ExportFile,Installation,UserStory,Requirement,DevOps,Feature,ReadMe,Image,SystemGuide,Concepts;
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
   export rdbms_type=postgres ; export load_model=upsert
   perl src/perl/issue_tracker/script/issue_tracker.pl --do xls-to-db --tables 'monthly_issues,yearly_issues'
   test $? -ne 0 && return
	
   doLog "INFO re-create the $env_type db once again for the db dump restore"
   bash src/bash/issue-tracker/issue-tracker.sh -a run-pgsql-scripts
   last_db_backup_file=$(find  -name $postgres_db_name*.sql | sort -n | tail -n 1)
   psql -d $postgres_db_name < "$last_db_backup_file"
   test $? -ne 0 && return

   
   doLog "INFO START integration testing - do run all the implemented action tests" 
   perl src/perl/issue_tracker/t/TestIssueTracker.pl
   test $? -ne 0 && return
	echo -e "\n\n\n" 

	doLog "DEBUG STOP  doRunIntegrationTests"
}


# eof file: src/bash/issue-tracker/funcs/run-integration-tests.func.sh
