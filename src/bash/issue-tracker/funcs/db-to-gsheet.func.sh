# src/bash/issue-tracker/funcs/db-to-gsheet.func.sh

# v1.0.9
# ---------------------------------------------------------
# cat doc/txt/issue-tracker/funcs/db-to-gsheet.func.txt
# ---------------------------------------------------------
doDbToGsheet(){

	doLog "DEBUG START doDbToGsheet"
	
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   doLog "INFO START testing db-to-gsheet"
   test -z ${tables+x} && export tables='daily_issues'
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-gsheet --tables $tables
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
   



	doLog "DEBUG STOP  doDbToGsheet"
}
# eof func doDbToGsheet


# eof file: src/bash/issue-tracker/funcs/db-to-gsheet.func.sh
