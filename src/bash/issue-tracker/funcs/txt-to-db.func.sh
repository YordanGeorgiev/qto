# src/bash/issue-tracker/funcs/txt-to-db.func.sh

# v1.0.9
# ---------------------------------------------------------
# 
# ---------------------------------------------------------
doTxtToDb(){

	doLog "DEBUG START doTxtToDb"
	
	# cat doc/txt/issue-tracker/funcs/txt-to-db.func.txt
	
	sleep "$sleep_interval"
	# add your action implementation code here ... 
	# Action !!!

   # run with pre-defined in the shell prjoject 
   doLog "INFO START testing txt-to-db"
   perl src/perl/issue_tracker/script/issue_tracker.pl --do txt-to-db 
   export exit_code=$?
   doLog "INFO doRunIssueTracker exit_code $exit_code"
   test $exit_code -ne 0 && doExit $exit_code "failed to run txt-to-db action for issue_tracker"  

	doLog "DEBUG STOP  doTxtToDb"
}
# eof func doTxtToDb


# eof file: src/bash/issue-tracker/funcs/txt-to-db.func.sh
