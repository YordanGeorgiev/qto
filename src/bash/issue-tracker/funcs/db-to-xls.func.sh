# src/bash/issue-tracker/funcs/db-to-xls.func.sh

# v1.0.9
# ---------------------------------------------------------
# todo: add doDbToXls comments ...
# ---------------------------------------------------------
doDbToXls(){

	doLog "DEBUG START doDbToXls"
	
	cat doc/txt/issue-tracker/funcs/db-to-xls.func.txt
	
	test -z "$sleep_interval" || sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!
   doLog "INFO START testing db-to-xls"
   # perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-xls --issues_file $issues_file \
   perl src/perl/issue_tracker/script/issue_tracker.pl --do db-to-xls
   exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run issue_tracker.pl"  
   


	doLog "DEBUG STOP  doDbToXls"
}
# eof func doDbToXls


# eof file: src/bash/issue-tracker/funcs/db-to-xls.func.sh
