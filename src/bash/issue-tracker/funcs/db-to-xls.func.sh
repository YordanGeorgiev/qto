# src/bash/issue-tracker/funcs/db-to-xls.func.sh

# v1.0.9
# ---------------------------------------------------------
# the wrapper func for db to xls issues conversion
# ---------------------------------------------------------
doDbToXls(){

	doLog "DEBUG START doDbToXls"
	
	cat doc/txt/issue-tracker/funcs/db-to-xls.func.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   doLog "INFO START testing db-to-xls"
   test -z ${tables+x} && export tables='daily_issues'
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-xls --tables $tables
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
   


	doLog "DEBUG STOP  doDbToXls"
}
# eof func doDbToXls


# eof file: src/bash/issue-tracker/funcs/db-to-xls.func.sh
