# src/bash/issue-tracker/funcs/db-to-txt.func.sh

# v1.0.9
# ---------------------------------------------------------
# wrapper for fetching the issues from the db and printing them to file
# ---------------------------------------------------------
doDbToTxt(){

	doLog "DEBUG START doDbToTxt"
	
	# cat doc/txt/issue-tracker/funcs/db-to-txt.func.txt
	
	sleep "$sleep_interval"

	# Action !!!
   test -z ${tables+x} && export tables='daily_issues'
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-txt --tables $tables
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  

	doLog "DEBUG STOP  doDbToTxt"
}
# eof func doDbToTxt


# eof file: src/bash/issue-tracker/funcs/db-to-txt.func.sh
