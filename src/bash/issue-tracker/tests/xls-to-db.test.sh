# src/bash/issue-tracker/funcs/xls-to-db.test.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/tests/xls-to-db.test.txt
# ---------------------------------------------------------
doTestXlsToDb(){

	doLog "DEBUG START doTestXlsToDb"
	
	
	sleep "$sleep_interval"
	# Action !!!
   export load_model='upsert'
   export rdbms_type='postgres'
   src/bash/issue-tracker/issue-tracker.sh -a xls-to-db -t monthly_issues,daily_issues
   exit_code=$?
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return
   
	# Action !!!
   export load_model='nested-set'
   export rdbms_type='mysql'
   # export rdbms_type='mariadb' # could be also mariadb
   src/bash/issue-tracker/issue-tracker.sh -a xls-to-db \
   -t Requirement,DevOps,UserStory,ItemController,ItemView,ItemModel,Tests,Feature,ExportFile,Feature,Issues,SystemGuide,ReadMe,ExportFile,Concepts
   exit_code=$?
   sleep "$sleep_interval"
   test $exit_code -ne 0 && return

	doLog "DEBUG STOP  doTestXlsToDb"
}
# eof func doTestXlsToDb


# eof file: src/bash/issue-tracker/funcs/xls-to-db.test.sh
