# src/bash/issue-tracker/funcs/db-to-txt.func.sh

# v1.0.9
# ---------------------------------------------------------
# wrapper for fetching the issues from the db and printing them to file
# ---------------------------------------------------------
doDbToTxt(){

	doLog "DEBUG START doDbToTxt"
	
	cat doc/txt/issue-tracker/funcs/db-to-txt.func.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-txt
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  

	doLog "DEBUG STOP  doDbToTxt"
}
# eof func doDbToTxt


# eof file: src/bash/issue-tracker/funcs/db-to-txt.func.sh
